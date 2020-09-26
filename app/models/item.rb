class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  has_many :comments, dependent :destroy
  has_many :item_images, dependent :destroy
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day

end
