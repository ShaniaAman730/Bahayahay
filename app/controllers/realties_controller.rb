class RealtiesController < ApplicationController
  before_action :set_realty, only: [:show, :edit_requirements, :update_requirements, :edit, :update, :manage_members]
  before_action :require_broker, only: [:new, :create, :edit, :update]
  before_action :check_existing_realty, only: [:new, :create]

  def index
    @query = params[:query]
    @realties = Realty.approved.search(@query).includes(:head_broker).order(created_at: :desc).page(params[:page]).per(8)
  end


  def show
  end

  def new
    @realty = Realty.new
  end

  def create
    @realty = current_user.build_managed_realty(realty_params)
    if @realty.save
      redirect_to @realty, notice: "Realty application submitted. Awaiting admin approval."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to @realty, alert: "Not authorized." unless @realty.head_broker == current_user && @realty.approved?
  end

  def update
    if @realty.head_broker == current_user && @realty.approved? && @realty.update(realty_editable_params)
      redirect_to @realty, notice: "Realty updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_requirements
    if @realty.rejected?
      render :edit_requirements
    else
      redirect_to @realty, alert: "You can only edit requirements if the application was rejected."
    end
  end

  def update_requirements
    if @realty.rejected?
      if @realty.update(realty_params)
        @realty.update(status: :pending) # reset status after resubmission
        redirect_to @realty, notice: "Your realty application has been resubmitted for review."
      else
        render :edit_requirements
      end
    else
      redirect_to @realty, alert: "You can only update requirements if the application was rejected."
    end
  end

  def manage_members
    authorize_broker!

    @pending_memberships = @realty.realty_memberships.pending
    @leaving_memberships = @realty.realty_memberships.leaving
    @approved_memberships = @realty.realty_memberships.approved
  end

  private

  def set_realty
    @realty = Realty.find(params[:id])
  end

  def realty_params
    params.require(:realty).permit(:name, :business_location, :email, :phone_number, :business_permit, :about, :website)
  end

   def realty_editable_params
    params.require(:realty).permit(:business_location, :email, :phone_number, :banner, :about, :website, :logo)
  end


  def require_broker
    if current_user
      redirect_to root_path, alert: "Only brokers can create a realty." unless current_user.is_broker?
    else
      redirect_to root_path, alert: "Please log-in to access this page."
    end
  end

  def check_existing_realty
    if current_user.managed_realty.present?
      redirect_to current_user.managed_realty, alert: "You already manage a realty."
    end
  end

  def authorize_broker!
    unless current_user == @realty.head_broker
      redirect_to @realty, alert: "You are not authorized to manage members."
    end
  end

end