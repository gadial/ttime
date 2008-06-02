hebrew_letter			(\327[\220\221\222\223\224\225\226\227\230\231\233\232\234\236\235\240\237\241\242\244\243\246\245\247\250\251\252])
faculty_header_bar		(\+==========================================\+)
faculty_first_line		(^\|.*מערכת שעות.*\|$)
faculty_second_line		(^\|.*סמסטר.*\|$)
sports_header_bar		(\+===============================================================\+)
sports_header_line		(^\|.*מקצועות ספורט.*\|$)
lecturer_in_charge		( מורה  אחראי :)
teaching_hours_in_week		(שעות הוראה בשבוע:)
first_moed			(מועד ראשון :)
second_moed			(מועד שני   :)
lecture				(הרצאה:)
points				(נק:)
course_seperator_bar		(\+------------------------------------------\+)
sport_course_seperator_bar	(\+---------------------------------------------------------------\+)
line				(^\|.*\|$)
whitespace			([\t\n ])
digit				([0-9])
possible_weekdays		(\327[\220\221\222\223\224\225\251])

exception_1			(\| [0-9]\.\327\224\327\224\327\247\327\234\327\224 \327\221\327\242\327\247\327\221\327\225\327\252 \327\224\327\251\327\221\327\231\327\252\327\224 \327\221\327\240\327\225\327\251\327\220 \327\247\327\223\327\236\327\231\327\235  \327\234 \327\220   \|\n\|   \327\227\327\234\327\224 \327\242\327\234 \327\236\327\247\327\246\327\225\327\242 \327\226\327\224\.                       \|\n)

%%
{faculty_header_bar}\n{faculty_first_line}\n{faculty_second_line}\n{faculty_header_bar} FACULTY_HEADER
{sports_header_bar}\n{sports_header_line}\n{sports_header_bar}	SPORT_HEADER
{exception_1}
({course_seperator_bar}|{sport_course_seperator_bar}) COURSE_SEPERATOR_BAR
{lecturer_in_charge}				LECTURER_IN_CHARGE
{teaching_hours_in_week}			TEACHING_HOURS_IN_WEEK
#{lecture}					LECTURE
{first_moed}					FIRST_MOED
{second_moed}					SECOND_MOED
#{possible_weekdays}\'{digit}+\.{digit}+-{digit}+\.{digit}+ DAY_AND_TIME_RANGE
{digit}+\.{digit}+-{digit}+\.{digit}+		TIME_RANGE
#{possible_weekdays}\'				DAY
#{possible_weekdays}				UNQUOTED_DAY
{digit}{digit}\/{digit}{digit}\/{digit}{digit}  DATE
{points}					POINTS
{digit}+\.{digit}+				REAL_NUMBER
{digit}+					NUMBER
{digit}+[A-Z]{digit}+				NUM_LETTER_NUM
({hebrew_letter}|[\'\-\.\"\/\:\+\!\(\)\,\#\_]|{digit})+ 	WORD
\|						LINE_START_END
{whitespace}