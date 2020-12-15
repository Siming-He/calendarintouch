class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit

  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)
    @subject.owneremail = current_user.email
    if @subject.private == nil
      @subject.private = false
    end
    respond_to do |format|
      if @subject.save
        @subject.user_add = current_user
        format.html { redirect_to edit_subject_path(@subject), notice: 'Subject was successfully created.' }
        format.json { render :edit, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to edit_subject_path(@subject), notice: 'Subject was successfully updated.' }
        format.json { render :edit, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subject_params
      params.require(:subject).permit(:name, :description, :syllabus,:private, tasks_attributes: Task.attribute_names.map(&:to_sym).push(:_destroy))
    end
end
