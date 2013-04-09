class Project < ActiveRecord::Base
 extend FriendlyId
  attr_accessible :name, :project_developer_id
  belongs_to :project_developer
  has_many :project_checklist_responses
  belongs_to :city
  #setting the friendly id option
  friendly_id :name, use: :slugged
end
