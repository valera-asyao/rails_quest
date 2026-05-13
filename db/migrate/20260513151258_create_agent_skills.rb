class CreateAgentSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :agent_skills do |t|
      t.references :agent, foreign_key: true
      t.references :skill, foreign_key: true

      t.timestamps
    end
    add_index :agent_skills, [ :agent_id, :skill_id ], unique: true
  end
end
