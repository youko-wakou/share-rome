class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    @profile_user = Profile.find_by(user_id: current_user.id)
    
    @profile = Profile.new(profile_params)
    if @profile.save
      flash[:success] = 'プロフィールを登録しました'
      redirect_to profiles_path
    else
      flash[:danger]= 'プロフィールの登録に失敗しました'
      render 'new'
    end
  end

  def index
    @profile = current_user.profile
  end

  def show
    @profile_get = Profile.where(id: params[:id])
  end
  
  def edit
    id = params[:id]
    @profile_info = Profile.find(id)
  end
  
  def update
    id = params[:id]
    
    @profile = Profile.find(id)
    if @profile.update(profile_params)
      flash[:success] = 'プロフィールの更新を完了しました'
      redirect_to profiles_url
    else
      flash[:danger]= 'プロフィールの更新に失敗しました'
      render 'new'
    end
  end
  
  private 
  def profile_params
    params.require(:profile).permit(:user_id,:homepage,:twitter,:content)
  end
end
