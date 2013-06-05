class CreateDownloadLinks < ActiveRecord::Migration
  def change
    create_table :download_links do |t|
      t.string :name
      t.string :status
      t.text :url
      t.references :question
      t.timestamps
    end
  end
end
