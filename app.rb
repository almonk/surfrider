require "./rider/Surfrider.rb"
include Surfrider

Surf.run do
  with "Property/Create" do |record|
    puts record.Name
    
    client.create("Task", Subject: "Call #{record.Name}")
  end
end
