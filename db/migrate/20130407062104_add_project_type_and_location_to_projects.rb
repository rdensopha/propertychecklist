class AddProjectTypeAndLocationToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :projectType, :string
    add_column :projects, :projectLocation, :string
  end
end
