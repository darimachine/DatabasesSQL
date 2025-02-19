select ADDRESS from STUDIO
where NAME='Disney';

select BIRTHDATE
from MOVIESTAR
where NAME='Jack Nicholson';

select STARNAME 
from STARSIN
where MOVIEYEAR = 1980 OR MOVIETITLE Like '%Knight%';

select NAME
from MOVIEEXEC
WHERE NETWORTH>10000000;

select NAME
from MOVIESTAR
where gender='M' OR ADDRESS = 'Prefect Rd.';