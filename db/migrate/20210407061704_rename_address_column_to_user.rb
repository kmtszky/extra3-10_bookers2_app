class RenameAddressColumnToUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :addres, :address_city
  end
end
