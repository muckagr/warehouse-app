require 'rails_helper'

RSpec.describe Order, type: :model do
    describe 'gera um codigo aleatório' do
        it 'deve ter um codigo' do
            user = User.create!(email: 'arthur@gmail.com', password: 'password', name: 'Arthur Rocha')
            warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011",full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')

            result = order.valid?

            expect(result).to be true
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
