require 'rubygems'
require 'sinatra'
require 'mongo'
require 'mongoid'
require 'json'

require  File.dirname(__FILE__) + '/resource'

# MongoDB configuration
Mongoid.configure do |config|
  if ENV['VCAP_SERVICES']
    vcap_config = JSON.parse(ENV['VCAP_SERVICES'])
    mongo_url = vcap_config['mongodb-2.2'][0]['credentials']['url']
    conn = Mongo::Connection.from_uri(mongo_url)
    uri = URI.parse(mongo_url)
    config.master = conn.db(uri.path.gsub(/^\//, ''))
  else
    config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db('test')
  end
end

# Models
class Todo
    include Mongoid::Document
    
    field :title, :type => String
    field :completed, :type => Boolean, :default => false
    
end

class TodoResource < Resource
  use_model Todo
end

class Root < Sinatra::Base

  get '/' do
    redirect '/index.html'
  end

end
