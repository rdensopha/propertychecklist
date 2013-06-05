# == Schema Information
#
# Table name: download_links
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  status      :string(255)
#  url         :text
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe DownloadLink do
  it "is valid with valid name,status and url" do
    test_downloadlink = FactoryGirl.build(:download_link)
    expect(test_downloadlink).to be_valid
  end
  
  it "belongs to the assigned question" do
     tst_question = FactoryGirl.build(:simple_question)
     tst_downloadlink = FactoryGirl.build(:download_link)
     expect(tst_downloadlink.question.questionContent).to eq(tst_question.questionContent)
  end
end
