class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.order(created_at: "DESC").page(params[:page]).per(10)
  end


  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @tax = 1.1
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path
    else
      @order_items = @order.order_items
      render action: :show
    end
  end



  private
  def order_params
    params.require(:order).permit(:status)
  end

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end

end
