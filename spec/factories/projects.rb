FactoryGirl.define do
  factory :project1, :class => Project do
    name 'project1'
    status APP_CONFIG['active']
    association :project_developer,factory: :project_developer1
  end
end