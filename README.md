# rabbitmq2postgresql

## Description

This is a tiny micoservice. It connects to a rabbitmq exchange via a dedicated
queue. All messages will be serialized into a Payload object (Sequel::Model
instance). Afterwards the objects will be saved, which in turn results in a
database transaction.

## Setup

```sh
git clone https://github.com/bastelfreak/rabbitmq2postgresql.git
cd rabbitmq2postgresql
bundle install --path .vendor
cp credentials_example.rb credentials.rb
# update credentials.rb now
bundle exec ruby main.rb
```
