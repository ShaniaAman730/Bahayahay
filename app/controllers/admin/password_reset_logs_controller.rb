class Admin::PasswordResetLogsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_admin!

  def index
    @query = params[:query]
    @password_reset_logs = PasswordResetLog.includes(:admin, :user).search(@query).order(created_at: :desc).page(params[:page]).per(20)
  end

  private

  def ensure_admin!
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end
