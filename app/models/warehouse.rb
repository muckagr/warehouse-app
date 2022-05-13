class Warehouse < ApplicationRecord
    validates :name, :city, :code, :adress, :cep, :area, :description, presence: true
    validates :code, :name, uniqueness: true
    validates :cep, format: {with: /\A\d{5}-{1}\d{3}\z/, message: 'inválido'}
end
