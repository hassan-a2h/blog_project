class CommentsController < ApplicationController

  ## Filters
  # Only signed in users can post
  before_action :confirm_sign_in
  # Only the owner can edit the post
  before_action :confirm_user, only: [:edit, :destroy]

  # Actions
  def index
    @post = Post.find_by(id: params[:post_id])

    redirect_to root_path, alert: 'Prohibited Action!' unless @post

    @comments = Comment.by_post(@post)
    # To allow user to comment while viewing all comments
    @comment = Comment.new
  end

  def new

  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.new(whitelist_params)

    if @comment.save
      redirect_to post_comments_path(@post), notice: 'Comment Added!'

    else
      redirect_to root_path, alert: 'Error! could not add comment'

    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    redirect_to root_path, alert: 'Error! could not find comment.' unless @comment
  end

  def update
    @comment = Comment.find_by(id: params[:id])

    if @comment.update(whitelist_params)
      redirect_to root_path, notice: 'Comment Updated'

    else
      redirect_to root_path, alert: 'Could not update Comment'

    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    redirect_to root_path, alert: 'Error! could not find comment.' unless @comment

    if @comment.destroy
      redirect_to root_path, notice: 'Comment Deleted'

    else
      redirect_to root_path, alert: 'Could not delete Comment'
    end
  end

  private

  # To whitelist params
  def whitelist_params
    params.require(:comment).permit(:user_id, :body)
  end

  # To confirm user
  def confirm_sign_in
    unless user_signed_in?
      session[:post_comments] = params[:post_id]
      redirect_to new_user_session_path, alert: 'You need to sign in first!'
    end
  end

  def confirm_user
    if Comment.find_by(id: params[:id]).user_id != current_user.id
      redirect_to root_path, alert: 'Error! Prohibited Action.'
    end
  end
end
