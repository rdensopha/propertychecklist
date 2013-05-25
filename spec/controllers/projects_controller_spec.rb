require 'spec_helper'

describe ProjectsController do
  
  describe 'guest role access' do 
    before :each do
      @project = FactoryGirl.create(:simple_project)
    end 
    describe 'GET#index' do
       it "raise AccessDenied" do
         bypass_rescue
          expect { get :index }.to raise_error(CanCan::AccessDenied)
       end
    end
    describe 'GET#show' do
      it "assignes the requested project to @project" do
         get :show, id: @project
         expect(assigns(:project)).to eq @project
      end
      it "renders the :show template" do
         get :show, id: @project
         expect(response).to render_template :show
      end
    end
    describe 'GET#new' do
      it "raise AccessDenied" do
         bypass_rescue
         expect { get :index}.to raise_error(CanCan::AccessDenied)
      end
    end
    describe 'GET#edit' do
       it "raise AccessDenied" do
          bypass_rescue
          expect { get(:edit,id: @project) }.to raise_error(CanCan::AccessDenied)
       end
    end
    describe 'POST#create' do
       it "raise AccessDenied" do
          bypass_rescue 
          expect { post(:create, project: FactoryGirl.attributes_for(:simple_project))}.to raise_error(CanCan::AccessDenied)
       end
    end
    describe 'PUT#update' do
       it "raise Access denied" do
          bypass_rescue
          expect { put(:update, id: @project, project: FactoryGirl.attributes_for(:simple_project)) }.to raise_error(CanCan::AccessDenied)
       end
    end
    describe 'DELETE#destroy' do
       it "raise Access denied" do
          bypass_rescue
          expect { delete(:destroy, id: @project,project: FactoryGirl.attributes_for(:simple_project)) }.to raise_error(CanCan::AccessDenied)
       end
    end
  end  

  describe 'admin role access' do
     before :each do
       @project = FactoryGirl.create(:simple_project)
       user = FactoryGirl.create(:simple_user,:roles => [FactoryGirl.create(:simple_role)])
       session[:current_user_id] = user.id 
     end
     describe 'GET#index' do
        it 'populates an array of projects' do
           get :index
           expect(assigns(:projects)).to match_array [@project]
        end
        it 'renders :index template' do
           get :index
           expect(response).to render_template :index
        end
     end
     describe 'GET#show' do
        it 'assigns requested project to @project' do
           get :show, id: @project
           expect(assigns(:project)).to eq @project
        end
        it 'renders the :show template' do
          get :show, id: @project
          expect(response).to render_template :show
        end
     end
     describe 'GET#new' do
        it 'assigns a new message to @message' do
           get :new
           expect(assigns(:project)).to be_a_new Project
        end
        it 'renders the :new template' do
           get :new
           expect(response).to render_template :new
        end
     end
     describe 'GET#edit' do
        it 'assigns the requested project  to @project' do
           get :edit, id: @project
           expect(assigns(:project)).to eq @project
        end
        it 'renders the :edit template' do
           get :edit, id: @project
           expect(response).to render_template @project
        end
     end
     describe 'POST#create' do
        context 'with valid attributes' do
           it 'saves the new project in to database' do
              expect { post :create, project: FactoryGirl.attributes_for(:simple_project) }.to change(Project, :count).by(1)
           end
           it 'redirects to @project detail page' do
              post :create, project: FactoryGirl.attributes_for(:simple_project)
              expect(response).to redirect_to Project.last
           end
        end
        context 'with invalid attributes' do
           it 'does not save the new project' do
             expect { post :create, project: FactoryGirl.attributes_for(:invalid_project) }.to_not change(Project, :count)
           end
           it 're-renders he new method' do
             post :create, project: FactoryGirl.attributes_for(:invalid_project)
             expect(response).to render_template :new
           end
        end
     end
     describe 'PUT#update' do
        context "valid attributes" do
           it "located the requested @project" do
              put :update, id: @project, project: FactoryGirl.attributes_for(:simple_project)
              expect(assigns(:project)).to eq @project
           end
           it "changes @project\'s attributes" do
             put :update, id: @project,project: FactoryGirl.attributes_for(:simple_project, name: 'project100')
             @project.reload
             expect(@project.name).to eq "project100"
           end
           it "redirects to updated project" do
             put :update, id: @project,project: FactoryGirl.attributes_for(:simple_project)
             expect(response).to redirect_to @project
           end
        end
        context "invalid attributes" do
           it "located the requested @project" do
              put :update, id: @project, project: FactoryGirl.attributes_for(:simple_project)
              expect(assigns(:project)).to eq @project
           end
           it "does not change @project's attributes" do
              put :update, id: @project, project: FactoryGirl.attributes_for(:simple_project, name: nil)
              @project.reload
              expect(@project.name).to_not eq nil
           end
           it "re-renders the edit method" do
              put :update, id: @project, project: FactoryGirl.attributes_for(:invalid_project)
              expect(response).to render_template :edit
           end
        end
     end
     describe 'DELETE#destroy' do
        it 'deletes the contact' do
           expect { delete :destroy, id: @project}.to change(Project,:count).by(-1)
        end
        it 'redirects to projects#index' do
           delete :destroy, id: @project
           expect(response).to redirect_to projects_url
        end
     end
  end
end
