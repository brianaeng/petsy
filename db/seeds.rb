
require "csv"

CSV.foreach('seed_csvs/pets.csv', :headers => true) do |csv_obj|
  Product.create( name: csv_obj['name'], user_id: csv_obj['user_id'], price: csv_obj['price'], quantity: csv_obj['quantity'],description: csv_obj['description'],picture: csv_obj['picture'], active: csv_obj['active'])
end

CSV.foreach('seed_csvs/reviews.csv', :headers => true) do |csv_obj|
  Review.create( rating: csv_obj['rating'].to_i, title: csv_obj['title'], description: csv_obj['description'],product_id: csv_obj['product_id'].to_i)
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
