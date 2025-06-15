class ModelHousesController < ApplicationController
  before_action :set_model_house, only: %i[ show edit update destroy ]
  before_action :authenticate_developer!
  before_action :ensure_developer!

  def remove_attachment
    @model_house = ModelHouse.find(params[:id])
    attachment = ActiveStorage::Attachment.find(params[:attachment_id])

    if attachment.record == @model_house && attachment.name == "model_photos"
      attachment.purge
      @model_house.reload
      redirect_to edit_model_house_path(@model_house), notice: "Photo was successfully removed."
    else
      redirect_to edit_model_house_path(@model_house), alert: "Invalid attachment."
    end
  end


  # GET /model_houses or /model_houses.json
  def index
    @model_houses = ModelHouse.all
                              .order(:title)
                              .page(params[:page])
                              .per(10)
  end

  # GET /model_houses/1 or /model_houses/1.json
  def show
    @model_house = ModelHouse.find(params[:id])
    @dev_project = @model_house.dev_project
  end

  # GET /model_houses/new
  def new
    @model_house = ModelHouse.new
  end

  # GET /model_houses/1/edit
  def edit
  end

  # POST /model_houses or /model_houses.json
  def create
    @model_house = current_user.model_houses.new(model_house_params)

    # Prevent assigning a dev_project the user doesn't own
    validate_dev_project_owner!

    respond_to do |format|
      if @model_house.save
        format.html { redirect_to @model_house, notice: "Model house was successfully created." }
        format.json { render :show, status: :created, location: @model_house }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @model_house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /model_houses/1 or /model_houses/1.json
  def update
    respond_to do |format|
      # Re-check if user is trying to assign someone else's project
      validate_dev_project_owner!

      photo_params = params[:model_house].delete(:model_photos)

      if @model_house.update(model_house_params)

        @model_house.model_photos.attach(photo_params) if photo_params.present?

        format.html { redirect_to @model_house, notice: "Model house was successfully updated." }
        format.json { render :show, status: :ok, location: @model_house }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @model_house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /model_houses/1 or /model_houses/1.json
  def destroy
    @model_house.destroy!

    respond_to do |format|
      format.html { redirect_to model_houses_path, status: :see_other, notice: "Model house was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model_house
      @model_house = ModelHouse.find(params[:id])
    end

    def ensure_developer!
     redirect_to root_path unless current_user.developer?
    end


  def validate_dev_project_owner!
    dev_project_id = params[:model_house][:dev_project_id]

    return if dev_project_id.blank? # allow optional

    unless current_user.dev_projects.exists?(id: dev_project_id)
      flash[:alert] = "You're not authorized to assign that Dev Project."
      redirect_back fallback_location: root_path
    end
  end

    # Only allow a list of trusted parameters through.
    def model_house_params
      params.require(:model_house).permit(
        :title, :description, :price, :inherit_amenities, :furnish_type,
        :guardhouse, :perimeterfence, :cctv, :clubhouse, :pool, :coveredcourt,
        :parks, :playground, :joggingpaths, :conveniencestore, :watersystem,
        :drainagesystem, :undergroundlines, :wastemgmt, :garden, :carport,
        :dirtykitchen, :gate, :watertank, :homecctv, :homepool, :lanai,
        :landscaping, :aircon, :provaircon, :wardrobes, :modkitchen, :crfixtures,
        :lightfixtures, :firesystem, :intercom, :internetprov, :cableprov,
        :meterperunit, :washingmachineprov, :waterheaterprov, :smarthomeready,
        :balcony, :cityview, :mountainview, :petfriendly, :facingeast,
        :beds, :baths, :sqft,
        :bank_financing, :inhouse_financing, :pagibig_financing,
        :dev_project_id, model_photos: []
      )
    end

end

