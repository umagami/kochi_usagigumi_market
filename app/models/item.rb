class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    has_many :comments, dependent: :destroy
    has_many :item_images, dependent: :destroy
    accepts_nested_attributes_for :item_images, allow_destroy: true
    belongs_to :user
    belongs_to :category
    belongs_to :brand, optional: true
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :item_condition
    belongs_to_active_hash :postage_payer
    belongs_to_active_hash :preparation_day

    validates :name, :price, :introduction, :prefecture_id,
    :category_id, :item_condition_id, :postage_payer_id,
    :preparation_day_id, :user_id, presence: true
    validates :price, presence: true,numericality: { 
      greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, 
      message: "¥300〜¥9999999の間で入力してください" 
    }

    validate  :image_lists_validation

    def image_lists_validation
      image_validation = item_images
      if image_validation.length < 1 then
        errors.add(:item_images, "画像を１枚以上添付してください")
      elsif image_validation.length > 5
        errors.add(:item_images, "画像は５枚まで添付可能です")
      end
    end

end
