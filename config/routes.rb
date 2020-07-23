Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
	devise_for :users
	root 'home#top'
  # コントローラーアクション
  	get 'home/about' => "home#about"
  	resources :users, only: [:show,:index,:edit,:update] do
      # users にネストする＿フォロー機能[relationships コントローラ]
      # relationships コントローラ
      resource :relationships, only: [:create, :destroy]
      # users/id/follows usersコントローラのfollows アクションへ
      get :follows, on: :member # 追加
      # users/id/followsers usersコントローラのfollowers アクションへ
      get :followers, on: :member # 追加
    end
  	resources :books do
  		resource :favorites, only: [:create, :destroy]
  		resources :book_comments, only: [:create, :destroy]

  	end
end