class Topic < ApplicationRecord
  belongs_to :user

  validates :subject, presence: true
  validates :description, presence: true
end
