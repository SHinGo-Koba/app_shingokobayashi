class ProjectsController < ApplicationController
  before_action :confirm_login

  # GET /projects
  def index
    @projects = Project.all.order(created_at: "DESC")
  end

  # GET /projects/1
  def show
    @project = Project.find_by(id: params[:id])
    if !@project
      no_page_("project") #from sharedhelper
    else
      @tasks = @project.tasks.order(created_at: "DESC")
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end
  
  # POST /projects
  def create
    @user = current_user
    Project.transaction do
      unless @user.organizer
        @organizer = @user.build_organizer(organizer_name: @user.user_name)
        @organizer.save!
      else
        @organizer = @user.organizer
      end
      @project = @organizer.projects.new(project_params)
      puts @project.inspect
      @project.save!
    end
      flash[:success] = "Project was successfully created"
      redirect_to projects_path
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:danger] = "Failed to be created"
      render :new
      puts "#{e.class}: #{e.message}"
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :summary)
    end
    
end
