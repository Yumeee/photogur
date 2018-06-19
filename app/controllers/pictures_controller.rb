class PicturesController < ApplicationController
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
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])

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
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to "/pictures"
  end
end
