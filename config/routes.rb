DungeonBay::Application.routes.draw do


  resources :users
  resources :campaigns#, :only => [:new, :create, :edit]#, :destroy]
  resources :characters#, :only => [:new, :create, :edit]#, :destroy]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :items,    :only => [:create, :destroy]
  resources :auctions, :only => [:create, :destroy]

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'

  match '/newcampaign', :to => 'campaigns#new'
  match '/newcharacter', :to => 'characters#new'

  root :to => 'pages#home'

  match '/characters/:id/select',  :controller => 'characters', :action => 'select'

end
