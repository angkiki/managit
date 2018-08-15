class HomeController < ApplicationController
  before_action :home_to_dashboard, only: [:home]
  before_action :unauthorised_access, only: [:dashboard]

  def home
  end

  def dashboard
    @projects = current_user.projects.includes(:project_users)
    @accepted_projects = @projects.where('project_users.status = 1')
    @pending_projects = @projects.where('project_users.status = 0')
  end

  private
  # if current user, redirect home to dashboard
  def home_to_dashboard
    redirect_to dashboard_path if current_user
  end

end
