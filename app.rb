require "./rider/surfrider.rb"
include Surfrider

Surf.run do
  with "Property__c/Create" do |record|
    client.create "Task",
      Subject: "Follow up with landlord of #{record.Name}",
      WhatId: record.Id
  end
end
