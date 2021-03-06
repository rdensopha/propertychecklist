class ProjectChecklistResponsesController < ApplicationController
  load_and_authorize_resource
  def update_response
        project_id = params[:project_id]
        question_id = params[:question_id]
       key_val = params.keys.grep(/answer/).first
        answer_value = params[key_val]
        user_id = session[:current_user_id]
       # Rails.cache.delete([project_id,question_id,answer_value])
       project_checklist_response = ProjectChecklistResponse.response_project_user_question(project_id, user_id,question_id).first
       if project_checklist_response.nil?
         project_checklist_response = ProjectChecklistResponse.new
         project_checklist_response.project_id= project_id
         project_checklist_response.question_id= question_id
         project_checklist_response.responseValue= answer_value
         project_checklist_response.user_id= user_id
         project_checklist_response.status="Active"
      else
        # Rails.cache.delete([project_id,question_id,project_checklist_response.responseValue])
         project_checklist_response.responseValue= answer_value
      end
        respond_to do |format|
               if project_checklist_response.save
                 format.js {}
               end
        end
  end
end
