class CitiesController < ApplicationController
  before_action :require_login

  def index
    @cities = City.city_list
  end

  def show
    @city = City.find(params[:id])
  end

  private

  def require_login
    if !session.include? :id
      redirect_to login_path
    end
  end

end