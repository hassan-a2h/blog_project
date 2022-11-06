Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resource :homepage do
    collection do
      get 'user'
      get 'mod'
      get 'admin'

    end
  end

  root "homepages#index"
end
