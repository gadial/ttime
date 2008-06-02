class RepyParser
prechigh
	left COURSE_SEPERATOR_BAR
preclow

rule
	repy			: faculties sport_courses

	faculties		: faculties faculty
				| /* empty */

	faculty			: FACULTY_HEADER courses COURSE_SEPERATOR_BAR {puts "Courses:\n #{val[1].inspect}"}

	sport_courses		: SPORT_HEADER courses COURSE_SEPERATOR_BAR

	courses			: courses course 	{result << val[1]}
				| /* empty */ 		{result=[]}
	
	course			: course_header course_body {result=Course.new(val[0]+val[1])}
	
	course_header		: COURSE_SEPERATOR_BAR course_header_first_line course_header_second_line COURSE_SEPERATOR_BAR {result=val[1]+val[2]}

	course_header_first_line: LINE_START_END NUMBER words LINE_START_END {result=[[:number,val[1]],[:name,val[2].join(" ")]]}

	course_header_second_line: LINE_START_END TEACHING_HOURS_IN_WEEK words POINTS any_number LINE_START_END {result = [[:teaching_hour_count,val[2]],[:point_value,val[4]]]}
	
	course_body		: lines			{result = val[0]}

	words			: words WORD		{result << val[1]}
				| words NUMBER		{result << val[1]}
				| words REAL_NUMBER	{result << val[1]}
				| words TIME_RANGE	{result << val[1]}
				| words NUM_LETTER_NUM  {result << val[1]}
				| /* empty */		{result=[]}

	lines			: lines line		{result << val[1]}
				| /* empty */		{result=[]}

				#general line
	line			: LINE_START_END words LINE_START_END {result=[:none,nil]}
				#lecturer in charge line
				| LINE_START_END LECTURER_IN_CHARGE words LINE_START_END {result=[:lecturer_in_charge, val[2].join(" ")]}
				#moed A line
				| LINE_START_END FIRST_MOED WORD WORD DATE moed_possible_time LINE_START_END {result=[:first_moed,[val[3],val[4]]]}
				#moed B line
				| LINE_START_END SECOND_MOED WORD WORD DATE moed_possible_time LINE_START_END {result=[:second_moed,[val[3],val[4]]]}
				#Lecture times first line
#				| LINE_START_END LECTURE DAY_AND_TIME_RANGE NUMBER WORD LINE_START_END {result=[:lectures,[nil]]}
				#special line for course 601410
#				| LINE_START_END WORD TIME_RANGE WORD words LINE_START_END

	moed_possible_time	: WORD REAL_NUMBER {result=val[1]}
				| /* empty */ {result=[]}

	any_number		: NUMBER
				| REAL_NUMBER
end

---- header
		def convert_to_number(pseudo_number)
			pseudo_number.reverse.to_f
		end

	require 'repy_lexer.rb'

	class Course
		def initialize(parameters)
			@number=nil
			@name=nil
			parameters.each do |parameter|
				info=parameter[1]
				case parameter[0] # type
					when :number: 			@number=info
					when :name:			@name=info
					when :lecturer_in_charge:	@lecturer_in_charge=info
					when :point_value:		@points=convert_to_number(info)
					when :first_moed:		@moed_a_date=info[1].reverse; @moed_a_day=info[0]
					when :second_moed:		@moed_b_date=info[1].reverse; @moed_b_day=info[0]
				end
			end
		end
		def inspect
			"\nCourse no. #{@number}: #{@name.to_s}\n"+
			"Lecturer in charge: #{@lecturer_in_charge}\n"+
			"Points: #{@points}\n"+
			"Moed A on #{@moed_a_date.inspect}, day #{@moed_a_day.to_s}\n"+
			"Moed B on #{@moed_b_date.inspect}, day #{@moed_b_day.to_s}\n"
		end
		def convert_to_number(pseudo_number)
			pseudo_number.reverse.to_f
		end
	end

---- inner

	def parse(str)
#		@yydebug=true
		@lexer=Rex::Lexer.new
		@lexer.parse(str)
		do_parse
	end

	def next_token
		token=@lexer.next_token
#		puts token.inspect
		token
	end
