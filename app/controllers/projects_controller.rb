class ProjectsController < ApplicationController
  layout 'project_detail', :only =>  [:show]
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @master_categories = Category.where parentCategory_id: nil
    @answers_labels = ['Yes' , 'No' , 'I have not yet verified']
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
  def project_checklist_response_user_question(question_id)
        question = ProjectChecklistResponse.response_project_user_question(@project.id, session[:current_user_id], question_id).first
        question.responseValue unless question.nil?
  end

  def return_answer_id(question_id)
        "answer_id_" + question_id.to_s
  end

  def return_question_label(question)
    label_string = nil
      unless question.question_labels.first.nil?
        if question.question_labels.first.name.upcase == "Important".upcase
            label_string = "label-warning"
        elsif question.question_labels.first.name.upcase == "Critical".upcase
            label_string = "label-important"
        end
      end
    label_string
  end

  def checklist_question_info_display(question)
    question_info_string = nil
    unless question.question_info.nil?
      question_info_string = question.question_info.sub(question.question_info_emphasis, "\"<strong>"<<question.question_info_emphasis<<"</strong>\"")
    end
    question_info_string
  end
  #helper methods
  helper_method :project_checklist_response_user_question, :return_answer_id, :return_question_label, :checklist_question_info_display

end
