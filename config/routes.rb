Rails.application.routes.draw do

  # For Users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # For Posts
  resources :posts, shallow: true do
    # For Comments
    resources :comments
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
