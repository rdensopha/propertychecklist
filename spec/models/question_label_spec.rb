# == Schema Information
#
# Table name: question_labels
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# == Schema Information
#
# Table name: question_labels
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'


describe QuestionLabel do
  it "is valid with a name and status" do
    testQL1 = QuestionLabel.new(name: 'question1', status: APP_CONFIG['active'])
    expect(testQL1).to be_valid
  end
  
  it "is invalid without a name" do
    testQL1 = QuestionLabel.new(name: nil, status: APP_CONFIG['active'])
    expect(testQL1).to have(1).errors_on(:name)
  end
  
  it "is invalid without status" do
    testQL1 = QuestionLabel.new(name: 'question1', status: nil)
    expect(testQL1).to have(2).errors_on(:status)
  end
  
  it "is invalid with duplicate label names" do
     testQL1 = QuestionLabel.create(name: "question1", status: APP_CONFIG['active'])
     testQL2 = QuestionLabel.create(name: "question1", status: APP_CONFIG['active'])
     expect(testQL2).to have(1).errors_on(:name)  
  end
  
  it "is valid with valid status" do
    testql = QuestionLabel.new(name: 'ridiculous',status: APP_CONFIG['active'])
    expect(testql).to be_valid          
  end
  
  it "is invalid with status other than #{APP_CONFIG['active']} and #{APP_CONFIG['inactive']}" do
    testql = QuestionLabel.new(name: 'ridiculous',status: 'statusUnknown')
    expect(testql).to have(1).errors_on(:status)
  end
end
