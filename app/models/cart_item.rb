class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  # validates :user_id, presence: true
  # validates :item_id, presence: true  
  # validates :amount, presence: true
  
  
end
