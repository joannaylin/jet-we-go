class RentalsController < ApplicationController
  before_action :require_login
  def index
  end

  def new
    @rental= Rental.new
    @user = User.find(session[:id])
    @planes = Plane.planes_available
    @airports = Airport.all
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.user_id = session[:id]
    if @rental.save
      planex = Plane.find(@rental.plane_id)
      planex.update(available: false)
      redirect_to rental_path(@rental)
    else  
      redirect_to new_rental_path
    end
  end

  def show
    @rental = Rental.find(params[:id])
  end

  private

  def rental_params
    params.require(:rental).permit(:plane_id, :airport_id)
  end
  def require_login
    if !session.include? :id
      redirect_to login_path
    end
  end
end
