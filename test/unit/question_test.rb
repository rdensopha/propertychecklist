# == Schema Information
#
# Table name: questions
#
#  id                     :integer          not null, primary key
#  questionContent        :text
#  answerType             :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  status                 :string(255)
#  category_id            :integer
#  question_info          :text
#  question_info_emphasis :string(255)
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
