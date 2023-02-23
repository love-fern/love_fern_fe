class SessionsController < ApplicationController
  def create
    user = User.new(request.env['omniauth.auth'])
    session[:user] = user
    redirect_to '/greenhouse'
  end
end