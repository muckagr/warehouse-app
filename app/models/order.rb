class Order < ApplicationRecord
  before_validation :code_generator
  validate :estimated_delivery_date_is_future
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  validates :code, :estimated_delivery_date, presence: true

  private
  def code_generator
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def estimated_delivery_date_is_future
    if self.estimated_delivery_date.present? && self.estimated_delivery_date <= Date.today
      self.errors.add(:estimated_delivery_date, 'Data deve ser futura.')
    end
  end
    
end
