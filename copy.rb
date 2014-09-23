require 'wordtree'
require 'preamble'
require 'optparse'

options = {
  :source => "pseudo_biblical",
  :library => "library",
}

OptionParser.new do |opts|
  opts.banner = "Usage: copy.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  opts.on("-s", "--source-dir DIR", "Set source path to DIR") do |path|
    options[:source] = path
  end

  opts.on("-l", "--library LIBRARY", "Set library path to LIBRARY") do |path|
    options[:library] = path
  end

end.parse!


librarian = WordTree::Disk::Librarian.new(options[:library])

Dir.glob(File.join(options[:source], "*")) do |src_path|

  retrieved = Preamble.load(src_path, :external_encoding => "utf-8")
  book_id = retrieved.metadata["id"]
  book = WordTree::Book.create(book_id, retrieved.metadata, retrieved.content)

  puts "Saving #{book_id} to #{librarian.library.dir_of(book_id)}"
  librarian.save_without_ngrams(book)
end