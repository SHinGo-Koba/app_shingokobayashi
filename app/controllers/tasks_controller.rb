class TasksController < ApplicationController
  before_action :confirm_login
  before_action :block_invalid_param_user_id, only: :create
  
  # GET new_project_task_path(project)
  def new
    @project = Project.find_by(id: params[:project_id])
    if !@project
      no_page_("project")
    else
      @task = Task.new
    end
  end

  # POST project_tasks_path(project)
  def create
    @project = Project.find_by(id: params[:project_id])
    if !@project
      no_page_("project")
    else
      @task = @project.tasks.new(task_params)
      if @task.save
        flash[:success] = "Committed to this project!"
        redirect_to project_path(@project)
      else
        flash.now[:danger] = "Failed to be created"
        render :new
      end
    end
  end
  
  private
    def task_params
      params.require(:task).permit(:body).merge(user_id: current_user.id)
    end
    
    def block_invalid_param_user_id
      if params[:task][:user_id] && (params[:task][:user_id] != current_user.id)
        flash[:danger] = "Invalid access"
        redirect_to projects_path
      end
    end
  
end
