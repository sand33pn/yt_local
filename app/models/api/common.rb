class Api::Common
	# require 'net/http'
 	#  	require 'uri'
	def get_video
	    response = HTTParty.get('https://www.googleapis.com/youtube/v3/videos?part=contentDetails,statistics&id=4Y4YSpF6d6w&key=AIzaSyBeMC4eMb_u-IqGeYRSpAzED8m5RcjTumg')
	    puts "DATA - #{response["items"][0]["statistics"]["viewCount"]}"
	    @response = JSON.parse response.to_json
    end
end