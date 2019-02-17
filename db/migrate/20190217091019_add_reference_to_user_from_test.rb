class AddReferenceToUserFromTest < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :user_id, :integer, null: false #, index: true не работает
    add_index :tests, :user_id
    add_foreign_key( :tests, :users )
  end
end
