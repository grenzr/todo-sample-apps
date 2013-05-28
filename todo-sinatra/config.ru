require './app'

app = Rack::Builder.new do

  map '/todos' do
    run TodoResource
  end
  
  map '/' do
    run Root
  end

end

run app