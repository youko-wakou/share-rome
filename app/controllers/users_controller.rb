class UsersController < ApplicationController
  
  before_action:require_user_logged_in,only:[:index,:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success]= 'ユーザーを登録しました。'
      redirect_to @user
    else
      flash.now[:danger]='ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  
  
  def friend_list
    count = 15
    @user = current_user.followings.page(params[:page]).per(count)
  end
  
  def index 
    @word = params[:word]
    page = 10
    
    @user = User.all.page(params[:page]).per(page)
  end
  
  def create_friend
    # require 'pry'
    # binding.pry
    user = User.find(params[:follow_id])
    # if current_user != user
      current_user.follow(user.id)
      # if !current_user.favorites.find_by(follow_id: user.id).blank?
      #   current_user.friends.find_or_create_by(follow_id: user.id)
      # end
    # end
    flash[:success] = 'ユーザーを友達に登録しました。'
    redirect_to users_url
  end
  
  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'ユーザーの友達登録を解除しました。'
    redirect_to users_url
  end
  
  def word_create
    page = 10
    @word = params[:word]
    @user = User.where("name like '#{@word}%'").page(params[:page]).per(page)
  end
  
  def show 
    @user = User.where(id:params[:id])
  end
  
  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
  
end
