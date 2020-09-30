require "./rider/Surfrider.rb"
include Surfrider

Surf.run do
  with "Property__c/Change" do |record|
    # Your code
  end
end
