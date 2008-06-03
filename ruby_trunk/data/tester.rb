# require 'repy.rb'
# 
# lexer=Rex::Lexer.new
# lexer.parse(File.open(ARGV[0],"r"){|file| file.read})
# while not lexer.empty?
# 	puts lexer.next_token.inspect
# end

require 'repy_parser.tab.rb'
p=RepyParser.new
str=File.open(ARGV[0],"r"){|file| file.read}
p.parse(str)