class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    if @order = Order.create(order_params)
      @cart_items = CartItem.where(customer_id: current_customer.id)
        @cart_items.each do |cart_item|
          @ordered_items = OrderItem.create(
            item_id: cart_item.item.id,
            order_id: @order.id,
            price: cart_item.item.price,
            amount: cart_item.amount
            )
        end
      @cart_items.destroy_all
      case params[:order][:address_option].to_i
      when 1
      when 2
      when 3
        @address = Address.create(
          customer_id: current_customer.id,
          name: params[:order][:name],
          postal_code: params[:order][:postal_code],
          address: params[:order][:address]
          )
      end
      redirect_to orders_complete_path
    else
      render :confirm
    end
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @tax = 1.1
    @shipping_cost = 800

    if params[:order][:payment_method].nil?
      params[:order][:payment_method] =
        case params[:order][:address_option].to_i
        when 1
          address_when1
        when 2
          address_when2
        when 3
          address_when3
        when 0
          address_when0
        end
      @order.valid?
      render :new
    else
      case params[:order][:address_option].to_i
      when 1
        address_when1
        @order.payment_method = params[:order][:payment_method].to_i
      when 2
        address_when2
        @order.payment_method = params[:order][:payment_method].to_i
      when 3
        address_when3
        @order.payment_method = params[:order][:payment_option].to_i
      when 0
        address_when0
      end

      if @order.valid?
      else
        render :new
      end
    end
  end

  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: "DESC").page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @tax = 1.1

  end


  private
  def order_params
    params.require(:order).permit( :customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method )
  end

  def address_when1
    @order = Order.new(
    customer_id: current_customer.id,
    name: current_customer.last_name + current_customer.first_name,
    postal_code: current_customer.postal_code,
    address: current_customer.address,
    total_payment: @cart_items.map{ |cp| (cp.item.price*cp.amount * @tax) }.sum.round + @shipping_cost
    )
  end

  def address_when2
    @address = Address.find(params[:order][:address_id])
    @order = Order.new(
      customer_id: current_customer.id,
      name: @address.name,
      postal_code: @address.postal_code,
      address: @address.address,
      total_payment: @cart_items.map{ |cp| (cp.item.price*cp.amount * @tax) }.sum.round + @shipping_cost
    )
  end

  def address_when3
    @order = Order.new(
      customer_id: current_customer.id,
      name: params[:order][:name],
      postal_code: params[:order][:postal_code],
      address: params[:order][:address],
      address_option: params[:order][:address_option].to_i,
      total_payment: @cart_items.map{ |cp| (cp.item.price*cp.amount * @tax) }.sum.round + @shipping_cost
      )
  end

  def address_when0
    @order = Order.new(
      customer_id: current_customer.id,
      total_payment: @cart_items.map{ |cp| (cp.item.price*cp.amount * @tax) }.sum.round + @shipping_cost
      )
  end

  # def cart_item_any?
  #   if current_cart_items.empty?
  #     redirect_to customers_path
  #   end
  # end


end
