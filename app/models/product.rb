class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }




  scope :on_sale, -> { where(on_sale: true) }
  scope :new_products, -> { where('created_at >= ?', 1.month.ago) }
  scope :recently_updated, -> { where('updated_at >= ?', 1.week.ago) }




end
