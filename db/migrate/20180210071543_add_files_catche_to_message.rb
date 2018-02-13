class AddFilesCatcheToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :files_catche, :text
  end
end
