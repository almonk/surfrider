<img src="https://user-images.githubusercontent.com/51724/96977958-b760c100-1515-11eb-9457-7b70a125f29b.png" height="80"/>


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

## Watch for Salesforce object changes

surfrider listens to Streaming PushTopic Events and allows developers to write clojures to respond to them.

First, tell surfrider which object and data you want to be able to subscribe to. Lets imagine we have a custom object called `Property__c`, we want to subscribe to `All` changes and we want the payload to contains fields `Name` and `Price`.

```
./surf follow Property__c All Name Price__c
```

As well as `All` changes, we can also subscribe to;

| Event type | Description                                                        |
|------------|--------------------------------------------------------------------|
| `All`        | All changes to object                                              |
| `Create`     | When a new object of this type is created                          |
| `Update`     | When an existing object is updated                                 |
| `Delete`     | When an existing object is deleted                                 |
| `Undelete`   | Only undelete events (when an object is undeleted from Salesforce) |



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
dispatch "EventName__e",
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
