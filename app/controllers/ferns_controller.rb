class FernsController < ApplicationController
  before_action :validate_user, only: :new

  def new
  end

  def create
    FernService.create_fern(current_user["uid"], fern_params)
  end

  private
    def fern_params
      params.permit(:name, :shelf, :preferred_contact_method)
    end
end