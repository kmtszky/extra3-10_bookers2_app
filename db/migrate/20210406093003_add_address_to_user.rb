class AddAddressToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :addres, :string
  end
end
