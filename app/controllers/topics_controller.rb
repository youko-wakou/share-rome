class TopicsController < ApplicationController
  def index
    @topic_all = Topic.all.page(params[:page]).per(10)
    
  end

  def new
    @users = User.all
    @topic = current_user.topics.build
    # @user_list = Array.new
    
    # if params[:commit] == '検索'
    #   word = params[:word][:word]
    #   user_search = User.where("name like '%" + word + "%'")
    #   @user = user_search
    #   render 'new'
    # end

  end

  def create

    @topic = current_user.topics.build
    @users = User.all
    if params[:commit] == '検索'
      @topic = current_user.topics.new
      @word = params[:word]
      @content = params[:topic][:content]
      @title = params[:topic][:title]
      @image = params[:topic][:topic_image]
      @genre = params[:topic][:genre]
      @show = params[:topic][:public]

      @users = User.where("name like '%" + @word + "%'")
      render 'new'
    else
        # require 'pry'
        # binding.pry
        @join = params[:join]
        p @join
      if params[:topic][:title].length ==0
        flash[:danger] = 'タイトルが未入力です'
        render 'new'
      elsif params[:topic][:content].length == 0
        flash[:danger] = '説明文を入力してください'
        render 'new'
     elsif params[:topic][:public]=="0"&& params[:topic][:join_user] == nil
        flash[:danger]="選択したユーザーに公開する場合はユーザーを選択してください"
        render 'new'
      
      elsif params[:topic][:public] =="1"&&params[:join] != "nothing"
        flash[:danger] = 'すべてのユーザーに公開が選択されているため、[公開対象はすべてのユーザー]にチェックを入れてください'
        render 'new'
      elsif params[:join] == nil && params[:topic][:public] == "1"&& params[:topic][:join_user] == nil
        flash[:danger] = 'すべてのユーザーに公開が選択されているため、[公開対象はすべてのユーザー]にチェックを入れてください'
        render 'new'
        
      elsif !params[:topic][:join_user].blank? && params[:topic][:public] =="1" && params[:join] == "nothing"
        flash[:danger] = 'すべてのユーザーに公開が選択されているため、[公開対象はすべてのユーザー]にチェックを入れてください、ユーザー名のチェックを外してください'
        render 'new'
        
      elsif params[:join]=="nothing" && params[:topic][:public]=="0"&& params[:topic][:join_user] == nil
        flash[:danger]="選択したユーザーに公開する場合はユーザーを選択してください、[公開対象はすべてのユーザー]にチェックを外してください" 
        render 'new'
      else
        
        if params[:join] == "nothing"&& params[:topic][:join_user]== nil
          @topic.join_user = "0"
        end
         @topic = current_user.topics.build(topic_params)
        
        if @topic.save
          flash[:success] = '新しいトピックを作成しました'
          redirect_to topic_url(@topic)
        else
          flash[:danber] = 'トピックの作成に失敗しました'
          render 'new'
        end
      end
    end
  end


  def show
    id = params[:id]
    @topic = Topic.where(id: id)
  end

  def edit
    @user = User.all
    @topic = current_user.topics.build
    @user_list = Array.new
  end
  
  def preview
    id = params[:id]
    @topic = Topic.where(id: id)
    @message = current_user.messages.build
    @message_user = Message.where(topic_id: id)
  end

  def update
    @topic = current_user.topics.build
    @user = User.all
    
    if params[:topic][:join_user]==nil||params[:topic][:join_user]=="0" && params[:topic][:public]=="0"
       flash[:danger]="選択したユーザーに公開する場合はユーザーを選択してください" 
       render 'edit'
    
    elsif params[:topic][:join_user]!="0" && params[:topic][:public] =="1"
      flash[:danger] = 'すべてのユーザーに公開が選択されているため、[全体に公開する場合はここをクリック]にチェックを入れてください'
      render 'edit'
    else
       @topic = current_user.topics.build(topic_params)
      
      if @topic.save
        flash[:success] = '新しいトピックを作成しました'
        redirect_to topic_url(@topic)
      else
        flash[:danber] = 'トピックの作成に失敗しました'
        render 'edit'
      end
    end
  end
  
  private
  
  def topic_params
    params.require(:topic).permit(:user_id,:content,:title,:topic_image,:genre,:public,{:join_user => []})
  end
end
