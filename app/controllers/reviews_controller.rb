class ReviewsController < ApplicationController
  def index
    @reviews = Review.all.order(created_at: "DESC").page(params[:page]).per(5)
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @reviews.user_id = current_user.id
    @review.school_id = @school.id
     if @review.save
      flash[:notice] = "作成できました"
      redirect_to restaurant_review_path(id: @review.id)
    else
      flash.now[:alert] = "作成に失敗しました。"
      render :new
    end
  end


end