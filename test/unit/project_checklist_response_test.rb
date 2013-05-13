# == Schema Information
#
# Table name: project_checklist_responses
#
#  id            :integer          not null, primary key
#  project_id    :integer
#  question_id   :integer
#  user_id       :integer
#  status        :string(255)
#  responseValue :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class ProjectChecklistResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
