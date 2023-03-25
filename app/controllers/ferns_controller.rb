class FernsController < ApplicationController
  def new; end

  def create
    created_fern = FernService.create_fern(current_user['uid'], fern_params)
    if created_fern.body['error'] == 'error'
      flash[:error] = "Please fill all of your fern's information out"
      render :new
    else
      redirect_to greenhouse_path
      flash[:success] = 'Congratulations on your new fern!'
    end
  end

  def show
    @fern = FernFacade.find_fern(current_user['uid'], params[:id])
    return if @fern.user_id == current_user['uid']

    flash[:error] = 'Focus on your own Ferns for now!'
    redirect_to greenhouse_path
  end

  def destroy
    fern = FernFacade.find_fern(current_user['uid'], params[:id])
    FernFacade.delete_fern(current_user['uid'], params[:id])
    redirect_to greenhouse_path
    flash[:success] = "#{fern.name} has been composted! Boundaries are healthy, good for you!"
  end

  def edit
    @fern = FernFacade.find_fern(current_user['uid'], params[:id])
  end

  def update
    if valid_interaction?
      update_for_water
    elsif params[:activity]
      update_for_fertilize
    else
      flash[:error] = "Interaction can't be blank"
      redirect_to water_fern_path(params[:id])
    end
  end

  private

  def valid_interaction?
    return unless params[:interaction]

    params[:interaction].delete(' ') != '' && params[:interaction].length >= 2
  end

  def fern_params
    params.permit(:name, :shelf, :interaction, :preferred_contact_method)
  end

  def fertilize_params
    params.permit(:activity)
  end

  def update_for_water
    response = FernService.update_fern(current_user['uid'], params[:id], fern_params)
    flash[:success] = water_success_message(response)
    redirect_to fern_path(params[:id])
  end

  def update_for_fertilize
    FernService.update_fern(current_user['uid'], params[:id], fertilize_params)
    flash[:success] = 'Fertilized!'
    redirect_to fern_path(params[:id])
  end

  def water_success_message(response)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    interaction = Interaction.new(parsed_response[:included][0])
    interaction.water_message
  end
end
