# 🌊 surfrider 

surfrider is a *proof-of-concept* app framework to build event-based, Salesforce integrations using a simple and expressive DSL.

surfrider supports both Streaming PushTopic Events and Salesforce Platform Events.

## Getting started
Clone this repository to your local machine

`git clone git@github.com:almonk/surfrider.git`

Install the dependencies

`bundle install`

Create your own environment variables. This is where you provide surfrider access to your Salesforce environment

`mv .env.copy .env`

Run the sample surfrider app, it should connect to your Salesforce org

```
❯ ruby app.rb
Connected to ☁️ Salesforce
as: amonk@curious-wolf-58aoub.com
```

## Write your first Event handler

surfrider listens to Streaming PushTopic Events and allows developers to write clojures to respond to them.

First, tell surfrider which object and data you want to be able to subscribe to. Lets imagine we have a custom object called `Property__c` with fields `Name` and `Price`.

```
./surf follow Property__c All Name Price__c
```

surfrider will automatically add the handler:

```ruby
with "Property__c/Change" do |record|
  # Your code
end
```

Running your code now will show responses to changes in Salesforce

## Inspect the Salesforce object model
At any point we can inspect our object model using `surf describe`

To list out every single object:

```
./surf describe
```

To describe a specific object's fields:

```
./surf describe Object
```

## Dispatching Salesforce Platform Events

As well as receiving events from the Platform, Surfrider can trigger Platform Events using the dispatch method.

```ruby
dispatch "EventName",
       Foo: Bar # Add your custom fields here
```

## Subscribe to Platform Events

surfirder can listen to Platform Events from Salesforce;

```ruby
with "event/EventName__e" do |payload|
       puts payload
end
```

## CRUD objects in Salesforce
 
Surfrider uses the amazing [Restforce](https://github.com/restforce/restforce) gem, so full documentation can be found on their site. Surfrider aliases the Restforce client to `client`.

Some examples;

**Creating a Task**

```ruby
client.create "Task",
       Subject: "Follow up on a thing"
```

**Updating an account**

```ruby
client.update "Account",
       Id: "0016000000MRatd",
       Name: "Whizbang Corp"
```