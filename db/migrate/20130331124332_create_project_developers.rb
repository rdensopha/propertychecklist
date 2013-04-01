class CreateProjectDevelopers < ActiveRecord::Migration
  def change
    create_table :project_developers do |t|
      t.string :name
      t.string :status
      t.timestamps
    end
  end
end
