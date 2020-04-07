class ReservationsController < ApplicationController
  before_action :set_camera, only: %i[new create]
  before_action :set_reservation, only: %i[show]

  def index
     @reservations = policy_scope(Reservation).order(created_at: :desc)
  end

  def new
    @reservation = Reservation.new
    authorize @reservation
  end

  def show
    authorize @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.camera = @camera
    authorize @reservation

    if @reservation.save
      redirect_to @reservation
      #reservation_path(@reservation)
    else
      render :new
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    authorize @reservation
    redirect_to reservations_path
  end

  private

  def set_camera
    @camera = Camera.find(params[:camera_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:day)
  end
end
