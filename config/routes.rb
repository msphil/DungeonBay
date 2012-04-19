DungeonBay::Application.routes.draw do


  resources :users
  resources :campaigns#, :only => [:new, :create, :edit]#, :destroy]
  resources :characters#, :only => [:new, :create, :edit]#, :destroy]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :items,    :only => [:new, :create, :destroy]
  resources :auctions, :only => [:new, :create, :destroy, :index, :show]

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'

  match '/newcampaign', :to => 'campaigns#new'
  match '/newcharacter', :to => 'characters#new'
  match '/newitem', :to => 'items#new'
  match '/newauction', :to => 'auctions#new'
  match '/search_auctions', :to => 'auctions#search'

  root :to => 'pages#home'

  match '/characters/:id/select',  :controller => 'characters', :action => 'select'
  match '/characters/:id/add_gold',  :controller => 'characters', :action => 'add_gold'
  match '/characters/:id/update_gold/',  :controller => 'characters', :action => 'update_gold'
  match '/characters/:id/update_gold/:gold',  :controller => 'characters', :action => 'update_gold'
  match '/campaigns/:id/select',  :controller => 'campaigns', :action => 'select'
  match '/campaigns/:campaign_id/addcharacter/:character_id',  :controller => 'campaigns', :action => 'add_character'
  match '/campaignless',  :controller => 'characters', :action => 'index_campaignless'
  match '/items/:id/select',  :controller => 'items', :action => 'select'
  match '/auctions/:id/bid',  :controller => 'auctions', :action => 'bid'
  match '/auctions/:id/update_bid/',  :controller => 'auctions', :action => 'update_bid'
  match '/auctions/:id/finish_auction/',  :controller => 'auctions', :action => 'finish_auction'
  match '/search/results/',  :controller => 'auctions', :action => 'search_results'

end
