ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  # map.connect ':controller/service.wsdl', :action => 'wsdl'

  map.video 'video/:slug', :controller => 'video', :action => 'show'
  map.tag 'tag/:name', :controller => 'tag', :action => 'show'
  map.user 'users/:login', :controller => 'users', :action => 'show'

  map.resources :users
  map.resource :session

  map.signup '/signup', :controller => "users", :action => "new"
  map.login '/login', :controller => "session", :action => "new"
  map.logout '/logout', :controller => "session", :action => "destroy"

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
