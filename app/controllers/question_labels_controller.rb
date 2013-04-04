class QuestionLabelsController < ApplicationController
  # GET /question_labels
  # GET /question_labels.json
  def index
    @question_labels = QuestionLabel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @question_labels }
    end
  end

  # GET /question_labels/1
  # GET /question_labels/1.json
  def show
    @question_label = QuestionLabel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question_label }
    end
  end

  # GET /question_labels/new
  # GET /question_labels/new.json
  def new
    @question_label = QuestionLabel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question_label }
    end
  end

  # GET /question_labels/1/edit
  def edit
    @question_label = QuestionLabel.find(params[:id])
  end

  # POST /question_labels
  # POST /question_labels.json
  def create
    @question_label = QuestionLabel.new(params[:question_label])
     @question_label.status="Active"
    respond_to do |format|
      if @question_label.save
        format.html { redirect_to @question_label, notice: 'Question label was successfully created.' }
        format.json { render json: @question_label, status: :created, location: @question_label }
      else
        format.html { render action: "new" }
        format.json { render json: @question_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /question_labels/1
  # PUT /question_labels/1.json
  def update
    @question_label = QuestionLabel.find(params[:id])

    respond_to do |format|
      if @question_label.update_attributes(params[:question_label])
        format.html { redirect_to @question_label, notice: 'Question label was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_labels/1
  # DELETE /question_labels/1.json
  def destroy
    @question_label = QuestionLabel.find(params[:id])
    @question_label.destroy

    respond_to do |format|
      format.html { redirect_to question_labels_url }
      format.json { head :no_content }
    end
  end
end
