#Go to bitly.com/a/your_api_key
#Copy your bitly username and bitly api key from that page.
#Open bulk_bitly.rb and put in your username and api_key in.
#The script takes all the links in a file called input.txt and creates a file
#called output.csv.  Please look at the format of input.txt and create a text file the same way.
#Running the script bulk_bitly.rb:
#You'll need to install a ruby gem called "bitly".
#$ gem install bitly
#then cd into this folder from your terminal.  If the folder is on your desktop do this:
#$ cd ~/Desktop/bitly
#Then run it.
#$ ruby bulk_bitly.rb


require 'bitly'
require 'csv'

USERNAME=""
API_KEY=""

Bitly.use_api_version_3
bitly = Bitly.new(USERNAME, API_KEY)
bitly_links = []
CSV.forEach('input.csv') do |row|
  bitly_links << bitly.shorten(row[0])
end

File.open('output.csv', 'w'){|f| bitly_links.each {|b| f << "'#{b.long_url}', '#{b.short_url}'\n"}}