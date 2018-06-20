class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])

	# request.env['omniauth.auth']に、OmniAuthによってHashのようにユーザーのデータが格納されている。
    session[:uid] = user.uid
    redirect_to root_path, notice: 'ログインしました'
  end

  def destroy
    reset_session
    redirect_to events_path
  end
end