Rails.application.routes.draw do
  devise_for :users

  # Root path handling
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  unauthenticated do
    root 'pages#home', as: :unauthenticated_root
  end

  # Dashboard
  get 'dashboard', to: 'dashboard#index'

  # Standalone resources
  resources :projects, only: [:index]
  resources :questions, only: [:index, :create]

  # Timesheet hierarchy
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

  # Client hierarchy
  resources :clients, except: :destroy do
    member do
      patch :archive
      patch :restore
    end

    resources :projects, except: :destroy do
      member do
        patch :archive
        patch :restore
        patch :complete
        patch :start_tracking
      end

      resources :timesheets, except: %i[index destroy]
    end
  end
end