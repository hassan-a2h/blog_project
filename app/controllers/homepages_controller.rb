# frozen_string_literal: true

class HomepagesController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_homepage_path
      elsif current_user.mod?
        redirect_to mod_homepage_path
      elsif current_user.user?
        redirect_to user_homepage_path
      end
    end

    @posts = Post.all
  end

  def user
    #### Polymorhphic associations are not getting eagerloaded.
    @posts = Post.where(status: :published).includes(:likes, :comments, :suggestions)
    @comments = Comment.by_user(current_user.id).includes(:post)
  end

  def mod
    @all_posts = Post.where(status: :published)
    @all_comments = Comment.all
    @reported_posts = Report.where(reportable_type: 'Post', status: :pending)
    @reported_comments = Report.where(reportable_type: 'Comment', status: :pending)
  end

  def admin
    @posts = Post.where(status: :published)
    @comments = Comment.all
  end
end
