class RemoveIndex < ActiveRecord::Migration[6.0]
  def change
  	remove_index "byDefault", name: "index_normalusers_on_id"
  end
end
