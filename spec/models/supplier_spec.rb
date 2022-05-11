require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when corporate_name is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: "",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when brand_name is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: "Manaós Industria",                               
        brand_name: "",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when full_adress is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when registration_number is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when city is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when state is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "",                                                      
        email: "manaos.solucoes.ind@gmail.com")
        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when email is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "")

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end
    end
  
    context 'uniqueness' do
      it 'false when corporate_name is already in use' do
        #Arrange
        first_supplier = Supplier.create!(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        second_supplier = Supplier.new(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Mecânicas",                        
        registration_number: "8009461420011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaus.mec@gmail.com")

        #Act
        result = second_supplier.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when email is already in use' do
        #Arrange
        first_supplier = Supplier.create!(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        second_supplier = Supplier.new(corporate_name: "Manaós Mecânica",                               
        brand_name: "Manaós Soluções Mecânicas",                        
        registration_number: "8009461420011",                            
        full_adress: "Vieralves, 266",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        result = second_supplier.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when brand_name is already in use' do
        #Arrange
        first_supplier = Supplier.create!(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        second_supplier = Supplier.new(corporate_name: "Manaós Mecânica",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461420011",                            
        full_adress: "Vieralves, 266",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.mec@gmail.com")

        #Act
        result = second_supplier.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when registration_number is already in use' do
        #Arrange
        first_supplier = Supplier.create!(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        second_supplier = Supplier.new(corporate_name: "Manaós Mecânica",                               
        brand_name: "Manaós Soluções Mecânicas",                        
        registration_number: "8009461400011",                            
        full_adress: "Vieralves, 266",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.mec@gmail.com")

        #Act
        result = second_supplier.valid?

        #Assert
        expect(result).to eq false
      end
    end
    
    context 'length' do
      it 'false when registration_number length is less than 13' do
        #Arrange
        supplier = Supplier.new(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "800946140011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when registration_number length is more than 13' do
        #Arrange
        supplier = Supplier.new(corporate_name: "Manaós Industria",                               
        brand_name: "Manaós Soluções Industriais",                        
        registration_number: "80094614014011",                            
        full_adress: "Vieralves, 255",                                    
        city: "Manaus",                                                   
        state: "AM",                                                      
        email: "manaos.solucoes.ind@gmail.com")

        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end
    end
  end
end
