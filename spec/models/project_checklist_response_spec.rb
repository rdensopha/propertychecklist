require 'spec_helper'

describe 'ProjectChecklistResponse' do
=begin
  it "has a valid factory" do
       tst_project_checklist_response = FactoryGirl.build(:project_checklist_response1)
       expect(tst_project_checklist_response).to be_valid
    end
=end
  
  it "is invalid without a project id" do
     tst_project_checklist_response = FactoryGirl.build(:simple_projectchecklistresponse,project_id: nil)
     expect(tst_project_checklist_response).to have(1).errors_on(:project_id)
  end
  
  it "is invalid without a question id" do
     tst_project_checklist_response = FactoryGirl.build(:simple_projectchecklistresponse,question_id: nil)
     expect(tst_project_checklist_response).to have(1).errors_on(:question_id)
  end
  
  it "is invalid without a user id" do
     tst_project_checklist_response = FactoryGirl.build(:simple_projectchecklistresponse,user_id: nil)
     expect(tst_project_checklist_response).to have(1).errors_on(:user_id)
  end
  
  it "is invalid without response value" do
     tst_project_checklist_response = FactoryGirl.build(:simple_projectchecklistresponse,responseValue: nil)
     expect(tst_project_checklist_response).to have(2).errors_on(:responseValue)
  end
  
  it "is invalid without status value" do
     tst_project_checklist_response = FactoryGirl.build(:simple_projectchecklistresponse,status: nil)
     expect(tst_project_checklist_response).to have(2).errors_on(:status)
  end
  
  it "is invalid with invalid status value" do
     tst_project_checklist_response = FactoryGirl.build(:simple_projectchecklistresponse,status: 'xyz')
     expect(tst_project_checklist_response).to have(1).errors_on(:status)
  end
  
  it "belongs to assigned question" do
     tst_question = FactoryGirl.build(:simple_question)
     tst_project_checklist_response = FactoryGirl.build(:simple_projectchecklistresponse)
     expect(tst_project_checklist_response.question.questionContent).to eq(tst_question.questionContent)
  end
  
  it "belongs to assigned user" do
     tst_user = FactoryGirl.build(:simple_user)
     tst_project_checklist_response = FactoryGirl.build(:simple_projectchecklistresponse)
     expect(tst_project_checklist_response.user.displayName).to eq(tst_user.displayName)
  end
  
  it "belongs to assigned project" do
     tst_project = FactoryGirl.build(:simple_project)
     tst_project_checklist_response = FactoryGirl.build(:simple_projectchecklistresponse)
     expect(tst_project_checklist_response.project.name).to eq(tst_project.name )
  end
  
  it "is invalid with  invalid response values" do
     tst_project_checklist_response = FactoryGirl.build(:simple_projectchecklistresponse, responseValue: 20)
     expect(tst_project_checklist_response).to have(1).errors_on(:responseValue)
  end
end
