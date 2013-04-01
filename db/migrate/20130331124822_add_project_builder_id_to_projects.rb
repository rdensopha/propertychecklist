class AddProjectBuilderIdToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.references :projectDeveloper
    end
  end
end
