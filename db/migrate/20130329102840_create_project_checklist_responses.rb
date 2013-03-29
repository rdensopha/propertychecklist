class CreateProjectChecklistResponses < ActiveRecord::Migration
  def change
    create_table :project_checklist_responses do |t|
      t.references :project
      t.references :question
      t.references :user
      t.string :status
      t.integer :responseValue
      t.timestamps
    end
  end
end
