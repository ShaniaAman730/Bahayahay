class DevProjectsController < ApplicationController
  before_action :set_dev_project, only: %i[ show edit update destroy ]
  before_action :authenticate_developer!
  before_action :ensure_developer!

  skip_before_action :authenticate_developer!, only: [:show]
  skip_before_action :ensure_developer!, only: [:show]

  def statistics_data
    @dev_project = DevProject.find(params[:id])
    data = @dev_project.statistics.view.group_by_day(:created_at, last: 7).count
    render json: data
  end

  def remove_attachment
    @dev_project = DevProject.find(params[:id])
    attachment = ActiveStorage::Attachment.find(params[:attachment_id])

    if attachment.record == @dev_project && attachment.name == "project_photos"
      attachment.purge
      @dev_project.reload
      redirect_to edit_dev_project_path(@dev_project), notice: "Photo was successfully removed."
    else
      redirect_to edit_dev_project_path(@dev_project), alert: "Invalid attachment."
    end
  end


  # GET /dev_projects or /dev_projects.json
  def index
    @dev_projects = DevProject.all.order(:title).page(params[:page]).per(10)
  end

  # GET /dev_projects/1 or /dev_projects/1.json
  def show
    @dev_project = DevProject.find(params[:id])
    @model_houses = @dev_project.model_houses

    # Statistics tracker
    if user_signed_in? && current_user.id != @dev_project.user.id
      Statistic.create!(
        trackable: @dev_project,
        user: current_user,
        event_type: :view
      )
    end
  end

  # GET /dev_projects/new
  def new
    @dev_project = DevProject.new
  end

  # GET /dev_projects/1/edit
  def edit
  end

  # POST /dev_projects or /dev_projects.json
  def create
    @dev_project = DevProject.new(dev_project_params)
    @dev_project.user = current_user

    respond_to do |format|
      if @dev_project.save
        format.html { redirect_to @dev_project, notice: "Dev project was successfully created." }
        format.json { render :show, status: :created, location: @dev_project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dev_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dev_projects/1 or /dev_projects/1.json
  def update
    @dev_project = DevProject.find(params[:id])

    photo_params = params[:dev_project].delete(:project_photos)

    respond_to do |format|
      if @dev_project.update(dev_project_params)
        @dev_project.project_photos.attach(photo_params) if photo_params.present?

        format.html { redirect_to @dev_project, notice: "Dev project was successfully updated." }
        format.json { render :show, status: :ok, location: @dev_project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dev_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dev_projects/1 or /dev_projects/1.json
  def destroy
    @dev_project.destroy!

    respond_to do |format|
      format.html { redirect_to dev_projects_path, status: :see_other, notice: "Dev project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_dev_project
      @dev_project = DevProject.find(params.expect(:id))
    end

    def ensure_developer!
     redirect_to root_path unless current_user.developer?
    end

    def dev_project_params
      params.expect(dev_project: [ :title, :description, :barangay, :address, :property_type, :latitude, :longitude, amenity_ids: [], project_photos: [] ])
    end
end
