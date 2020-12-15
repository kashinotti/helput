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
   resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
     resources :likes, only: [:create, :destroy]
     resources :comments, only: [:create, :destroy, :show]
     post '/comments/replies' => 'comments#replies', as: 'comments_replies'
   end
   get '/posts/confirm' => 'posts#confirm', as: 'posts_confirm'
  end


  scope module: :admins do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  end
end
