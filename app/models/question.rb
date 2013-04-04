class Question < ActiveRecord::Base
  #attributes are #answerType:string, #questionContent:text, #status:string,
  attr_accessible :answerType, :questionContent, :category_id, :question_label_ids
  belongs_to :category, inverse_of:  :questions
  has_many :project_checklist_responses
  has_and_belongs_to_many :question_labels
end
