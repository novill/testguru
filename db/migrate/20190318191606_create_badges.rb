class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.references :badge_type, foreign_key: true
      t.boolean :active
      t.string :image_url
      t.references :object, polymorphic: true

      t.timestamps
    end
  end
end
