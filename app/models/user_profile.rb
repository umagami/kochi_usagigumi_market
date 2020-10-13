class UserProfile < ApplicationRecord
  belongs_to :user, optional: true

  validates :family_name, :first_name, presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "全角で入力してください"}
  validates :kana_family_name, :kana_first_name,  presence: true, format: {with: /\A[ァ-ヶー－]+\z/, message: "全角(カナ)で入力してください"}
  validates :birthday, presence: true
end
