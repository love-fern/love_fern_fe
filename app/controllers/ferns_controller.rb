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
  #   return if @fern.user_id == current_user['uid']

  #   flash[:error] = 'Focus on your own Ferns for now!'
  #   redirect_to greenhouse_path
  end

  def destroy
    FernFacade.delete_fern(current_user['uid'], params[:id])
    redirect_to greenhouse_path
  end

  def edit
    @fern = FernFacade.find_fern(current_user['uid'], params[:id])
  end

  def update
    if valid_interaction?
      update_for_water
    elsif params[:health]
      update_for_fertilize
    else
      flash[:error] = "Interaction can't be blank"
      redirect_to water_fern_path(params[:id])
    end
  end
  
  private

  def valid_interaction?
    if params[:interaction]
      params[:interaction].delete(' ') != '' && params[:interaction].length >= 2
    end
  end
  
  def fern_params
    params.permit(:name, :shelf, :interaction, :preferred_contact_method)
  end
  
  def fertilize_params
    params.permit(:health)
  end

  def update_for_water
    FernService.update_fern(current_user['uid'], params[:id], fern_params)
    flash[:success] = 'Fern watered!'
    redirect_to fern_path(params[:id])
  end
  
  def update_for_fertilize
    FernService.update_fern(current_user['uid'], params[:id], fertilize_params)
    flash[:success] = 'Fertilized!'
    redirect_to fern_path(params[:id])
  end
end