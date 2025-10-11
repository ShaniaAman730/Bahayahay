class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!, only: [:all_users, :managerealtors, :approve, :reject, :destroy, :new, :create, :edit, :update]
  before_action :ensure_realtor_developer!, only: [:reviews]

  skip_before_action :ensure_realtor_developer!, only: [:show, :review_events]
  skip_before_action :authenticate_user!, only: [:show]


   # ---- PROFILE ----

  def show
    @user = User.find(params[:id])
    @listings = @user.listings_posted.merge(Listing.public_listings).page(params[:listings_page]).per(3)
    @dev_projects = @user.dev_projects.page(params[:dev_projects_page]).order(created_at: :desc).per(3)
    @reviews = @user.received_reviews.order(created_at: :desc).page(params[:reviews_page]).per(3)
    @guides = @user.guides.order(created_at: :desc).page(params[:guides_page]).per(4)

    @developer = User.find(params[:id])

    if current_user&.head_broker?
      @realty = current_user.managed_realty
      if @realty.present?
        @existing_accreditation = Accreditation.find_by(realty: @realty, developer: @developer)
      end
    end

    if @user.admin? && !current_user.admin?
      redirect_to root_path, notice: "User's profile is not available."
    end

     if @user.user_type == "rebap"
      # Fetch REBAP memberships related to this chapter
      @officers = @user.rebap_memberships.where.not(role: [nil, ""]).order(:order).page(params[:officers_page]).per(30)
      @active_members = @user.rebap_memberships.where(role: [nil, ""]) .joins(:member).page(params[:members_page]).per(20)
    end

    @recent_guides = @user.guides.order(created_at: :desc).limit(40)

    # Statistics tracker
    if user_signed_in? && current_user.id != @user.id
      Statistic.create!(
        trackable: @user,
        user: current_user,
        event_type: :view
      )
    end
  end

  # ----------- REVIEWS -----------

  def reviews
    @user = User.find(params[:id])
    unless @user.realtor?
      redirect_to user_path(@user), alert: "This user does not have public reviews."
      return
    end

    @reviews = @user.received_reviews.order(created_at: :desc).page(params[:page]).per(5)
    @events  = ReviewEvent.where(realtor: @user).order(created_at: :desc).page(params[:page]).per(10)

    @new_reviews_present = @user.received_reviews.unread.exists?
    @user.received_reviews.unread.update_all(read: true)
  end

  def review_events
    @user = User.find(params[:id])
    if @user == current_user
      @reviews = Review.where(client: @user).order(created_at: :desc).page(params[:page]).per(10)
      @events  = ReviewEvent.where(client: @user).order(created_at: :desc).page(params[:page]).per(10)
    else
      redirect_to root_path, alert: "You can only view your own review activity."
    end
  end

  # ----------- ADMIN ACTIONS -----------

  def all_users
    @q = params[:q].to_s.strip
    @user_type = params[:user_type]
    @users = User.all

    if @q.present?
      @users = @users.where(
        "first_name ILIKE :q OR last_name ILIKE :q OR email ILIKE :q OR contact_no ILIKE :q OR company_name ILIKE :q",
        q: "%#{@q}%"
      )
    end

    if @user_type.present?
      @users = @users.where(user_type: User.user_types[@user_type])
    end

    @users = @users.order(created_at: :desc).page(params[:page]).per(10)
  end


  def managerealtors
    @users = User.realtor.where(admin_approved: false)

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @users = @users.where(
        "LOWER(first_name) LIKE :query OR LOWER(last_name) LIKE :query OR LOWER(email) LIKE :query OR LOWER(company_name) LIKE :query",
        query: query
      )
    end

    @users = @users.order(created_at: :desc).page(params[:manage_realtors_page]).per(3)
  end


  def approve
    @user = User.find(params[:id])
    if @user.update(admin_approved: true)
      UserMailer.realtor_approval_email(@user).deliver_now
      @user.update_column(:realtor_approval_email_sent_at, Time.current)
      redirect_to managerealtors_users_path, notice: 'Realtor approved and email sent!'
    else
      redirect_to managerealtors_users_path, alert: "Approval failed: #{@user.errors.full_messages.join(", ")}"
    end
  end

  def reject
    @user = User.find(params[:id])
    if @user.update(admin_approved: false)
      UserMailer.realtor_rejection_email(@user).deliver_now
      @user.update_column(:realtor_rejection_email_sent_at, Time.current)
      redirect_to managerealtors_users_path, notice: "Realtor rejected and email sent."
    else
      redirect_to managerealtors_users_path, alert: "Rejection failed: #{@user.errors.full_messages.join(", ")}"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User created successfully."
    else
      flash[:alert] = "User could not be created: #{@user.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_back fallback_location: users_path, notice: "User deleted successfully."
    else
      redirect_back fallback_location: users_path, alert: "Could not delete user."
    end
  end

  private

  def ensure_admin!
    redirect_to root_path unless current_user.admin?
  end

  def ensure_realtor_developer!
    redirect_to root_path unless current_user.realtor? || current_user.developer?
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :contact_no, :user_type, :company_name, :address, :admin_approved, :profile_photo)
  end

  def profile_params
    params.require(:user).permit(:contact_no, :company_name,:address, :about, :website, :profile_photo, :broker_name, :broker_prc_no)
  end
  
end
