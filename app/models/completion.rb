class Completion < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :task_id, presence: true, uniqueness: { scope: :user_id, case_sensitive: true }
  validates :user_id, presence: true
end
