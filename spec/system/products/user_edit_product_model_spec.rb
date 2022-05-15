require 'rails_helper'

describe 'usuario acessa a tela de edição de produto' do

    it 'e vê corretamente todos os campos editáveis e seus valores' do
        #Arrange
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "MSI",                        
        registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")
        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

        #Act
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('TV 32')
        click_on('Editar')

        #Assert
        expect(page).to have_content('Editar Modelo de Produto')
        expect(page).to have_field('Nome', with: 'TV 32')
        expect(page).to have_field('SKU', with: 'TV32-MAO-XPTO90')
        expect(page).to have_field('Altura', with: '45')
        expect(page).to have_field('Largura', with: '70')
        expect(page).to have_field('Profundidade', with: '10')
        expect(page).to have_field('Peso', with: '8000')
        expect(page).to have_select('Fornecedor', selected: 'MSI')
    end

    it 'e edita com sucesso' do
        #Arrange
        first_supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")
        second_supplier = Supplier.create!(corporate_name: "Maçã do Amor", brand_name: "Apple",                        
        registration_number: "5009461403011", full_adress: "Rua do Açaí", city: "Manacapuru", state: "AM",                                                      
        email: "maca-do-amor@expensive.com")
        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: first_supplier)

        #Act
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('TV 32')
        click_on('Editar')
        fill_in 'Nome', with: 'GTX 3070'
        fill_in 'Peso', with: '1300'
        fill_in 'Largura', with: '30'
        fill_in 'Altura', with: '8'
        fill_in 'Profundidade', with: '5'
        fill_in 'SKU', with: 'GTX-3070-NV'
        select 'Manaós Soluções Industriais', from: 'Fornecedor'
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Modelo de produto cadastrado com SUCESSO!')
        expect(page).to have_content('GTX 3070')
        expect(page).to have_content('SKU: GTX-3070-NV')
        expect(page).to have_content('Dimensão: 30cm x 8cm x 5cm')
        expect(page).to have_content('Peso: 1300g')
        expect(page).to have_content('Fornecedor: Manaós Soluções Industriais')
    end

    it 'e valida campos obrigatórios' do
        #Arrange
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")
        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

        #Act
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('TV 32')
        click_on('Editar')
        fill_in 'Peso', with: ''
        fill_in 'Largura', with: ''
        fill_in 'Altura', with: ''
        click_on 'Enviar'

        #Assertexpect(page).to have_content('Fornecedor Internacional')
        expect(page).to have_content('Falha ao atualizar! Preencha todos os campos.')
    end
end