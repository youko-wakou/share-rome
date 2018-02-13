class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :homepage
      t.string :twitter
      t.string :content

      t.timestamps
    end
  end
end
