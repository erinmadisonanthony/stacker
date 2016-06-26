class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all 
  end

  def create
    @item = current_user.items.create(item_params) 
    if @item.invalid?
      flash[:alert] = 'Invalid Entry. Item name must be between 2 and 50 characters.'
    end
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end
end