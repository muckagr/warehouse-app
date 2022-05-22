require 'rails_helper'

RSpec.describe User, type: :model do
    describe '#description' do
        it 'e exibe o nome e o email' do
            u = User.new(name: 'Maysa Inacio', email: 'inaciomay@gmail.com')

            result = u.description()

            expect(result).to eq('Maysa Inacio - inaciomay@gmail.com')
        end
    end
end
