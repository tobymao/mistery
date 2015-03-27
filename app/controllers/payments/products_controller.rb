class Payments::ProductsController < ApplicationController
  before_action :authenticate

  # GET /products
  # GET /products.json
  def index
  end

  # POST /products
  # POST /products.json
  def create
    product = Payments::Product.new(product_params)

    if product.purchasable.user != current_user
      return render_bad_credentials
    end

    respond_to do |format|
      if product.save
        format.html {redirect_to payments_products_path}
      else
        format.html {redirect_to :back, flash: {error: "Error saving product"}}
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    product = Payments::Product.find(params[:id])
    respond_to do |format|
      if product.update(product_update_params)
        format.html {redirect_to payments_products_path}
      else
        format.html {redirect_to :back, flash: {error: "Error updating your product. #{product.errors.full_messages}"}}
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
  end

  private
  def product_params
    params.require(:payments_product).permit(:price, :purchasable_id, :purchasable_type)
  end

  def product_update_params
    params.require(:payments_product).permit(:price)
  end
end
