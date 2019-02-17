class AddReferenceToUserFromTest < ActiveRecord::Migration[5.2]
  def change
    add_reference(:tests, :user, index: true)
  end
end
