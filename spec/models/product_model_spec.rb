require 'rails_helper'

RSpec.describe ProductModel, type: :model do
    describe '#valid?' do
        context 'presence' do
            it 'name is mandatory' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

                result = pm.valid?

                expect(result).to eq false
            end

            it 'sku is mandatory' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'', supplier: supplier)

                result = pm.valid?

                expect(result).to eq false
            end

            it 'weight is mandatory' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm = ProductModel.new(name: 'TV 32', weight: '', width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

                result = pm.valid?

                expect(result).to eq false
            end

            it 'width is mandatory' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm = ProductModel.new(name: 'TV 32', weight: 8000, width: '', height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

                result = pm.valid?

                expect(result).to eq false
            end

            it 'height is mandatory' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: '', depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

                result = pm.valid?

                expect(result).to eq false
            end

            it 'depth is mandatory' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: '', sku:'TV32-MAO-XPTO90', supplier: supplier)

                result = pm.valid?

                expect(result).to eq false
            end
        end

        context 'uniqueness' do
            it 'sku is unique' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm_1 = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)
                pm_2 = ProductModel.new(name: 'TV 44', weight: 12000, width: 90, height: 55, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

                result = pm_2.valid?

                expect(result).to eq false
            end
        end

        context 'greater_than' do
            it 'weight is greater than 0' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm = ProductModel.new(name: 'TV 32', weight: 0, width: 70, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

                result = pm.valid?

                expect(result).to eq false
            end

            it 'width is greater than 0' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm = ProductModel.new(name: 'TV 32', weight: 45, width: 0, height: 45, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

                result = pm.valid?

                expect(result).to eq false
            end

            it 'height is greater than 0' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm = ProductModel.new(name: 'TV 32', weight: 45, width: 70, height: 0, depth: 10, sku:'TV32-MAO-XPTO90', supplier: supplier)

                result = pm.valid?

                expect(result).to eq false
            end

            it 'depth is greater than 0' do
                supplier = Supplier.create!(corporate_name: "Manaós Industria", brand_name: "Manaós Soluções Industriais",                        
                registration_number: "8009461400011", full_adress: "Vieralves, 255", city: "Manaus", state: "AM",                                                      
                email: "manaos.solucoes.ind@gmail.com")

                pm = ProductModel.new(name: 'TV 32', weight: 45, width: 70, height: 45, depth: 0, sku:'TV32-MAO-XPTO90', supplier: supplier)

                result = pm.valid?

                expect(result).to eq false
            end
        end
    end
end
