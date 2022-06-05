require 'rails_helper'

describe 'Usuário edita um pedido e não é o dono' do
    it 'caso seja o responsável' do
        user_1 = User.create!(name: "Arthur", email: "arthur@email.com", password: "password")
        user_2 = User.create!(name: "Maysa", email: "maysa@email.com", password: "password")
        warehouse = Warehouse.create!(name: 'Galpão Aeroporto SP', code: "GRU", city: "Guarulhos", 
                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais", 
                    registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM", 
                    email: "manaos.solucoes.ind@gmail.com")
        order = Order.create!(user: user_2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        
        login_as(user_1)
        patch(order_path(order.id), params: { order: { supplier_id: 3}})

        expect(response).to redirect_to(root_path)
    end
end