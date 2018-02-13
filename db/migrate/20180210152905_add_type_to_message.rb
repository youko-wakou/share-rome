class AddTypeToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :type, :text
  end
end
