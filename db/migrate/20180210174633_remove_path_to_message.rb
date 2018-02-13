class RemovePathToMessage < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :path, :string
  end
end
