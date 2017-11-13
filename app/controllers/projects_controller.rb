class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  include UserHelper
  # GET /projects
  # GET /projects.json
  def index
    if administrator(current_user.id)
      @projects = Project.where(:user_id => current_user.id)
    else
      @projects = Project.where(:id => Task.where(:user_id => current_user.id).select(:project_id))
    end
    
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit 
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.start_project = DateTime.strptime("#{project_params[:start_project].split('/')[2].split(' ')[0]}#{project_params[:start_project].split('/')[0]}#{project_params[:start_project].split('/')[1]}","%Y%m%d")
    @project.end_project = DateTime.strptime("#{project_params[:end_project].split('/')[2].split(' ')[0]}#{project_params[:end_project].split('/')[0]}#{project_params[:end_project].split('/')[1]}","%Y%m%d")
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|      
      if project_params[:start_project] != ""
        @project.update(:start_project => DateTime.strptime("#{project_params[:start_project].split('/')[2].split(' ')[0]}#{project_params[:start_project].split('/')[0]}#{project_params[:start_project].split('/')[1]}","%Y%m%d"))        
      end
      if project_params[:end_project] != ""
        @project.update(:end_project => DateTime.strptime("#{project_params[:end_project].split('/')[2].split(' ')[0]}#{project_params[:end_project].split('/')[0]}#{project_params[:end_project].split('/')[1]}","%Y%m%d"))        
      end      
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end    
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :user_id, :start_project, :end_project, :description)
    end
end
