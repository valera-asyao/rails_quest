class Agent < ApplicationRecord
  has_many :missions
  has_many :agent_skills
  has_many :skills, through: :agent_skills

  validates :codename, presence: true, uniqueness: true
  validates :level, inclusion: { in: 1..10 }
end
