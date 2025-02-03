# Rails.application.routes.draw do
#   devise_for :users
#   root to: "pages#home"
#   resources :clients, except: :destroy do
#     patch :archive, on: :member
#     patch :restore, on: :member
#
#     resources :projects, except: :destroy do
#       patch :archive, on: :member
#       patch :restore, on: :member
#
#       resources :timesheets, except: :destroy do
#         resources :timestamps, only: [:new, :create]
#       end
#     end
#   end
# end



Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :projects, only: [:index]
  resources :clients, except: :destroy do
    patch :archive, on: :member
    patch :restore, on: :member

    resources :projects, except: :destroy do
      patch :archive, on: :member
      patch :restore, on: :member

      resources :timesheets, except: :destroy do
        resources :timestamps, except: [:index, :destroy] do
          member do
            post "stop"
          end
        end
      end
    end
  end
  resources :questions, only: [:index, :create]
end
