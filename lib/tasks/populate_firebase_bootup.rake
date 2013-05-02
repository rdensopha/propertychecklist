namespace :populate_firebase_bootup do
  desc "populate initial projects in firebase for comments"
  task :populate => [:environment] do
    module MyFireBase
      class BasicFireBase
        include HTTParty

        base_uri 'https://propertychecklist-comments.firebaseio.com'

        default_params auth:  'ENV["FIREBASE_SECRET_KEY"]'

        format :json

        headers 'Content-Type' => 'application/json'

        def self.add_project(project_id, project_dev_name, project_loc, project_name)
          patch("/projects/.json", :body => {project_id => {projectDeveloperName: project_dev_name,
                                                                                            projectLocation: project_loc,
                                                                                            projectName: project_name
                                                                                            }
                                                                   }.to_json)
        end
      end
      #iterate through all the projects and load in to firebase
      Project.find_each do |project_fmdb|
        processed_proj_dev_name =  project_fmdb.project_developer.name.downcase.gsub(/\./,'')
        project_id =  project_fmdb.name.downcase << "_" <<  processed_proj_dev_name
        BasicFireBase.add_project(project_id, project_fmdb.project_developer.name, project_fmdb.city.name.chomp, project_fmdb.name)
      end
    end
  end
end