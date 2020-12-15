class Post < ApplicationRecord
  
  belongs_to :user
  has_many :comment, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  
end
