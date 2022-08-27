class User < ApplicationRecord
  has_secure_password

  has_many :completions, dependent: :destroy

  def complete(task)
    completions.create!(task: task)
  end
end
