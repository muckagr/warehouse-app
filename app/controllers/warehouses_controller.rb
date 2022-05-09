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

    def edit
        @warehouse = Warehouse.find(params[:id])
    end

    def update
        @warehouse = Warehouse.find(params[:id])
        @warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :adress, :description, :area, :cep)

        if @warehouse.update(@warehouse_params)
            return redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso!'
        end

        flash.now[:notice] =  'Falha ao atualizar! Preencha todos os campos.'
        render 'edit'
    end
end