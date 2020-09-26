class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|

      t.string      :first_name, null: false
      t.string      :family_name, null: false
      t.string      :kana_first_name, null: false
      t.string      :kana_family_name, null: false
      t.date        :birthday, null: false
      t.references  :user, null: false, foreign_key: true
      
      t.timestamps  null: false
    end
  end
end
