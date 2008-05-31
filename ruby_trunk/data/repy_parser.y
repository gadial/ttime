class RepyParser
prechigh
	left COURSE_SEPERATOR_BAR
preclow

rule

	repy			: FACULTY_HEADER courses COURSE_SEPERATOR_BAR {puts "number of courses: #{val[1]}"}

	courses			: courses course 	{result += 1; puts "current course count: #{result}"}
				| /* empty */ 		{result = 0}
	
	course			: course_header course_body {puts "course: #{val[0]}, length: #{val[1]}"}
	
	course_header		: COURSE_SEPERATOR_BAR LINE LINE COURSE_SEPERATOR_BAR {result=val[1]}
	
	course_body		: course_body LINE 	{result+=1}
				| /* empty */		{result=0}
end

---- header

	require 'repy_lexer.rb'

---- inner

	def parse(str)
#		@yydebug=true
		@lexer=Rex::Lexer.new
		@lexer.parse(str)
		do_parse
	end

	def next_token
		token=@lexer.next_token
		puts "next token: #{token.inspect}"
		token
	end
