class ProductModelsController < ApplicationController
    before_action :set_product_model, only: [:show, :edit, :update, :destroy]
    def index
        @product_models = ProductModel.all
    end

    def new
        @product_model = ProductModel.new()
    end

    def create
        @product_model = ProductModel.new(product_model_params)

        if @product_model.save
            return redirect_to product_model_path(@product_model.id), notice: 'Modelo de produto cadastrado com SUCESSO!'
        
            flash.now[:notice] = 'Falha ao cadastrar! Preencha todos os campos.'
            render 'new'
        end
    end

    private
    def set_product_model
        @product_model = ProductModel.find(params[:id])
    end

    def product_model_params
        params.require(:product_model).permit(:name, :weight, :width,
        :height, :depth, :sku, :supplier_id)
    end
end