DungeonBay::Application.routes.draw do
  #get "characters/new"
  #get "campaigns/new"

  resources :users
  resources :campaigns#, :only => [:new, :create, :edit]#, :destroy]
  resources :characters#, :only => [:new, :create, :edit]#, :destroy]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :items,    :only => [:create, :destroy]

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'

  match '/newcampaign', :to => 'campaigns#new'
  match '/newcharacter', :to => 'characters#new'

  root :to => 'pages#home'

end
