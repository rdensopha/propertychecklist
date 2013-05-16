# == Schema Information
#
# Table name: project_developers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProjectDeveloper < ActiveRecord::Base
  attr_accessible :name
  has_many :projects
end
