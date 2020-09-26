class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|

      t.string  :destination_first_name, null: false
      t.string  :destination_family_name, null: false
      t.string  :destination_kana_first_name, null: false
      t.string  :destination_kana_family_name, null: false
      t.string  :post_code, null: false
      t.integer :prefecture, null: false
      t.string  :municipality, null: false
      t.string  :house_number, null: false
      t.string  :building_name
      t.string  :phone_number, unique: true
      t.references  :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
