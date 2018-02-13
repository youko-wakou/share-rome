class PhotosController < ApplicationController
  def index
    @photo = current_user.photo
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:success] = '画像を設定しました'
      redirect_to photos_url
    else
      flash[:danger] = '画像の設定に失敗しました'
      render new_photo_path
    end
  end

  def new
    @photo = Photo.new
  end

  def update
    id = params[:id]
    @photot = Photo.find(id)
    if current_user.photo.update(photo_params)
      flash[:success] = '画像の更新に成功しました。'
      redirect_to photos_url
    else
      flash[:danger] = '画像の更新に失敗しました'
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @photo = Photo.find(id)
  end
  
  private
  def photo_params
    params.require(:photo).permit(:image_url,:user_id)
  end
end
