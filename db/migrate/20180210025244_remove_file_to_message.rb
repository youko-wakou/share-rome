class RemoveFileToMessage < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :file, :string
  end
end
