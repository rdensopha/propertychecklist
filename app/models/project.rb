class Project < ActiveRecord::Base
  attr_accessible :name, :project_developer_id
  belongs_to :project_developer
  has_many :project_checklist_responses
  belongs_to :city
end
