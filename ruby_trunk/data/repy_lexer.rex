hebrew_letter			([אבגדהוזחטיכךלמםנןסעפףצץקרשת])
faculty_header_bar		(\+==========================================\+)
faculty_first_line		(^\|.*מערכת שעות.*\|$)
faculty_second_line		(^\|.*סמסטר.*\|$)
sports_header_bar		(\+===============================================================\+)
lecturer_in_charge		(מורה אחראי)
course_seperator_bar		(\+------------------------------------------\+)
line				(^\|.*\|$)
word				([a-zA-Z]+)
whitespace			([\t\n ])
digit				([0-9])

%%
{faculty_header_bar}\n{faculty_first_line}\n{faculty_second_line}\n{faculty_header_bar} FACULTY_HEADER
{course_seperator_bar} 				COURSE_SEPERATOR_BAR
{lecturer_in_charge}				LECTURER_IN_CHARGE
({hebrew_letter}|[\'\-\.\"\/]|{digit})+ 	WORD
{digit}+					NUMBER
\|						LINE_START_END
{hebrew_letter}+				HEBREW_WORD
{word}						ENGLISH_WORD
{whitespace}