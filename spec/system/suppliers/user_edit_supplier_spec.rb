require 'rails_helper'

describe 'usuario edita um Fornecedor' do

    it 'Usuario edita Fornecedor' do
        #Arrange
        supplier = Supplier.create!(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Manaós Soluções Industriais')
        click_on('Editar Fornecedor')

        #Assert
        expect(page).to have_content('Editar Fornecedor')
        expect(page).to have_field('Cidade', with: 'Manaus')
        expect(page).to have_field('Estado', with: 'AM')
        expect(page).to have_field('Endereço', with: 'Vieralves, 255')
        expect(page).to have_field('CNPJ', with: '8009461400011')
        expect(page).to have_field('Razão Social', with: 'Manaós Industria')
        expect(page).to have_field('E-mail', with: 'manaos.solucoes.ind@gmail.com')
        expect(page).to have_field('Nome Fantasia', with: 'Manaós Soluções Industriais')
    end

    it 'com sucesso' do
        #Arrange
        supplier = Supplier.create!(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Manaós Soluções Industriais')
        click_on('Editar Fornecedor')
        fill_in 'Razão Social', with: 'Manaus Industria'
        fill_in 'Nome Fantasia', with: 'Manaus Soluções Industriais'
        fill_in 'E-mail', with: 'manaus.solucoes.ind@gmail.com'
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Manaus Industria')
        expect(page).to have_content('Manaus Soluções Industriais')
        expect(page).to have_content('manaus.solucoes.ind@gmail.com')
        expect(page).to have_content('Fornecedor atualizado com sucesso!')
    end

    it 'e mantem os campos obrigatórios' do
        #Arrange
        supplier = Supplier.create!(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Manaós Soluções Industriais')
        click_on('Editar Fornecedor')
        fill_in 'Razão Social', with: ''
        fill_in 'Nome Fantasia', with: ''
        fill_in 'E-mail', with: ''
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Falha ao atualizar! Preencha todos os campos.')
    end
end