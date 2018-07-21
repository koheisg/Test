module HasLoggedInUser
  extend ActiveSupport::Concern

  # ユーザーIDを保存
  def logged_in?
  	if user_signed_in?
 	event_change_histories.user_id = current_user.user_id
  end
end