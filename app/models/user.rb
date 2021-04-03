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

  #フォローしている人を取得
    # @user.followerとした際に、@user.idをfollowed_idと指定（follower_idにuser_idを格納）
    has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :following_users, through: :follower, source: :followed
  # フォロワー取得
    # @user.followedとした際に、@user.idをfollowed_idと指定（followed_idにuser_idを格納）
    has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :followed_users, through: :followed, source: :follower

    def follow(other_user)
      unless self == other_user
        self.relationships.find_or_create_by(follower_id: other_user.id)
      end
    end

    def unfollow(other_user)
      relationship = self.relationships.find_by(follower_id: other_user.id)
      relationship.destroy if relationship
    end

    def following?(other_user)
      myself.following_users.include?(other_user)
    end
end
