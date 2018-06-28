Rails.application.routes.draw do
  root to: 'events#index'
  # Rootはライブ一覧ページ

  # 基礎情報ページの表示
  get '/about', to: 'root#about'　#当サイトについて
  get '/terms', to: 'root#terms' #利用規約
  get '/privacy', to: 'root#privacy' #プライバシーポリシー
  get '/survey', to: 'root#survey' #アンケート結果

  # ユーザー管理
    resources :users, only: [:show, :edit, :update, :create, :destroy]

    #Twitterログイン認証
     get 'auth/:provider/callback', to: 'sessions#create'
    #Twitterからログアウト
     delete '/logout', to: 'sessions#destroy'
    
    # ユーザー設定
    get '/setting', to: 'users#setting'　#

    # メール認証
    devise_for :users, :controllers => {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords",
    :omniauth_callbacks => "users/omniauth_callbacks"
    }

  #ライブ投稿
    resources :events, only: [:new, :create, :edit, :update, :index, :show, :destroy] do
        #出演者
        resource :event_performers, only: [:create, :update,:destroy]
        #リンク
        resource :event_links, only: [:create, :update,:destroy]
        #カテゴリ
        resource :event_categories, only: [:create, :update,:destroy]
        #更新履歴
        resource :event_change_histories, only: [:create, :destroy]
        #参加するボタン
        resource :participates, only: [:create, :destroy]
        #検討中ボタン
        resource :pendings, only: [:create, :destroy]
    end

    # 参加予定
    get 'schedule', to: 'events#schedule'

    # ライブ情報検索
    get 'search', to: 'events#search'

    # フォローしてる芸人のライブ一覧を表示する
    get 'following', to: 'events#following'

  # 芸人管理
    resources :geinins, only: [:new, :create, :edit, :update, :index, :show, :destroy]

    #フォローしてる芸人のスケジュールを表示する
    get 'schedule', to: 'geinin#schedule'

    #フォローしてる芸人の一覧を表示する
    get 'following', to: 'geinin#following'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end