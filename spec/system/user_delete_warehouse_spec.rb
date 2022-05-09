require 'rails_helper'

describe 'usuário remove um galpão' do
    it 'com sucesso' do
        #Arrange
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: "GRU", city: "Guarulhos", 
        area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
        description: 'Galpão destinado para cargas internacionais')

        #Act
        visit(root_path)
        click_on('Aeroporto SP')
        click_on('Remover')
        
        #Assert
        expect(current_path).to eq root_path
        expect(page).not_to have_content('Aeroporto SP')
        expect(page).not_to have_content('GRU')
        expect(page).to have_content('Galpão removido com SUCESSO!')
    end
end