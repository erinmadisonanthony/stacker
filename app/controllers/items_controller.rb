class ItemsController < ApplicationController
  def index
    @item = Item.last
  end

  def create
    @item = Item.create(item_params) 
    if @item.invalid?
      flash[:error] = '<strong>Invalid Entry</strong>'
    end
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end
end