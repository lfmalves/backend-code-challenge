require 'rspec/autorun'
require_relative '../poor_mans_dijkstra.rb'

describe "poor_mans_dijkstra" do 
	it 'raises an error if parameters are not (both) strings' do 
		expect{poor_mans_dijkstra(123456, 456789)}.to raise_error(ArgumentError)
		expect{poor_mans_dijkstra(123456, "Mairinque")}.to raise_error(ArgumentError)
		expect{poor_mans_dijkstra("Mairinque", 456789)}.to raise_error(ArgumentError)
		expect{poor_mans_dijkstra(['a', 'b'], "Mairinque")}.to raise_error(ArgumentError)
		expect{poor_mans_dijkstra({}, "Mairinque")}.to raise_error(ArgumentError)
		expect{poor_mans_dijkstra(:Mairinque, "Mairinque")}.to raise_error(ArgumentError)
	end

	it 'raises an error if the input has the wrong number of parameters' do 
		expect{poor_mans_dijkstra("Mairinque", "Sorocaba", "Ibiuna")}.to raise_error(ArgumentError)
		expect{poor_mans_dijkstra("Mairinque")}.to raise_error(ArgumentError)
	end
end