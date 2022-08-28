class User < ApplicationRecord
  has_secure_password

  has_many :completions, dependent: :destroy

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
