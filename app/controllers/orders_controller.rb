class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_user, only: %i[show edit update]

    def index
        @orders = current_user.orders
    end

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
            return redirect_to @order, alert: 'Pedido cadastrado com SUCESSO!'
        else
            @warehouses = Warehouse.all
            @suppliers = Supplier.all
            flash.now[:notice] = 'Não foi possível registrar o pedido.'
            render 'new'
        end
    end
    
    def show; end

    def edit
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
    end

    def update
        order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
        @order.update(order_params)
        redirect_to @order, notice: 'Pedido atualizado com sucesso.'
    end
    
    def search
        @code = params[:query]
        @orders = Order.where("code LIKE ?", "%#{@code}%")
    end

    private
    def check_user
        @order = Order.find(params[:id])
        return redirect_to root_path, notice: "Você não possui acesso a esse pedido." if @order.user != current_user
    end
end