class AddCityIdToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.references :city
    end
  end
end
