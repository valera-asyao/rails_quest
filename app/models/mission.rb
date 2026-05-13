class Mission < ApplicationRecord
  belongs_to :agent

  enum :status, %w[pending in_progress completed]

  validates :title, presence: true
  validates :status, presence: true
end
