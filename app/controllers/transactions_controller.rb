class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @transactions = Transaction.includes(:listing, :buyer, :seller).order(sold_at: :desc)
    else
      @transactions = current_user.sales.includes(:listing, :buyer).order(sold_at: :desc)
    end
  end
end
