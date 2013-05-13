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

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
