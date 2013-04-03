class ProjectChecklistResponsesController < ApplicationController
  def update_response
        project_id = params[:project_id]
        question_id = params[:question_id]
        answer_value = params[:answer_id]
        user_id = session[:current_user_id]
       project_checklist_response = ProjectChecklistResponse.where(project_id: project_id, question_id: question_id, user_id: user_id).first
       if project_checklist_response.nil?
         project_checklist_response = ProjectChecklistResponse.new
         project_checklist_response.project_id= project_id
         project_checklist_response.question_id= question_id
         project_checklist_response.responseValue= answer_value
         project_checklist_response.user_id= user_id.id
         project_checklist_response.status="Active"
      else
         project_checklist_response.responseValue= answer_value
      end
        respond_to do |format|
               if project_checklist_response.save
                 format.js {}
               end
        end
  end
end
