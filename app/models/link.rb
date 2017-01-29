class Link < ApplicationRecord
	validates :link_text, presence: true, uniqueness: { case_sensitive: false}
	# after_create :save_video_viewcount
 #  	after_update :save_video_viewcount


  	def save_video_viewcount
  		response = HTTParty.get('https://www.googleapis.com/youtube/v3/videos?part=contentDetails,statistics&id=4Y4YSpF6d6w&key=AIzaSyBeMC4eMb_u-IqGeYRSpAzED8m5RcjTumg')
  		puts "Calling save video count"
	    puts "DATA - #{response["items"][0]["statistics"]["viewCount"]}"
	    self.update.attributes(:ranking => response["items"][0]["statistics"]["viewCount"] )
  	end
end
