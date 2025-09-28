class ReviewEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:mark_as_read]

  def mark_as_read
    if @event.client == current_user || @event.realtor == current_user
      @event.update(read: true)
      head :ok
    else
      head :forbidden
    end
  end

  private

  def set_event
    @event = ReviewEvent.find(params[:id])
  end
end
