# frozen_string_literal: true

class HomepagesController < ApplicationController
  def index
    #### Polymorhphic associations are not getting eagerloaded.
    @posts = Post.published.includes(:likes, :comments, :suggestions)
  end
end
