class PlanesController < ApplicationController
  before_action :require_login

  def index
    @planes = Plane.all
    @user = User.find(session[:id])
  end

  def show
    @plane = Plane.find(params[:id])
  end

  private

  def require_login
    if !session.include? :id
      redirect_to login_path
    end
  end

end
