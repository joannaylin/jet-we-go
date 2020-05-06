class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect_to user_path(session[:id])
    else
      flash[:message] = "Authentication failed!"
      redirect_to '/login'
    end
  end

  def destroy
    if session[:id]
      session.delete :id
      redirect_to login_path
    end
  end

end
