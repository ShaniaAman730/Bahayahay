class Admin::RealtiesController < ApplicationController
  before_action :require_admin
  before_action :set_realty, only: [:show, :approve, :reject]
  before_action :show_only_before_approved, only: [:show]

  def index
    @realties = Realty.all

    if params[:q].present?
      query = "%#{params[:q].downcase}%"
      @realties = @realties.where("LOWER(name) LIKE ?", query)
    end

    if params[:status].present?
      @realties = @realties.where(status: params[:status])
    end

    @realties = @realties.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def approve
  if @realty.update(realty_params.merge(status: "approved"))
    # Purge permit file after successful approval
    @realty.business_permit.purge if @realty.business_permit.attached?

    redirect_to admin_realties_path, notice: "Realty approved."
  else
    flash.now[:alert] = @realty.errors.full_messages.to_sentence
    render :show
  end
end


  def reject
    @realty.update(status: :rejected, rejection_reason: params[:rejection_reason])
    redirect_to admin_realties_path, notice: "Realty rejected."
  end

  def destroy
    @realty = Realty.find(params[:id])
    @realty.destroy
    redirect_to admin_realties_path, notice: "Realty deleted successfully."
  end


  private


  def realty_params
    params.require(:realty).permit(:permit_type, :permit_last_digits)
  end


  def set_realty
    @realty = Realty.find(params[:id])
  end

  def require_admin
    redirect_to root_path, alert: "Access denied." unless current_user.admin?
  end

  def show_only_before_approved
    if @realty.status == 'approved' 
      redirect_to admin_realties_path, notice: "Realty is already approved."
    end
  end
end
