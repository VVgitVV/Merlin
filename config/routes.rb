Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :clients, except: :destroy do
    resources :projects, except: :destroy do
      resources :timesheets, except: :destroy do
        resources :timestamps, except: :destroy do
          member do
            post "stop"
          end
        end
      end
    end
  end
end
