class CamerasController < ApplicationController
  before_action :set_camera, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @cameras = policy_scope(Camera).order(created_at: :desc)
    @cameras = Camera.geocoded

    if params[:q].present?
      @cameras = @cameras.search(params[:q])
    end

    if params[:max_price].present?
      @cameras = @cameras.where('price < ?', params[:max_price])
    end

    @markers = @cameras.map do |camera|
      {
        lat: camera.latitude,
        lng: camera.longitude,
        infoWindow: render_to_string(partial: 'info_window', locals: { camera: camera }),
        image_url: helpers.asset_url('map-marker.png')
      }
    end
  end

  def new
    @page = true
    @camera = Camera.new
    @camera.owner = current_user
    authorize @camera
  end

  def show
    @review = Review.new
  end

  def create
    @camera = Camera.new(cameras_params)
    @camera.owner = current_user
    authorize @camera
    if @camera.save
      redirect_to cameras_path, notice: 'camera created.'
    else
      render :new
    end
  end

  def destroy
    @camera.destroy
    # redirect_to cameras_path, notice: 'camera was successfully destroyed.'
  end

  def edit
  end

  def update
    @camera.update(cameras_params)
    redirect_to camera_path(@camera)
  end

  private

  def set_camera
    @camera = Camera.find(params[:id])
    authorize @camera
  end

  def cameras_params
    params.require(:camera).permit(:name, :address, :price, :photo)
  end
end
