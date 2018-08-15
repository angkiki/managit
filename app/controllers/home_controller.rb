class HomeController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def home
  end

  def dashboard
    @projects = current_user.projects.includes(:project_users)
    @accepted_projects = @projects.where('project_users.status = 1')
    @pending_projects = @projects.where('project_users.status = 0')
  end

  def github_auth
    # provide a random string
    # random string will be called state in params
    # ?state="RANDOM_STRING"
    @state = SecureRandom.alphanumeric(8)
    session[:state] = @state
  end

  def callback
    # check for random string to prevent CORS
    # get params[:code] for user's access token

    # POST https://github.com/login/oauth/access_token
    # need to provide client_id, client_secret, params[:code]
    # use params[:code] to exchange for an access_token

    # receive back access_token and store into user column

    if params[:state] == session[:state]

      @uri = URI.parse("https://github.com/login/oauth/access_token")

      @response = Net::HTTP.post_form(@uri, {
        'client_id' => "893624586408ad9146c0",
        'client_secret' => "1eaa7676b8eee9d5d6af1861224ac43914a519d2",
        'code' => params[:code]
      })

      if @response.code == "200"
        @access_token = @response.body.split("&")[0].split("=")[1]
        current_user.update_columns(access_token: @access_token)
      end
    end
  end

end
