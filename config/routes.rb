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
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  resources :users, only: [:show] do
    member do
      get 'comments'
      get 'posts'
      get 'likes'
      get 'suggestions'
    end

    collection do
      get 'reports'
    end
  end

  resources :posts, concerns: %i[likeable reportable], shallow: true do
    resources :comments, concerns: %i[likeable reportable replyable]
    resources :suggestions, concerns: [:replyable]

    collection do
      get 'approve'
    end

    member do
      post 'publish'
      post 'unpublish'
    end
  end

  resource :homepage, only: [:index]

  root 'homepages#index'
end
