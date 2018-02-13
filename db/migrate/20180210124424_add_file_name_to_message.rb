class AddFileNameToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :file_name, :text
  end
end
