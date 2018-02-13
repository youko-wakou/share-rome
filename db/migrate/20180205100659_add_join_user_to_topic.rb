class AddJoinUserToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :join_user, :string,default: 0
  end
end
