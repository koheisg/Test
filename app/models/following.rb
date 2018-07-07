class Following < ApplicationRecord
  belongs_to :user
  belongs_to :geinin

	#1ユーザー1回まで
	validates_uniqueness_of :geinin_id, scope: :user_id
end
