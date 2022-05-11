require 'rails_helper'

describe 'Usuário visita a tela de fornecedores ' do

    it 'e vê fornecedores cadastrados' do
        #Arrange
        supplier = Supplier.create!(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "80094614000119",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        visit(root_path)
        click_on('Fornecedores')


        #Assert
        expect(page).to have_content('Manaós Soluções Industriais')
        expect(page).to have_content('Manaus/AM')
    end

    it 'e vê que não existem fornecedores cadastrados' do
        #Arrange
        #Act
        visit(root_path)
        click_on('Fornecedores')

        #Assert
        expect(page).to have_content('Não há fornecedores cadastrados!')
    end

end 