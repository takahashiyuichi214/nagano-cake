class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end

  def list
    @orders = Order.where(customer_id: params[:id]).order(created_at: "DESC").page(params[:page]).per(10)
  end


  private

  def customer_params
    params.require(:customer).permit(:customer_id, :first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number, :is_active)
  end
end
