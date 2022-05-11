require 'rails_helper'

describe 'Usuário visita a tela de cadastro' do

    it 'Usuario cadastra galpão' do
        #Arrange
        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Cadastrar Fornecedor')

        #Assert
        expect(page).to have_field('Razão Social')
        expect(page).to have_field('Nome Fantasia')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Estado')
        expect(page).to have_field('E-mail')
    
    end

    it 'com sucesso' do
        #Arrange
        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Cadastrar Fornecedor')
        fill_in 'Razão Social', with: 'Manaós Industria'
        fill_in 'Nome Fantasia', with: 'Manaós Soluções Industriais'
        fill_in 'CNPJ', with: '8009461400011'
        fill_in 'Endereço', with: 'Vieralves, 255'
        fill_in 'Cidade', with: 'Manaus'
        fill_in 'Estado', with: 'AM'
        fill_in 'E-mail', with: 'manaos.solucoes.ind@gmail.com'
        click_on 'Enviar'

        #Assert
        expect(current_path).to eq suppliers_path
        expect(page).to have_content('Fornecedor cadastrado com SUCESSO!')
        expect(page).to have_content('Manaós Soluções Industriais')
        expect(page).to have_content('Manaus/AM')
    end

    it 'com dados incompletos' do
        #Arrange
        #Act
        visit(root_path)
        click_on('Fornecedores')
        click_on('Cadastrar Fornecedor')
        fill_in 'Razão Social', with: ''
        fill_in 'Cidade', with: ''
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Falha ao cadastrar! Preencha todos os campos.')
        expect(page).to have_content('Endereço não pode ficar em branco')
        expect(page).to have_content('Razão Social não pode ficar em branco')
        expect(page).to have_content('Estado não pode ficar em branco')
        expect(page).to have_content('E-mail não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('Nome Fantasia não pode ficar em branco')
        expect(page).to have_content('Cidade não pode ficar em branco')
    end
end