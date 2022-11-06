class PostsController < ApplicationController
  # Only signed in users can post
  before_action :confirm_sign_in

  # Only the owner can edit the post
  before_action :confirm_user, only: [:edit]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])

    unless @post
      redirect_to root_path, alert: "Could not find post."
    end
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = Post.new(whitelist_post_params)

    if @post.save
      flash[:notice] = "Post created"
      redirect_to post_path(@post)

    else
      flash[:alert] = "Error! Could not save post."
      redirect_to root_path
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @user = current_user

    unless @post
      redirect_to root_path, alert: "Could not find Post"
    end
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.update(whitelist_post_params)
      redirect_to post_path(@post), notice: "Post Updated"

    else
      redirect_to root_path, alert: "Could not update Post!"

    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
  end

  private

  def whitelist_post_params
    params.require(:post).permit(:title, :body, :user_id, :status)
  end

  def confirm_sign_in
    unless user_signed_in?
      redirect_to root_path, alert: "Action Forbidden!"
    end
  end

  def confirm_user
    if Post.find_by(id: params[:id]).user_id != current_user.id
      redirect_to root_path, alert: "Error! Prohibited Action."
    end
  end

end
