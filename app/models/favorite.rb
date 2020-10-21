class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates_uniqueness_of :item_id, scope: :user_id 

def self.fav_count(item_id)

  favorites = Favorite.where(item_id:item_id).count
  return favorites


  

  
end

end
