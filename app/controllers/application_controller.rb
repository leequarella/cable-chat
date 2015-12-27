class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

  def authenticate
    redirect_to login_path unless current_user && current_user.active?
  end

  def current_user
    unless @current_user = User.find_by_id(session[:user_id])
      @current_user = User.temp
    end
    @current_user
  end
  helper_method :current_user
end
