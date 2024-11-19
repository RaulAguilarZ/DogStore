class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  #validates :category, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :available_quantity, numericality: { greater_than_or_equal_to: 0 }

  #scope :on_sale, -> { where(on_sale: true) }
  #scope :new_products, -> { where('created_at >= ?', 1.month.ago) }
  #scope :recently_updated, -> { where('updated_at >= ?', 1.week.ago) }

 # Ransack: Atributos permitidos para búsqueda
 def self.ransackable_attributes(auth_object = nil)
  ["id", "name", "description", "price", "available_quantity", "created_at", "updated_at"]
end

# Ransack: Asociaciones permitidas para búsqueda
def self.ransackable_associations(auth_object = nil)
  ["category"]
end



end
