FactoryGirl.define do
  factory :project_developer1, :class => ProjectDeveloper do
    name "project_developer1"
    status APP_CONFIG['active']
    #association :projects,factory: :project1
    ignore do
      number_of_projects 2
    end
    after(:create) do |project_developer_arg,evaluator|
       FactoryGirl.build_list(:project1,evaluator.number_of_projects,project_developer: project_developer_arg)
    end
  end
end