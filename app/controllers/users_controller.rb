class UsersController < ApplicationController
  before_action :validate_user, only: :show
  def show
    @shelves = ShelfFacade.user_shelves(current_user['uid'])
  end
end