class GuidesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_realtor_developer_rebap!, except: [:index, :show]
  before_action :ensure_realtor_developer_rebap!, except: [:index, :show]
  before_action :set_guide, only: [:show, :edit, :update, :destroy]
  before_action :authorize_guide_owner!, only: [:edit, :update, :destroy]

  def index
    if params[:q].present?
      @guides = Guide.search(params[:q]).order(created_at: :desc).page(params[:page]).per(6)
    else
      @guides = Guide.order(created_at: :desc).page(params[:page]).per(9)
    end
  end

  def my_guides
    @guides = current_user.guides.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @comment = Comment.new
    @comments = @guide.comments.order(created_at: :desc).page(params[:page]).per(5)

    # Statistics tracker
    if user_signed_in? && current_user.id != @guide.user_id
      Statistic.create!(
        trackable: @guide,
        visitor: current_user,
        event_type: :view
      )
    end
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

  def edit
  end

  def update
    if @guide.update(guide_params)
      redirect_to @guide, notice: "Guide was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @guide.destroy
    redirect_to my_guides_guides_path, notice: "Guide was successfully deleted."
  end

  private

  def ensure_realtor_developer_rebap!
    redirect_to root_path unless current_user.realtor? || current_user.developer? || current_user.rebap?
  end

  def set_guide
    @guide = Guide.find(params[:id])
  end

  def authorize_guide_owner!
    redirect_to root_path, alert: "You are not authorized to edit this guide." unless @guide.user == current_user
  end

  def guide_params
    params.require(:guide).permit(:title, :body, :guide_photo)
  end
end
