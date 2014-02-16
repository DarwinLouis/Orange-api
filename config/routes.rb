OrangeApi::Application.routes.draw do

  devise_for :users

  namespace :api do
	namespace :v1 do
		devise_scope :user do
			post 'registrations' => 'registrations#create', :as => 'register'
			post 'sessions' => 'sessions#create', :as => 'login'
			put 'registrations' => 'users#update', :as => 'update_register'
			get 'registrations/:id' => 'users#show', :as => 'user'
			delete 'sessions' => 'sessions#destroy', :as => 'logout'
		end
		resources :passwords, only: [:put,:post] do
			collection do 
				put 'reset_password'
				post 'request_reset'
			end
		end

		resources :vouchers do
			collection do
				post 'claims', :to => "vouchers#claim_voucher"
			end
		end

		resources :items do
			collection do
				get 'search', :to => 'items#search'
			end
		end
		resource :feedbacks
		get 'memberships/:id' => 'memberships#show', :as => 'membership'
		resource :promos do
			collection do
				get 'branches/:id', :to => 'promos#branch'
			end
		end
		resources :credits, :only => [:create, :show]
		resources :devices, :only => [:create]
		resources :branches, :only => [:create, :update, :index, :destroy, :show] do
			collection do 
				get 'search', :to => 'branches#search'  
			end
		end

	end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
