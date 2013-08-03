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

  # setting up cache for response count for a question, deleting cache in ProjectChecklistResponsesController#update_response
  def self.cached_response_count_of_question_in_project(project_num, question_num, response_value)
    Rails.cache.fetch([project_num, question_num, response_value]) do
      where(project_id: project_num, question_id: question_num, responseValue: response_value).count  
    end  
  end  

  #validations
  validates :project_id,presence: true
  validates :question_id,presence: true
  validates :user_id,presence: true
  validates(:responseValue,
            presence: true,
            inclusion: {
              in: [APP_CONFIG.fetch('yesValue'),APP_CONFIG.fetch('noValue'),APP_CONFIG.fetch('inotVerify')],
              message: "%{value} is not a valid responseValue"
            })
  validates(:status,
            presence: true,
            inclusion: {
              in:[APP_CONFIG.fetch('active'),APP_CONFIG.fetch('inactive')],
              message: "%{value} is not a valid status"
            })
        
end
