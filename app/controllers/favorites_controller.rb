class FavoritesController < ApplicationController

  before_action :item_params
  before_action :authenticate_user!

  def create
    # binding.pry
    if @item.user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, item_id: @item.id)
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
  end

  

  private

  def item_params
    @item = Item.find(params[:item_id])
  end

end
