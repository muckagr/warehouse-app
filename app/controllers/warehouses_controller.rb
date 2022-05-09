class WarehousesController < ApplicationController
    before_action :set_warehouse, only: [:show, :edit, :update, :destroy]
    def show; end

    def new
        @warehouse = Warehouse.new()
    end

    def create
        @warehouse = Warehouse.new(warehouse_params)

        if @warehouse.save
            return redirect_to root_path, notice: 'Galpão cadastrado com SUCESSO!'
        end

        flash.now[:notice] =  'Falha ao cadastrar! Preencha todos os campos.'
        render 'new'
    end

    def edit; end

    def update
        if @warehouse.update(warehouse_params)
            return redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso!'
        end
        flash.now[:notice] =  'Falha ao atualizar! Preencha todos os campos.'
        render 'edit'
    end

    def destroy
        @warehouse.destroy
        redirect_to root_path, notice: 'Galpão removido com SUCESSO!'
    end 

    private #só pode ser usado pelos métodos dentro do controller
    def set_warehouse
        @warehouse = Warehouse.find(params[:id])
    end

    def warehouse_params
        params.require(:warehouse).permit(:name, :code, :city, :adress, :description, :area, :cep)
    end


end