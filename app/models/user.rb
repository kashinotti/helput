class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  
  # フォロー機能関連のアソシエーション
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  
  # チャット機能関連のアソシエーション
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  
  
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
     relationship = self.relationships.find_by(follow_id: other_user.id)
     if relationship
      relationship.destroy
     end
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  
  attachment :profile_image


  def liked_by?(post)
    likes.where(post_id: post.id).exists?
  end
  
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
