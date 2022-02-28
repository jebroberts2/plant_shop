# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

plants = [
  {
    name: 'Fig Tree',
    scientific_name: 'Ficus carica',
    available_quantity: 10,
    price: 20,
    fun_fact: 'Every fig contains the digested body of the fig wasp that polinated it'
  },
  {
    name: 'Mexican Giant Cactus',
    scientific_name: 'Pachycereus pringlei',
    available_quantity: 10,
    price: 100,
    fun_fact: 'The tallest cactus in the world is a member of this species, standing at 63 feet.'
  },
  {
    name: 'Giant Sequoia',
    scientific_name: 'Sequoiadendron giganteum',
    available_quantity: 5,
    price: 10000,
    fun_fact: 'The largest tree species in the world -- the widest giant sequoia measures 155 feet at its base'
  },
  {
    name: 'Venus Fly Trap',
    scientific_name: 'Dionaea muscipula',
    available_quantity: 10,
    price: 50,
    fun_fact: "The plant springs a trap triggered by disturbance of hairs on the periphery of its leaves, making it the plant kingdom's ultimate event listener..."
  },
  {
    name: 'Purple Loosestrife',
    scientific_name: 'Lythrum salicaria',
    available_quantity: 10000,
    price: 1,
    fun_fact: "One of the most notorius invasive species on the planet -- we recommend you don't buy this one..."
  },
  {
    name: 'Snake Plant',
    scientific_name: 'Dracaena trifasciata',
    available_quantity: 100,
    price: 5,
    fun_fact: 'The fibers from this plant are so hardy that hunters fashioned them into bowstrings'
  },
  {
    name: 'Stickbug',
    scientific_name: 'Phasmatodea',
    available_quantity: 50,
    price: 10,
    fun_fact: "Is it a stick? A bug? Our taxonomists couldn't decide, so we'll sell them"
  }
]

# Destroy all records currently in the db and reset the auto increment
Plant.all.destroy_all
Order.all.destroy_all
Customer.all.destroy_all

# reset the database auto increment value
%w(plants orders customers).each do |model|
  sql = "update sqlite_sequence set seq = 0 where name = '#{model}'"
  ActiveRecord::Base.connection.execute(sql)
end

plants.each do |plant_attrs|
  Plant.create(plant_attrs)
end
