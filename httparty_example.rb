require 'httparty'
require 'json'
require 'pry'

class PostcodeIo
include HTTParty

	attr_accessor :single_postcode_result
	attr_accessor :random_postcode_result
	attr_accessor :post_postcode_result


	base_uri 'http://api.postcodes.io'

	def single_postcode_search(postcode)
		x = self.class.get("/postcodes/#{postcode}")
		@single_postcode_result = JSON.parse(x.body)
	end

	def random_postcode_search
		y = self.class.get("/random/postcodes")
		@random_postcode_result = JSON.parse(y.body)
	end

	def post_postcode_search(postcodeHash)

		# postcodeJson = JSON.parse(postcodeHash)
		# @post_postcode_result = self.class.post("/postcodes", body : (postcodeHash))
		z = self.class.post("/postcodes", body:postcodeHash)
		@post_postcode_result = JSON.parse(z.body)
	end

end

postcode = PostcodeIo.new
postcode.single_postcode_search("cr09hp")
postcode.random_postcode_search


postcodeJson = {"postcodes":["CR0 9HP", "CR2 8EN"]}
postcode.post_postcode_search(postcodeJson)
puts postcode.post_postcode_result

# puts @post_postcode_result

# response = HTTParty.get('http://api.postcodes.io/postcodes/CR09HP')
# response = HTTParty.get('http://bbc.co.uk/news')
# puts response.body, response.message, response.code

# puts response.header.inspect