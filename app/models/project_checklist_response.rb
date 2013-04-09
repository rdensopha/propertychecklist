class ProjectChecklistResponse < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :project
  belongs_to :question
  belongs_to :user
  #scopes defined
  scope :responses_project_user ,  ->(project_num, user_num) { where(project_id: project_num, user_id: user_num) }
  scope :response_project_user_question, ->(project_num, user_num, question_num) do
    responses_project_user(project_num,user_num).where question_id: question_num
  end
  def self.response_project_question_count(project_num, question_num, response_value)
      where(project_id: project_num, question_id: question_num, responseValue: response_value).count
  end
end
