module Admin
  class ProductsController < ApplicationController
    layout "admin"
    before_action :check_authentication

    # GET /products
    # GET /products.xml
    def index
      @products = Product.all

      respond_to do |format|
        format.html # index.rhtml
        format.xml  { render :xml => @products.to_xml }
      end
    end

    # GET /products/1
    # GET /products/1.xml
    def show
      @product = Product.find(params[:id])

      respond_to do |format|
        format.html # show.rhtml
        format.xml  { render :xml => @product.to_xml }
      end
    end

    # GET /products/new
    def new
      @product = Product.new
    end

    # GET /products/1;edit
    def edit
      @product = Product.find(params[:id])
    end

    # POST /products
    # POST /products.xml
    def create
      @product = Product.new(product_params)

      respond_to do |format|
        if @product.save
          flash[:notice] = 'Product was successfully created.'
          format.html { redirect_to admin_product_url(@product) }
          format.xml  { head :created, :location => admin_product_url(@product) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @product.errors.to_xml }
        end
      end
    end

    # PUT /products/1
    # PUT /products/1.xml
    def update
      @product = Product.find(params[:id])

      respond_to do |format|
        if @product.update(product_params)
          flash[:notice] = 'Product was successfully updated.'
          format.html { redirect_to admin_product_url(@product) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @product.errors.to_xml }
        end
      end
    end

    # DELETE /products/1
    # DELETE /products/1.xml
    def destroy
      @product = Product.find(params[:id])
      @product.destroy

      respond_to do |format|
        format.html { redirect_to admin_products_url }
        format.xml  { head :ok }
      end
    end

    private

    def product_params
      params.require(:product).permit(:code, :name, :price, :image_path, :url, :download_url, :license_url, :license_url_scheme, :active)
    end

  end
end
