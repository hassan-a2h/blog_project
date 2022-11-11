Rails.application.routes.draw do

  ##  Routing Concerns
  # For Comments
  concern :likeable do
    resources :likes, only: [:new]
  end

  # For Reports
  concern :reportable do
    resources :reports, only: [:new, :create, :destroy]
  end

  ## Normal Restful routes, with additional nested routes
  # For Users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # For Posts
  resources :posts, concerns: [:likeable, :reportable], shallow: true do
    # For Comments
    resources :comments, concerns: [:likeable, :reportable]

    # For suggestions
    resources :suggestions do
      member do
        get 'accept'
      end
    end
  end


  # For Homepage of each user
  resource :homepage do
    collection do
      get 'user'
      get 'mod'
      get 'admin'
    end

  end

  root 'homepages#index'
end
