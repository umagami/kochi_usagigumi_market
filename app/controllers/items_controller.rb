class ItemsController < ApplicationController
  def index
    @newitems = Item.last(5)
    # @newitems_img = Item_mages.last(5)
    @ladies_items = Item where().last(5)

  end

  def show
  end

  def buy
  end
  
end
