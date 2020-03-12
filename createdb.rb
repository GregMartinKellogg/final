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
                    description: "Here we go again bacon burger taco fans, another Bacon Burger Taco Fest is here!",
                    date: "June 21",
                    location: "Kellogg Global Hub")

locations_table.insert(title: "Alpena", 
                    description: "It always beautiful riding on Thunder Bay",
                    date: "https://www.fishweb.com/maps/alpena/alpena-co.gif",
                    location: "Nowhere")

locations_table.insert(title: "Cheboygan", 
                    description: "If you're into nutrition and vitamins and stuff, this is the event for you.",
                    date: "https://www.fishweb.com/maps/alpena/alpena-co.gif",
                    location: "Nowhere")

locations_table.insert(title: "Grand Traverse", 
                    description: "If you're into nutrition and vitamins and stuff, this is the event for you.",
                    date: "https://www.fishweb.com/maps/alpena/alpena-co.gif",
                    location: "Nowhere")

locations_table.insert(title: "Oscoda", 
                    description: "If you're into nutrition and vitamins and stuff, this is the event for you.",
                    date: "https://www.fishweb.com/maps/alpena/alpena-co.gif",
                    location: "Nowhere")

locations_table.insert(title: "Roscommon", 
                    description: "If you're into nutrition and vitamins and stuff, this is the event for you.",
                    date: "https://www.fishweb.com/maps/alpena/alpena-co.gif",
                    location: "Nowhere")