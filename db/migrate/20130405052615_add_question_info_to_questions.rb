class AddQuestionInfoToQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :question_info, :text
    add_column :questions, :question_info_emphasis, :string

    drop_table :question_infos
  end

  def down
    create_table :question_infos do |t|
      t.text :infoContent
      t.string :status
      t.string :emphasis
      t.belongs_to :question
      t.timestamps
    end

    remove_column :questions, :question_info
    remove_column :questions, :question_info
  end
end
