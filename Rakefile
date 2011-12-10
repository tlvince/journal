# Rakefile for creating new journal entries. {{{1
# 
# Derived from toto's original Rakefile by Alexis Sellier:
# https://github.com/cloudhead/dorothy/blob/master/Rakefile
#
# Modified by Tom Vincent <http://www.tlvince.com/contact/>

task :default => :new

desc "Create a new article." # {{{1
task :new do
  path = "entry"

  if not Dir.exist? path
    abort("Error: Not in draft branch")
  end

  title = ask('Title: ')
  abstract = ask('Abstract: ')
  slug = title.empty?? nil : title.strip.slugize

  article = "title: #{title}\n"
  article << "date: #{Time.now.strftime("%d/%m/%Y")}\n"
  article << "abstract: #{abstract}\n"
  article << "\n\n"

  path += "/#{Time.now.strftime("%Y-%m-%d")}#{'-' + slug if slug}.mkd"

  if not File.exist? path
    File.open(path, "w") do |file|
      file.write article
    end
  end
end

# Helper functions {{{1

def ask message
  print message
  STDIN.gets.chomp
end

class String
  def slugize
    self.downcase.gsub(/&/, 'and').gsub(/\s+/, '-').gsub(/[^a-z0-9-]/, '')
  end
end

# vim: set fdm=marker ts=2 sw=2 sts=2:
