class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  # ユーザー情報とルームがレコードごとに被らないよう制約。
  # 例）room:Aにuser:a 2人が格納されないように制約。ただし、テーブル全体でuser:aは何度も登録されてよいのでscopeで一意的制約をかける
  validates :room_id, uniqueness: { scope: :user_id }
end
