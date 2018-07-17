class GeininMember < ApplicationRecord
  belongs_to :geinin
	has_many :geinin_member_tags, dependent: :destroy
end
