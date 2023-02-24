class SessionsController < ApplicationController
  def create
    user = User.new(request.env['omniauth.auth'])
    session[:user] = user.raw_data
    binding.pry
    redirect_to '/greenhouse'
  end
end