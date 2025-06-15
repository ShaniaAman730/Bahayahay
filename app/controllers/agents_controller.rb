class AgentsController < ApplicationController
  def index
    @query = params[:query]
    @agents = User.search_realtors(@query).order(created_at: :desc).page(params[:page]).per(8)
  end
end
