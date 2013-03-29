class CategoryIdToQuestions < ActiveRecord::Migration
def change
  change_table :questions do |t|
    t.references :category
  end
end
end
