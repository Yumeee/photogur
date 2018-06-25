class PicturesController < ApplicationController
  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_owns_picture, only: [:edit, :update, :destroy]

  def index
    @most_recent_pictures = Picture.most_recent_five
    @one_month = Picture.created_before(Time.now - 1.month)
    @twenty_seventeen = Picture.pictures_created_in_year(2017)
    @twenty_eighteen = Picture.pictures_created_in_year(2018)
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def new
    @picture= Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to '/pictures'
    else
      render :new
    end
  end

  def edit
    load_picture
  end

  def update
    load_picture

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
  end

  def destroy
    load_picture
    @picture.destroy
    redirect_to "/pictures"
  end

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_user_owns_picture
    if current_user == nil
      flash[:alert] = "Please log in."
      redirect_to new_sessions_path
    elsif current_user != @picture.user
      flash[:alert] = "Sorry, you do not have access to this picture."
      redirect_to picture_path
    end
  end
end
