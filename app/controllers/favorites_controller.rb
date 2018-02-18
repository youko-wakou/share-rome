class FavoritesController < ApplicationController
  def index
    count = 10
    @topic_all = current_user.favorite_item.page(params[:page]).per(count)
  end

  def show
  end

  def new
  end

  def create
    # require 'pry'
    # binding.pry
    id = params[:topic][:id]
    @topic = Topic.where(id: id)
    @favorite = current_user.favorites.new(topic_id: id)
    if @favorite.save
      flash[:success] = "お気に入り情報を登録しました"
      redirect_to preview_topic_url(id)
    else
      flash[:danger] = "お気に入り情報の登録に失敗しました"
      render template: 'topics/preview',id: id
    end
  end

  def destroy
    id = params[:id]
    if current_user.favorites.find_by(topic_id: id).destroy
      flash[:success] = 'お気に入りを解除しました'
      redirect_to preview_topic_url(id)
    else
      flash[:danger] = 'お気に入りの解除に失敗しました'
      render template: 'topics/preview',id: id
    end
  end
  
  def update
    # require 'pry'
    # binding.pry
    @favorite = current_user.topic_favorites.build
    id = params[:id]
    @favorite.topic_id = id

    if @favorite.save
      flash[:success] = 'お気に入り情報を更新しました'
      redirect_to preview_topic_url(id)
    else
      flash[:danger] = 'お気に入り情報の更新に失敗しました'
      render 'topics/preview',id: id
    end
  end
end
