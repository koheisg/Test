class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, omniauth_providers: %i(twitter)

  # 1Userにつき何個もライブ情報を登録できる
    has_many :events

  # 1Userにつき何個もイイねできる
    has_many :participates, dependent: :destroy

  # 1Userにつき何個も検討中に入れられる
    has_many :pendings, dependent: :destroy

  # プロフィール画像の利用
   attachment :profile_image

  # Twitterログイン認証
  def self.find_for_oauth(auth, signed_in_resource=nil)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
       uid:      auth.uid,
       provider: auth.provider,
       nickname: auth[:info][:nickname],
       name: auth[:info][:name],
       image_url: auth[:info][:image],
       description: auth[:info][:description],
       url: auth[:info][:urls][:Website],
       email:    User.dummy_email(auth),
       password: Devise.friendly_token[0, 20]
      )
    end

    # unless user
    #   user = User.create(
    #     uid:      auth.uid,
    #     provider: auth.provider,
    #     email:    User.dummy_email(auth),
    #     password: Devise.friendly_token[0, 20],
    #     image_url: auth.info.image,
    #     name: auth.info.name,
    #     nickname: auth.info.nickname,
    #     description: auth.info.description
    #   )
    #   end

    user.skip_confirmation!
    # email仮をデータベースに保存するため、validationを一時的に無効化。
    user.save(validate: false)
    user
  end

  # twitterではemailを取得できないので、適当に一意のemailを生成
  private
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
   end
end