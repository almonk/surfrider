# 🌊 surfrider 

surfrider is a *proof-of-concept* app framework to build event-based, Salesforce integrations using a simple and expressive DSL.

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

## Write your first event handler

surfrider listens to Streaming Platform events and allows developers to write clojures to respond to them.

First, tell surfrider which object and data you want to be able to subscribe to. Lets imagine we have a custom object called `Property__c` with fields `Name` and `Price`.

```
./surf follow Property__c Name Price__c
```

surfrider will automatically add the handler:

```ruby
with "Property__c/Change" do |record|
  # Your code
end
```

Running your code now will show responses to changes in Salesforce

## Inspect the object model
At any point we can inspect our object model using `surf describe`

To list out every single object:

```
./surf describe
```

To describe a specific object's fields:

```
./surf describe Object
```