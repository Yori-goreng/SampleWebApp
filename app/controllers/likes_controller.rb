class LikesController < ApplicationController
  before_action :sign_in_required

    def create
      @review = Review.find(params[:review_id])
      unless @review.like_rev?(current_user)
        @review.like_rev(current_user)
        @review.create_notification_like!(current_user)
        @review.reload
      end
    end

    def destroy
      @review = Like.find(params[:id]).review
      if @review.like_rev?(current_user)
        @review.un_like_rev(current_user)
        @review.reload
      end
    end
end
