Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :users do
   devise_for :users, controllers: {
     sessions: 'users/sessions',
     passwords: 'users/passwords',
     registrations: 'users/registrations'
   }
   root to: 'homes#top'
   get '/homes/about' => 'homes#about', as: 'homes_about'
   get 'users/timeline' => 'users#timeline', as: 'user_timeline'
   get 'users/:id/like_post' => 'users#like_post', as: 'user_like_post'
   get '/users/search_user_index' => 'users#search_user_index', as: 'search_user_index'
   resources :users, only: [:index, :show, :edit, :update] do
     get 'events/index' => 'events#index', as: 'events'
   end
   get '/users/:id/follow_index' => 'users#follow_index', as: 'user_follow'
   get '/users/:id/follower_index' => 'users#follower_index', as: 'user_follower'
   get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'user_unsubscribe'
   patch '/users/:id/withdraw' => 'users#withdraw', as: 'user_withdraw'
   resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
     resources :likes, only: [:create, :destroy]
     resources :comments, only: [:create, :destroy]
     get '/comments/:id/new_reply' => 'comments#new_reply', as: 'new_reply'
     post '/comments/:id/reply_create' => 'comments#reply_create', as: 'reply_create'
   end
   get '/posts/:id/show_like_users' => 'posts#show_like_users', as: 'show_like_users'
   get '/posts/confirm' => 'posts#confirm', as: 'posts_confirm'
  resources :relationships, only: [:destroy, :create]
  resources :chats, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :events, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :contacts, only: [:new, :create]
  get 'contacts/complete' => 'contacts#complete', as: 'contact_complete'
  end

  post "/upload_image" => "upload#upload_image", :as => :upload_image
  get "/download_file/:name" => "upload#access_file", :as => :upload_access_file, :name => /.*/

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  namespace :admins do
  get "/homes/top" => "homes#top", as: "homes"
  get '/users/search_user_index' => 'users#search_user_index', as: 'search_user_index'
  get '/users/:id/follow_index' => 'users#follow_index', as: 'user_follow'
  get '/users/:id/follower_index' => 'users#follower_index', as: 'user_follower'
  resources :users, only: [:index, :show, :update]
  get '/posts/search_post_index' => 'posts#search_post_index', as: 'search_post_index'
  resources :posts, only: [:index, :show, :destroy] do
    resources :comments, only: [:destroy]
  end
  get '/posts/:id/show_like_users' => 'posts#show_like_users', as: 'show_like_users'


  end
end
