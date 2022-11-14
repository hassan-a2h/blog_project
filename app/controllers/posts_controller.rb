class PostsController < ApplicationController
  # Only signed in users can post
  before_action :confirm_sign_in

  # Only the owner can edit the post
  before_action :confirm_user, only: [:edit, :destroy]

  def index
    @posts = Post.all.includes(:likes, :comments, :suggestions)
  end

  def show
    @post = Post.find_by(id: params[:id])

    unless @post
      redirect_to root_path, alert: 'Could not find post.'
    end
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = Post.new(whitelist_post_params)

    if @post.save
      flash[:notice] = 'Post created'
      redirect_to post_path(@post)

    else
      flash[:alert] = 'Error! Could not save post.'
      redirect_to root_path
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @user = current_user

    redirect_to root_path, alert: 'Could not find Post' unless @post
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.attachment.purge if whitelist_edit_params

    if @post.update(whitelist_post_params)
      redirect_to post_path(@post), notice: 'Post Updated'

    else
      redirect_to root_path, alert: 'Could not update Post!'

    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    if @post.destroy
      redirect_to root_path, notice: 'Post Deleted!'

    else
      redirect_to post_path(@post), alert: 'Could not delete Post!'

    end
  end

  # Additional Actions

  private

  def whitelist_post_params
    params.require(:post).permit(:title, :body, :user_id, :status, :attachment)
  end

  def whitelist_edit_params
    params.require(:post).permit(:no_attachment)
  end

  def confirm_sign_in
    unless user_signed_in?
      redirect_to root_path, alert: 'Action Forbidden!'
    end
  end

  def confirm_user
    unless Post.find_by(id: params[:id]).user_id == current_user.id || current_user.role_mod?
      redirect_to root_path, alert: 'Error! Prohibited Action.'
    end
  end
end
