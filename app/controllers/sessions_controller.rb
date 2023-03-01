class SessionsController < ApplicationController
  def create
    user = User.new(user_information)
    session[:user] = user.raw_data
    create_info = session[:user]
    create_info[:google_id] = create_info[:uid]
    UserFacade.create_user(create_info)

    redirect_to '/greenhouse'
  end

  def delete
    session[:user] = nil
    redirect_to root_path
  end

  private

  def user_information
    request.env['omniauth.auth']
  end
end
