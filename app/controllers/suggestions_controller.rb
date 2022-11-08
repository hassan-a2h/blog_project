class SuggestionsController < ApplicationController
  ## Filters
  # Only signed in users can post
  before_action :confirm_sign_in

  # Only the owner can edit the post
  before_action :confirm_user, only: [:edit, :destroy]


  # Suggestions don't have anything implemented, except for model, associations, controller, routes. You need to
  # make sure to get everything running, take inspiration from Comments.
  def index
    @post = Post.find_by(id: params[:post_id])

    redirect_to root_path, alert: 'Prohibited Action!' unless @post

    @suggestions = Suggestion.by_post(@post)
    # To allow user to add suggestion while viewing all suggestions
    @suggestion = Suggestion.new
  end

  def new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @suggestion = @post.Suggestion.new(whitelist_params)

    if @suggestion.save
      redirect_to post_suggestions_path(@post), notice: 'Suggestion made!'

    else
      redirect_to root_path, alert: 'Error! could not add suggestion'

    end
  end

  def edit
    @suggestion = Suggestion.find_by(id: params[:id])
    redirect_to root_path, alert: 'Error! could not find suggestion' unless @suggestion
  end

  def update
    @suggestion = Suggestion.find_by(id: params[:id])

    if @suggestion.update(whitelist_params)
      redirect_to root_path, notice: 'Suggestion Updated'

    else
      redirect_to root_path, alert: 'Could not update Suggestion'

    end
  end

  def destroy
    @suggestion = Suggestion.find_by(id: params[:id])
    redirect_to root_path, alert: 'Error! could not find Suggestion.' unless @suggestion

    if @suggestion.destroy
      redirect_to root_path, notice: 'Suggestion Removed'

    else
      redirect_to root_path, alert: 'Could not remove Suggestion'
    end
  end

  def accept
    @suggestion = Suggestion.find_by(id: params[:id])
    redirect_to root_path, alert: 'Could not find Suggestion' unless @suggestion

    redirect_to post_suggestions_path(params[:id]), alert: 'Could not find Suggestion' if @suggestion.status.accepted!
  end

  private

  def whitelist_params
    params.require(:suggestion).permit(:user_id, :body)
  end

  def confirm_sign_in
    unless user_signed_in?
      redirect_to root_path, alert: 'Action Forbidden!'
    end
  end

  def confirm_user
    suggestion = Suggestion.find_by(id: params[:id])
    unless suggestion.user_id == current_user.id || suggestion.post.user_id == current_user.id
      redirect_to root_path, alert: 'Error! Prohibited Action.'
    end
  end
end
