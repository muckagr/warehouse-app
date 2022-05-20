class OrdersController < ApplicationController
    before_action :authenticate_user!
    def new
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
        @order = Order.new()
    end

    def create
        order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
        @order = Order.new(order_params)
        @order.user = current_user
        if @order.save!
            return redirect_to @order, notice: 'Pedido cadastrado com SUCESSO!'
        else
            flash.now[:notice] = 'Falha ao cadastrar Pedido'
            render 'new'
        end
    end

    def show
        @order = Order.find(params[:id])
    end
end