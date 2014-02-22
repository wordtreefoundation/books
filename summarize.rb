require 'yaml'

# This script creates a summary of the status of each book so we can easily
# update the README.md file and show a list of books there.

books = Dir[File.join(File.dirname(__FILE__), 'pseudo_biblical', '*.md')].map do |file|
  head = `head -200 '#{file}'`.encode( "UTF-8", "binary", :invalid => :replace, :undef => :replace)
  begin
    YAML::load(head)
  rescue Exception
    puts file
    puts head
    raise
  end
end

books.group_by do |b|
  b['status']
end.sort_by do |status, books|
  case status
  when /ocr only/i
    '00'
  when /(missing|incomplete)/i
    '01'
  else
    status
  end
end.each do |(status, books)|
  puts "#{status}\n#{'-'*status.size}\n\n"
  books.each do |book|
    line = "- #{book['short_title']}"
    line += " (#{book['year']})" if book['year']
    puts line
  end
  puts
end