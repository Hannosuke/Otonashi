class Task < ApplicationRecord
  validates :description, presence: true, length: { maximum: 4000 }
  validates :due_on, presence: true

  has_many :completions, dependent: :destroy
  has_one :notification_reservation, dependent: :destroy
  belongs_to :user

  def reserve_notification
    create_notification_reservation!(reservation_date: due_on - 1.day)
  end
end
