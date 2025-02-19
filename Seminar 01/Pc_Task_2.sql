select model,speed as MHz,hd as GB
from pc
where price<1200;

select DISTINCT maker  
from product
where type='Printer';

select model,ram,screen
from laptop
where price>1000;

select *
from printer
where color='y';

select model,speed,hd
from pc
where (cd ='12x' OR cd='16x') AND price<2000;
