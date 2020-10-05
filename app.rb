require "./rider/surfrider.rb"
include Surfrider

Surf.run do
  # Your code

  with "Property__c/Create" do |record|
    puts "A property was created! #{record.Name}"
  end
end
