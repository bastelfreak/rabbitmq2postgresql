# frozen_string_literal: true

require 'active_record'
require 'pg'
require 'logger'

ActiveRecord::Base.logger = Logger.new('debug.log')
configuration = YAML.load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])

class User < ActiveRecord::Base
end
