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
    has_many :following_user, through: :follower, source: :followed
  # フォロワー取得
    # @user.followedとした際に、@user.idをfollowed_idと指定（followed_idにuser_idを格納）
    has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :follower_user, through: :followed, source: :follower

    def follow(user_id)
      follower.create(followed_id: user_id)
    end

    def unfollow(user_id)
      follower.find_by(followed_id: user_id).destroy
    end

    def following?(user)
      following_user.include?(user)
    end
end
