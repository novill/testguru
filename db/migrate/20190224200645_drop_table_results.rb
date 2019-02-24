class DropTableResults < ActiveRecord::Migration[5.2]
  def up
    drop_table :results, if: table_exists?(:results)
  end
end
