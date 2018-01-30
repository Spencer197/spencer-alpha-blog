Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'pages#home'# This make the homepage the root route, which doesn't need /home on the url to go there.
#get 'pages/home', to: 'pages#home' - Replaced by the above line.
get 'about', to: 'pages#about'
get 'help', to: 'pages#help'

resources :articles

get 'signup', to: 'users#new'
resources :users, except: [:new]#Provides all users routes except the 'new' route is called 'signup' instead of 'new'.

get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
delete 'logout', to: 'sessions#destroy'

resources :categories, except: [:destroy]
end
