module  Api
  module V1
    class ProjectsController < ApplicationController
      respond_to :json
      
      # GET /api/v1/projects/count 
      def count
        respond_with(@count = Project.count)
      end
      # GET /api/v1/projects/added?days=X
      def added
        @result_hash = {}
        if params[:days]
         time_range = params[:days].to_i.days.ago..Time.now
         time_zone = ActiveSupport::TimeZone["Kolkata"] 
         group_hash = Project.group_by_day(:created_at,time_zone,time_range).count
         group_hash.each do |time,count|
            temp_hash = {time.strftime("%d/%m") => count}
            @result_hash.merge! temp_hash
         end
        elsif params[:months]
        end
      end         
    end
  end
end