Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :projects, only: [:index]
  resources :timesheets, only: [:index] do
    member do
      post "generate_pdf"
    end
    resources :timestamps, except: %i[index destroy] do
      member do
        post "stop"
      end
    end
  end
  resources :clients, except: :destroy do
    patch :archive, on: :member
    patch :restore, on: :member

    resources :projects, except: :destroy do
      patch :archive, on: :member
      patch :restore, on: :member

      resources :timesheets, except: %i[index destroy]
    end
  end
end
