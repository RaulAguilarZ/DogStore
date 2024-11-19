# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


require 'csv'

# ------------------------------------------Product--------------------------------------------
csv_file_path = 'db/products.csv'

if File.exist?(csv_file_path)
  CSV.foreach(csv_file_path, headers: true) do |row|
    category_name = row['category']
    category = Category.find_or_create_by(name: category_name)
    product = Product.find_by(name: row['name'])

    if product
      product.update(
        description: row['description'],
        price: row['price'],
        available_quantity: row['available_quantity'],
        category: category,
        id_category: row['id_category']
      )
      puts "Update: #{product.name}"
    else
      Product.create(
        name: row['name'],
        description: row['description'],
        price: row['price'],
        available_quantity: row['available_quantity'],
        category: category
      )
      puts "Add: #{row['name']}"
    end
  end
else
  puts "The CSV file is not found in the specified path.."
end


# ------------------------------------------Suppliers--------------------------------------------
csv_file_path = 'db/suppliers.csv'

if File.exist?(csv_file_path)
  CSV.foreach(csv_file_path, headers: true) do |row|
    supplier = Supplier.find_by(name: row['name'])

    if supplier
      supplier.update(
        contact: row['contact'],
        address: row['address'],
        phone: row['phone'],
        email: row['email']
      )
      puts "Update: #{supplier.name}"
    else
      Supplier.create(
        name: row['name'],
        contact: row['contact'],
        address: row['address'],
        phone: row['phone'],
        email: row['email']
      )
      puts "Add: #{row['name']}"
    end
  end
else
   puts "The CSV file is not found in the specified path."
end


# ------------------------------------------Suppliers--------------------------------------------

csv_file_path = 'db/customers.csv'

if File.exist?(csv_file_path)
  CSV.foreach(csv_file_path, headers: true) do |row|

    customer = Customer.find_by(name: row['name'])

    if customer
      customer.update(
        email: row['email'],
        phone: row['phone'],
        address: row['address']
      )
      puts "Update: #{customer.name}"
    else
      Customer.create(
        name: row['name'],
        email: row['email'],
        phone: row['phone'],
        address: row['address']
      )
      puts "Add: #{row['name']}"
    end
  end
else
  puts "The CSV file is not found in the specified path."
end
