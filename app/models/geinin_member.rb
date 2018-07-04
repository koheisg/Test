class GeininMember < ApplicationRecord
  belongs_to :geinin
  has_many :geinin_member_tags, dependent: :destroy
  
  scope :including_geinin_member_info, -> { includes(:geinin_members_tags).references(:geinin_member_tags)}
end
