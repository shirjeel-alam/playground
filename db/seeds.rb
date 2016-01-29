# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

json = ActiveSupport::JSON.decode(File.read('db/seeds/posts.json'))
json.each do |post|
  Post.create!(title: post['title'], content: post['body'])
end

(1..3).each do |n|
  Product.create(title: "Product \##{n}", price: rand(10) + 0.99)
end