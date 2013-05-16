FactoryGirl.define do
  factory :project1, :class => Project do
    name 'project1'
    status APP_CONFIG['active']
    association :project_developer,factory: :project_developer1
  end
  
  factory :project_developer1, :class => ProjectDeveloper do
    name "project_developer1"
    status APP_CONFIG['active']
    
    ignore do
      number_of_projects 1
    end
    after(:create) do |project_developer_arg,evaluator|
       FactoryGirl.build_list(:project1,evaluator.number_of_projects,project_developer: project_developer_arg)
    end
  end
  
  factory :project_checklist_response1, :class => ProjectChecklistResponse do
    status APP_CONFIG['active']
    association :project,factory: :project1
    association :question,factory: :question1
    association :user,factory: :user1
    responseValue 1
  end
  
  factory :question1, :class => Question do
     status APP_CONFIG['active']
     questionContent "xyz"
     
     ignore do
       number_of_project_checklist_responses 1
     end
     
     after(:create) do |question_arg,evaluator|
        FactoryGirl.build_list(:project_checklist_response1,evaluator.number_of_project_checklist_responses,question: question_arg)  
     end
  end  
  
  factory :user1, :class => User do
    status APP_CONFIG['active']
  end
end