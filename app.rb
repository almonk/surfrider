require "./rider/surfrider.rb"
include Surfrider

Surf.run do
  with "Property__c/Change" do |record|
    client.create "Task",
                  Subject: "Follow up with owner of #{record.Name}",
                  WhatId: record.Id
  end

  with "Task/Change" do |record|
    if record.IsClosed
      puts "Task completed: #{record.Subject}"
    end
  end
end
