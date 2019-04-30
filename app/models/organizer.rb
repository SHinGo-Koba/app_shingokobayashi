class Organizer < ApplicationRecord
  has_many :projects
  belongs_to :user
  
  validates :user_id,
    presence: true
  
  validates :organizer_name,
    presence: true,
    length: { maximum: 12 }
end
