class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :project_checklist_responses
end
