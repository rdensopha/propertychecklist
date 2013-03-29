class Project < ActiveRecord::Base
  attr_accessible :name
  has_many :project_checklist_responses
end
