class ProductModel < ApplicationRecord
  validates :name, :weight, :width, :height, :depth, :sku, :supplier_id, presence: true
  validates :width, :weight, :height, :depth, comparison: { greater_than: 0 }
  validates :sku, uniqueness: true
  belongs_to :supplier
end
