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

  def invite_users
    @project = Project.find(params[:id])
  end

  def invite_users_create
    @user = User.find_by_email_or_username(params[:username_or_email])

    if @user
      @project = Project.find(params[:project_id])
      @project.users << @user

      flash[:success] = "Successfully Invited User: #{@user.username}"
      redirect_to invite_users_path(params[:project_id])
    else
      flash[:danger] = "User Could Not Be Found"
      redirect_to invite_users_path(params[:project_id])
    end
  end

  private
    def project_params
      params.require(:project).permit(:title, :owner)
    end

    def find_project
      @project = Project.find(params[:id])
    end
end
