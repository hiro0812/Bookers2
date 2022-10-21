Rails.application.routes.draw do
devise_for :users #usersのdeviseのcontroller
root to: "homes#top" #homesのcontroller
resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] #booksのcontroller
resources :users, only: [:index, :show, :edit, :update] #usersのcontroller
get  'homes/about', to: 'homes#about', as: 'about' #homesのcontrollerのaboutページへのルーティング

end
