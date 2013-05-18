require 'spec_helper'

describe ProjectsController do
  
  describe 'GET#index' do
     
     it "populates an array of projects" do
        project = FactoryGirl.create(:simple_project)
        #project = Project.create
        get :index
        expect(assigns(:projects)).to match_array [project]
        #expect(project.name).to eq 'project2'
     end
  end
end
