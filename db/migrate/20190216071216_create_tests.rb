class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :title, limit: 150
      t.integer :level
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
