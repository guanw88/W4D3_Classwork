class ApplicationController < ActionController::Base

  helper_method :current_user

  def current_user
      @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def reroute_if_signed_in
    # debugger
    redirect_to cats_url if current_user
  end

  def redirect_if_signed_out
    redirect_to new_session_url unless current_user
  end

end
