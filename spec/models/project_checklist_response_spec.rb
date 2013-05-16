require 'spec_helper'

describe 'ProjectChecklistResponse' do
  it "has a valid factory" do
     tst_project_checklist_response = FactoryGirl.build(:project_checklist_response1)
     expect(tst_project_checklist_response).to be_valid
  end
  
  it "is invalid without a project id" do
     tst_project_checklist_response = FactoryGirl.build(:project_checklist_response1,project_id: nil)
     expect(tst_project_checklist_response).to have(1).errors_on(:project_id)
  end
  
  it "is invalid without a question id" do
     tst_project_checklist_response = FactoryGirl.build(:project_checklist_response1,question_id: nil)
     expect(tst_project_checklist_response).to have(1).errors_on(:question_id)
  end
  
  it "is invalid without a user id" do
     tst_project_checklist_response = FactoryGirl.build(:project_checklist_response1,user_id: nil)
     expect(tst_project_checklist_response).to have(1).errors_on(:user_id)
  end
  
  it "is invalid without response value" do
     tst_project_checklist_response = FactoryGirl.build(:project_checklist_response1,responseValue: nil)
     expect(tst_project_checklist_response).to have(1).errors_on(:responseValue)
  end
  
  it "is invalid without status value" do
     tst_project_checklist_response = FactoryGirl.build(:project_checklist_response1,status: nil)
     expect(tst_project_checklist_response).to have(2).errors_on(:status)
  end
  
  it "is invalid with invalid status value" do
     tst_project_checklist_response = FactoryGirl.build(:project_checklist_response1,status: 'xyz')
     expect(tst_project_checklist_response).to have(1).errors_on(:status)
  end
  
  it "belongs to assigned question" do
     tst_question = FactoryGirl.build(:question1)
     tst_project_checklist_response = FactoryGirl.build(:project_checklist_response1)
     expect(tst_project_checklist_response.question.questionContent).to eq(tst_question.questionContent)
  end
end
