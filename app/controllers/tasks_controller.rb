class TasksController < ApplicationController
  before_action :confirm_login
  before_action :block_invalid_param_user_id, only: :create
  
  def new
    @task = Task.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    
    if @task.save
      flash[:success] = "Committed to this project!"
      redirect_to project_path(@project)
    else
      flash.now[:danger] = "Failed to be created"
      render :new
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
