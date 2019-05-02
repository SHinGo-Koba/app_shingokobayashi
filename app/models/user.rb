class User < ApplicationRecord
  has_secure_password

  has_one :organizer
  has_many :tasks
  has_many :projects, through: :tasks
  
  validates :user_name, 
    presence: true,
    uniqueness: true,
    length: { maximum: 12 }

  validates :password,
    format: { with: /\A[a-zA-Z0-9]+\z/, message: "only arrows letters and numbers" },
    length: { in: 6..10 },
    allow_nil: true
  
end
