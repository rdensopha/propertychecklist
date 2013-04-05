class CreateQuestionInfos < ActiveRecord::Migration
  def change
    create_table :question_infos do |t|
      t.text :infoContent
      t.string :status
      t.string :emphasis
      t.belongs_to :question
      t.timestamps
    end
  end
end