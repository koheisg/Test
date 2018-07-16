Rails.application.routes.draw do
  root to: 'events#index'
  # Rootはライブ一覧ページ

  # 基礎情報ページの表示
  get '/about', to: 'root#about'
  get '/terms', to: 'root#terms'
  get '/privacy', to: 'root#privacy'
  get '/setting', to: 'root#setting'

  #フォローしてる芸人のスケジュールを表示する
  get '/schedule', to: 'root#schedule'

  #参加予定
  get '/participate', to: 'root#participate'

  #ライブ情報検索
  get 'search', to: 'events#search'

  #Twitterログイン認証
   get 'users/auth/:provider/callback', to: 'sessions#create'
  #Twitterからログアウト
   get '/logout', to: 'sessions#destroy'

  #ユーザー認証
    devise_for :users, :controllers => {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  # ユーザー管理
  resources :users, only: [:show, :edit, :update, :create, :destroy]

  #ライブ投稿
  resources :events, only: [:new, :create, :edit, :update, :index, :show, :destroy] do
      #参加するボタン
      resource :participates, only: [:create, :destroy]
      #検討中ボタン
      resource :pendings, only: [:create, :destroy]
      #出演者
      resource :event_performers, only: [:create, :update,:destroy]
      #リンク
      resource :event_links, only: [:create, :update,:destroy]
      #カテゴリ
      resource :event_categories, only: [:create, :update,:destroy]
      #更新履歴
      resource :event_change_histories, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end