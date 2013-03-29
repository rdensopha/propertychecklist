class ProjectChecklistResponse < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :project
  belongs_to :question
  belongs_to :user
end
