require 'bunny'

# connection settings for our rabbitmq
# replace guest/guest with the credentials that marcel and tim have
connection_details = {
  :host      => "ci-slave1.virtapi.org",
  :port      => 5672,
  :ssl       => false,
  :vhost     => "/",
  :user      => "guest",
  :pass      => "guest",
  :auth_mechanism => "PLAIN"
}

# create the object conn from the class Bunny
conn = Bunny.new(connection_details)
# connect (TCP connection) to rabbitmq
conn.start
# create a communication channel
# AMQP is multiplexed via a single TCP connection
# each channel is one communication way
ch = conn.create_channel
# create a persistent queue
queue  = ch.queue("test1", auto_delete: false)
# bind queue to an exchange
queue.bind('marcelliitest')

# get a single message
# queue.pop
# or: queue.get

# create a continious bind as a consumer to our queue
queue.subscribe do |delivery_info, metadata, payload|
  puts "delivery_info: #{delivery_info}"
  puts "metadata: #{metadata}"
  puts "payload #{payload}"
end
