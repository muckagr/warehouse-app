class SuppliersController < ApplicationController
    before_action :set_supplier, only: [:show, :edit, :update]

    def index
        @suppliers = Supplier.all
    end

    def show; end
    
    def new
        @supplier = Supplier.new()
    end

    def create
        @supplier = Supplier.new(supplier_params)

        if @supplier.save
            return redirect_to suppliers_path, notice: 'Fornecedor cadastrado com SUCESSO!'
        end

        flash.now[:notice] =  'Falha ao cadastrar! Preencha todos os campos.'
        render 'new'
    end

    def edit; end

    def update
        if @supplier.update(supplier_params)
            return redirect_to supplier_path(@supplier.id), notice: 'Fornecedor atualizado com sucesso!'
        end
        flash.now[:notice] =  'Falha ao atualizar! Preencha todos os campos.'
        render 'edit'
    end

    private
    def set_supplier
        @supplier = Supplier.find(params[:id])
    end

    def supplier_params
        params.require(:supplier).permit(:corporate_name, :brand_name, 
        :registration_number, :full_adress, 
        :city, :state, :email)
    end

end