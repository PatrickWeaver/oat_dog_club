OatDogClub::Application.routes.draw do

  root 'static_pages#home'

  resources :users
  resources :zines
  resources :images, only: [:create, :show, :update]
  resources :paragraphs, only: [:create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :authorships
  resources :zine_contents
  resources :covers, only: [:create, :update]

  match '/help',                                to: 'static_pages#help',                      via: 'get'
  match '/about',                               to: 'static_pages#about',                     via: 'get'
  match '/contact',                             to: 'static_pages#contact',                   via: 'get'
  match '/signup',                              to: 'users#new',                              via: 'get'
  match '/signin',                              to: 'sessions#new',                           via: 'get'
  match '/signout',                             to: 'sessions#destroy',                       via: 'delete'
  match '/zines/:id/publish-unpublish',         to: 'zines#publish',                          via: 'get'
  match '/paragraphs/:id/font-size',            to: 'paragraphs#font_size',                   via: 'get'
  match '/paragraphs/:id/delete',               to: 'paragraphs#destroy',                     via: 'get'
  match '/images/:id/delete',                   to: 'images#destroy',                         via: 'get'
  match '/zines/:id/title',                     to: 'zines#title',                            via: 'get'
  match '/zines/:id/authors',                   to: 'zines#authors',                          via: 'get'
  match '/zines/:id/:author/remove',            to: 'zines#remove_author',                    via: 'get'
  match '/zines/:id/',                          to: 'zines#add_author',                       via: 'post'
  match '/zines/:id/delete',                    to: 'zines#delete',                          via: 'get'
  match '/zinecontents/:id/position',           to: 'zine_contents#position',                 via: 'get'
  match '/covers/:id/remove',                   to: 'covers#remove',                          via: 'get'
  match '/covers/:id/make-cover',               to: 'covers#cover',                           via: 'get'
  match '/zinecontents/:id/hide-border-color',  to: 'zine_contents#hide_border_color',        via: 'get'


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
