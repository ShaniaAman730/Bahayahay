class RealtyMembershipsController < ApplicationController
  before_action :set_realty
  before_action :set_membership, only: [:approve, :reject, :update, :destroy, :request_removal, :approve_removal, :reject_removal, :force_remove]

  def approve
    @membership.update(status: :approved)
    redirect_to manage_members_realty_path(@realty), notice: "Membership approved."
  end

  def reject
    @membership.update(status: :rejected)
    reset_member(@membership.user) 
    redirect_to manage_members_realty_path(@realty), alert: "Membership rejected."
  end

  def create
    if @realty.pending? || @realty.rejected?
      redirect_to @realty, alert: "This realty is not approved for membership applications yet."
      return
    end

    membership = @realty.realty_memberships.find_or_initialize_by(user: current_user)

    if membership.left? || membership.rejected?
      membership.status = :pending
      if membership.save
        redirect_to @realty, notice: "Application resubmitted."
      else
        redirect_to @realty, alert: "Unable to resubmit application."
      end
    elsif membership.new_record?
      if membership.save
        redirect_to @realty, notice: "Application submitted."
      else
        redirect_to @realty, alert: "Unable to submit application."
      end
    else
      redirect_to @realty, alert: "You already have an active or pending membership here."
    end
  end


  def update
    membership = RealtyMembership.find(params[:id])
    if membership.realty.head_broker == current_user
      membership.update(status: params[:status])
      redirect_to membership.realty, notice: "Membership updated."
    else
      redirect_to root_path, alert: "Not authorized."
    end
  end

  def destroy
    membership = RealtyMembership.find(params[:id])
    if membership.user == current_user || membership.realty.head_broker == current_user
      reset_member(@membership.user) 
      membership.destroy
      redirect_to membership.realty, notice: "Membership removed."
    else
      redirect_to root_path, alert: "Not authorized."
    end
  end

  def request_removal
    if @membership.approved?
      @membership.update(status: :leaving)
      redirect_to @realty, notice: "Removal request submitted. The head broker will review it."
    else
      redirect_to @realty, alert: "You can only request removal if you are currently an approved member."
    end
  end

  def approve_removal
    if current_user == @realty.head_broker && @membership.leaving?
      @membership.update(status: :left)
      reset_member(@membership.user) 
      redirect_to @realty, notice: "Member successfully removed."
    else
      redirect_to @realty, alert: "Invalid action."
    end
  end

  def reject_removal
    if current_user == @realty.head_broker && @membership.leaving?
      @membership.update(status: :approved)
      redirect_to @realty, notice: "Removal request rejected. Member remains in the realty."
    else
      redirect_to @realty, alert: "Invalid action."
    end
  end

  def force_remove
    if current_user == @realty.head_broker && @membership
      @membership.update(status: :left)
      reset_member(@membership.user) 
      redirect_to @realty, notice: "Member removed by head broker."
    else
      redirect_to @realty, alert: "Not authorized or membership not found."
    end
  end


  private

  def set_realty
    @realty = Realty.find(params[:realty_id])
  end

  def set_membership
    @membership = @realty.realty_memberships.find_by(id: params[:id])
  end


  def reset_member(user)
    user.update(
      broker_name: "",
      company_name: "",
      address: ""
    )
  end

end
