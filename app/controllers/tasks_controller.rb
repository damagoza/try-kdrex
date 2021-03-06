class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /tasks
  # GET /tasks.json
  def index
    @project = Project.find(params[:project_id])
    @tasks = Task.where(:project_id => params[:project_id])
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    puts "LLe en params[:project_id] => #{params[:project_id]}"    
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.start_task = DateTime.strptime("#{task_params[:start_task].split('/')[2].split(' ')[0]}#{task_params[:start_task].split('/')[0]}#{task_params[:start_task].split('/')[1]}","%Y%m%d")
    @task.end_task = DateTime.strptime("#{task_params[:end_task].split('/')[2].split(' ')[0]}#{task_params[:end_task].split('/')[0]}#{task_params[:end_task].split('/')[1]}","%Y%m%d")
    respond_to do |format|
      if @task.save
        UserMailer.notification_task(@task.project, @task.user).deliver_now
        format.html { redirect_to tasks_path(:project_id => @task.project_id), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :project_id, :user_id, :start_task, :end_task, :state, :description)
    end
end
