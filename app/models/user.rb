class User < ApplicationRecord
  has_secure_password
  
  validates :user_name, 
    presence: true,
    uniqueness: true,
    length: { maximum: 12 }
  
  validates :password,
    format: { with: /\A[a-zA-Z0-9]+\z/, message: "only arrows letters and numbers" },
    length: { in: 6..10 }
  
end
