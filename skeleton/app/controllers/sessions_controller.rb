class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    debugger
    if @user # user found!
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      flash[:errors] = ['Incorrect credentials! Hacker alert! WHEEWOOOWHEEWHOO']
      render :new
    end
  end

  def destroy

  end
end
