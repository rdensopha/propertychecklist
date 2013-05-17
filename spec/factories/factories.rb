FactoryGirl.define do
  ############## Project factories ##############################
  factory :simple_project, :class => Project do
    name 'project1'
    status APP_CONFIG['active']
    
    factory :with_developer_project do
      association :project_developer,factory: :simple_projectdeveloper
=begin      
      factory :with_dev_and_checlstresponses_project do
         ignore do
           number_of_project_checklist_responses 1
         end
    
         # create list of project_checklist_responses for a project
         after(:build) do |project_arg,evaluator|
          FactoryGirl.build_list(:with_project_projectchecklistresponse,evaluator.number_of_project_checklist_responses,project_developer: project_arg)
         end  
      end
=end      
    end
  end
  
  ############################### Project Developer factories ###################
  factory :simple_projectdeveloper, :class => ProjectDeveloper do
    name "project_developer1"
    status APP_CONFIG['active']
=begin
    
    factory :with_projects_projectdeveloper do
      ignore do
        number_of_projects 1
      end
      after(:build) do |project_developer_arg,evaluator|
         FactoryGirl.build_list(:simple_project,evaluator.number_of_projects,project_developer: project_developer_arg)
      end
    end  
=end
  end
  
  ####################### ProjectChecklistResponse factories ###################
  factory :simple_projectchecklistresponse, :class => ProjectChecklistResponse do
    status APP_CONFIG['active']
    association :project,factory: :simple_project
    association :question,factory: :simple_question
    association :user,factory: :simple_user
    responseValue 1
    
  end
  
  #################### Question factories ####################
  factory :simple_question, :class => Question do
     status APP_CONFIG['active']
     questionContent "xyz"
=begin
     
     factory :with_responses_question do
       ignore do
         number_of_project_checklist_responses 1
       end
       # create list of project_checklist_responses for a question
       after(:build) do |question_arg,evaluator|
          FactoryGirl.build_list(:simple_projectchecklistresponse,evaluator.number_of_project_checklist_responses,question: question_arg)  
       end
     end  
=end
  end  
  
  ################### User factories ####################
  factory :simple_user, :class => User do
    status APP_CONFIG['active']
    displayName "xyzabc"
=begin
    
    factory :with_responses_user do
      ignore do
         number_of_project_checklist_responses 1
      end
      # create list of project_checklist_responses for a user
      after(:build) do |user_arg,evaluator|
         FactoryGirl.build_list(:simple_projectchecklistresponse,evaluator.number_of_project_checklist_responses,user: user_arg)
      end
    end  
=end
  end
end