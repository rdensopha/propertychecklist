module  Api
  module V1
    class ProjectsController < ApplicationController
      respond_to :json
      
      def count
        respond_with(@count = Project.count)
      end
    end
  end
end