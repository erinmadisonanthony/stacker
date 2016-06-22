class ItemsController < ApplicationController
  def index
    @item = Item.last
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params) 
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end
end