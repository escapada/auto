class NewphotoController < ::ApplicationController
  def index
    @photos = ItemPhoto.all
  end
 
  def new
    @photo = ItemPhoto.new
  end
 
  def create
    @photo = ItemPhoto.new(photo_params)
    if @photo.save
      flash[:success] = "Photo saved!"
      redirect_to item_photos_path
    else
      render 'new'
    end
  end
end
 