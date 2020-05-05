class RentalsController < ApplicationController
  before_action :require_login
  before_action :destroy_rental, only: [:destroy]

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
      @planes = Plane.planes_available
      @airports = Airport.all
      render :new
    end
  end

  def edit
    @user = User.find(session[:id])
    @planes = Plane.planes_available
    @airports = Airport.all
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update(rental_params)
      redirect_to rental_path(@rental)
    else
      @user = User.find(session[:id])
      @planes = Plane.planes_available
      @airports = Airport.all
      render :edit
    end
  end

  def destroy
    @rental = Rental.find(params[:id])
    current_plane = Plane.find(@rental.plane_id)
    current_plane.available = !current_plane.available
    current_plane.save
    @user = User.find(session[:id])
    @rental.destroy
    redirect_to user_path(@user)
  end

  def show
    @rental = Rental.find(params[:id])
    @user = User.find(session[:id])
  end

  def return
    @rental = Rental.find(params[:id])
    current_plane = Plane.find(@rental.plane_id)
    @rental.rental_return = DateTime.now
    @rental.rental_cost = @rental.rental_period_actual * current_plane.daily_cost
    if @rental.save
      current_plane.available = !current_plane.available
      current_plane.save
      redirect_to user_path
    end
  end

  def invoice
    p params
    @rental = Rental.find(params[:id])
    @user = User.find(session[:id])
  end

  private

  def rental_params
    params.require(:rental).permit(:plane_id, :airport_id, :rental_start, :rental_end)
  end

  def require_login
    if !session.include? :id
      redirect_to login_path
    end
  end

  def destroy_rental
    @rental = Rental.find(params[:id])
    if @rental.rental_start < DateTime.now
      flash[:message] = "!!! Your rental has already started or has happened"
      redirect_to rental_path(@rental)
    end
  end
end
