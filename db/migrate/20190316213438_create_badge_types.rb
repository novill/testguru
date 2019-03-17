class CreateBadgeTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :badge_types do |t|
      t.string :b_type, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
