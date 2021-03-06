require 'rails_helper'

describe 'usuário vê seus próprios pedidos' do
    it 'e deve estar autenticado' do

        visit(root_path)
        click_on('Meus Pedidos')

        expect(current_path).to eq new_user_session_path
    end

    it 'e não vê outros pedidos' do
        user_1 = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        user_2 = User.create!(name: "Maysa", email: "maysa@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        order_1 = Order.create!(user: user_1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'pending')
        order_2 = Order.create!(user: user_2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now, status: 'delivered')
        order_3 = Order.create!(user: user_2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now, status: 'canceled')

        login_as(user_1)
        visit(root_path)
        click_on('Meus Pedidos')

        expect(page).to have_content(order_1.code)
        expect(page).to have_content('Pendente')
        expect(page).not_to have_content('Entregue')
        expect(page).not_to have_content('Cancelado')
        expect(page).not_to have_content(order_2.code)
        expect(page).not_to have_content(order_3.code)
    end

    it 'e visita um pedido' do
        user = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

        login_as(user)
        visit(root_path)
        click_on('Meus Pedidos')
        click_on(order.code)

        expect(page).to have_content('Detalhes do Pedido')
        expect(page).to have_content(order.code)
        expect(page).to have_content(warehouse.full_description)
        expect(page).to have_content("Fornecedor: #{supplier.corporate_name}")
        formated_date = I18n.localize(1.day.from_now.to_date)
        expect(page).to have_content("Data Prevista de Entrega: #{formated_date}")
        expect(page).to have_content('Pendente')
    end

    it 'e não visita pedidos de outros usuários' do
        user_1 = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        user_2 = User.create!(name: "Maysa", email: "maysa@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        order_1 = Order.create!(user: user_1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        order_2 = Order.create!(user: user_1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)
        order_3 = Order.create!(user: user_2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)

        login_as(user_1)
        visit(order_path(order_3.id))
        
        expect(current_path).not_to eq order_path(order_3.id)
        expect(current_path).to eq root_path
        expect(page).to have_content('Você não possui acesso a esse pedido.')
    end

    it 'e vê itens do pedido' do
        user = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        product_1 = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)
        product_2 = ProductModel.create!(name: 'Soundbar 7.1', weight: 3000, width: 80, height: 15, depth: 20, sku:'SOU71-SAMSU-NOIZ77', supplier: supplier)
        product_3 = ProductModel.create!(name: 'Webcam 1080p Logitech', weight: 200, width: 10, height: 7, depth: 5, sku:'WEBLOG3072', supplier: supplier)
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        OrderItem.create!(product_model: product_1, order: order, quantity: 19)
        OrderItem.create!(product_model: product_2, order: order, quantity: 12)

        login_as(user)
        visit(root_path)
        click_on('Meus Pedidos')
        click_on(order.code)

        expect(page).to have_content('Itens do Pedido')
        expect(page).to have_content('19 x TV 32')
        expect(page).to have_content('12 x Soundbar 7.1')
    end
end