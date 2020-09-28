class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items
  has_many :comments, dependent: :destroy
  has_many :destinations, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_one :user_profiles, dependent: :destroy
end