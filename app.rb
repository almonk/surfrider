require "./rider/Surfrider.rb"
include Surfrider

Surf.run do
  with "Property__c/Change" do |record|
    dispatch "SRDispatch",
            Body__c: "Create task from platform event",
            Name__c: "CreateTask",
            Related__c: record.Id
  end
end
