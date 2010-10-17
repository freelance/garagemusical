require 'rubygems'
require 'mongomatic'
require 'uri'

require './models/models.rb'

  # set the db for all models
  conn = Mongo::Connection.new("flame.mongohq.com", 27064)
  conn.db("app318810").authenticate("app318810","d6vqgr76urvopntbvyodrg")
  
  Mongomatic.db = conn.db("app318810")


# #   # or you can set it for a specific model:
  User.empty?

=begin
puts  u = User.new(:name => "Ben")
puts  u.valid?
puts  u["email"] = "me@somewhere.com"
puts  u.valid?
puts  u.insert
puts
puts  User.empty?
puts
puts  u["name"] = "Ben Myles"
puts  u.update
puts  
puts  found = User.find_one({"name" => "Ben Myles"})
=end
puts User.find.first["name"]

=begin
Posting.new({
  :title => 'search for bass',
  :body  => 'please, we are a punk band with shit ears',
  :instrument => [:keyboard]
}).insert
=end

Posting.find({"instrument" => "keyboard"}).each {|x| puts x["title"] }