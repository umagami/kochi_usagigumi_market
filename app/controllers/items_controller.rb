class ItemsController < ApplicationController
  before_action :item_find, {only:[:show, :edit, :update, :destroy, :buy, :purchase, :access_judge, :card_information_check, :item_information_check]}
  before_action :sign_in_judge, {only:[:edit,:new]}
  before_action :access_judge, {only:[:edit]}
  before_action :card_information_check, {only:[:purchase]}
  # before_action :item_information_check, {only:[:purchase]}

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
    if @item.save
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
  end

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
    @card = Card.get_card(current_user.card.customer_token) if current_user.card
  end

  def purchase
    @buyer = @item.update(buyer_id: current_user.id)
    # if @item.buyer_id != nil
    #   flash[:alert] = '売り切れています。'
    #   redirect_to item_path(@item.id)
    # else
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price,
      customer: customer_token,
      currency: 'jpy'
    )
    redirect_to root_path(@item)
    # end
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

  def card_information_check
    @user = User.find(current_user.id)
    if @user.card == nil
      flash.now[:alert] = 'カード情報が登録されていません'
      render :buy
    end
  end

  # def item_information_check
  #   @buyer = @item.update(buyer_id: current_user.id)
  #   if @item.buyer_id != nil
  #     flash.now[:alert] = '売り切れています。'
  #     render :buy
  #   end
  # end

  def destroy
    if @item != nil
      if current_user.id == @item.user_id
        @item.destroy
        flash[:alert] = '商品を削除しました'
        redirect_to root_path
      else
        flash[:alert] = '商品の削除が行えませんでした'
        redirect_to item_path(@item.id)
      end
    else
      flash[:alert] = 'その商品はすでに削除されているか、情報がありません'
      redirect_to root_path
    end
  end

  def destroy
    @item = Item.find(params[:id])
      if current_user.id == @item.user_id
        @item.destroy
        redirect_to root_path
      else
        redirect_to item_path(@item.id)
      end
  end


  private

  def item_find
    if  Item.exists?(params[:id])
      @item = Item.find(params[:id])
    else
      flash[:alert] = 'その商品はすでに削除されているか、情報がありません'
      redirect_to root_path
    end
  end

  def item_params
    params.require(:item).permit(:name, :price, :introduction, :prefecture_id,
    :category_id, :item_condition_id, :postage_payer_id,
    :preparation_day_id, item_images_attributes: [:image_url, :id, :_destroy]).merge(user_id: current_user.id)
  end
end
