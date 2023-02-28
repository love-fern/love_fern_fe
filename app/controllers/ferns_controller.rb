class FernsController < ApplicationController
  def new
  end

  def create
    created_fern = FernService.create_fern(current_user["uid"], fern_params)
    if created_fern.body["error"] == "error"
      flash[:error] = "Please fill all of your fern's information out"
      render :new
    else
      redirect_to greenhouse_path
      flash[:success] = "Congratulations on your new fern!"
    end
  end

  def show
    @fern = FernFacade.find_fern(current_user['uid'], params[:id])
    return if @fern.user_id == current_user['uid']

    flash[:error] = 'Focus on your own Ferns for now!'
    redirect_to greenhouse_path
  end

  def destroy
    FernFacade.delete_fern(current_user['uid'], params[:id])
    redirect_to greenhouse_path
  end

  def edit
    @fern = FernFacade.find_fern(current_user['uid'], params[:id])
  end

  def update
    if valid_message?
      update_for_water(params)
    elsif params[:health]
      update_for_fertilize(params)
    else
      flash[:error] = "Interaction can't be blank"
      redirect_to water_fern_path(params[:id])
    end
  end
  
  private

  def valid_message?
    params[:message].delete(' ') != '' && params[:message].length >= 2
  end
  
  def fern_params
    params.permit(:name, :shelf, :interaction, :preferred_contact_method)
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