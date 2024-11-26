class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  validates :total_amount, numericality: { greater_than: 0 }

  def calculate_total(cart_items)
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.product.price * cart_item.quantity
    end
    total
  end
end