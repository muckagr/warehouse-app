require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
    it 'e pedido foi entregue' do
        user = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

        login_as(user)
        visit(root_path)
        click_on('Meus Pedidos')
        click_on(order.code)
        click_on('Marcar como ENTREGUE')

        expect(current_path).to eq order_path(order.id)
        expect(page).to have_content('Status do Pedido: Entregue')
        expect(page).not_to have_button('Marcar como CANCELADO')
        expect(page).not_to have_button('Marcar como ENTREGUE')
    end

    it 'e pedido foi cancelado' do
        user = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

        login_as(user)
        visit(root_path)
        click_on('Meus Pedidos')
        click_on(order.code)
        click_on('Marcar como CANCELADO')

        expect(current_path).to eq order_path(order.id)
        expect(page).to have_content('Status do Pedido: Cancelado')
    end
end