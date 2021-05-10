class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8)
    @amount = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @tax = 1.1
    @cart_item = CartItem.new
  end


end
