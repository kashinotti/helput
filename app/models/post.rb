class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy

  validates :title_or_content_cont, presence: true
end
