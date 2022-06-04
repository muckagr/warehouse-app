# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(email: "admin@admin.com.br", password: "password", name: 'Administrador')

supplier_1 = Supplier.create!(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

supplier_2 = Supplier.create!(corporate_name: "BSB Industrias",                               
        brand_name: "Brasília Industrias",                        
        registration_number: "8009464400011",                            
        full_adress: "Conjunto Nacional, loja 10",                                    
        city: "Brasília",                                                   
        state: "DF",                                                      
        email: "bsb.ind@gmail.com")

warehouse_1 = Warehouse.create!(name: 'Aeroporto SP', code: "GRU", city: "Guarulhos", 
        area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
        description: 'Galpão destinado para cargas internacionais')

warehouse_2 = Warehouse.create!(name: 'Centro MAO', code: "MAC", city: "Manaus", 
        area: 50_000, adress: 'Vieralves, 50', cep: '69000-000', 
        description: 'Galpão de estoque de Açaí')

product_1 = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier_1)

product_2 = ProductModel.create!(name: 'Soundbar 7.1', weight: 3000, width: 80, height: 15, depth: 20, sku:'SOU71-SAMSU-NOIZ77', supplier: supplier_2)