Rails.application.routes.draw do

  #  Routing Concerns
  concern :likeable do
    resources :likes
  end

  # For Users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # For Posts
  resources :posts, concerns: [:likeable], shallow: true do
    # For Comments
    resources :comments, concerns: [:likeable]
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

  root "homepages#index"
end
