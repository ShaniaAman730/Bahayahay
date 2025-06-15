# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :set_guide

  def create
    @comment = @guide.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to guide_path(@guide, anchor: "comments"), notice: "Comment posted."
    else
      @comments = @guide.comments.order(created_at: :desc).page(params[:page]).per(5)
      flash.now[:alert] = "Comment can't be blank."
      render "guides/show", status: :unprocessable_entity
    end
  end

  private

  def set_guide
    @guide = Guide.find(params[:guide_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
