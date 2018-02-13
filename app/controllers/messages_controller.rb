class MessagesController < ApplicationController
  def index
  end

  def show
    id = params[:id]
    @message = Message.where(id: id)
  end

  def new
    @message = current_user.messages.build
  end

  def create
    # require 'pry'
    # binding.pry
    file = []
   file_content = params[:message][:files]
   file_content.each do |file_list|
     params[:message][:file_name] << file_list.original_filename + ','
     file << file_list.content_type
   end
    @message = current_user.messages.build(message_params)
    @message.status = file
    if @message.save!(validate: true)
      flash[:success] = 'コメントの投稿に成功しました'
      redirect_to message_path(@message)
    else
      flash[:danger] = 'コメントの投稿に失敗しました'
      render topics/preview
    end 
    
  end

  def destroy
  end

  def edit
  end

  def update
  end
  
  def preview
    id = params[:id]
    @message_user = Message.find_by(topic_id: id)
    
   
  end
  
  def download
     # ZIPファイル作成
    require 'zip'
    require 'rubygems'
    id = params[:id]
   
   file_name = Time.now.strftime("%Y%m%d-%H%M%S.zip")
    zip_file = "#{Rails.root}/tmp/#{file_name}"
    target_path = "#{Rails.root}/public/uploads/message/#{id}"

  # ここでファイルの中身を一つ一つ配列に格納する
    target_files = []
    Dir.glob("#{target_path}/*.*").each do |i|
      target_files.push(i)
    end
    
    ::Zip::File.open(zip_file, ::Zip::File::CREATE) do |zipfile|
      target_files.each do |file|
        zipfile.add(File.basename(file),file)
      end
    end  
    send_file(zip_file)
    File.delete(zip_file)

      # File.unlink(zip_file)
    # ::Zip::File.open(zip_file, ::Zip::File::CREATE) {|z|z.add(File.basename(target_path),target_path)}
    # if send_file(zip_file)
    #     File.unlink(zip_file)
    # end
  end

  private
  def encode_filename(base_filename, type)
      ERB::Util.url_encode("#{base_filename}_#{Time.current.in_time_zone('Asia/Tokyo').strftime "%Y%m%d%H%M%S"}.#{type}")
  end
  def message_params
    params.require(:message).permit(:message,:user_id,:file_name,:for_message_id,:topic_id,{:files => []})
  end
end
