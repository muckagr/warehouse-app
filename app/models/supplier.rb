class Supplier < ApplicationRecord
    validates :corporate_name, :brand_name, :registration_number, :full_adress, 
    :city, :state, :email, presence: true
    validates :corporate_name, :brand_name, :registration_number, :email, uniqueness: true
    validates :registration_number, length: { is: 13}
end
