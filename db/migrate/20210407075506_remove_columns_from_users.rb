class RemoveColumnsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :postal_code, :string
    remove_column :users, :addres, :string
  end
end
