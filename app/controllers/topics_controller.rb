class TopicsController < ApplicationController
  def index
    page = 10
    @topic_all = Topic.where(join_user: "0").page(params[:page]).order('created_at DESC').per(page)
      # @topic_message = Message.where(topic_id: id).count
  end
  
  def category
    page = 10
    @category = params[:id]
    @topic_all = Topic.where(join_user: "0").where(genre: @category).page(params[:page]).per(page)
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

      @users = User.where("name like '#{@word}%'")
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

  def join
    count = 10
    userid = params[:id]
    @topic = Topic.where.not(join_user: "0")
    # トピックID
    join_id = []
    # ユーザーID
    join_user = []
    @topic.each do |topic|
       topic.id
       anstopic = topic.join_user.delete('" ').split(',')
      if anstopic.include?(userid)
        p join_id << topic.id
        p join_user << anstopic
      end
    end
    @topic_all = Topic.where(id: join_id).order(created_at: :desc).page(params[:page]).per(count)
    
    
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
    page = 10
    @id = params[:id]
    @count = Message.where(topic_id: @id).count
    @topic = Topic.where(id: @id)
    @message = current_user.messages.build
    # @message_user = Message.where(topic_id: id)
    # @message_user = Kaminari.paginate_array(Message.find_all_by_topic_id(id)).order(created_at: :asc).page(params[:page]).per(page)
    @message_user = Message.where(topic_id: @id).page(params[:page]).per(page)
    @history = current_user.historys.build
    @history.topic_id = @id
    @history.save
  end
  
  def edit_usertopic
    # require 'pry'
    # binding.pry
    @id= params[:id][:topic_id]
    @topic = current_user.topics.find(@id)
    @title = @topic.title
    @genre = @topic.genre
    @show = @topic.public
    @content = @topic.content
    @users = User.all
  end
  
  def usertopic_update
  #   require 'pry'
  # binding.pry
    id = params[:id]
    @topic = current_user.topics.find(id)
    @users = User.all
    if params[:commit] == '検索'
      @topic = current_user.topics.new
      @word = params[:word]
      @content = params[:topic][:content]
      @title = params[:topic][:title]
      @image = params[:topic][:topic_image]
      @genre = params[:topic][:genre]
      @show = params[:topic][:public]

      @users = User.where("name like '#{@word}%'")
      
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
        # @topic = current_user.topics.build(topic_params)
        
        if @topic.update(topic_params)
          flash[:success] = 'トピックを更新しました'
          redirect_to topic_url(@topic)
        else
          flash[:danber] = 'トピックの更新に失敗しました'
          render 'new'
        end
      end
    end
  end
  
  def user_topic
    count = 10
    @topic_all = current_user.topics.order(created_at: 'desc').page(params[:page]).per(count)
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
