class FeaturesController < ApplicationController

  def new
    @feature = Feature.new
    @project = Project.includes(:users).find(params[:proj_id])
    @users = @project.users

    respond_to { |format| format.js }
  end

  def create
    @feature = Feature.new(feature_params)

    if @feature.save
      # flash[:success] = "Created New Feature"
      # redirect_to project_path(feature_params[:project_id])
      respond_to { |format| format.js { render "features/success" } }
    else
      # flash[:danger] = @feature.errors.full_messages
      # render :new
      respond_to { |format| format.js { render "features/failure" } }
    end
  end

  def feature_completed
    @feature = Feature.find(params[:feat_id])

    if @feature.status != 'completed'
      @feature.update_columns(status: 2)

      ActionCable.server.broadcast('project_channel', feature: render_completed_features(@feature), feature_id: @feature.id)
    end
  end

  private
    def feature_params
      params.require(:feature).permit(:name, :status, :project_id, :user_id)
    end

    def render_completed_features(feature)
      render(partial: 'projects/completed_feature', locals: { feat: feature })
    end
end
