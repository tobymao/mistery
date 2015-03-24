class Payments::ProductsController < ApplicationController
  before_action :authenticate

  # GET /products
  # GET /products.json
  def index
  end

  # POST /products
  # POST /products.json
  def create
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
  end

  private
  def products_params
    params.require(:payments_product).permit(:email)
  end
end
