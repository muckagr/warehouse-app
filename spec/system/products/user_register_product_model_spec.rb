require 'rails_helper'

describe 'usuário visita a tela de modelo de produto' do

    it 'e vê informações de cadastro' do
        #Arrange
        user = User.create!(email: "arthurafk@gmail.com", password: "password", name: "Arthur")

        #Act
        login_as(user)
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Cadastrar produtos')

        #Assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Peso')
        expect(page).to have_field('Altura')
        expect(page).to have_field('Largura')
        expect(page).to have_field('Profundidade')
        expect(page).to have_field('Fornecedor')
        expect(page).to have_field('SKU')
    
    end

    it 'e cadastra um modelo de produto com sucesso' do
        #Arrange
        user = User.create!(email: "arthurafk@gmail.com", password: "password", name: "Arthur")
        supplier = Supplier.create!(corporate_name: 'LG LTDA', brand_name: 'LG',                        
        registration_number: "8009461400011",full_adress: "Vieralves, 255",                                    
        city: "Manaus", state: "AM", email: "lg.atendimento@gmail.com")

        #Act
        login_as(user)
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

    it 'e envia com dados incompletos' do
        user = User.create!(email: "arthurafk@gmail.com", password: "password", name: "Arthur")
        supplier = Supplier.create!(corporate_name: 'LG LTDA', brand_name: 'LG',                        
        registration_number: "8009461400011",full_adress: "Vieralves, 255",                                    
        city: "Manaus", state: "AM", email: "lg.atendimento@gmail.com")
        second_supplier = Supplier.create!(corporate_name: "Maçã do Amor", brand_name: "Apple",                        
        registration_number: "5009461403011", full_adress: "Rua do Açaí", city: "Manacapuru", state: "AM",                                                      
        email: "maca-do-amor@expensive.com")

        login_as(user)
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Cadastrar produtos')
        fill_in('Nome', with: '')
        fill_in('Peso', with: '')
        select 'LG', from: 'Fornecedor'
        click_on('Enviar')

        expect(page).to have_content('Falha ao cadastrar! Preencha todos os campos.')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Peso não pode ficar em branco')
        expect(page).to have_content('Largura não pode ficar em branco')
        expect(page).to have_content('Altura não pode ficar em branco')
        expect(page).to have_content('SKU não pode ficar em branco')
        expect(page).to have_content('Profundidade não pode ficar em branco')
    end

    it 'e envia dados inválidos' do
        user = User.create!(email: "arthurafk@gmail.com", password: "password", name: "Arthur")
        supplier = Supplier.create!(corporate_name: 'LG LTDA', brand_name: 'LG',                        
                registration_number: "8009461400011",full_adress: "Vieralves, 255",                                    
                city: "Manaus", state: "AM", email: "lg.atendimento@gmail.com")
        second_supplier = Supplier.create!(corporate_name: "Maçã do Amor", brand_name: "Apple",                        
            registration_number: "5009461403011", full_adress: "Rua do Açaí", city: "Manacapuru", state: "AM",                                                      
            email: "maca-do-amor@expensive.com")

        ProductModel.create!(name: 'Soundbar 7.1', weight: 3000, width: 80, height: 15,
                            depth: 20, sku:'SOU71-SAMSU-NOIZ77', supplier: supplier)

        login_as(user)
        visit(root_path)
        click_on('Modelos de Produtos')
        click_on('Cadastrar produtos')
        fill_in('Nome', with: 'TV 32')
        fill_in('Peso', with: '0')
        fill_in('Largura', with: '0')
        fill_in('Altura', with:'0')
        fill_in('Profundidade', with:'0')
        fill_in('SKU', with:'SOU71-SAMSU-NOIZ77')
        select 'LG', from: 'Fornecedor'
        click_on('Enviar')

        expect(page).to have_content('Falha ao cadastrar! Preencha todos os campos.')
        expect(page).to have_content('Peso deve ser maior que 0')
        expect(page).to have_content('Largura deve ser maior que 0')
        expect(page).to have_content('Altura deve ser maior que 0')
        expect(page).to have_content('Profundidade deve ser maior que 0')
        expect(page).to have_content('SKU já está em uso')
    end
end