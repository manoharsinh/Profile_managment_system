class AddHeightToNormalusers < ActiveRecord::Migration[6.0]
  def change
    add_column :normalusers, :height, :integer
  end
end
