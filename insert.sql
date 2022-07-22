use [profaz4]

insert into garden values
/*(name,area)*/
/*1*/('ziba',800000),
/*2*/('ziba1',700000),
/*3*/('ziba2',400000),
/*4*/('ziba3',20000)


insert into locationgarden values
/*(plaque,alley,street,city,idgarden)*/
/*1*/(19,'adib1','karghar1','tehran',1),
/*2*/(20,'adib2','karghar2','mashhad',2),
/*3*/(21,'adib3','karghar3','gom',3),
/*4*/(22,'adib3','karghar3','birjand',4)

insert into gardener values
/*(firstname,lastname,workex,marials,gender,datebirth,datehire,salary,idgarden,vazeytbime)*/
/*1*/('fatemeh','Askari',4,0,'female','2002-11-11','2020-11-11',100000,1,1),
/*2*/('mahdi1','hosseini',5,0,'male','1990-11-11','2010-11-11',10000,2,1),
/*3*/('mahdi2','hosseini',5,0,'male','1980-11-11','2010-11-11',10000,3,0),
/*4*/('mahdi2','hosseini',5,0,'male','1970-11-11','2000-11-11',80000,4,0),
/*5*/('marzie','malki',6,0,'female','2000-11-11','2020-11-11',1000000,1,1),
/*6*/('ali','ahmadi',6,0,'male','2003-11-11','2020-11-11',1000000,1,1)

insert into locationgardener values
/*(plaque,alley,street,city,idgarden)*/
/*1*/(19,'adib','karghar','tehran',1),
/*2*/(20,'adib1','karghar1','mashhad',2),
/*3*/(21,'adib2','karghar2','gom',3),
/*4*/(22,'adib2','karghar2','birjand',4),
/*5*/(23,'adibpish3','karghar','tehran',5),
/*6*/(23,'jamali','karghar','tehran',6)

insert into plant values
/*(name,type,price,idgr,modatkasht)*/
/*1*/('yas1','1',123,1,1),
/*2*/('yas2','3',124,1,2),
/*3*/('yas3','1',223,2,3),
/*4*/('yas4','3',254,2,5),
/*5*/('yas5','3',274,3,7),
/*6*/('yas6','3',284,3,8),
/*7*/('yas7','1',294,5,8),
/*8*/('yas8','0',204,5,8),
/*9*/('yas9','8',354,5,8)


insert into rawmaterial values
/*(necessarysoil,necessaryirrigation,neccarymositure,necessarysunlight)*/
/*1*/('low','medium','high','low'),
/*2*/('low','low','high','low')

insert into needs values
/*(idplant,idrawmaterial)*/
/*1*/(1,1),
/*2*/(2,2),
/*3*/(3,1),
/*4*/(4,2),
/*5*/(5,1),
/*6*/(6,2),
/*7*/(7,1),
/*8*/(8,2),
/*9*/(9,1)

insert into provide values
/*(idgardener,idrawmaterial)*/
/*1*/(1,1),
/*2*/(1,2),
/*3*/(2,1),
/*4*/(2,2),
/*5*/(3,1),
/*6*/(3,2),
/*7*/(5,1),
/*8*/(5,2),
/*9*/(5,2)


insert into exist values
/*(idplant,idgarden)*/
/*1*/(1,1),
/*2*/(2,1),
/*3*/(3,2),
/*4*/(4,2),
/*5*/(5,3),
/*6*/(6,3)

insert into customer values 
/*(firstname,lastname,gender)*/
/*1*/('niaz','poorgholami','male'),
/*2*/('niaz2','poorgholami2','male'),
/*3*/('niaz3','poorgholami3','male'),
/*4*/('niaz4','poorgholami4','male')

insert into locationcustomer values
/*(plaque,alley,street,city,idgarden)*/
/*1*/(19,'adib','karghar','tehran',1),
/*2*/(20,'adib1','karghar1','tehran1',2),
/*3*/(21,'adib2','karghar2','tehran2',3),
/*4*/(22,'adib2','karghar2','mashhad',4)


insert into salesoperation values
/*(idgardener,idcustomer)*/
/*1*/(1,1),
/*2*/(1,2),
/*3*/(2,3),
/*4*/(2,4),
/*5*/(2,3),
/*6*/(3,4),
/*7*/(3,2),
/*8*/(3,1),
/*9*/(3,3),
/*10*/(5,1),
/*11*/(5,2),
/*12*/(5,3)





insert into ordercustomer values
/*(idsales,idcustomer,idplant,orderdate)*/
/*1*/(1,1,1,'2020-3-4'),
/*2*/(2,1,2,'2011-5-4'),
/*3*/(3,2,1,'2011-6-4'),
/*4*/(4,2,2,'2011-7-4'),
/*5*/(1,1,2,'2010-6-4'),
/*6*/(2,2,1,'2010-7-4'),
/*7*/(4,4,3,'2010-8-4'),
/*8*/(5,3,4,'2000-8-4'),
/*9*/(6,4,5,'2009-8-4'),
/*10*/(7,2,6,'2004-8-4'),
/*11*/(8,1,6,'2004-8-4'),
/*12*/(9,3,5,'2002-8-4'),
/*13*/(10,1,1,'2002-8-4'),
/*14*/(11,2,2,'2003-8-4'),
/*15*/(12,3,2,'2006-8-4')

insert into purchaseoperation values
/*(accountnumber,idgardener,idcustomer,purchasedate)*/
/*1*/('12345',1,1,'2020-3-7'),
/*2*/('12345',1,2,'2015-3-1'),
/*3*/('12345',2,3,'2017-3-1'),
/*4*/('12345',2,4,'2018-3-1'),
/*5*/('12345',2,4,'2012-3-1'),
/*6*/('12349',3,4,'2012-3-1'),
/*7*/('12349',3,2,'2012-3-1'),
/*8*/('17349',3,1,'2012-3-1'),
/*9*/('18349',3,3,'2012-3-1'),
/*10*/('183469',5,1,'2017-3-1'),
/*11*/('183469',5,2,'2016-3-1'),
/*12*/('183469',5,3,'2009-3-1')










