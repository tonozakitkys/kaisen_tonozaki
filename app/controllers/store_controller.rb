class StoreController < ApplicationController
  before_filter :set_cart

  def index
    @products = Product.for_sale.paginate :page => params[:page], :per_page => 5
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @cart.add_product(@product)
    respond_to do |format|
      format.js
    end
  end

  def remove_item_from_cart
    product = Product.find(params[:id])
    @cart.remove_product(product)
    respond_to do |format|
      format.js
    end
  end

  def empty_cart
    @cart.empty!
    respond_to do |format|
      format.js
    end
  end

  def suppliers
    @suppliers = Shop.all
  end

  def checkout
    if @cart.nil? || @cart.items.empty?
      redirect_to store_path, :notice => "カートは現在空です"
    end

    @order = Order.new
  end

  def save_order
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    if @order.save
      @cart.empty!
      redirect_to store_path, :notice => "ご注文ありがとうございます！ｍ（＿＿）ｍ"
    else
      render checkout_path
    end
  end

  private
  def set_cart
    @cart = session[:cart] ||= Cart.new
  end
end
