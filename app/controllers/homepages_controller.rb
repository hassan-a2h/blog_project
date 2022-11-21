# frozen_string_literal: true

class HomepagesController < ApplicationController
  before_action :confirm_sign_in, except: :index
  before_action :authorized, only: [:reports]
  before_action :user_authorized, only: [:user]
  before_action :mod_authorized, only: [:mod]
  before_action :admin_authorized, only: [:admin]

  def index
    #### Polymorhphic associations are not getting eagerloaded.
    @posts = Post.published.includes(:likes, :comments, :suggestions)
  end

  private

  def authorized
    redirect_to root_path 'Prohibited Action!' unless current_user.mod?
  end

  def confirm_sign_in
    redirect_to root_path, alert: 'Action Forbidden!' unless user_signed_in?
  end

  def user_authorized
    redirect_to root_path, alert: 'Action Forbidden!' unless current_user.user?
  end

  def mod_authorized
    redirect_to root_path, alert: 'Action Forbidden!' unless current_user.mod?
  end

  def admin_authorized
    redirect_to root_path, alert: 'Action Forbidden!' unless current_user.admin?
  end

  def find_post
    post = params[:id] ? Post.find_by(id: params[:id]) : Post.find_by(id: params[:post_id])
    redirect_to root_path, alert: 'Error! could not find post' unless post
    post
  end

end
