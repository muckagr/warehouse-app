require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        User.create!(email: 'arthurafk@gmail.com', password: 'password')

        visit(root_path)
        click_on('Fazer login')
        fill_in('E-mail', with: 'arthurafk@gmail.com')
        fill_in('Senha', with: 'password')
        click_on('Logar')
        
        expect(page).to have_content('Login efetuado com sucesso.')
        within('nav') do
            expect(page).to have_button 'Deslogar'
            expect(page).to have_content 'arthurafk@gmail.com'
            expect(page).not_to have_link 'Fazer login'
        end
    end

    it 'e fez logout' do
        User.create!(email: 'arthurafk@gmail.com', password: 'password')

        visit(root_path)
        click_on('Fazer login')
        fill_in('E-mail', with: 'arthurafk@gmail.com')
        fill_in('Senha', with: 'password')
        click_on('Logar')
        click_on('Deslogar')

        expect(page).to have_content('Logout efetuado com sucesso.')
        within('nav') do
            expect(page).to have_link 'Fazer login'
            expect(page).not_to have_content 'arthurafk@gmail.com'
            expect(page).not_to have_link 'Deslogar'
        end

    end
end