require "./rider/surfrider.rb"
include Surfrider

Surf.run do
  with "event/TestEvent__e" do |payload|
    # Your code
    puts payload
  end
end
