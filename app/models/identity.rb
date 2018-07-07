class Identity < ApplicationRecord
  belongs_to :user

  #:providerと:uidはもちろんのことユーザーとの紐付け(:user_id)も保証
  validates_presence_of :user_id, :uid, :provider
  #:providerと:uidのペアは一意であることを保証
  validates_uniqueness_of :uid, uniqueness: {:scope => :provider}

  # Twitterログイン認証
  def self.find_for_oauth(auth, signed_in_resource=nil)
    identity = Identity.where(uid: auth.uid, provider: auth.provider).first

    unless identity
      identity = Identity.create(
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

    user.skip_confirmation!
    # email仮をデータベースに保存するため、validationを一時的に無効化。
    identity.save(validate: false)
    identity
  end
end
