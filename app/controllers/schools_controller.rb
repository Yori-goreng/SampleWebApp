class SchoolsController < ApplicationController
  before_action :sign_in_required, only: [:new]

  def index
    @search_params = school_search_params
    @schools = school.search(@search_params).order(created_at: "DESC").page(params[:page]).per(6)
    all_genre = School.pluck(:genre) + School.pluck(:subgenre)
    @genres = all_genre.uniq.reject(&:blank?)
    all_prefecture = School.pluck(:prefecture)
    @prefectures = all_prefecture.uniq.reject(&:blank?)
  end

  def show
    @schools = School.find(params[:id])
    @reviews = @school.reviews.order(created_at: "DESC").page(params[:page]).per(3)
  end

  def new
    @school = School.new
    @user = User.last
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @school = School.new(      
      name: params[:name],
      address: params[:address],
      tell: params[:tell],
      latitude: params[:latitude],
      longitude: params[:longitude],
      image_url_a: params[:image_url_a],
      image_url_b: params[:image_url_b],
      genre: params[:genre],
      subgenre: params[:subgenre],
      prefecture: params[:prefecture],
      opentime: params[:opentime]
    )
    if @school.save
      puts "保存しました"
    else
      puts "すでに保存されています"
    end
  end

  private

  def school_search_params
    params.fetch(:search, {}).permit(:name, :prefecture, :genre)
  end
end
