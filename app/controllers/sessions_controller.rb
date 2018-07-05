class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])

	# request.env['omniauth.auth']に、OmniAuthによってHashのようにユーザーのデータが格納されている。
    session[:uid] = user.uid

    @twitter_id = auth[:info][:nickname]
    @friends_count = auth[:extra][:raw_info][:friends_count]

    binding.pry

    if @user.sign_in_count == 0
      # 初回ログイン時のみ行いたい処理
      return @geinins = GetTwitterFollowingList.new(@twitter_id,@friends_count).execute
      redirect_to '/geinins/following'
    else 
      redirect_to root_path, notice: 'ログインしました'
    end
  end

  def destroy
    reset_session
    redirect_to events_url, notice: 'ログアウトしました'
  end
end