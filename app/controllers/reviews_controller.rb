class ReviewsController < ApplicationController
  before_action :set_restaurant, only: [:new, :create, :index]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    @review.save

    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      @restaurant.errors.full_messages
      render :new
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
