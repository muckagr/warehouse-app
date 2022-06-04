require 'rails_helper'

RSpec.describe Order, type: :model do
    describe '#valid?' do

        it 'data estimada de entrega deve ser obrigatória' do
                order = Order.new(estimated_delivery_date: '')
                
                order.valid?
                result = order.errors.include?(:estimated_delivery_date)

                expect(order.errors.include? :estimated_delivery_date).to be true
                expect(order.errors[:estimated_delivery_date]).to include 'não pode ficar em branco' 
        end

        it 'data estimada de entrega não deve ser anterior à data atual' do
                order = Order.new(estimated_delivery_date: 1.day.ago)
                
                order.valid?
                result = order.errors.include?(:estimated_delivery_date)

                expect(result).to be true
                expect(order.errors[:estimated_delivery_date]).to include 'Data deve ser futura.' 
        end

        it 'data estimada de entrega não deve ser igual a hoje' do
                order = Order.new(estimated_delivery_date: Date.today)
                
                order.valid?
                result = order.errors.include?(:estimated_delivery_date)

                expect(result).to be true
                expect(order.errors[:estimated_delivery_date]).to include 'Data deve ser futura.' 
        end

        it 'data estimada de entrega deve ser igual ou maior do que amanhâ' do
                order = Order.new(estimated_delivery_date: 1.day.from_now)
                
                order.valid?
                result = order.errors.include?(:estimated_delivery_date)

                expect(result).to be false 
        end

        it 'deve ter um codigo aleatório' do
            user = User.create!(email: 'arthur@gmail.com', password: 'password', name: 'Arthur Rocha')
            warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '')

            result = order.valid?

            expect(result).to be false
        end

        it 'ao criar um pedido' do 
            user = User.create!(email: 'arthur@gmail.com', password: 'password', name: 'Arthur Rocha')
            warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011",full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')

            order.save!
            result = order.code

            expect(result).not_to be_empty
            expect(result.length).to eq 8
        end

        it 'e o codigo é unico' do 
            user = User.create!(email: 'arthur@gmail.com', password: 'password', name: 'Arthur Rocha')
            warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011",full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
            order_1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
            order_2 = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-01')

            order_2.save!

            expect(order_2.code).not_to eq order_1.code
        end
    end
end
