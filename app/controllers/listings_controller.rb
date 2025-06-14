class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]

  before_action :authenticate_realtor!
  before_action :ensure_realtor!

  skip_before_action :authenticate_realtor!, only: [:show, :index, :public_listings, :public]
  skip_before_action :ensure_realtor!, only: [:show, :index, :public_listings, :public]

  def remove_attachment
    @listing = Listing.find(params[:id])
    attachment = ActiveStorage::Attachment.find(params[:attachment_id])

    # Confirm the attachment is associated with listing_photos
    if attachment.record == @listing && attachment.name == "listing_photos"
      attachment.purge
      @listing.reload
      redirect_to edit_listing_path(@listing), notice: "Photo was successfully removed."
    else
      redirect_to edit_listing_path(@listing), alert: "Invalid attachment."
    end
  end


  def confirm
    @listing = Listing.find(params[:id])

    unless @listing.realtor == current_user
      redirect_to root_path, alert: "Unauthorized."
      return
    end

    @client = User.find(params[:client_id])

    if @listing.update(client: @client, confirmed: true)
      redirect_to @listing, notice: "Sale confirmed with #{@client.first_name}."
    else
      redirect_to @listing, alert: "Could not confirm the transaction."
    end
  end

  def public_listings

    @listings = Listing.public_listings

    if params[:keyword].present?
      keyword = params[:keyword].downcase
      matching_project_types = Listing.project_types.keys.select { |pt| pt.downcase.include?(keyword) }
      matching_furnish_types = Listing.furnish_types.keys.select { |ft| ft.downcase.include?(keyword) }

      @listings = @listings.where(
        "LOWER(title) LIKE :q OR project_type IN (:project_types) OR furnish_type IN (:furnish_types)",
        q: "%#{keyword}%",
        project_types: matching_project_types.map { |pt| Listing.project_types[pt] },
        furnish_types: matching_furnish_types.map { |ft| Listing.furnish_types[ft] }
      )
    end

    @listings = @listings.where("beds >= ?", params[:beds]) if params[:beds].present?
    @listings = @listings.where("baths >= ?", params[:baths]) if params[:baths].present?
    @listings = @listings.where("price >= ?", params[:min_price]) if params[:min_price].present?
    @listings = @listings.where("price <= ?", params[:max_price]) if params[:max_price].present?

    @listings = @listings.where(pagibig_financing: true) if params[:pagibig_financing].present?
    @listings = @listings.where(bank_financing: true) if params[:bank_financing].present?
    @listings = @listings.where(inhouse_financing: true) if params[:inhouse_financing].present?

    @listings = @listings.where(project_type: params[:project_type]) if params[:project_type].present?
    @listings = @listings.where(furnish_type: params[:furnish_type]) if params[:furnish_type].present?

    @listings = @listings.page(params[:page]).per(10)
  end

  def select_type
  end

  def choose_type
    if params[:listing_type] == 'independent'
      redirect_to '/new_independent'
    else
      redirect_to '/new_project'
    end
  end

  def new_independent
    @listing = Listing.new(listing_type: :independent)
  end

  def new_project
    @listing = Listing.new(listing_type: :project)
  end

  def index
  if current_user.realtor?
    @listings = current_user.listings_posted.order(:created_at).page(params[:page]).per(10)
  else
    @listings = Listing.approved_listings.order(:created_at).page(params[:page]).per(10)
  end
end

  # GET /listings/1 or /listings/1.json
  def show
    @interested_clients = Conversation
      .where(realtor: @listing.realtor)
      .pluck(:client_id)
      .uniq
      .map { |id| User.find(id) }
  end

  def public
    @listing = Listing.find(params[:id])
    render :public
  end

  # GET /listings/new
  def new
    redirect_to '/select_type'
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
  end

  # POST /listings or /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.realtor = current_user

    puts "Uploaded files:"
    puts params[:listing][:listing_photos].inspect if params[:listing][:listing_photos].present?

    saved = @listing.save

    respond_to do |format|
      if saved && @listing.listing_type_num == 0 
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      elsif saved && @listing.listing_type_num == 1
        format.html { redirect_to @listing, notice: "Listing was successfully created and is now pending for admin approval" }
        format.json { render :show, status: :created, location: @listing }
      else
        template = @listing.listing_type_num == 0 ? :new_independent : :new_project
        format.html { render template, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end

    puts params.inspect
    puts listing_params.inspect
  end



  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    @listing = Listing.find(params[:id])

    # Extract the file attachment params and remove from strong params
    photo_params = params[:listing].delete(:listing_photos)
    spa_params   = params[:listing].delete(:spa)
    tct_params   = params[:listing].delete(:tct)

    respond_to do |format|
      if @listing.update(listing_params)
        @listing.listing_photos.attach(photo_params) if photo_params.present?
        @listing.spa.attach(spa_params) if spa_params.present?
        @listing.tct.attach(tct_params) if tct_params.present?

        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy!

    respond_to do |format|
      format.html { redirect_to listings_path, status: :see_other, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
       @listing = Listing.find(params[:id]) 
    end


    def ensure_realtor!
     redirect_to root_path unless current_user.realtor?
    end

    # Only allow a list of trusted parameters through.
    def listing_params
  params.require(:listing).permit(
      :title, :description, :price, :bank_financing, :inhouse_financing,
      :pagibig_financing, :furnish_type, :project_type,
      :barangay, :address, :filipinocitizen, :citizenship, :tin,
      :ownerabroad, :owneralive, :estatetax, :ejsprocessed,
      :aif, :guardhouse, :perimeterfence, :cctv,
      :clubhouse, :pool, :coveredcourt, :parks, :playground,
      :joggingpaths, :conveniencestore, :watersystem, :drainagesystem,
      :undergroundlines, :wastemgmt, :garden, :carport, :dirtykitchen,
      :gate, :watertank, :homecctv, :homepool, :lanai, :landscaping,
      :aircon, :provaircon, :wardrobes, :modkitchen, :crfixtures,
      :lightfixtures, :firesystem, :intercom, :internetprov, :cableprov,
      :meterperunit, :washingmachineprov, :waterheaterprov, :smarthomeready,
      :balcony, :cityview, :mountainview, :petfriendly, :facingeast,
      :realtor, :client, :listing_type, :listing_type_num, 
      :beds, :baths, :sqft,
      :valid_id, :birthcert, 
      listing_photos: [], spa: [], tct: []
    )
  end


end
