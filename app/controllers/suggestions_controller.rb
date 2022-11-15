class SuggestionsController < ApplicationController

  before_action :confirm_sign_in
  before_action :confirm_user, only: %i[edit destroy]

  def index
    @post = find_post

    @suggestions = Suggestion.includes(:user).by_post(@post)
    @suggestion = Suggestion.new
  end

  def new; end

  def create
    @post = find_post

    @suggestion = @post.suggestions.new(whitelist_params)
    redirect_to root_path, alert: 'Error! could not find Suggestion.' unless @suggestion

    if @suggestion.save
      redirect_to post_suggestions_path(@post), notice: 'Suggestion made!'
    else
      redirect_to root_path, alert: 'Error! could not add suggestion'
    end
  end

  def edit
    @suggestion = find_suggestion
  end

  def update
    @suggestion = find_suggestion

    if @suggestion.update(whitelist_params)
      redirect_to root_path, notice: 'Suggestion Updated'
    else
      redirect_to root_path, alert: 'Could not update Suggestion'
    end
  end

  def destroy
    @suggestion = find_suggestion

    if @suggestion.destroy
      redirect_to root_path, notice: 'Suggestion Removed'
    else
      redirect_to root_path, alert: 'Could not remove Suggestion'
    end
  end

  def accept
    @suggestion = find_suggestion
    redirect_to post_suggestions_path(params[:id]), alert: 'Could not find Suggestion' if @suggestion.status.accepted!
  end

  private

  def whitelist_params
    params.require(:suggestion).permit(:user_id, :body)
  end

  def confirm_sign_in
    redirect_to root_path, alert: 'Action Forbidden!' unless user_signed_in?
  end

  def confirm_user
    suggestion = find_suggestion
    unless suggestion.user_id == current_user.id || suggestion.post.user_id == current_user.id
      redirect_to root_path, alert: 'Error! Prohibited Action.'
    end
  end

  def find_post
    post = params[:id] ? Post.find_by(id: params[:id]) : Post.find_by(id: params[:post_id])
    redirect_to root_path, alert: 'Error! could not find post' unless post
    post
  end

  def find_suggestion
    suggestion = params[:id] ? Suggestion.find_by(id: params[:id]) : Suggestion.find_by(id: params[:suggestion_id])
    redirect_to root_path, alert: 'Error! could not find suggestion' unless suggestion
    suggestion
  end
end
