class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    has_many :comments, dependent: :destroy
    has_many :item_images, dependent: :destroy
    belongs_to :user
    belongs_to :category
    belongs_to :brand, optional: true
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :item_condition
    belongs_to_active_hash :postage_payer
    belongs_to_active_hash :preparation_day

    
  def self.ladies_items_search(id)

    item = Item.all
    items_array = []

    item.each do |item|
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
    return items_array
  end
end

