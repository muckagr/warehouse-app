class Warehouse < ApplicationRecord
    validates :name, :city, :code, :adress, :cep, :area, :description, presence: true
    validates :code, uniqueness: true
end
