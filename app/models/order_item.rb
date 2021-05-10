class OrderItem < ApplicationRecord
  
  belongs_to :item
  belongs_to :order
  
  enum making_status:{"製作不可":0,"製作待ち":1,"製作中":2,"製作完了":3}
  
  # validates :item_id, presence: true
  # validates :order_id, presence: true
  # validates :price, presence: true
  # validates :amount, presence: true
  # validates :making_status, presence: true
  
  
end
