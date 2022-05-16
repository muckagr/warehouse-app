require 'rails_helper'

describe 'usuário se autentica' do
    it 'com sucesso' do


        visit(root_path)
        click_on('Fazer login')
        click_on('Criar uma conta')
        fill_in('Nome', with: 'Maysa')
        fill_in('E-mail', with: 'arthurafk@gmail.com')
        fill_in('Senha', with: 'password')
        fill_in('Confirme sua senha', with: 'password')
        click_on('Criar conta')

        expect(page).to have_content('Boas vindas! Você criou sua conta com SUCESSO!')
        expect(page).to have_content('arthurafk@gmail.com')
        expect(page).to have_content('Deslogar')
        user = User.last
        expect(user.name).to eq 'Maysa'
    end
end