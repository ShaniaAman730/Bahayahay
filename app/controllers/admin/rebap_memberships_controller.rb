class Admin::RebapMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @query = params[:query]

    @rebap_users = User.rebap.joins(:rebap_memberships).select("users.*, rebap_memberships.chapter AS chapter_name").distinct.order(:email)

    if @query.present?
      @rebap_users = @rebap_users.where(
        "users.email ILIKE :q OR users.contact_no ILIKE :q OR rebap_memberships.chapter ILIKE :q",
        q: "%#{@query}%"
      )
    end

    @rebap_users = @rebap_users.page(params[:page]).per(10)
  end


  def new
    @rebap_user = User.find(params[:rebap_id])
    @rebap_membership = @rebap_user.rebap_memberships.build
  end

  def create
    @rebap_user = User.find(params[:rebap_id])
    chapter = params[:chapter]

    if @rebap_user.rebap_memberships.present?
      redirect_to admin_rebap_memberships_path, alert: "This REBAP user already has a chapter."
      return
    end

    @rebap_membership = @rebap_user.rebap_memberships.build(chapter: chapter)

    if @rebap_membership.save
      redirect_to admin_rebap_memberships_path, notice: "REBAP chapter created successfully."
    else
      flash.now[:alert] = "Failed to create REBAP chapter."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def require_admin!
    redirect_to root_path, alert: "Access denied." unless current_user.admin?
  end
end
