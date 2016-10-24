
require "csv"

CSV.foreach('seed_csvs/pets.csv', :headers => true) do |csv_obj|
  Product.create( name: csv_obj['name'], user_id: csv_obj['user_id'], price: csv_obj['price'], quantity: csv_obj['quantity'],description: csv_obj['description'],image: File.open(File.join(Rails.root, 'assets', 'images', csv_obj['picture'])), active: csv_obj['active'])
end

CSV.foreach('seed_csvs/reviews.csv', :headers => true) do |csv_obj|
  Review.create( rating: csv_obj['rating'].to_i, title: csv_obj['title'], description: csv_obj['description'],product_id: csv_obj['product_id'].to_i)
end

CSV.foreach('seed_csvs/categories.csv', :headers => true) do |csv_obj|
  Category.create(name: csv_obj['name'])
end

CSV.foreach('seed_csvs/product_categories.csv', :headers => true) do |csv_obj|
  ProductCategory.create(product_id: csv_obj['product_id'], category_id: csv_obj['category_id'])
end


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
