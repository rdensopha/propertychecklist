# == Schema Information
#
# Table name: projects
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  status               :string(255)
#  project_developer_id :integer
#  projectType          :string(255)
#  projectLocation      :string(255)
#  city_id              :integer
#  slug                 :string(255)
#

class Project < ActiveRecord::Base
 extend FriendlyId
  attr_accessible :name, :project_developer_id, :city_id, :status
  belongs_to :project_developer
  has_many :project_checklist_responses
  belongs_to :city
  #setting the friendly id option
  friendly_id :name, use: :slugged
  
  #validations
  validates :name, presence: true
  validates(:status,
            presence: true,
            inclusion:{
              in: [APP_CONFIG.fetch('active'), APP_CONFIG.fetch('inactive')],
              message:"%{value} is not a valid status"
            })
end
