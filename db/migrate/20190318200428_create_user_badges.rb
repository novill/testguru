class CreateUserBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :user_badges do |t|
      t.references :badges, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
