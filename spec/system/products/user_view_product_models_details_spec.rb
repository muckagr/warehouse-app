require 'rails_helper'

describe 'Usuário vê detalhes de um modelo de produto' do
    it 'e vê informações adicionais' do
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")
        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('TV 32')

        expect(page).to have_content('Manaós Soluções Industriais')
        expect(page).to have_content('TV32-MAO-XPTO90')
        expect(page).to have_content('70cm x 45cm x 10cm')
        expect(page).to have_content('8000g')
    end

    it 'e volta para a tela de modelos de produtos' do
        #Arrange
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")
        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)
        
        #Act
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('TV 32')
        click_on('Voltar')

        #Assert
        expect(current_path).to eq product_models_path
    end
end