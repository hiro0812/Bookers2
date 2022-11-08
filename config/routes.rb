Rails.application.routes.draw do
devise_for :users #usersのdeviseを使用したcontrollerのルーティング ※devise のモデルを作成したことでルーティングが自動的に追加される
root to: "homes#top" #root to: "controller名#action名"=サイトのルートページを決める記述 #homesのcontrollerのルーティング
resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] #booksのcontrollerのルーティング
resources :users, only: [:index, :show, :edit, :update] #usersのcontrollerのルーティング
get  'home/about', to: 'homes#about', as: 'about' #homesのcontrollerのaboutページへのルーティング

end
