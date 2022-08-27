class Task < ApplicationRecord
  validates :description, presence: true

  has_many :completions, dependent: :destroy
end
