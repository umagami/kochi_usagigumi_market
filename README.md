# README

# ChatSpace DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|index: true|
|password|string|null: false|
### Association
- has_many :items
- has_many :comments, dependent: :destroy
- has_many :destination dependent: :destroy
- has_many :credit_infomation, dependent: :destroy 
- has_one :user_profiles, dependent: :destroy

## user_profilesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false| 
|family_name|string|null: false|
|kana_first_name|string|null: false|
|kana_family_name|string|null: false|
|birth_year|data|null: false|
|birth_month|data|null: false|
|dirth_day|data|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## destinationsテーブル
|Column|Type|Options|
|------|----|-------|
|destination_first_name|string|null: false| 
|destination_family_name|string|null: false|
|destination_kana_first_name|string|null: false|
|destination_kana_family_name|string|null: false|
|post_code|integer(7)|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string||
|phone_number|integer|unique :true|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- Gem :jp_prefectuer

## Credit_infomationsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|unique: true|
|card_year|integer|null: false|
|card_month|integer|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|created|timestamp|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|introduction|text|null: false|
|prefecture_code|integer|null: false|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|item_condition_id|references|null: false, foreign_key: true|
|item_image_id|references|null: false, foreign_key: true|
|postage_payer_id|references|null: false, foreign_key: true|
|preparation_day|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|
### Association
- has_many :comments, dependent :destroy
- has_many :item_images, dependent :destroy - belongs_to :user
- belongs_to :category
- belongs_to :brand
- belongs_to_active_hash :item_condition
- belongs_to_active_hash :postage_payer
- belongs_to_active_hash :preparation_day
- Gem :jp_prefecture

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image_url|string|null: false|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :item

## Brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
### Association
- has_many :items

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|ancestry|string|null: false|
|name|string|null: false|
### Association
- has_many :item

## item_conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|item_condition|string|null: false|
### Association
- has_many :item

## postage_payersテーブル
|Column|Type|Options|
|------|----|-------|
|postage_payer|string|null: false|
### Association
- has_many :item

## preparation_daysテーブル
|Column|Type|Options|
|------|----|-------|
|preparation_day|string|null: false|
### Association
- has_many :item

