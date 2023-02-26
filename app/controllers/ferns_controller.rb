class FernsController < ApplicationController
  def new
  end

  def create
    FernService.create_fern(current_user["uid"], fern_params)
    redirect_to greenhouse_path
  end

  def show
    @fern = FernFacade.find_fern(current_user['uid'], params[:id])
  end

  def destroy
    FernFacade.delete_fern(current_user['uid'], params[:id])
    redirect_to greenhouse_path
  end

  private

  def fern_params
    params.permit(:name, :shelf, :preferred_contact_method)
  end
end