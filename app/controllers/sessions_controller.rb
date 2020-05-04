class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user 
      return head(:forbidden) unless @user.authenticate(params[:user][:password])
      session[:id] = @user.id
      redirect_to user_path(session[:id])
    else
      redirect_to new_user_path
    end
  end

  def destroy
    if session[:id]
      session.delete :id
      redirect_to login_path
    end
  end

end
