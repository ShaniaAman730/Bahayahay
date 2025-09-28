class AccreditationsController < ApplicationController
  before_action :authenticate_user! 
  before_action :ensure_developer!, only: [:developer_requests]
  before_action :set_realty, only: [:create]

  def developer_requests
    # pending & approved accreditations for this developer
    @pending_accreditations = Accreditation.pending.where(developer: current_user).includes(:realty)
    @approved_accreditations = Accreditation.approved.where(developer: current_user).includes(:realty).page(params[:page]).per(10)
  end

  # Head broker sends request
  def create
    developer = User.find(params[:developer_id])

    unless developer.developer?
      redirect_to @realty, alert: "Only developers can receive accreditation requests."
      return
    end

    accreditation = @realty.accreditations.find_or_initialize_by(developer: developer)

    if accreditation.persisted?
      if accreditation.rejected?
        accreditation.status = :pending
        if accreditation.save
          redirect_back fallback_location: @realty, notice: "Accreditation request re-submitted."
        else
          redirect_back fallback_location: @realty, alert: "Unable to reapply."
        end
      else
        redirect_back fallback_location: @realty, alert: "Accreditation request already exists."
      end
    else
      if accreditation.save
        redirect_back fallback_location: @realty, notice: "Accreditation request sent."
      else
        redirect_back fallback_location: @realty, alert: "Could not request accreditation."
      end
    end
  end


  # Developer approves/rejects
  def update
    accreditation = Accreditation.find(params[:id])
    if accreditation.developer == current_user
      if accreditation.update(status: params[:status])
        redirect_back fallback_location: accreditation.realty, notice: "Accreditation updated."
        #redirect_to accreditation.realty, notice: "Accreditation updated."
      else
        redirect_back fallback_location: accreditation.realty, alert: "Failed to update accreditation."
        #redirect_to accreditation.realty, alert: "Failed to update accreditation."
      end
    else
      redirect_to root_path, alert: "Not authorized."
    end
  end

  # Either party can remove
  def destroy
    accreditation = Accreditation.find(params[:id])
    if accreditation.realty.head_broker == current_user || accreditation.developer == current_user
      accreditation.destroy
      redirect_back fallback_location: accreditation.realty, notice: "Accreditation removed."
      # redirect_to accreditation.realty, notice: "Accreditation removed."
    else
      redirect_to root_path, alert: "Not authorized."
    end
  end

  private

  def set_realty
    @realty = Realty.find(params[:realty_id])
  end

  def ensure_developer!
    unless current_user&.developer?
      redirect_to root_path, alert: "Not authorized."
    end
  end
end
