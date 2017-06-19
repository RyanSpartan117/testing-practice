require 'spec_helper'
require 'json'

describe "HTTParty tests" do 

	context "check that the functions for HTTParty_example work as intended" do
		before(:all) do
		# before(:all)
			@postcode = PostcodeIo.new
			@search = @postcode.single_postcode_search("CR09HP")
		end
		it "should return status 200" do
			expect(@search["status"]).to eql(200) 

		end

		it "Should return a status 404 with an invalid postcode" do
			expect(@postcode.single_postcode_search("CR04p")["status"]).to eql(404) 

		end

		it "should return the same postcode as we sent" do
			expect(@search["result"]["postcode"]).to eql("CR0 9HP") 

		end

		it "should return a JSON type" do
			skip "Test not written"
			jsond = JSON.parse(@postcode)
			expect(@search["result"]["postcode"]).to eq{"result => CR0 9HP"}

		end

		it "should return the admin county" do

			expect(@search["result"]["codes"]["admin_county"]).to eql("E99999999")

		end

		it "should return 1-9 from the positional quality" do

			expect(@search["result"]["quality"]).to be_between(1, 9)

		end

		it "should return a random postcode in the correct format" do 
			@postcode.random_postcode_search
			expect(@postcode.random_postcode_result["result"]["postcode"]).to match(/([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([AZa-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9]?[A-Za-z])))) [0-9][A-Za-z]{2})/)
		end

		it "should return the longitude and latitude of a postcode correctly as a Float" do

			expect(@search["result"]["longitude"]).to be_within(0.001).of(-0.036676)
			expect(@search["result"]["latitude"]).to be_within(0.001).of(51.340371)
			expect(@search["result"]["latitude"]).to be_a(Float)
			expect(@search["result"]["longitude"]).to be_a(Float)


		end

		it "should return the incode and outcode of a given postcode correctly" do

			expect(@search["result"]["incode"]).to eql("9HP")
			expect(@search["result"]["outcode"]).to eql("CR0")

		end

		it "should return the eastings and northings of a given postcode correctly" do

			expect(@search["result"]["eastings"]).to be_within(1).of(536850)
			expect(@search["result"]["northings"]).to be_within(1).of(161972)

		end

		it "should return the correct data for Country, Region, admin_district" do

			expect(@search["result"]["country"]).to eql("England")
			expect(@search["result"]["region"]).to eql("London")
			expect(@search["result"]["admin_district"]).to eql("Croydon")

		end

	end

end