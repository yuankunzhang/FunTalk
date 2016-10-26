class Topic < ApplicationRecord
  belongs_to :user
  has_many :votes

  validates :subject, presence: true
  # validates :description, presence: true
end
