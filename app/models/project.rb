class Project < ApplicationRecord
  belongs_to :organizer
  has_many :tasks
  has_many :users, through: :tasks

  validates :organizer_id,
    presence: true
    
  validates :title,
    presence: true,
    length: { maximum: 140 }

  validates :summary,
    presence: true,
    length: { maximum: 140 }

end
