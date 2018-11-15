class SessionsController < ApplicationController
  before_action :reroute_if_signed_in, only: [:new]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      flash[:errors] = ['Incorrect credentials! Hacker alert! WHEEWOOOWHEEWHOO']
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to new_session_url
    end
  end
end
