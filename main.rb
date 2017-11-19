# frozen_string_literal: true

require 'bunny'
require 'sequel'

# the Sequel magic is based on"
# https://gist.github.com/janko-m/87865c47500a90302152
# http://sequel.jeremyevans.net/rdoc/classes/Sequel/Database.html

# connection settings for our rabbitmq and for postgres are stored in a
# seperate file
require './credentials.rb'

# create the object conn from the class Bunny
conn = Bunny.new(connection_details_rabbitmq)
# connect (TCP connection) to rabbitmq
conn.start
# create a communication channel
# AMQP is multiplexed via a single TCP connection
# each channel is one communication way
ch = conn.create_channel
# create a persistent queue
queue = ch.queue('test1', auto_delete: false)
# bind queue to an exchange
queue.bind('marcelliitest')

# get a single message
# queue.pop
# or: queue.get

## database stuff
DB = Sequel.connect(connection_details_postgres, logger: Logger.new('log/db.log'))
DB.create_table? :payloads do
  primary_key :id
  String :metadata_info
  String :delivery_info
  String :payload
end

# New hot shit, jsonbbbbbbbbbbbbbbbbbbbbbbbbbbbb. Lets beeeeeeeeeeeeeeeeeeeeeeeeeee (A Jan Philipp Zymnt quote)
DB.create_table? :payloadjsonbs do
  primary_key :id
  String :metadata_info
  String :delivery_info
  Jsonb :payload
end

# Reading and writing
DB.extension :pg_array
DB.extension :pg_json
# Querying
Sequel.extension :pg_array_ops
Sequel.extension :pg_json_ops

require './payload.rb'
require './payloadjsonb.rb'
# create a continious bind as a consumer to our queue
queue.subscribe do |delivery_info, metadata, payload|
  #puts "delivery_info: #{delivery_info}"
  #puts "metadata: #{metadata}"
  #puts "payload: #{payload}"
  Payloadjsonb.new(delivery_info: delivery_info, metadata_info: metadata, payload: payload).save
end
loop do
  #puts "message count: #{queue.message_count}"
  sleep 10
end
