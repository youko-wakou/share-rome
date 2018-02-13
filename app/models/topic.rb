class Topic < ApplicationRecord
  belongs_to :user
  mount_uploader :topic_image,TopicImageUploader
  
  before_save do 
    self.join_user = self.join_user&.strip
    self.join_user = self.join_user&.delete('"[\] ')
    
    # 配列を、文字列化して前後をtrimする感じが以下
    # ["1", "3", "5", "10"].join(' ')&.strip
  end
end
