require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
    
    it 'e vê informações adicionais' do
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

        #Assert
        expect(page).to have_content('Razão Social: Manaós Industria')
        expect(page).to have_content('Nome Fantasia: Manaós Soluções Industriais')
        expect(page).to have_content('CNPJ: 8009461400011')
        expect(page).to have_content('Endereço: Vieralves, 255')
        expect(page).to have_content('Cidade: Manaus')
        expect(page).to have_content('Estado: AM')
        expect(page).to have_content('E-mail: manaos.solucoes.ind@gmail.com')
    end

    it 'e volta para a tela de fornecedores' do
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
        click_on('Voltar')

        #Assert
        expect(current_path).to eq suppliers_path
    end
end
