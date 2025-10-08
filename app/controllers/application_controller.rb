class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :check_realtor_approval, if: :user_signed_in?
  before_action :set_action_cable_identifier

  protected

  def authenticate_admin!
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def authenticate_developer!
    unless current_user && current_user.developer?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def authenticate_realtor!
    unless current_user && current_user.realtor?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def authenticate_realtor_developer!
    unless current_user && current_user.realtor? || current_user.developer?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def check_realtor_approval
    if current_user.realtor? && !current_user.admin_approved?
      sign_out current_user
      redirect_to new_user_session_path, alert: "Your account is pending approval by an administrator."
    end
  end

  private

  def set_action_cable_identifier
    cookies.encrypted[:user_id] = current_user.id if current_user
  end

end

