class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) && user.active?
      session[:user_id] = user.id
      session[:user_name] = user.full_name
      redirect_to root_path
    else
      redirect_to login_path
    end

    cookies.signed[:username] = session[:user_name]

    ActionCable.server.broadcast 'messages',
      message: "##HAS JOINED##",
      username: cookies.signed[:username]
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
