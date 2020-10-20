class FavoritesController < ApplicationController

  before_action :item_params, {only:[:create, :destroy]}
  before_action :authenticate_user!

  def create
    # binding.pry
    if @item.user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, item_id: @item.id)
      @favorites = Favorite.fav_count(@item.id)
      respond_to do |format|
        format.json
    end
  end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
  end

  def index
    @user = User.find_by(id: params[:user_id])
    @favorites = Favorite.where(user_id: @user.id)   
  end

  

  private

  def item_params
    @item = Item.find(params[:item_id])
  end

end
