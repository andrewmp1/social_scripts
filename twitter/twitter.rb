require 'twitter'
require 'csv'

Twitter.configure do |config|
  config.consumer_key   = ''
  config.consumer_secret = ''
  config.oauth_token = ''
  config.oauth_tokenh_token_secret = ''
end

filename = ARGV[0] || 'twitter_input.csv'
output = File.open('followers.csv', 'w')
puts "Querying twitter api for data..."
output.puts('"username", "followers_count", "friends_count"')
CSV.foreach(filename, headers: true) do |row|
  string =  '"' + row[0].to_s + '",'
  begin
    twitter_user =  Twitter.user(row[0])
    string << '"' + twitter_user.followers_count.to_s + 'followers_count",'
    string << '"' + twitter_user.friends_count.to_s + '"'
  rescue Excesseption => e
    puts "An error occured: #{e.to_s}"
  end
  output.puts string
end
puts "Created file followers.csv with followers_count & friends_count."
