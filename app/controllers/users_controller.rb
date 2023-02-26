class UsersController < ApplicationController
  def show
    @shelves = ShelfFacade.user_shelves(current_user['uid'])
  end
end