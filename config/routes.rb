Code::Application.routes.draw do
  get "tracks/new"
  resources :users,  except: [:edit, :show, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  # Shallow nesting to ensure paths are not filled with unnecessary information.
  resources :courses, except: :show, shallow: true do
    resources :tracks do
      resources :lessons
    end
  end

  root 'pages#home'

  match '/help',      to: 'pages#help',      via: 'get'
  match '/about',     to: 'pages#about',     via: 'get'
  match '/contact',   to: 'pages#contact',   via: 'get'
  match '/dashboard', to: 'users#dashboard', via: 'get'

  match '/courses/:permalink', to: 'courses#show', via: 'get', as: 'custom_course'

  match '/signup',  to: 'users#new',        via: 'get'
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'


  # All paths must be declared before this to ensure Rails does not think
  # it is a username for a user (:permalink)
  match '/:permalink',      to: 'users#destroy', via: 'delete', as: 'custom_delete_user'
  get   '/:permalink',      to: 'users#show',    as: 'custom_user'
  get   '/:permalink/edit', to: 'users#edit',    as: 'custom_edit_user'

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
