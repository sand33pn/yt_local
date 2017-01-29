namespace :store_ranking do 
	desc "Storing data for ranking column"

	task :store_ranks => :environment do 
		Link.all.each do |l|
			rank = l.view_count.to_i/(Date.today - Date.parse(l.published_at) ).to_i
			l.update_attributes(:ranking => rank)
		end
	end
	
end