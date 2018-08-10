class ProjectsController < ApplicationController
  # before_action :find_project, only: [:show]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      @project.add_to_users(current_user)

      flash[:success] = "Created New Project"
      redirect_to dashboard_path
    else
      flash[:danger] = @project.errors.full_messages
      render :new
    end
  end

  def show
    @project = Project.includes(:features).find(params[:id])
  end

  private
    def project_params
      params.require(:project).permit(:title, :owner)
    end

    def find_project
      @project = Project.find(params[:id])
    end
end
