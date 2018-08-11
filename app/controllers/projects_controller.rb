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

    # owner will be boolean
    @owner = @project.is_owner_or_not(current_user)

    # pending features
    @pending_features = @project.features.where(status: 'pending')
    @bug_features = @project.features.where(status: 'bugs')
    @completed_features = @project.features.where(status: 'completed')
  end

  # form for inviting other users to join project
  def invite_users
    @project = Project.find(params[:id])
  end

  # action for inserting other users into project
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

  # action for accepting project invitation
  def accept_project_invitation
    @project_user = ProjectUser.find_by(user_id: current_user.id, project_id: params[:proj_id])

    if @project_user.status == 'pending'
      @project_user.update_columns(status: 1)

      flash[:success] = 'Accepted Project Invitation'
      redirect_to dashboard_path
    else
      flash[:danger] = 'Invalid Action'
      redirect_to dashboard_path
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
