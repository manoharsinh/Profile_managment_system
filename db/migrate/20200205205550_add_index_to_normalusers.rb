class AddIndexToNormalusers < ActiveRecord::Migration[6.0]
  def change
  	add_index :normalusers, :pid
  end
end
