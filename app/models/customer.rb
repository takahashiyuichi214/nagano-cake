class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  def full_name
   [last_name,first_name].join(' ')
  end

  enum is_active: { '有効': true, '退会済': false }

  def active_for_authentication?
    super && (self.is_active == "有効")
  end



  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :first_name_kana, presence: true
  # validates :last_name_kana, presence: true
  # validates :postal_code, presence: true
  # validates :address, presence: true
  # validates :telephone_number, presence: true
  # validates :is_active, inclusion:{in: [true, false]}




end
