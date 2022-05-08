class WarehousesController < ApplicationController

    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new 
        @warehouse = Warehouse.new()
    end

    def create
        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :adress, :description, :area, :cep)
        @warehouse = Warehouse.new(warehouse_params)

        if @warehouse.save
            return redirect_to root_path, notice: 'Galpão cadastrado com SUCESSO!'
        end

        flash.now[:notice] =  'Falha ao cadastrar! Preencha todos os campos.'
        render 'new'
    end

end