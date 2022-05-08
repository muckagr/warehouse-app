require 'rails_helper'

describe 'Usuário visita tela inicial' do
    it 'e vê o nome da app' do
        #Arrange
        
        #Act
        visit(root_path)

        #Assert
        expect(page).to have_content('Galpões & Estoque')
    end
    
    it 'e vê os galpões cadastrados' do
        #Arrange
        Warehouse.create(name: 'Aeroporto SP', code: "GRU", city: "Guarulhos", 
                        area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                        description: 'Galpão destinado para cargas internacionais')
    
        #Act
        visit(root_path)

        #Assert
        expect(page).not_to have_content('Não há galpões cadastrados')

        expect(page).to have_content('Aeroporto SP')
        expect(page).to have_content('Cidade: Guarulhos')
        expect(page).to have_content('Código: GRU')
        expect(page).to have_content('100000 m2')
    end

    it 'e não existem galpões cadastrados' do
        #Arrange


        #Act
        visit(root_path)
        
        #Assert
        expect(page).to have_content('Não há galpões cadastrados')
    end
end