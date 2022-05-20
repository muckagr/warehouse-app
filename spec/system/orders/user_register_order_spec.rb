require 'rails_helper'

describe 'User register an order' do

    it 'and must be authenticated' do
        
        visit(root_path)
        click_on('Registrar Pedido')

        expect(current_path).to eq new_user_session_path

    end

    it 'sucessfully' do
        user = User.create!(email: 'arthur@gmail.com', password: 'password', name: 'Arthur')
        warehouse_2 = Warehouse.create!(name: 'Galpão Aeroporto BSB', code: "BSB", city: "Brasília", 
                area: 300_000, adress: 'Aeroporto, 101', cep: '70000-000', 
                description: 'Galpão de eletrônicos importandos')
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                description: 'Galpão destinado para cargas internacionais')
        supplier_2 = Supplier.create!(corporate_name: "HIHAPPY COM", brand_name: "HIHAPPY", 
                registration_number: "8009466400011",full_adress: "Shopping Pier21", city: "Brasília", state: "DF", 
                email: "hihappy.atendimento@gmail.com")
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                registration_number: "8009461400011",full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                email: "manaos.solucoes.ind@gmail.com")
        

        login_as(user)
        visit(root_path)
        click_on('Registrar Pedido')
        select warehouse.name, from: 'Galpão Destino'
        select supplier.corporate_name, from: 'Fornecedor'
        fill_in('Data Prevista de Entrega', with: '20/12/2022')
        click_on('Gravar')

        expect(page).to have_content('Pedido cadastrado com SUCESSO!')
        expect(page).to have_content('Galpão de Destino: Galpão Aeroporto SP')
        expect(page).to have_content('Fornecedor: Manaós Industria')
        expect(page).to have_content('Usuário Responsável: Arthur arthur@gmail.com')
        expect(page).to have_content('Data Prevista de Entrega: 20/12/2022')
        expect(page).not_to have_content('Galpão Aeroporto BSB')
        expect(page).not_to have_content('HIHAPPY COM')
    end

end