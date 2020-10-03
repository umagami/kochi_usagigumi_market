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
end
