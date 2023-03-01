class ApplicationController < ActionController::Base
  before_action :validate_user, only: %i[new show]
  helper_method :current_user
  def current_user
    @current_user ||= session[:user] if session[:user]
  end

  def validate_user
    return if current_user

    flash[:error] = 'You must be logged in to access this page'
    redirect_to root_path
  end
end
