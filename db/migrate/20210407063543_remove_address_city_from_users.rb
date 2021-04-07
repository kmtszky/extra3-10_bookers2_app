class RemoveAddressCityFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :address_city, :string
  end
end
