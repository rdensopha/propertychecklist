# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  status            :string(255)
#  parentCategory_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
