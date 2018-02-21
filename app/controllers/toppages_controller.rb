class ToppagesController < ApplicationController
  def index
    if logged_in?
      # 招待トピック
      userid = current_user.id.to_s
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
      @topic_all = Topic.where(id: join_id).order(created_at: :desc).limit(5)
  
      # 招待トピックここまで
      # 最新記事
        @new = Topic.where(join_user: "0").order(created_at: 'desc').limit(5)
      # 最新記事ここまで
    end
  end
end
