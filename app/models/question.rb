class Question < ActiveRecord::Base
  #attributes are #answerType:string, #questionContent:text, #status:string,
  attr_accessible :answerType, :questionContent
  belongs_to :category, inverse_of:  :questions
  has_many :project_checklist_responses
end
