class ItemsController < ApplicationController
  def index

    @new_items = Item.last(5)
    @ladies_items = Item.ladies_items_search(1).last(5)

  end

  def new
    @item = Item.new
    @item.item_images.new
  end

  def create
    @item = Item.new(item_params)
    if !@item.save
      render :new 
    else
      redirect_to root_path
    end
  end

  def show
  end

  def buy
  end

  private
  def item_params
  params.require(:item).permit(:name, :price, :introduction, :prefecture_id, 
    :category_id, :item_condition_id, :postage_payer_id,
    :preparation_day_id, images_attributes: [:item_image]).merge(user_id: current_user.id)
  end
  
end
