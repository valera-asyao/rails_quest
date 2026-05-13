class Quest2StudentService
  class << self
    # @return [String]
    def all_agents
      Agent.order(:codename).pluck(:codename).join("\n")
    end

    # @return [String]
    def all_missions
      Mission.order(:title).pluck(:title).join("\n")
    end

    # @return [String]
    def agents_with_missions
      Agent.order(:codename).map do |agent|
        missions = agent.missions.order(:title).pluck(:title).join(', ')
        "#{agent.codename}: #{missions}"
      end.join("\n")
    end

    # @return [String]
    def agents_with_missions_sorted_by_mission_count
      Agent.joins(:missions).group("agents.id").order("COUNT(missions.id) DESC, agents.codename").includes(:missions).map do |agent|
        count = agent.missions.count
        missions = agent.missions.order(:title).pluck(:title).join(", ")
        "#{agent.codename} (#{count}): #{missions}"
      end.join("\n")
    end

    # @return [String]
    def agents_with_skills
      Agent.order(:codename).map do |agent|
        skills = agent.skills.order(:name).pluck(:name).join(', ')
        "#{agent.codename}: #{skills}"
      end.join("\n")
    end

    # @return [String]
    def skills_by_agent_count
      Skill.joins(:agents).group("skills.id").order("COUNT(agents.id) DESC, skills.name").includes(:agents).map do |skill|
        count = skill.agents.count
        agents = skill.agents.order(:codename).pluck(:codename).join(", ")
        "#{skill.name} (#{count}): #{agents}"
      end.join("\n")
    end
  end
end
