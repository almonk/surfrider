require "faye"
require "restforce"
require "recursive-open-struct"
require "dotenv/load"
require "colorize"

Surf = EM

module Surfrider
  API_VERSION = 49.0

  @@client = Restforce.new(username: ENV["SF_USERNAME"],
                           password: ENV["SF_PASSWORD"],
                           security_token: ENV["SF_TOKEN"],
                           instance_url: ENV["SF_INSTANCE_URL"],
                           client_id: ENV["CLIENT_ID"],
                           client_secret: ENV["CLIENT_SECRET"],
                           api_version: API_VERSION)

  if @@client.authenticate!
    puts "Connected to ☁️ Salesforce".green
    puts "as: #{@@client.options[:username]}".green
  end

  def with(event, &block)
    EM.run do
      Signal.trap("TERM") do
        EM.stop
        exit
      end

      @@client.subscription "/topic/#{event.sub!("/", "")}", replay: -1 do |message|
        puts "⚡️ Message from Salesforce".blue
        yield RecursiveOpenStruct.new(message["sobject"])
        puts "\n"
      end
    end
  end

  def dispatch(name, **args)
    puts "⚡️ Sent Platform Event: #{@@client.create("#{name}__e", args)}".blue
  end

  def client
    @@client
  end
end

module CookieJar
  module CookieValidation
    def self.hostname_reach(hostname)
      host = to_domain hostname
      host = host.downcase
      match = BASE_HOSTNAME.match host

      return unless match

      match[1] if PublicSuffix.valid?(match[1]) || match[1] == "local"
    end

    def self.compute_search_domains_for_host(host)
      host = effective_host host
      result = [host]

      return result if IPADDR.match?(host)

      loop do
        result << ".#{host}"
        host = hostname_reach(host)
        break unless host
      end

      result
    end
  end
end
