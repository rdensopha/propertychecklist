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
 include Workflow
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
              in: [APP_CONFIG.fetch('inactive'),APP_CONFIG.fetch('active')],
              message:"%{value} is not a valid status"
            })
            
 #workflow related
 workflow_column :status # use status column for persisting workflow status
 
 workflow do
  state APP_CONFIG['active'] do
    event :delete, :transitions_to => APP_CONFIG['inactive']
  end 
  
  state APP_CONFIG['inactive']
 end # end of workflow definition            
end
