class ItemsController < ApplicationController
  def index
    @new_items = Item.last(5)
    @ladies_items = Item.ladies_items_search(1).last(5)

  end

  def show
  end

  def buy
  end
  
end
