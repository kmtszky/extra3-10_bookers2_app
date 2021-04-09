class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :user_id, foreign_key: true
      t.integer :room_id, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
