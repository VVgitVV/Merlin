Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :projects, only: [:index]
  resources :timesheets, only: [:index] do
    resources :invoices, only: [:show] do
      member do
        post "generate_pdf"
      end
    end
    resources :timestamps, except: %i[index] do
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
      patch :complete, on: :member
      patch :start_tracking, on: :member

      resources :timesheets, except: %i[index destroy]
    end
  end
  resources :questions, only: [:index, :create]

end
