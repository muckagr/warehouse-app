class Supplier < ApplicationRecord
    validates :corporate_name, :brand_name, :registration_number, :full_adress, :city, :state, :email, presence: true
    validates :corporate_name, :brand_name, :registration_number, :email, uniqueness: true
    validates :registration_number, length: { is: 13 }

    has_many :product_models 
    
    # validate :registration_number_can_or_cant_have_special_chars

    # def registration_number_can_or_cant_have_special_chars
    #     if !!!(registration_number =~ /\A[0-9]{2}[.][0-9]{3}[.][0-9]{3}[\/][0-9]{4}[-][0-9]{2}\z/) && !!!(registration_number =~ /\A[0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2}\z/)
    #         errors.add(:registration_number, "inválido")
    #     end
    #     if !!(registration_number =~ /\A[0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2}\z/) && !registration_number_includes_special(registration_number)
    #         errors.add(:registration_number, "inválido")
    #     end
    # end

    # def registration_number_includes_special(registration_number)
    #     special_chars_repetition = ['-', '.', '/'].map { |special| registration_number.count(special)}
    #     if [1,2,1] == special_chars_repetition || [0,0,0] == special_chars_repetition
    #         return true
    #     end
    #     return false
    # end
end
