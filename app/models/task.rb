class Task < ApplicationRecord
  validates :description, presence: true
  validates :due_on, presence: true

  has_many :completions, dependent: :destroy
  has_one :notification_reservation, dependent: :destroy
  belongs_to :user
end
