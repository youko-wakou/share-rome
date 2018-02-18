Rails.application.routes.draw do
  
  get 'rankings/index'

  root to: 'toppages#index'
 
   get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/new'

  get 'users/create'
  post '/topics/:id/preview' => 'topics#preview'
  
  post '/topics/new' => 'topics#new'
  
  post '/photos/new' => 'photos#new'
  
  post '/photos/:id/edit' => 'photos#edit'
  
  post '/profiles/new' => 'profiles#new'
  
  post '/profiles/:id/edit' => 'profiles#edit'
  
  resources :profiles
  resources :photos,only:[:index,:new,:create,:update,:edit]
  resources :historys,only:[:index,:new,:create,:show]
  resources :favorites,only:[:index,:show,:new,:create,:update,:destroy]
  resources :rankings,only:[:index]
  resources :users do
    member do
      
    end
    collection do
      post 'create_friend'
      post 'word_create'
      get 'friend_list'
    end
  end
  
  resources :messages do
    member do
      get 'preview'
      get 'download'
      get 'renew'
      get 'reply'
      get 'comment'
    end
    collection do 
            post 'recreate'

    end
  end
  resources :topics do
    member do 
      get 'preview'
      get 'renew'
      get 'join'
      get 'category'
      patch 'usertopic_update'
      put 'usertopic_update'
    end
    collection do
      get 'user_topic'
      post 'edit_usertopic'
    end
  end
  root to: 'toppages#index'
  get 'signup',to:'users#new'
  
  get 'login',to:'sessions#new'
  post'login',to:'sessions#create'
  delete 'logout',to: 'sessions#destroy'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
