Rails.application.routes.draw do
  resources :notifications
  resources :scadas
  resources :sensors
  resources :sites

  namespace :api, defaults: {format: 'json'} do
   namespace :v1 do
     resources :sites
     resources :sensors
     resources :scadas
     resources :notifications

     get "/GetListPerSite/:id" => "sites#get_list_per_site"
     get "/GetListPerSensor/:id" => "sensors#get_list_per_sensor"
     get "/GetSensorNameScadaValuesPerSite/:id" => "sites#get_sensor_names_and_scada_values_per_site"
     get "/GetAllSensorNameScadaValues" => "sites#get_all_sensor_names_and_scada_values"
     get "/SensorInfo/:id" => "sensors#show"
     get "/SensorStatus/:id" => "notifications#sensor_status"
     get "/AllSensorStatus" => "notifications#all_sensor_status"
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
