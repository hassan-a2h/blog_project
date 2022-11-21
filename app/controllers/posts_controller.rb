# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :confirm_sign_in
  before_action :confirm_user, only: %i[edit destroy]

  def index
    @posts = Post.published.includes(:likes, :comments, :suggestions)
  end

  def show
    @post = find_post
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = Post.new(whitelist_post_params)

    if @post.save
      flash[:notice] = 'Post Created (Approval Pending)'
      redirect_to post_path(@post)
    else
      flash[:alert] = 'Error! Could not save post.'
      redirect_to root_path
    end
  end

  def edit
    @post = find_post
    @user = current_user
  end

  def update
    @post = find_post
    @post.attachment.purge if whitelist_edit_params

    if @post.update(whitelist_post_params)
      redirect_to post_path(@post), notice: 'Post Updated'
    else
      redirect_to root_path, alert: 'Could not update Post!'
    end
  end

  def destroy
    @post = find_post

    if @post.destroy
      redirect_to root_path, notice: 'Post Deleted!'
    else
      redirect_to post_path(@post), alert: 'Could not delete Post!'
    end
  end

  def approve
    @pending_posts = Post.pending_posts.includes(:user)
  end

  def publish
    @post = find_post

    if @post.published!
      redirect_to approve_posts_path, notice: 'Post Published!'
    else
      render :approve, alert: 'Error! could not publish post'
    end
  end

  def unpublish
    @post = find_post

    if @post.unpublished!
      redirect_to approve_posts_path, notice: 'Post Unpublished!'
    else
      render :approve, alert: 'Error! could not unpublish post'
    end
  end

  def user_posts
    @posts = Post.published_by(current_user.id).published
  end

  private

  def whitelist_post_params
    params.require(:post).permit(:title, :body, :user_id, :status, :attachment)
  end

  def whitelist_edit_params
    params.require(:post).permit(:no_attachment)
  end

  def confirm_sign_in
    redirect_to root_path, alert: 'Action Forbidden!' unless user_signed_in?
  end

  def confirm_user
    return if Post.find_by(id: params[:id]).user_id == current_user.id || current_user.mod?

    redirect_to root_path, alert: 'Error! Prohibited Action.'
  end

  def find_post
    post = params[:id] ? Post.find_by(id: params[:id]) : Post.find_by(id: params[:post_id])
    redirect_to root_path, alert: 'Error! could not find post' unless post
    post
  end
end
