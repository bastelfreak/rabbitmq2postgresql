# frozen_string_literal: true

# ruby file which only holds credentials
# those are methods that return the hash
# we don't define the hash itself here, because the scope would be limited to
# this file. The methods are available where we will require this file.
def connection_details_rabbitmq
  {
    host: 'localhost',
    port: 5672,
    ssl: false,
    vhost: '/',
    user: 'guest',
    pass: 'guest',
    auth_mechanism: 'PLAIN'
  }
end

def connection_details_postgres
  {
    adapter: 'postgres',
    host: 'localhost',
    database: 'database',
    user: 'user',
    password: 'password',
    logger: Logger.new('log/db.log')
  }
end
