class Destination < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, optional: true
  belongs_to_active_hash :prefecture

  validates :destination_first_name, :destination_family_name, presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "全角で入力してください"}
  validates :destination_kana_first_name, :destination_kana_family_name, presence: true, format: {with: /\A[ァ-ヶー－]+\z/, message: "全角(カナ)で入力してください"}
  validates :post_code, presence: true, format: {with: /\A\d{3}[-]\d{4}$|^\d{3}[-]\d{2}$|^\d{3}$|^\d{5}$|^\d{7}\z/, message: "郵便番号をご確認ください"}
  validates :municipality, :house_number, :prefecture_id,presence: true
  validates :phone_number, format: {with:/\A\d{10,11}\z/, message: "電話番号をご確認ください"}, if: :phone_number?
end