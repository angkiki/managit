class HomeController < ApplicationController

  def home
  end

  def dashboard
    @projects = current_user.projects.includes(:project_users)
    @accepted_projects = @projects.where('project_users.status = 1')
    @pending_projects = @projects.where('project_users.status = 0')
  end

end
