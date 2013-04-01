class RenameColumnOfProjects < ActiveRecord::Migration
  def change
       change_table :projects do |t|
         t.rename :projectDeveloper_id, :project_developer_id
       end
  end
end
