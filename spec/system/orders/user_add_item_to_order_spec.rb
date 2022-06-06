require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
    it 'com sucesso' do
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

        login_as(user)
        visit(root_path)
        click_on('Meus Pedidos')
        click_on(order.code)
        click_on('Adicionar Item')
        select("#{product_1.name}", from: 'Produto')
        fill_in('Quantidade', with: "8")
        click_on('Gravar')

        expect(current_path).to eq order_path(order.id)
        expect(page).to have_content('Item adicionado com sucesso.')
        expect(page).to have_content('8 x TV 32')
    end

    it 'e não vê produtos de outro fornecedor' do
        user = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier_1 = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        supplier_2 = Supplier.create!(corporate_name: "BSB Industrial", brand_name: "BSB Industrial", 
                    registration_number: "8009461430011", full_adress: "SHCN, 101", city: "Brasilia", state: "DF", 
                    email: "bsb.ind@gmail.com")
        product_1 = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier_1)
        product_2 = ProductModel.create!(name: 'Soundbar 7.1', weight: 3000, width: 80, height: 15, depth: 20, sku:'SOU71-SAMSU-NOIZ77', supplier: supplier_2)
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_1, estimated_delivery_date: 1.day.from_now)

        login_as(user)
        visit(root_path)
        click_on('Meus Pedidos')
        click_on(order.code)
        click_on('Adicionar Item')

        expect(page).not_to have_content("#{product_2.name}")
        expect(page).to have_content("#{product_1.name}")
    end
end