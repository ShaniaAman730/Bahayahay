# app/controllers/guides_controller.rb
class GuidesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_realtor_developer!, except: [:index, :show]
  before_action :ensure_realtor_developer!, except: [:index, :show]
  before_action :set_guide, only: [:show]

  def index
    if params[:q].present?
      @guides = Guide.search(params[:q]).order(created_at: :desc).page(params[:page]).per(6)
    else
      @guides = Guide.order(created_at: :desc).page(params[:page]).per(7)
    end
  end

  def show
	@guide = Guide.find(params[:id])
	@comment = Comment.new
	@comments = @guide.comments.order(created_at: :desc).page(params[:page]).per(5)
  end


  def new
    @guide = current_user.guides.build
  end

  def create
    @guide = current_user.guides.build(guide_params)
    if @guide.save
      redirect_to @guide, notice: "Guide was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ensure_realtor_developer!
    redirect_to root_path unless current_user.realtor? || current_user.developer?
  end

  def set_guide
    @guide = Guide.find(params[:id])
  end

  def guide_params
    params.require(:guide).permit(:title, :body, :guide_photo)
  end
end
