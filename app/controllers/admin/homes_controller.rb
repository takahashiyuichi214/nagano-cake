class Admin::HomesController < ApplicationController
  def top
    @orders = Order.where(created_at:  Time.zone.now.all_day)
  end
end
