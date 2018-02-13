class RemoveFilesCatcheToMessage < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :files_catche, :text
  end
end
