class AddPathToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :path, :text
  end
end
