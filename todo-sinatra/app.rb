require 'rubygems'
require 'sinatra'
require 'mongo'
require 'mongoid'

require  File.dirname(__FILE__) + '/resource'

# MongoDB configuration
Mongoid.configure do |config|
  if ENV['MONGOHQ_URL']
    conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    uri = URI.parse(ENV['MONGOHQ_URL'])
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

