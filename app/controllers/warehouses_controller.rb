class WarehousesController < ApplicationController

    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new
        
    end

    def create
        warehouse_params = params.require(:warehouse).permit(:name, :codigo, :cidade, :endereco, :descricao, :area, :cep)
        w = Warehouse.new(warehouse_params)

        if w.save()
            return redirect_to root_path, notice: 'Galpão cadastrado com SUCESSO!'
        end
        render new_warehouse_path

    end

end