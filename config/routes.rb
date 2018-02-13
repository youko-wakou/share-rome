Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'histroys/index'

  get 'histroys/show'

  get 'histroys/new'

  get 'histroys/create'

  get 'histories/index'

  get 'histories/show'

  get 'histories/new'

  get 'histories/create'

   get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/new'

  get 'users/create'
  resources :profiles
  resources :photos,only:[:index,:new,:create,:update,:edit]
  resources :historys,only:[:index,:new,:create,:show]
  resources :messages do
    member do
      get 'preview'
      get 'download'
    end
    collection do 
    end
  end
  resources :topics do
    member do 
      get 'preview'
      get 'renew'
    end
    collection do
    end
  end
  root to: 'toppages#index'
  get 'signup',to:'users#new'
  
  get 'login',to:'sessions#new'
  post'login',to:'sessions#create'
  delete 'logout',to: 'sessions#destroy'
  
  resources :users,only:[:new,:create,:show]
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
