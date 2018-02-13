class AddFileToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :files, :text
  end
end
