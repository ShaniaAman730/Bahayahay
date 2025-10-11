class RebapsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_rebap!
  before_action :set_rebap_membership, only: [:show, :edit, :update]
  before_action :authorize_rebap!, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @rebap_membership.update(rebap_membership_params)
      redirect_to edit_rebap_path(@rebap_membership), notice: "Chapter name updated successfully."
    else
      flash.now[:alert] = "Failed to update chapter name."
      render :edit, status: :unprocessable_entity
    end
  end

  def manage_members
    @rebap = current_user
    @officers = @rebap.rebap_memberships.where.not(role: nil).order(:role)
    @active_memberships = @rebap.rebap_memberships.joins(:member).where(role: [nil, ""]).where(users: { user_type: "realtor" }).order(created_at: :desc).page(params[:page]).per(20)

    # Handle search if query is provided
    if params[:query].present?
      query = params[:query].strip
      @members = User.realtor.where("first_name ILIKE :q OR last_name ILIKE :q OR prc_no ILIKE :q",q: "%#{query}%")
                             .order(:first_name).page(params[:page]).per(10)
    end
  end

  def add_member
    member = User.find(params[:member_id])

    if member.rebap_memberships.exists?
      redirect_to manage_members_rebaps_path, alert: "#{member.full_name} is already a member of another REBAP chapter."
      return
    end

    current_user.rebap_memberships.create!(member: member, chapter: "Naga City Chapter")
    redirect_to manage_members_rebaps_path, notice: "#{member.full_name} added as an active member."
  end



  def assign_officer
    membership = RebapMembership.find(params[:membership_id])
    membership.update(role: params[:role], year: params[:year])
    redirect_to manage_members_rebaps_path, notice: "#{membership.member.full_name} is now #{params[:role]} for #{params[:year]}."
  end

  def remove_member
    membership = RebapMembership.find(params[:id])
    membership.destroy
    redirect_to manage_members_rebaps_path, notice: "#{membership.member.full_name} removed successfully."
  end

  def manage_officers
    @rebap = current_user
    @officers = @rebap.rebap_memberships.where.not(role: [nil, ""]).order(:order).page(params[:page]).per(20)

      query = params[:query].to_s.strip
      rebap = current_user

      @members = User.joins("INNER JOIN rebap_memberships ON rebap_memberships.member_id = users.id")
        .where(rebap_memberships: { rebap_id: rebap.id })
        .where(user_type: 2) 
        .where("users.first_name ILIKE :q OR users.last_name ILIKE :q OR users.prc_no ILIKE :q", q: "%#{query}%")
        .distinct.order(:first_name).page(params[:page]).per(10)
  end



  def assign_officer
    membership = RebapMembership.find(params[:membership_id])
    if membership.update(role: params[:role], year: params[:year], order: params[:order])
      redirect_to manage_officers_rebaps_path, notice: "#{membership.member.full_name} assigned as #{membership.role}."
    else
      redirect_to manage_officers_rebaps_path, alert: "Failed to assign officer."
    end
  end

  def unassign_officer
    membership = RebapMembership.find(params[:id])
    membership.update(role: nil, year: nil, order: nil)
    redirect_to manage_officers_rebaps_path, notice: "Officer unassigned successfully."
  end

  private

  def set_rebap_membership
    # Find the membership tied to the logged-in REBAP user
    @rebap_membership = RebapMembership.find_by(rebap_id: current_user.id)

    unless @rebap_membership
      redirect_to root_path, alert: "No REBAP membership record found."
    end
  end

  def rebap_membership_params
    params.require(:rebap_membership).permit(:chapter, :year, :role, :order)
  end

  def authorize_rebap!
    unless @rebap_membership.rebap_id == current_user.id
      redirect_to root_path, alert: "You are not authorized to edit this chapter."
    end
  end

  def require_rebap!
    redirect_to root_path, alert: "Access denied." unless current_user.user_type == "rebap"
  end
end
