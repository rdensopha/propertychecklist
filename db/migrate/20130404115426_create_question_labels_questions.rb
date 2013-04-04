class CreateQuestionLabelsQuestions < ActiveRecord::Migration
  def up
    drop_table :questions_question_labels do |t|
    end

    create_table :question_labels_questions do |t|
         t.belongs_to :question
         t.belongs_to :question_label
    end
  end

  def down
    drop_table :question_labels_questions do |t|
    end

    create_table :questions_question_labels do |t|
      t.belongs_to :question
      t.belongs_to :question_label
    end
  end
end
