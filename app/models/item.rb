class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_items
  belongs_to :genre

  attachment :image

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, presence: true
end
