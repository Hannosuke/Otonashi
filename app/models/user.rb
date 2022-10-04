class User < ApplicationRecord
  has_secure_password

  has_many :completions, dependent: :destroy
  has_many :tasks, dependent: :destroy

  scope :not_completed_task, ->{ User.left_joins(:completions).where(completions: {task_id: nil}) }

  def complete(task)
    completions.create!(task: task)
  end

  def make_wip(task)
    completions.find_by(task: task).destroy!
  end

  def done?(task)
    completions.find_by(task: task).present?
  end
end
