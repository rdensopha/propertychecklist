class ProjectDevelopersController < ApplicationController
  # GET /project_developers
  # GET /project_developers.json
  def index
    @project_developers = ProjectDeveloper.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @project_developers }
    end
  end

  # GET /project_developers/1
  # GET /project_developers/1.json
  def show
    @project_developer = ProjectDeveloper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project_developer }
    end
  end

  # GET /project_developers/new
  # GET /project_developers/new.json
  def new
    @project_developer = ProjectDeveloper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project_developer }
    end
  end

  # GET /project_developers/1/edit
  def edit
    @project_developer = ProjectDeveloper.find(params[:id])
  end

  # POST /project_developers
  # POST /project_developers.json
  def create
    @project_developer = ProjectDeveloper.new(params[:project_developer])

    respond_to do |format|
      if @project_developer.save
        format.html { redirect_to @project_developer, notice: 'Project developer was successfully created.' }
        format.json { render json: @project_developer, status: :created, location: @project_developer }
      else
        format.html { render action: "new" }
        format.json { render json: @project_developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /project_developers/1
  # PUT /project_developers/1.json
  def update
    @project_developer = ProjectDeveloper.find(params[:id])

    respond_to do |format|
      if @project_developer.update_attributes(params[:project_developer])
        format.html { redirect_to @project_developer, notice: 'Project developer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project_developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_developers/1
  # DELETE /project_developers/1.json
  def destroy
    @project_developer = ProjectDeveloper.find(params[:id])
    @project_developer.destroy

    respond_to do |format|
      format.html { redirect_to project_developers_url }
      format.json { head :no_content }
    end
  end
end
