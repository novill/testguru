Rails.application.routes.draw do
  devise_for :users,
             path: :gurus,
             path_names: { sign_in: :login, sign_out: :logout }

  root 'tests#index'

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :send_gist
      get :time_left
    end
  end

  resource :feedback, only: :new, controller: 'feedback' do
    post :send_email
  end

  resources :badges, only: :index do
    get :index_by_user, on: :collection
  end

  namespace :admin do
    resources :user_badges
    resources :badge_types
    resources :badges
    resources :test_passages, only: :index
    resources :users, only: :index
    resources :gists, only: :index
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
  end
end
