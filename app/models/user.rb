class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  # 有名人side （フォローされる人=> フォロワー（follower）たくさんいる= has_many: followers）
  has_many :relationships, foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :relationships, source: :follower
  # ファンside（有名人: followed_users のファン）
  has_many :positive_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :positive_relationships, source: :followed

  # self=ファン, other_user=有名人（フォローされる人；followed_id）
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(followed_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(followed_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.following_users.include?(other_user)
  end
end
