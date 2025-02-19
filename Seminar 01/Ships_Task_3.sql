select CLASS,COUNTRY 
from CLASSES
where NUMGUNS<10;

select NAME as shipName
from SHIPS
where LAUNCHED<1918;

select SHIP as shipName, BATTLE
from OUTCOMES
where RESULT='sunk';

select NAME
from SHIPS
where CLASS = NAME;

select Name
from ships
Where NAME Like 'R%'

select NAME
from ships
where NAME Like '% %';
