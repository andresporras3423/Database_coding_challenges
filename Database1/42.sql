---- having two inputs: an n number and an s string
---- transform the string using a caesar cipher 
---- to do this convert each character of the s string to its ascii value
---- add n to the number and obtain the character related with the resulting number
---- use only the first 128 ascii codes (from 0 to 127), those are the only to be used in the s string
---- if for example the n number is 4, and the ascii code of the character to transform is 126
---- then move back to the beginning, this is: 
---- 127 1
---- 0 2
---- 1 3
---- 3 4
---- then the ascii code of the number will be 4.
--create table simple_cipher(
--steps int,
--message_ varchar(255)
--);
--insert into simple_cipher values (40,'{|}~'), (4, 'Hello World'), (8,'Oscar Russi'), (7, 'ABCD'), (0,'1234')
SELECT STRING_AGG(CHAR((ASCII(tca.chr) + sc.steps)%128), '') AS ciphered, sc.*
FROM simple_cipher AS sc
CROSS APPLY to_char_array(sc.message_) AS tca
group by sc.message_, sc.steps
