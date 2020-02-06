class AddIndexToAdmins < ActiveRecord::Migration[6.0]
  def change
  	add_index :normalusers, :phonenumber
  end
end
