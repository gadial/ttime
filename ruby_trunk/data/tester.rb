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
# t=<<END
# +==========================================+
# | מערכת שעות - הנדסה אזרחית וסביבתית       |
# |              סמסטר אביב תשס"ח            |
# +==========================================+
# END
# 
# puts p.parse(t)

