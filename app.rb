require "./rider/Surfrider.rb"
include Surfrider

Surf.run do
  with "Property__c/Change" do |record|
    client.create "Task",
           Subject: "Follow up on #{record.Name}"
  end
end
