class ItemsController < ApplicationController
  def index
    @item = Item.last
  end

  def new
    @item = Item.new
  end
end
