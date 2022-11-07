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
    @posts = Post.published_by(current_user.id)
    @comments = Comment.by_user(current_user.id)
  end

  def mod
    @posts = Post.all.published_by(current_user.id)
  end

  def admin
    @posts = Post.all.published_by(current_user.id)
  end

end
