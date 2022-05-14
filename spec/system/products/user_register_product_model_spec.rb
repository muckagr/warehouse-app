require 'rails_helper'

describe 'usuário cadastra um modelo de produto' do
    it 'com sucesso' do
        #Arrange
        supplier = Supplier.create!(corporate_name: 'LG LTDA', brand_name: 'LG',                        
        registration_number: "8009461400011",full_adress: "Vieralves, 255",                                    
        city: "Manaus", state: "AM", email: "lg.atendimento@gmail.com")

        #Act
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Cadastrar produtos')
        fill_in('Nome', with: 'TV 32')
        fill_in('Peso', with: '8000')
        fill_in('Largura', with: '70')
        fill_in('Altura', with:'45')
        fill_in('Profundidade', with:'7')
        fill_in('SKU', with:'TV32-SAMSU-XPTO90')
        select 'LG', from: 'Fornecedor'
        click_on('Enviar')

        #Assert
        expect(page).to have_content('Modelo de produto cadastrado com SUCESSO!')
        expect(page).to have_content('TV 32')
        expect(page).to have_content('SKU: TV32-SAMSU-XPTO9')
        expect(page).to have_content('Dimensão: 70cm x 45cm x 7cm')
        expect(page).to have_content('Peso: 8000g')
        expect(page).to have_content('Fornecedor: LG')
    end
end