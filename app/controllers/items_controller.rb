class ItemsController < ApplicationController

  
  before_action :item_find, {only:[:show, :edit, :update, :buy, :access_judge]}
  before_action :sign_in_judge, {only:[:edit,:new]}
  before_action :access_judge, {only:[:edit]}

  def index
    @new_items = Item.last(5)
    @ladies_items = Item.ladies_items_search(1).last(5)
  end

  def new
    @item = Item.new
    @item_image = @item.item_images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid? && @item.save
      redirect_to root_path
    else
      @item.item_images.new
      render :new and return
    end
  end

  def show
    @category = Category.where(ancestry:nil)
    @categoryParent = Category.find(Item.parentCategory(@item.category))
    @items = Item.categorySRC(@item.category,@item.id).last(3)

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else 
      redirect_to edit_item_path
    end 
  end

  def buy
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def access_judge
    if @item.user_id != current_user.id
      redirect_to root_path
    end
  end

  def sign_in_judge
    if current_user == nil
      redirect_to user_session_path
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :price, :introduction, :prefecture_id,
    :category_id, :item_condition_id, :postage_payer_id,
    :preparation_day_id, item_images_attributes: [:image_url, :id, :_destroy]).merge(user_id: current_user.id)
  end

end
