class CreateQuestionLabels < ActiveRecord::Migration
  def change
    create_table :question_labels do |t|
      t.string :name
      t.string :status

      t.timestamps
    end

    create_table :questions_question_labels do |t|
      t.belongs_to :question
      t.belongs_to :question_label
    end
  end
end
