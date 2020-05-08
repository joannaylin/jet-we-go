class RentalsController < ApplicationController
  before_action :require_login
  before_action :destroy_rental, only: [:destroy]
  before_action :edit_rental, only: [:edit]
  before_action :plane_available, only: [:create]
  before_action :plane_available_edit, only: [:update]
  def new
    @rental= Rental.new
    @user = User.find(session[:id])
    # @planes = Plane.planes_available
    @planes = Plane.all
    @airports = Airport.all
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.user_id = session[:id]
    if @rental.save
      # planex = Plane.find(@rental.plane_id)
      # planex.update(available: false)
      flash[:message] = ""
      redirect_to rental_path(@rental)
    else
      @planes = Plane.all
      @airports = Airport.all
      render :new
    end
  end

  def edit
    @user = User.find(session[:id])
    @planes = Plane.all
    @airports = Airport.all
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    original_plane = @rental.plane_id 
    if @rental.update(rental_params)
      current_plane = Plane.find(@rental.plane_id)
      current_plane.available = !current_plane.available
      current_plane.save
      old_plane = Plane.find(original_plane)
      old_plane.available = !old_plane.available
      old_plane.save
      flash[:message] = ""
      redirect_to rental_path(@rental)
    else
      @user = User.find(session[:id])
      @planes = Plane.all
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
    else
      flash[:message] = "Cannot return plane before rental starts!"
      @user = User.find(session[:id])
      render :show
    end
  end

  def invoice
    @rental = Rental.find(params[:id])
    @user = User.find(session[:id])
  end

  def rating
    @rental = Rental.find(params[:id])
    p "*******************"
    p params
    @rental.update(rating_params)
    redirect_to rental_path(@rental)
  end
  
  private

  def rental_params
    params.require(:rental).permit(:plane_id, :airport_id, :rental_start, :rental_end)
  end

  def rating_params
    params.require(:rental).permit(:plane_rating)
  end

  def require_login
    if !session.include? :id
      redirect_to login_path
    end
  end

  def destroy_rental
    @rental = Rental.find(params[:id])
    if @rental.rental_start < DateTime.now
      flash[:message] = "Your rental has already started or has happened!"
      redirect_to rental_path(@rental)
    end
  end

  def edit_rental
    @rental = Rental.find(params[:id])
    if @rental.rental_return
      flash[:message] = "Cannot edit a completed rental!"
      redirect_to rental_path(@rental)
    end
  end

  def plane_available
    planec = Plane.find(rental_params[:plane_id])
   
    avail = true
    planec.rentals.where(rental_return: nil).each do |rental|
      if (rental_params[:rental_start] <= rental.rental_start &&  
        rental_params[:rental_end] >= rental.rental_start) ||
        (rental_params[:rental_start] <= rental.rental_end &&  
          rental_params[:rental_end] >= rental.rental_end) 
        avail = false
      end
    end
    if !avail
      @rental= Rental.new
      @user = User.find(session[:id])
      @planes = Plane.all
      @airports = Airport.all
      flash[:message] = "Plane not available for the selected dates!"
      render :new
    end
  end

  def plane_available_edit
    planec = Plane.find(rental_params[:plane_id])
    avail = true
    planec.rentals.where(rental_return: nil).each do |rental|
      if params[:id].to_i != rental.id
        if (rental_params[:rental_start] <= rental.rental_start &&  
          rental_params[:rental_end] >= rental.rental_start) ||
          (rental_params[:rental_start] <= rental.rental_end &&  
            rental_params[:rental_end] >= rental.rental_end) 
          avail = false
        end
      end
    end
    if !avail
      @rental= Rental.find(params[:id])
      @user = User.find(session[:id])
      @planes = Plane.all
      @airports = Airport.all
      flash[:message] = "Plane not available for the selected dates!"
      render :edit
    end
  end
end
