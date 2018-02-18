class RankingsController < ApplicationController
  def index
    # コメント数ランキング
      @message = Message.limit(10).group(:topic_id).order('count_all desc').count
      topicID = []
      @count_list = []
      @message.each do |id,topic|
        if p Topic.where(id: id).where.not(join_user: "0")
          p topicID << id
          p @count_list << topic
        end
      end
       @message_topic = Topic.where(id: topicID).order("field(id, #{topicID.join(',')})")
      @count = 0

      # お気に入り数ランキング
      @ranking = Favorite.limit(10).group(:topic_id).order('count_all DESC').count
      @rank_id = []
      @rank_count = []
      @ranking.each do |id,count|
        p @rank_id << id
        p @rank_count << count
      end
      
      @ranking_topic = Topic.where(id: @rank_id).where(join_user: "0").order("field(id, #{@rank_id.join(',')})")
  end
end
