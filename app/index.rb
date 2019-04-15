require 'active_record'
require 'sinatra'
require 'puma'
require_relative 'models/website'


get '/*' do

end

def read_zip
  Zip::File.open('foo.zip') do |zip_file|
    # Handle entries one by one
    zip_file.each do |entry|
      # Extract to file/directory/symlink
      puts "Extracting #{entry.name}"
      entry.extract(dest_file)

      # Read into memory
      content = entry.get_input_stream.read
    end

    # Find specific entry
    entry = zip_file.glob('*.csv').first
    puts entry.get_input_stream.read
  end
end