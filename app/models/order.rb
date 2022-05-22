class Order < ApplicationRecord
  before_validation :code_generator
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  validates :code, presence: true

  private
  def code_generator
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
