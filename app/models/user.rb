class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # @user.followerとした際に、@user.idをfollowed_idと指定 = フォローしている人を取得
  has_many :follower, class_name: "Relationship", foregin_key: "follower_id", dependent: :destroy #follower_idにuser_idを格納する: フォローしている人を取得
  # @user.followedとした際に、@user.idをfollowed_idと指定 = フォロワー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #followed_idにuser_idを格納する：フォロワーを取得

  has_many :following_user, through: :follower, source: :followed # フォローしている人の一覧
  has_many :follower_user, through: :followed, source: :follower  # フォローされている人の一覧

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
end
