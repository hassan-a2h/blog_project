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
  end

  def user

  end

  def mod

  end

  def admin

  end

end
