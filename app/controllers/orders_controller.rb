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
        if @order.save
            return redirect_to @order, notice: 'Pedido cadastrado com SUCESSO!'
        else
            @warehouses = Warehouse.all
            @suppliers = Supplier.all
            flash.now[:notice] = 'Não foi possível registrar o pedido.'
            render 'new'
        end
    end

    def search
        @code = params[:query]
        @orders = Order.where("code LIKE ?", "%#{@code}%")
    end

    def show
        @order = Order.find(params[:id])
    end
end