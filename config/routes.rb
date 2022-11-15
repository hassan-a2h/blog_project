# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/homepage/admin', as: 'rails_admin'
  concern :likeable do
    resources :likes, only: [:new]
  end

  concern :reportable do
    resources :reports, only: %i[new create destroy]
  end

  concern :replyable do
    resources :replies, only: %i[index create destroy]
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :posts, concerns: %i[likeable reportable], shallow: true do
    resources :comments, concerns: %i[likeable reportable replyable]
    resources :suggestions, concerns: [:replyable] do
      member do
        get 'accept'
      end
    end
  end

  resource :homepage do
    collection do
      get 'user'
      get 'mod'
      get 'admin'
      get 'my_posts'
      get 'my_comments'
      get 'my_likes'
      get 'reports'
    end
  end

  root 'homepages#index'
end
