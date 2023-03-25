class Ferns::StatsController < ApplicationController
  def index
    @fern = FernFacade.get_fern_stats(current_user['uid'], params[:fern_id])
  end
end