class Ferns::ActivitiesController < ApplicationController
  def index
    @fern = FernFacade.find_fern(current_user['uid'], params[:id])
    @activity = ActivityFacade.get_an_activity
  end
end