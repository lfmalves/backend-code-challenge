require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'sqlite3'
require_relative './poor_mans_dijkstra.rb'

# With the excuse of portability, we'll use the simplest DB
City1 = SQLite3::Database.new 'cities1'
City1.results_as_hash = true #sacrifices a bit of performance for the sake of simplicity
City1.execute "CREATE TABLE IF NOT EXISTS cities(city_one TEXT, city_two TEXT, distance INT)"

post '/distance' do
	params = request.body.read.split(' ')
	params[2] = params[2].to_f
	if params[2] > 100000 || params[2] < 0
		halt 500, "INVALID DISTANCE"
	end
	City1.execute("INSERT INTO cities(city_one, city_two, distance) VALUES(?, ?, ?)", [params[0], params[1], params[2]])
end

get '/cost' do 
	distan = 0
	weight = request.params['weight'].to_f 
	if weight > 50 || weight < 0 
		halt 500, "INVALID WEIGHT"
	end
	dist = []
	City1.execute('SELECT * FROM cities') do |row|
		if (row["city_one"] == request.params['origin'] && row['city_two'] == request.params['destination'])
			dist << row['distance'] #gets the shortest distance if we have duplicated results
		end
	end
	dist = poor_mans_dijkstra(request.params['origin'], request.params['destination']) if dist == []
	distan = dist.min.to_i unless dist.class == Integer
	cost = distan * weight * 0.15
	cost.round(2).to_s
end