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
   resources :users, only: [:show, :edit, :update] do
     get 'events/index' => 'events#index', as: 'events'
   end
   get '/users/:id/follow_index' => 'users#follow_index', as: 'user_follow'
   get '/users/:id/follower_index' => 'users#follower_index', as: 'user_follower' 
   get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'user_unsubscribe'
   patch '/users/:id/withdraw' => 'users#withdraw', as: 'user_withdraw'
   resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
     resources :likes, only: [:create, :destroy]
     resources :comments, only: [:create, :destroy, :show]
     post '/comments/replies' => 'comments#replies', as: 'comments_replies'
   end
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


  namespace :admins do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  get "/homes/top" => "homes#top", as: "homes"
  resources :users, only: [:index, :show, :update]
  get '/posts/search_index' => 'posts#search_index', as: 'search_index'
  resources :posts, only: [:index, :show, :destroy]
  

  end
end
