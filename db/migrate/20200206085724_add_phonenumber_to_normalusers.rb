class AddPhonenumberToNormalusers < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :phonenumber, :string
    add_index :admins, :phonenumber
  end
end
