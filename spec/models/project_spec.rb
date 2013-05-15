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

require 'spec_helper'

describe 'Project' do
  it "is valid with valid name and status" do
    #testProj = Project.new(name: 'TestProject', status: APP_CONFIG['active'])
    testProj = FactoryGirl.build(:project1)
    expect(testProj).to be_valid
  end
  
  it "is invalid without a name" do
    #testProj = Project.new(name: nil, status: APP_CONFIG['active'])
    testProj = FactoryGirl.build(:project1, name: nil)
    expect(testProj).to have(1).errors_on(:name)
  end
  
  it "is invalid with a invalid status value" do
     #testProj = Project.new(name: 'TestProject', status: 'crazyStatus')
     testProj = FactoryGirl.build(:project1, status: 'crazystatus')
     expect(testProj).to have(1).errors_on(:status)
  end
  

  it "is invalid without  status" do
     testProj = Project.new(name: 'testProj', status:nil)
     expect(testProj).to have(2).errors_on(:status)
  end 

  it { have_db_column :project_developer_id }
  
  it { validate_presence_of :name }

  
  it "has belongs to association" do
    testProj = FactoryGirl.create(:project1)
    expect(testProj).to belong_to(:project_developer)
  end
  
  it "belongs to the assigned Project Developer" do
     testProj = FactoryGirl.create(:project1)
     testProjectDeveloper = FactoryGirl.create(:project_developer1)
     expect(testProj.project_developer.name).to eq(testProjectDeveloper.name)
  end


end
