require 'csv'
require 'nokogiri'
require 'open-uri'

yt_stats = []


File.read('channel_list.txt').each_line do |url|
  doc = Nokogiri::HTML(open('http://www.youtube.com/user/'+url))
  subscribers = doc.css('span.stat-value')[0].content.gsub(',','')
  views = doc.css('span.stat-value')[1].content.gsub(',','')
  channel_stats = '"' + subscribers.to_s + '"' + "," + '"' + views.to_s + '"'
  yt_stats << channel_stats

  puts "User: #{url.strip} subscribers: #{subscribers} views: #{views}"
end

File.open('yt_stats.csv', 'w') do |file|
  yt_stats.each do |row| 
    file.puts row
  end
end