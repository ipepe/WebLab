require 'active_support'
require 'sinatra'
require 'zip'
require 'mimemagic'
require 'pry' if ENV['RAILS_ENV'] != 'production'

WEBSITES_DATA_DIR = '/home/app/data/websites'

Zip.unicode_names = true
Zip.warn_invalid_date = false
Zip.force_entry_names_encoding = 'UTF-8'

def detect_content_type(io, filename)
  extension = filename.split('.').last
  case extension
  when 'css'
    return 'text/css'
  when 'js'
    return 'application/javascript'
  end || MimeMagic.by_magic(io)
end

Dir.glob(WEBSITES_DATA_DIR+'/*.zip') do |zip_file_path|
  zip_file = Zip::File.open(zip_file_path)
  cname_file = zip_file.glob('**/CNAME')[0]
  if cname_file
    domains = cname_file.get_input_stream.read.split("\n")
    root_path = cname_file.name[0..-6]
    domains.each do |domain|
      domain += '.localhost' if ENV['RAILS_ENV'] != 'production'
      puts "Mounting #{zip_file_path} at #{domain}"
      get '/*', host_name: domain do
        file_path = root_path + request.path[1..-1]
        if zip_file.glob(file_path).size == 1
          file_stream = zip_file.glob(file_path)[0].get_input_stream
          content_type detect_content_type(file_stream, file_path)
          file_stream
        elsif zip_file.glob(file_path + 'index.html').size == 1 # handle simple / by adding index.html
          file_stream = zip_file.glob(file_path + 'index.html')[0].get_input_stream
          content_type detect_content_type(file_stream, file_path + 'index.html')
          file_stream
        else
          status 404
        end
      end
    end
  end
end

