class AddTopicImageToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :topic_image, :string
  end
end
