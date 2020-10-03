class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @item_image = @item.item_images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
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
    :preparation_day_id, item_images_attributes: [:image_url]).merge(user_id: current_user.id)
  end
  
end
