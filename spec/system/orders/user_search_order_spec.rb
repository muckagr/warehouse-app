require 'rails_helper'

describe 'usuário busca por um pedido' do

    it 'e deve estar autenticado' do 
        
        visit root_path

        within('header nav') do
            expect(page).not_to have_field('Buscar Pedido')
            expect(page).not_to have_button('Buscar')
        end
    end

    it 'a partir do menu' do
        user = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        
        login_as(user)
        visit root_path
        
        within('header nav') do
            expect(page).to have_field('Buscar Pedido')
            expect(page).to have_button('Buscar')
        end
    end

    it 'e encontra um pedido' do
        user = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        
        login_as(user)
        visit root_path
        within('header nav') do
            fill_in('Buscar Pedido', with: order.code)
            click_on('Buscar')
        end

        expect(page).to have_content("Resultados da Busca por: #{order.code}")
        expect(page).to have_content('1 Pedido encontrado')
        expect(page).to have_content("Código: #{order.code}")
        expect(page).to have_content("Galpão de Destino: #{warehouse.full_description}")
        expect(page).to have_content("Fornecedor: #{supplier.brand_name}")
    end

    it 'e encontra múltiplos pedidos' do
        user_1 = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        user_2 = User.create!(name: "Maysa", email: "maysa@email.com", password: "password")
        warehouse_1 = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        warehouse_2 = Warehouse.create!(name: 'Galpão Aeroporto BSB', code: "BSB", city: "Brasília", 
                    area: 60_000, adress: 'Quadra do Aeroporto, 55', cep: '70000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
        order_1 = Order.create!(user: user_1, warehouse: warehouse_1, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU98755')
        order_2 = Order.create!(user: user_2, warehouse: warehouse_1, supplier: supplier, estimated_delivery_date: 2.day.from_now)
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('BSB12345')
        order_2 = Order.create!(user: user_2, warehouse: warehouse_2, supplier: supplier, estimated_delivery_date: 2.day.from_now)
        
        login_as(user_1)
        visit root_path
        within('header nav') do
            fill_in('Buscar Pedido', with: 'GRU')
            click_on('Buscar')
        end

        expect(page).to have_content('GRU12345')
        expect(page).to have_content('GRU98755')
        expect(page).to have_content('Galpão de Destino: GRU | Galpão Aeroporto SP')
        expect(page).not_to have_content('BSB12345')
        expect(page).not_to have_content('Galpão de Destino: BSB | Galpão Aeroporto BSB')
    end
end