require 'rails_helper'

RSpec.describe Warehouse, type: :model do
    describe '#valid?' do
        context 'presence' do
            it 'false when name is empty' do
                #Arrange
                warehouse = Warehouse.new(name: '', code: 'RIO', adress: 'Endereço', 
                cep: '25000-000', city: 'Rio de Janeiro', area: '1000', description: 'alguma description')

                #Act
                result = warehouse.valid?

                #Assert
                expect(result).to eq false
            end

            it 'false when code is empty' do
                #Arrange
                warehouse = Warehouse.new(name: 'Rio', code: '', adress: 'Endereço', 
                cep: '25000-000', city: 'Rio de Janeiro', area: '1000', description: 'alguma description')

                #Act
                result = warehouse.valid?

                #Assert
                expect(result).to eq false
            end

            it 'false when adress is empty' do
                #Arrange
                warehouse = Warehouse.new(name: 'Rio', code: 'RIO', adress: '', 
                cep: '25000-000', city: 'Rio de Janeiro', area: '1000', description: 'alguma description')

                #Act
                result = warehouse.valid?

                #Assert
                expect(result).to eq false
            end

            it 'false when cep is empty' do
                #Arrange
                warehouse = Warehouse.new(name: 'Rio', code: 'RIO', adress: 'Endereço', 
                cep: '', city: 'Rio de Janeiro', area: '1000', description: 'alguma description')

                #Act
                result = warehouse.valid?

                #Assert
                expect(result).to eq false
            end

            it 'false when city is empty' do
                #Arrange
                warehouse = Warehouse.new(name: 'Rio', code: 'RIO', adress: 'Endereço', 
                cep: '25000-000', city: '', area: '1000', description: 'alguma description')

                #Act
                result = warehouse.valid?

                #Assert
                expect(result).to eq false
            end

            it 'false when area is empty' do
                #Arrange
                warehouse = Warehouse.new(name: 'Rio', code: 'RIO', adress: 'Endereço', 
                cep: '25000-000', city: 'Rio de Janeiro', area: '', description: 'alguma description')

                #Act
                result = warehouse.valid?

                #Assert
                expect(result).to eq false
            end

            it 'false when description is empty' do
                #Arrange
                warehouse = Warehouse.new(name: 'Rio', code: 'RIO', adress: 'Endereço', 
                cep: '25000-000', city: 'Rio de Janeiro', area: '1000', description: '')

                #Act
                result = warehouse.valid?

                #Assert
                expect(result).to eq false
            end
        end
        
        context 'uniqueness' do
            it 'false when code is already in use' do
                #Arrange
                first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', adress: 'Endereço', 
                                                cep: '25000-000', city: 'Rio de Janeiro', area: '1000', description: 'alguma description')

                second_warehouse = Warehouse.new(name: 'Brasilia', code: 'RIO', adress: 'Endereço 2', 
                                                cep: '70000-000', city: 'Brasilia', area: '10000', description: 'alguma outra description')

                #Act
                result = second_warehouse.valid?

                #Assert
                expect(result).to eq false
            end
        end
    end

    describe '#full_description' do
        it 'exibe o nome e o código' do
            w = Warehouse.new(name: 'Galpão Cuiabá', code: 'CBA')

            result = w.full_description

            expect(result).to eq('CBA | Galpão Cuiabá')
        end
    end
end
