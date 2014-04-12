require 'Feedjira'
require 'nokogiri'
require 'treat'
include Treat::Core::DSL

count = 0
feed = (Feedjira::Feed.fetch_and_parse ['http://feeds.feedburner.com/RockPaperShotgun?format=xml'])['http://feeds.feedburner.com/RockPaperShotgun?format=xml']
feed.entries.each do |f|
	rawEntry = f.content
	doc = Nokogiri::HTML(rawEntry)
	entry = ""
	doc.css('p,h1').each do |e|
		entry << e.content 
	end
	article = paragraph entry
	article.apply(:chunk, :segment, :tokenize, :parse)
	article.print_tree
	count += 1
end
puts count
