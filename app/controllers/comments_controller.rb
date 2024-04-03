class CommentsController < ApplicationController
  before_action :find_film, only: :create
  before_action :find_comment, except: :create

  def create
    
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to film_path(@film)
    end
  end

  def edit
    authorize @comment
  end

  def update
    @comment.assign_attributes(comment_params)

    if @comment.save
      redirect_to @comment.commentable
    else
      flash[:error] = @comment.errors.full_messages.join(", ")
      p :error
      render :edit
    end
  end

  def destroy
    authorize @comment

    @comment.destroy!
  end

  private

  def find_film
    @film = Film.find(params[:film_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
    .merge!(commentable: find_film, user: current_user)
  end
end