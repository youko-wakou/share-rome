class HistorysController < ApplicationController
  def index
    user = current_user
     count = 20
    @topic_all = user.users_show_item.limit(count)
    topicID = []
    @topic_all.each do |topic|
      p topicID << topic.id
    end
    @topic_history = user.historys.where(topic_id: topicID).order(created_at: 'desc')
    historyID = []
    @topic_history.each do |topic|
      p historyID << topic.topic_id
    end
    @topic_all = Topic.where(id: historyID).order("field(id, #{historyID.join(',')})").limit(count)
    # @topic_all = user.users_show_item.order("field(id, #{historyID.join(',')})").limit(count)

  end
end
