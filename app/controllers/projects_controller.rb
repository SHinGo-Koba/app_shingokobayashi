class ProjectsController < ApplicationController
  before_action :confirm_login, only: [:new, :create]
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all.order(created_at: "DESC")
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks.order(created_at: "DESC")
  end

  # GET /projects/new
  def new
    @project = Project.new
  end
  
  # POST /projects
  # POST /projects.json
  def create
    @user = current_user
    Project.transaction do
      unless @user.organizer
        @organizer = @user.build_organizer(organizer_name: @user.user_name)
        @organizer.save!
      else
        @organizer = @user
      end
      @project = @organizer.projects.new(project_params)
      @project.save!
    end
      flash[:success] = "Project was successfully created"
      redirect_to projects_path
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:danger] = "Failed to be created"
      render :new
      puts "#{e.class}: #{e.message}"
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  # def destroy
  #   @project.destroy
  #   respond_to do |format|
  #     format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :summary)
    end
    
end
