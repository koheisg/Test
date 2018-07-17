class Geinin < ApplicationRecord
  # 複数メンバーを持てる
  has_many :geinin_members, dependent: :destroy
  accepts_nested_attributes_for :geinin_members, allow_destroy: true,reject_if: :all_blank

  # 複数タグ付けできる
  has_many :geinin_tags, dependent: :destroy
  accepts_nested_attributes_for :geinin_tags, allow_destroy: true,reject_if: :all_blank

  # 複数フォローできる
  has_many :followings, dependent: :destroy
  accepts_nested_attributes_for :followings, allow_destroy: true,reject_if: :all_blank

  #存在チェック
    validates :name, presence: true
    validates :yomi, presence: true

  # あいうえお順の昇順に並べ換える
    scope :including_geinin_info, -> { includes(:geinin_members, :geinin_tags, :followings)
                .references(:geinin_members, :geinin_tags, :followings)}
  # あいうえお順の昇順に並べ換える
    scope :order_by_yomi, -> { order(yomi: :asc) }

    scope :default, -> { order_by_yomi.including_geinin_info }
    
    #　フォローするになってるかチェック
    def followed_by?(user)
      Following.where(user_id: user.id).exists?
    end

end
