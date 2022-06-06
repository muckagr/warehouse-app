class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  has_many :order_items
  has_many :product_models, trough: :order_items
  
  before_validation :code_generator

  validate :estimated_delivery_date_is_future
  validates :code, :estimated_delivery_date, presence: true

  enum status: { pending: 0, delivered: 5, canceled: 10 }, _default: :pending

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
