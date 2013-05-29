require 'spec_helper'

describe UsersController do
  ###########shared examples################3
  
  shared_examples 'public access to users' do
    describe 'GET#index' do
       it 'raise AccessDenied' do
         bypass_rescue
         expect { get :index }.to raise_error(CanCan::AccessDenied)
       end
    end
    describe 'GET#show' do
       it 'raise AccessDenied' do
          bypass_rescue
          expect { get :show, id: @user}.to raise_error(CanCan::AccessDenied)
       end
    end
    describe 'GET#new' do
       it 'raise AccessDenied' do
          bypass_rescue
          expect { get :new}.to raise_error CanCan::AccessDenied
       end
    end
    describe 'GET#edit' do
       it 'raise AccessDenied' do
          bypass_rescue
          expect { get(:edit,id: @user) }.to raise_error CanCan::AccessDenied
       end
    end
    describe 'POST#create' do
       it 'raise AccessDenied' do
          bypass_rescue
          expect { post(:create, user: FactoryGirl.attributes_for(:simple_user)) }.to raise_error CanCan::AccessDenied
       end
    end
    describe 'PUT#update' do
       it 'raise AccessDenied' do
          bypass_rescue
          expect { put(:update, id: @user, user: FactoryGirl.attributes_for(:simple_user)) }.to raise_error CanCan::AccessDenied
       end
    end
    describe 'DELETE#destroy' do
       it 'raise AccessDenied' do
          bypass_rescue
          expect { delete(:destroy, id: @user) }.to raise_error CanCan::AccessDenied
       end
    end
  end
  ################ guest role #################
  describe 'guest role access' do
     before :each do
        @user = FactoryGirl.create(:simple_user)
        user = FactoryGirl.create(:logged_in_user, roles: [FactoryGirl.create(:guest_role)])
        session[:current_user_id] = user.id
     end
     
     it_behaves_like 'public access to users'
  end
  
  ############ project member role ###########
  describe 'project member role access' do
     before :each do
        @user = FactoryGirl.create(:simple_user)
        user = FactoryGirl.create(:logged_in_user, roles: [FactoryGirl.create(:project_member_role)])
        session[:current_user_id] = user.id
     end
     
     it_behaves_like 'public access to users'
  end
  
  ############### admin role access ###################
  describe 'admin role access' do
     before :each do
        @user = FactoryGirl.create(:simple_user)
        user = FactoryGirl.create(:logged_in_user, roles: [FactoryGirl.create(:admin_role)])
        session[:current_user_id] = user.id
     end
     
     describe 'GET#index' do
        it 'populates an array of users' do
           get :index
           expect(assigns(:users)).to match_array [@user]
        end
        it 'renders :index template' do
           get :index
           expect(response).to render_template :index
        end
     end
     
     describe 'GET#show' do
        it 'assigns requested user to @user' do
           get :show,id: @user
           expect(assigns(:user)).to eq @user
        end
        it 'renders :show template' do
           get :show, id: @user
           expect(response).to render_template :show
        end
     end
     
     describe 'GET#new' do
        it 'assigns a new user' do
           get :new
           expect(assigns(:user)).to be_a_new User
        end
        it 'renders :new template' do
           get :new
           expect(response).to render_template :new
        end
     end
     
     describe 'GET#edit' do
        it 'assigns the requested user to @user' do
           get :edit, id: @user
           expect(assigns(:user)).to eq @user
        end
        it 'renders edit template' do
           get :edit, id: @user
           expect(response).to render_template :edit
        end
     end
     
     
  end
end
