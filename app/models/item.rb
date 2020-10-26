class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    has_many :comments, dependent: :destroy
    has_many :item_images, dependent: :destroy
    accepts_nested_attributes_for :item_images, allow_destroy: true, update_only: true
    belongs_to :user
    belongs_to :category
    belongs_to :brand, optional: true
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :item_condition
    belongs_to_active_hash :postage_payer
    belongs_to_active_hash :preparation_day
    belongs_to :user, optional: true
    has_many :favorites, dependent: :destroy 

    validates :name, :price, :introduction, :prefecture_id,
    :item_condition_id, :postage_payer_id,
    :preparation_day_id, :user_id, presence: true

    validates :price, presence: true,numericality: {
      greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999,
      message: "¥300〜¥9999999の間で入力してください"

    }

    validate :category_validation

    def category_validation
      category_validation = category
      if category_validation == nil
        errors.add(:category, "カテゴリーを最後まで選択してください")
      elsif category_validation.ancestry.count("/") == 0
        errors.add(:category, "カテゴリーを最後まで選択してください")
      end
    end

    validates :item_images, length: {minimum: 1, maximum: 5, message: "の数が不正です"}

    # validate  :image_lists_validation

    # def image_lists_validation
    #   image_validation = item_images
    #   if image_validation[0].image_url.url == nil then
    #     errors.add(:item_images, "画像を１枚以上添付してください")
    #   elsif image_validation.length > 5
    #     errors.add(:item_images, "画像は５枚まで添付可能です")
    #   end
    # end

  def self.ladies_items_search(id)
    items = Item.all
    items_array = []
    items.each do |item|
      if item.buyer_id == nil
        if item.category.ancestry == nil
          if  item.category.id == id
              items_array << item
          end
        elsif item.category.ancestry.count("/") == 1
          if item.category.parent.parent_id == id
              items_array << item
          end
        else
          item.category.parent_id == id
          items_array << item
        end
      end
    end
    return items_array
  end

    def self.parentCategory(item)
      if item.ancestry == nil then
        ancestryNumber = item.id
      else
        if item.ancestry.count("/") == 0 then
          ancestryNumber = item.parent_id
        else
          ancestryNumber = item.parent.parent_id
        end
      end
      return ancestryNumber
    end


    def self.categorySRC(item,currentItemId)
      ancestryNumber = self.parentCategory(item)

      items = Item.all
      itemArray = []

      items.each do |itemInfo|
        if itemInfo.category.ancestry == nil then
          if itemInfo.category.id == ancestryNumber then
            itemArray << itemInfo
          end
        elsif itemInfo.category.ancestry.count("/") == 0 then
          if itemInfo.category.parent_id == ancestryNumber then
            itemArray << itemInfo
          end
        else
          if itemInfo.category.parent.parent_id == ancestryNumber then
            itemArray << itemInfo
          end
        end
      end
      itemArray.delete_if{|item|
        item.id == currentItemId
      }
      return itemArray
    end

end
