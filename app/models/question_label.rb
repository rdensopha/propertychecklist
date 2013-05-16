# == Schema Information
#
# Table name: question_labels
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class QuestionLabel < ActiveRecord::Base
  attr_accessible :name, :status
  has_and_belongs_to_many :questions
  
  #validations
  validates :name,presence: true, uniqueness: true
  validates(:status,
            presence: true,
            inclusion: {
                        in: [APP_CONFIG.fetch('active'), APP_CONFIG.fetch('inactive')],
                        message: "%{value} is not a valid status"}
           )           
end
