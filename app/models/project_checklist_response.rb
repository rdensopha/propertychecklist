# == Schema Information
#
# Table name: project_checklist_responses
#
#  id            :integer          not null, primary key
#  project_id    :integer
#  question_id   :integer
#  user_id       :integer
#  status        :string(255)
#  responseValue :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

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
  
  #validations
  validates :project_id,presence: true
  validates :question_id,presence: true
  validates :user_id,presence: true
  validates(:responseValue,
            presence: true,
            inclusion: {
              in: [0,1,2],
              message: "%{value} is not a valid responseValue"
            })
  validates(:status,
            presence: true,
            inclusion: {
              in:['Active','InActive'],
              message: "%{value} is not a valid status"
            })
  
end
