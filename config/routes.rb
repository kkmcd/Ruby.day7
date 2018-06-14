Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/home/index' => 'home#index' #/로 시작하는 규칙만 지켜주면됨.
  
  #route => controller 순서임.
  
  root 'home#index'
  #get '/lotto' => 'home#lotto'
  get '/lunch' => 'home#lunch'
  
  get '/users' => 'user#index'
  get '/user/:id' => 'user#show'
  get '/users/new' => 'user#new'
  post '/user/create' => 'user#create'
  
  get '/lotto' => 'lotto#index'
  get '/lotto/new' => 'lotto#new'
  
end
