class Photo < ApplicationRecord
  belongs_to :user
  mount_uploader :image_url,ProfilePhotUploader
end
