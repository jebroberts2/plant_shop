# README

Welcome to the tree and leaf plant shop! Below is a list of actions. 

Note that all routes should be prepended with /api:

../plants" => 'GET - returns a list of all the plants, including quantities and fun facts'

../orders" => 'POST - creates an order (customer_name, plant_name, quantity, and address are required params)'

../orders/retrieve_by_customer" => 'GET - retrieves an order (customer_name is required, plant name is optional)

../orders/retrieve_by_number" => 'GET - retrieves an order (order_number is required param)




SETUP

Fork/pull down the repo

Make sure you have all dependencies installed with homebrew/bundler (if on mac)

run `rake db:setup`

open a console and verify that all plants were properly seeded by verifying that `Plant.all` returns a list of plants

start the server and query away!
