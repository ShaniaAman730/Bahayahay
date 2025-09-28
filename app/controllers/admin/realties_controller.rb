class Admin::RealtiesController < ApplicationController
  before_action :require_admin
  before_action :set_realty, only: [:show, :approve, :reject]

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
    @realty.update(status: :approved)
    redirect_to admin_realties_path, notice: "Realty approved."
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

  def set_realty
    @realty = Realty.find(params[:id])
  end

  def require_admin
    redirect_to root_path, alert: "Access denied." unless current_user.admin?
  end
end
