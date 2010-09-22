ActionController::Routing::Routes.draw do |map|
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  
  # Home page
  map.root :controller => 'home', :action => 'index'
  
  # Static pages
  map.about 'about', :controller => 'home', :action => 'about'
  map.contact 'contact', :controller => 'home', :action => 'contact'
  map.license 'license', :controller => 'home', :action => 'license'
  
  # Datasets
  map.resources :datasets, :member => {:count_download => :post}
  map.tagged_datasets 'datasets/tagged/:tag', :controller => 'datasets', :action => 'tagged_with'
  map.dataset_category 'datasets/categories/:category', :controller => 'datasets', :action => 'in_category'

  # Applications
  map.resources :apps

  # Companies
  map.resources :companies

  # Press
  map.resources :press_items

  # Authentication
  map.devise_for :admins
end
