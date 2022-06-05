require 'rails_helper'

describe 'Usuário edita pedido' do
    it 'e deve estar autenticado' do
        user = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        
        visit(edit_order_path(order.id))

        expect(current_path).to eq new_user_session_path
    end

    it 'com sucesso' do
        user = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        Supplier.create!(corporate_name: "Spark Industries Brasil LTDA", brand_name: "Spark", 
        registration_number: "8009461400311", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
        email: "spark.ind@email.com")
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

        login_as(user)
        visit(root_path)
        click_on('Meus Pedidos')
        click_on(order.code)
        click_on('Editar')
        fill_in('Data Prevista de Entrega', with: '12/12/2022')
        select('Spark Industries Brasil LTDA', from: 'Fornecedor')
        click_on('Gravar')

        expect(page).to have_content('Pedido atualizado com sucesso.')
        expect(page).to have_content("Fornecedor: Spark Industries Brasil LTDA")
        expect(page).to have_content('Data Prevista de Entrega: 12/12/2022')
    end

    it 'caso seja o responsável' do
        user_1 = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        user_2 = User.create!(name: "Maysa", email: "maysa@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        order = Order.create!(user: user_2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        
        login_as(user_1)
        visit(edit_order_path(order.id))

        expect(current_path).to eq root_path
    end
end