require 'rails_helper'

describe 'usuario edita um galpão' do

    it 'Usuario edita galpão' do
        #Arrange
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: "GRU", city: "Guarulhos", 
                area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                description: 'Galpão destinado para cargas internacionais')

        #Act
        visit(root_path)
        click_on('Aeroporto SP')
        click_on('Editar Galpão')

        #Assert
        expect(page).to have_content('Editar Galpão')
        expect(page).to have_field('Cidade', with: 'Guarulhos')
        expect(page).to have_field('Código', with: 'GRU')
        expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 1000')
        expect(page).to have_field('CEP', with: '15000-000')
        expect(page).to have_field('Nome', with: 'Aeroporto SP')
        expect(page).to have_field('Área', with: '100000')
        expect(page).to have_field('Descrição', with: 'Galpão destinado para cargas internacionais')
    end

    it 'com sucesso' do
        #Arrange
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: "GRU", city: "Guarulhos", 
        area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
        description: 'Galpão destinado para cargas internacionais')

        #Act
        visit(root_path)
        click_on('Aeroporto SP')
        click_on('Editar Galpão')
        fill_in 'Nome', with: 'Galpão  Internacional'
        fill_in 'Área', with: '200000'
        fill_in 'Endereço', with: 'Avenida dos Galpões, 500'
        fill_in 'CEP', with: '16000-000'
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Galpão Internacional')
        expect(page).to have_content('Endereço: Avenida dos Galpões, 500')
        expect(page).to have_content('Área: 200000 m2')
        expect(page).to have_content('CEP: 16000-000')
        expect(page).to have_content('Galpão atualizado com sucesso!')
    end

    it 'e mantem os campos obrigatórios' do
        #Arrange
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: "GRU", city: "Guarulhos", 
        area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
        description: 'Galpão destinado para cargas internacionais')

        #Act
        visit(root_path)
        click_on('Aeroporto SP')
        click_on('Editar Galpão')
        fill_in 'Nome', with: ''
        fill_in 'Área', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'CEP', with: ''
        click_on 'Enviar'

        #Assertexpect(page).to have_content('Galpão Internacional')
        expect(page).to have_content('Nome: Aeroporto SP')
        expect(page).to have_content('Área: 100000')
        expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000')
        expect(page).to have_content('CEP: 15000-000')
        expect(page).to have_content('Falha ao atualizar! Preencha todos os campos.')
    end
end