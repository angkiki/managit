class FeaturesController < ApplicationController

  def new
    @feature = Feature.new
    @project = Project.includes(:users).find(params[:proj_id])
    @users = @project.users
  end

  def create
    @feature = Feature.new(feature_params)

    if @feature.save
      flash[:success] = "Created New Feature"
      redirect_to project_path(feature_params[:project_id])
    else
      flash[:danger] = @feature.errors.full_messages
      render :new
    end
  end

  private
    def feature_params
      params.require(:feature).permit(:name, :status, :project_id, :user_id)
    end

end
