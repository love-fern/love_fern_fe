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

  def edit
    @fern = FernFacade.find_fern(current_user['uid'], params[:id])
  end

  def update
    if params[:interaction] != '' && params[:interaction] != ' '
      FernService.update_fern(current_user['uid'], params[:id], fern_params)
      flash[:success] = 'Fern watered!'
      redirect_to fern_path(params[:id]) if params[:commit] == 'Water Fern'
    else
      flash[:error] = "Interaction can't be blank"
      redirect_to water_fern_path(params[:id])
    end
  end

  private

  def fern_params
    params.permit(:name, :shelf, :preferred_contact_method)
  end
end