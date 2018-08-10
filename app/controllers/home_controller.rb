class HomeController < ApplicationController

  def home
  end

  def dashboard
    @user = current_user
  end

end
