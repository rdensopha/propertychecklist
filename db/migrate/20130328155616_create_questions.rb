class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :questionContent
      t.string :answerType

      t.timestamps
    end
  end
end
