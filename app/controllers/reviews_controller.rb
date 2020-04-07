class ReviewsController < ApplicationController
  def create
    @camera = Camera.find(params[:camera_id])
    @review = Review.new(review_params)
    @review.camera = @camera
    authorize @review
    if @review.save
      respond_to do |format|
        format.html { redirect_to camera_path(@camera) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'cameras/show' }
        format.js  # <-- idem
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
