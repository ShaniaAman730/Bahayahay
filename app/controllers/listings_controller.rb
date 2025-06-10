class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]

  before_action :authenticate_realtor!
  before_action :ensure_realtor!

  skip_before_action :authenticate_realtor!, only: [:show, :index, :public_listings, :public]
  skip_before_action :ensure_realtor!, only: [:show, :index, :public_listings, :public]

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
    @listings = Listing.public_listings.order(created_at: :desc).page(params[:page]).per(10)
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

    respond_to do |format|
      if @listing.save && @listing.listing_type_num == 0 
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      elsif @listing.save && @listing.listing_type_num == 1
        format.html { redirect_to @listing, notice: "Listing was successfully created and is now pending for admin approval" }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end

   puts params.inspect
   puts listing_params.inspect

  end


  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
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
      :valid_id, :birthcert, listing_photos: [], spa: [], tct: []
    )
  end


end
