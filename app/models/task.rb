class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  
  validates :project_id,
    presence: true
  validates :user_id,
    presence: true
  validates :body,
    presence: true,
    length: { maximum: 140 }
    
end
