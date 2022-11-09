class HomepagesController < ApplicationController

  def index

    if user_signed_in?
      if current_user.role_admin?
        redirect_to admin_homepage_path

      elsif current_user.role_mod?
        redirect_to mod_homepage_path

      elsif current_user.role_user?
        redirect_to user_homepage_path

      end

    end

    @posts = Post.all

  end

  def user
    if session[:post_comments]
      @post = Post.find_by(id: session[:post_comments])
      session.delete(:post_comments) # To clear session so that we don't get stuck in loop.
      redirect_to post_comments_path(@post)
    end

    @posts = Post.where(status: :published)
    @comments = Comment.by_user(current_user.id).includes(:post)
  end

  def mod
    if session[:post_comments]
      @post = Post.find_by(id: session[:post_comments])
      redirect_to post_comments_path(@post)
    end

    @posts = Post.where(status: :published)
    @comments = Comment.all
  end

  def admin
    if session[:post_comments]
      @post = Post.find_by(id: session[:post_comments])
      redirect_to post_comments_path(@post)
    end

    @posts = Post.where(status: :published)
    @comments = Comment.all
  end

end
