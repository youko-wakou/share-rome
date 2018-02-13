class RenameTypeColumnToMessages < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages,:type,:status
  end
end
