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

  # 例）ファンside （有名人をフォローする人）
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :follower, source: :followed
  # 例）有名人side （ファンにフォローされている人）
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_users, through: :followed, source: :follower

  # 例）self: ファン, other_user: 有名人
  def follow(other_user)
    unless self == other_user
      self.follower.find_or_create_by(followed_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.follower.find_by(followed_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.following_users.include?(other_user)
  end

  def self.search(search, search_key)
    if search == "perfect_match"
      @user = User.where(name: "#{search_key}")
    elsif search == "forward_match"
      @user = User.where("name like?", "#{search_key}%")
    elsif search == "backward_match"
      @user = User.where("name like?", "%#{search_key}")
    elsif search == "partial_match"
      @user = User.where("name like?", "%#{search_key}%")
    else
      @user = User.none
    end
  end

  # 都道府県コードから都道府県名に自動で変換
  include JpPrefecture
  jp_prefecture :prefecture_code

  # ~.prefecture_nameで都道府県名を参照出来る => 例) @user.prefecture_nameで該当ユーザーの住所(都道府県)を表示
    def prefecture_name
      JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
    end

    def prefecture_name=(prefecture_name)
      self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
    end
end
