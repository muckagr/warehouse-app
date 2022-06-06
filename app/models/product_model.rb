class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :weight, :width, :height, :depth, :sku, :supplier_id, presence: true
  validates :width, :weight, :height, :depth, comparison: { greater_than: 0 }
  validates :sku, uniqueness: true
end
