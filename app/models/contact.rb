class Contact < ApplicationRecord
  
  validates :name, presence: true
  validates :email, presence: true
  validates :subject, presence: true
  validates :message, presence: true, length: { maximum: 2000 }
  
end
