# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :locations do
  primary_key :id
  String :title
  String :description, text: true
  String :date
  String :location
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :location_id
  foreign_key :user_id
  Boolean :going
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
locations_table = DB.from(:locations)

locations_table.insert(title: "Alger", 
                    description: "The snowmobile capital of Michigan",
                    date: "https://www.fishweb.com/maps/alger/trails/munising_autrain/map.gif",
                    location: "Kellogg Global Hub")

locations_table.insert(title: "Alpena", 
                    description: "It always beautiful riding on Thunder Bay",
                    date: "https://www.fishweb.com/maps/alpena/alpena-co.gif",
                    location: "Nowhere")

locations_table.insert(title: "Cheboygan", 
                    description: "Ride all the way to the Bridge!",
                    date: "https://www.fishweb.com/maps/cheboygan/cheboygan-co.gif",
                    location: "Nowhere")

locations_table.insert(title: "Grand Traverse", 
                    description: "The prettiest place to ride in Michigan",
                    date: "https://www.fishweb.com/maps/grandtraverse/grandtraverse-co.gif",
                    location: "Nowhere")

locations_table.insert(title: "Oscoda", 
                    description: "Come check out Ma Deeters in Luzerne",
                    date: "https://www.fishweb.com/maps/oscoda/oscoda-co.gif",
                    location: "Nowhere")

locations_table.insert(title: "Roscommon", 
                    description: "Home of Tip-up Town",
                    date: "https://www.fishweb.com/maps/roscommon/roscommon-co.gif",
                    location: "Nowhere")