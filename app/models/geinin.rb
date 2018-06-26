class Geinin < ApplicationRecord
	has_many :geinin_members, dependent: :destroy
	has_many :geinin_tags, dependent: :destroy

  #存在チェック
    validates :name, presence: true
    validates :yomi, presence: true

  # あいうえお順の昇順に並べ換える
    default_scope -> { order(yomi: :asc) }
end
