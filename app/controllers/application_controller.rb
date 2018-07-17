class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user, :logged_in?

  # aboutページの表示
  def about
	render '/about'
  end

  # プライバシーポリシーの表示
  def privacy
	render '/privacy'
  end

  # 利用規約ページの表示
  def terms
	render '/terms'
  end

  # 設定ページの表示
  def setting
  render '/setting'
  end

  # スケジュールの表示
  def participate
  #@user = current_user
  @participates = Participate.where(user_id: current_user.id)
  @pendings = Pending.where(user_id: current_user.id)
  @events = Event.all
  #@events = Event.where(id: @participates.event_id)
  #@events = Event.participate.reverse_order
  render '/participate'
  end

  # スケジュールの表示
  def schedule
  #@user = current_user
  @participates = Participate.where(user_id: current_user.id)
  @events = Event.all
  #@events = Event.where(id: @participates.event_id)
  #@events = Event.participate.reverse_order
  render '/schedule'
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  #end

  #private
  def set_current_user
    return unless session[:user_id]
    @current_user = User.find_by(id: session[:user_id])
    #@current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

  def authenticate
    return if logged_in?
    redirect_to root_path, alert: 'ログインしてください'
  end

  def escape_like(string)
    string.gsub(/[\\%_]/){|m| "\\#{m}"}
  end
end