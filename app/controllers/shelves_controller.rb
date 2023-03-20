class ShelvesController < ApplicationController
  def new

  end

  def create
    created_shelf = FernService.create_shelf(current_user['uid'], shelf_params)
    # binding.pry
    if created_shelf.body['error'] == 'error'
      flash[:error] = "Please fill out all of the shelf's information out"
      render :new
    else
      redirect_to greenhouse_path
      flash[:success] = 'Congratulations on your new shelf! Plant a fern to add to the shelf and get watering!'
    end
  end

  private

  def shelf_params
    params.permit(:name, :user_id)
  end
end