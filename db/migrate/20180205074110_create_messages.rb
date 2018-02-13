class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.integer :topic_id
      t.text :message
      t.text :file
      t.integer :for_message_id,default:0

      t.timestamps
    end
  end
end
