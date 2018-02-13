class Message < ApplicationRecord
  belongs_to :user
  serialize :files,JSON
  mount_uploaders :files,FileMessageUploader
  
  # before_save do
  #   file_content = params[:message][:files]
  #   params[:message][:file_name] = file_content.original_filename
  # end
end
