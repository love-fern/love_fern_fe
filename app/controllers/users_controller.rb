class UsersController < ApplicationController
  before_action :validate_user, only: :show
  def show
  end
end