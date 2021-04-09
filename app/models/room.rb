class Room < ApplicationRecord
  has_many :users, through: :user_rooms #DMしているユーザー一覧表示のため設定
  has_many :chats
  has_many :user_rooms
end
