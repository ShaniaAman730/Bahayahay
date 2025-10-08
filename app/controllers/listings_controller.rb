class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  before_action :authenticate_realtor!
  before_action :ensure_realtor!
  before_action :prevent_edit_if_sold, only: [:edit, :update]
  before_action :ensure_realtor_can_post!, only: [:new, :create]

  skip_before_action :authenticate_realtor!, only: [:show, :public_listings, :public, :contact_agent]
  skip_before_action :ensure_realtor!, only: [:show, :public_listings, :public, :contact_agent]

  def statistics_data
    @listing = Listing.find(params[:id])
    data = @listing.statistics.view.group_by_day(:created_at, last: 7).count
    render json: data
  end

  def contact_agent
    @listing = Listing.find(params[:id])
    @realtor = @listing.realtor

    # contact count
    @listing.increment!(:contact_clicks)

    # find or create conversation
    conversation = Conversation.find_or_create_by(client: current_user, realtor: @realtor)

    redirect_to conversation_path(conversation)
  end


  def remove_attachment
    @listing = Listing.find(params[:id])
    attachment = ActiveStorage::Attachment.find(params[:attachment_id])

    # Confirm the attachment is associated with listing_photos
    if attachment.record == @listing && ["listing_photos", "spa", "tct"].include?(attachment.name)
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

    if @listing.update(client: @client, confirmed: true, active: false)
      # This is for the review feed
      ReviewEvent.create!(
        realtor: @listing.realtor,
        client: @client,
        listing: @listing,
        review: @review,
        event_type: "assigned",
        message: "#{@client.first_name} has been assigned to your listing #{@listing.title}. They can now leave a review."
      )
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
        matching_barangays = Listing.barangays.keys.select { |brgy| brgy.downcase.include?(keyword) }

        @listings = @listings.where(
          "LOWER(title) LIKE :q OR project_type IN (:project_types) OR furnish_type IN (:furnish_types)",
          q: "%#{keyword}%",
          project_types: matching_project_types.map { |pt| Listing.project_types[pt] },
          furnish_types: matching_furnish_types.map { |ft| Listing.furnish_types[ft] },
          barangays: matching_barangays.map { |brgy| Listing.barangays[brgy] }
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
      @listings = @listings.where(barangay: params[:barangay]) if params[:barangay].present?

      if params[:barangay].present?
        @listings = @listings.where(barangay: params[:barangay])
        @map_center = Listing::BARANGAY_COORDS[params[:barangay]]
      else
        # Default: Naga City center
        @map_center = [13.6236, 123.1948]
      end
      
      @listings = @listings.page(params[:page]).per(8)
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
    if @listing.listing_type_num == 1 && !@listing.approved? &&
       !(current_user&.admin? || current_user == @listing.realtor)
      redirect_to public_listings_path, alert: "This listing is not available for public viewing."
      return
    end

    @interested_clients = Conversation
      .where(realtor: @listing.realtor)
      .pluck(:client_id)
      .uniq
      .map { |id| User.find(id) }

    # Statistics tracker
    Statistic.create!(
      trackable: @listing,
      user: current_user,
      event_type: :view
    )
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

    # Set developer_id only for project listings (listing_type_num == 0)
    if @listing.listing_type_num == 0
      @listing.developer_id = params[:listing][:developer_id]
    else
      @listing.developer_id = nil
    end

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

    # Set developer_id only for project listings (listing_type_num == 0)
    if @listing.listing_type_num == 0
      @listing.developer_id = params[:listing][:developer_id]
    else
      @listing.developer_id = nil
    end

    # Extract the file attachment params and remove from strong params
    photo_params = params[:listing].delete(:listing_photos)
    spa_params   = params[:listing].delete(:spa)
    tct_params   = params[:listing].delete(:tct)

    respond_to do |format|
      if @listing.update(listing_params)

        # Independent listings will revert for approval after updating
        if @listing.listing_type_num == 1
        @listing.update(
            approved: false,
            for_edit: false,
            approval_requests_count: @listing.approval_requests_count + 1
          )
        end

        @listing.listing_photos.attach(photo_params) if photo_params.present?
        @listing.spa.attach(spa_params) if spa_params.present?
        @listing.tct.attach(tct_params) if tct_params.present?

        if @listing.listing_type_num == 0
          format.html { redirect_to @listing, notice: "Listing was successfully updated." }
          format.json { render :show, status: :ok, location: @listing }
        end

        if @listing.listing_type_num == 1
          format.html { redirect_to @listing, notice: "Listing was successfully updated and is now pending for admin approval" }
          format.json { render :show, status: :ok, location: @listing }
        end

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

    def prevent_edit_if_sold
      if @listing.present? && !@listing.active?
        redirect_to @listing, alert: "You cannot edit or delete a sold listing."
      end
    end

    def ensure_realtor_can_post!
      if current_user.realtor? && !current_user.is_broker && current_user.realty.blank?
        redirect_to root_path, alert: "You must be part of a Realty to post listings. Please submit a Realty application."
      end
    end


    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(
          :title, :description, :price, :bank_financing, :inhouse_financing,
          :pagibig_financing, :furnish_type, :project_type,
          :barangay, :address, :filipinocitizen, :citizenship, :tin,
          :ownerabroad, :owneralive, :estatetax, :ejsprocessed,
          :aif, :realtor, :client, :listing_type, :listing_type_num, 
          :beds, :baths, :sqft, :contact_clicks, :confirmed, :approved, :active,
          :valid_id, :birthcert, :developer_id, :for_edit, :approval_requests_count,
          :latitude, :longitude, amenity_ids: [],
          listing_photos: [], spa: [], tct: []
        )
  end


end

