hebrew_letter			([אבגדהוזחטיכךלמםנןסעפףצץקרשת])
faculty_header_bar		(\+==========================================\+)
faculty_first_line		(^\|.*מערכת שעות.*\|$)
faculty_second_line		(^\|.*סמסטר.*\|$)
sports_header_bar		(\+===============================================================\+)
lecturer_in_charge		( מורה  אחראי :)
teaching_hours_in_week		(שעות הוראה בשבוע:)
points				(נק:)
course_seperator_bar		(\+------------------------------------------\+)
line				(^\|.*\|$)
whitespace			([\t\n ])
digit				([0-9])

%%
{faculty_header_bar}\n{faculty_first_line}\n{faculty_second_line}\n{faculty_header_bar} FACULTY_HEADER
{course_seperator_bar} 				COURSE_SEPERATOR_BAR
{lecturer_in_charge}				LECTURER_IN_CHARGE
{teaching_hours_in_week}			TEACHING_HOURS_IN_WEEK
{points}					POINTS
{digit}+\.{digit}+				REAL_NUMBER
{digit}+					NUMBER
({hebrew_letter}|[\'\-\.\"\/\:\+\!\(\)\,\#]|{digit})+ 	WORD
\|						LINE_START_END
{whitespace}