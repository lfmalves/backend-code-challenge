require 'rspec/autorun'
require_relative '../api.rb'

describe "DB feeding endpoint" do 
	it "receives data" do 
		post '/distance'
        expect(last_response.status).to eq 200
	end
end