# There are a couple gems that calculate Dijkstra's algo way better than this method that follows.
# But, as this is a challenge, I do not see much glory in showing that I can use a gem. Therefore I did it myself.
# Not that this funky method has any glory on it, but it's an honest try.


def poor_mans_dijkstra(origin, destination)
	raise ArgumentError, "INVALID PARAMETERS" unless origin.class == String && destination.class == String

	dist = []
	starting_point = City1.execute('SELECT * FROM cities').select{|x| x['city_one'] == origin}
	ending_point = City1.execute('SELECT * FROM cities').select{|x| x['city_two'] == destination}

	ends = []
	ending_point.each do |path|
		ends << path['city_one']
	end

	matching_mid_points = starting_point.select{|x| ends.include?(x['city_two'])}
	matching_mid_points.each do |path|
		second_leg = ending_point.select{|a| path['city_two'] == a['city_one']}
		km = path['distance'].to_i + second_leg[0]['distance'].to_i
		dist << km
	end
	dist
end