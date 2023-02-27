class FernsController < ApplicationController
  def new
  end

  def create
    FernService.create_fern(current_user["uid"], fern_params)
    redirect_to greenhouse_path
  end

  def show
    @fern = FernFacade.find_fern(current_user['uid'], params[:id])
    unless @fern.user_id == current_user['uid']
      flash[:error] = 'Focus on your own Ferns for now!'
      redirect_to greenhouse_path
    end
  end

  def destroy
    FernFacade.delete_fern(current_user['uid'], params[:id])
    redirect_to greenhouse_path
  end

  def edit
    @fern = FernFacade.find_fern(current_user['uid'], params[:id])
  end

  def update
    if interaction?
      update_for_water(params)
    elsif params[:health]
      update_for_fertilize(params)
    else
      flash[:error] = "Interaction can't be blank"
      redirect_to water_fern_path(params[:id])
    end
  end
  
  private

  def interaction?
    params[:interaction] != '' && params[:interaction] != ' '
  end
  
  def fern_params
    params.permit(:name, :shelf, :preferred_contact_method)
  end
  
  def update_for_water(params)
    FernService.update_fern(current_user['uid'], params[:id], fern_params)
    flash[:success] = 'Fern watered!'
    redirect_to fern_path(params[:id])
  end
  
  def update_for_fertilize(params)
    FernService.update_fern(current_user['uid'], params[:id], fern_params)
    flash[:success] = 'Fertilized!'
    redirect_to fern_path(params[:id])
  end
end