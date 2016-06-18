class ItemsController < ApplicationController
  def index
    @item = Item.last
  end
end
