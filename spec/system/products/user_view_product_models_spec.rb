require 'rails_helper'

describe 'Usuário vê modelos de produtos' do

    it 'se estiver autenticado' do

        visit(root_path)
        within('nav') do
            click_on('Modelos de Produtos')
        end

        expect(current_path).to eq new_user_session_path
    end

    it 'a partir do menu' do
        #Arrange
        user = User.create!(email: "arthurafk@gmail.com", password: "password", name: "Arthur")

        #Act
        login_as(user)
        visit(root_path)
        click_on('Modelos de Produtos')

        #Assert
        expect(current_path).to eq product_models_path
    end

    it 'e vê produtos cadastrados com sucesso' do
        #Arrange
        user = User.create!(email: "arthurafk@gmail.com", password: "password", name: "Arthur")

        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-SAMSU-XPTO90', supplier: supplier)
        ProductModel.create!(name: 'Soundbar 7.1', weight: 3000, width: 80, height: 15, depth: 20, sku:'SOU71-SAMSU-NOIZ77', supplier: supplier)

        #Act
        login_as(user)
        visit(root_path)
        click_on('Modelos de Produtos')

        #Assert
        expect(page).to have_content('TV 32')
        expect(page).to have_content('TV32-SAMSU-XPTO90')
        expect(page).to have_content('Manaós Soluções Industriais')
        expect(page).to have_content('Soundbar 7.1')
        expect(page).to have_content('SOU71-SAMSU-NOIZ77')
        expect(page).to have_content('Manaós Soluções Industriais')
    end

    it 'e vê a mensagem de que não há produtos cadastrados' do
        #Arrange
        user = User.create!(email: "arthurafk@gmail.com", password: "password", name: "Arthur")
        
        #Act
        login_as(user)
        visit(root_path)
        click_on('Modelos de Produtos')

        #Assert
        expect(page).to have_content('Não há produtos cadastrados!')
    end
end