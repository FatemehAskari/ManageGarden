use [profaz4]


/*view*/
DROP VIEW IF EXISTS Listpurchaseoperation ;
GO
CREATE VIEW Listpurchaseoperation AS
select garden.id as gardenid,garden.name as gardenname,p.nameplant as plantname,price,p1.purchasedate as purchasedate,
g.id as gardenerid,g.firstname as gardenerfirstname,g.lastname as gardenerlastname
from plant as p,customer as c,salesoperation as s,ordercustomer as o,purchaseoperation as p1,gardener as g,garden,exist as e
where o.idcustomer=c.id and o.idplant=p.id and o.idsales=s.id and s.idcustomer=c.id and s.idgardener=g.id
and p1.idgardener=g.id and p1.idcustomer=c.id and garden.id=g.idgarden and e.idgarden=garden.id and e.idplant=p.id
GO


DROP VIEW IF EXISTS Listofmaterialplantgarden ;
GO
CREATE VIEW Listofmaterialplantgarden AS
select g.id as gardenid,g.name as gardenname,p.id as plantid ,p.nameplant as nameplant,g1.firstname as firstnamegardener
,g1.lastname as lastnamegardener ,necessaryirrigation,necessarymoisture,necessarysoil,necessarysunlight
from garden as g,plant as p,gardener as g1,rawmaterial as r ,needs as n,provide as p1,exist as e
where g1.idgarden=g.id and p.idgr=g1.id and e.idgarden=g.id and e.idplant=p.id and n.idplant=p.id 
and n.idrawmaterial=r.id and p1.idgardener=g1.id and p1.idrawmaterial=r.id
GO

/*نمایش فروش کیاهان به صورت صعودی در یک باغ مختلف*/
select garden.id,garden.name,p.nameplant,sum(p.price) as price
from plant as p,customer as c,salesoperation as s,ordercustomer as o,purchaseoperation as p1,gardener as g,garden,exist as e
where o.idcustomer=c.id and o.idplant=p.id and o.idsales=s.id and s.idcustomer=c.id and s.idgardener=g.id
and p1.idgardener=g.id and p1.idcustomer=c.id and garden.id=g.idgarden and e.idgarden=garden.id and e.idplant=p.id
group by garden.id , p.nameplant,garden.name
order by price

/*روش دوم*/
select gardenid,gardenname,plantname,sum(price) as price
from Listpurchaseoperation
group by gardenid,gardenname,plantname
order by price




/*نمایش فروش گیاهان بر اساس تاریخ*/
select garden.id,garden.name,p.nameplant,p1.purchasedate
from plant as p,customer as c,salesoperation as s,ordercustomer as o,purchaseoperation as p1,gardener as g,garden,exist as e
where o.idcustomer=c.id and o.idplant=p.id and o.idsales=s.id and s.idcustomer=c.id and s.idgardener=g.id
and p1.idgardener=g.id and p1.idcustomer=c.id and garden.id=g.idgarden and e.idgarden=garden.id and e.idplant=p.id
group by garden.id , p.nameplant,garden.name,p1.purchasedate
order by purchasedate

/*روش دوم*/
select gardenid,gardenname,plantname,purchasedate
from Listpurchaseoperation
group by gardenid,gardenname,plantname,purchasedate
order by purchasedate

/*در تاریخ 2012-3-1 در باغ زیبا دو چه گیاهانی فروخته شده است و از هر کدوم چه تعداد*/
select garden.id,garden.name,p.nameplant,count(*) as number
from plant as p,customer as c,salesoperation as s,ordercustomer as o,purchaseoperation as p1,gardener as g,garden,exist as e
where o.idcustomer=c.id and o.idplant=p.id and o.idsales=s.id and s.idcustomer=c.id and s.idgardener=g.id
and p1.idgardener=g.id and p1.idcustomer=c.id and garden.id=g.idgarden and e.idgarden=garden.id and e.idplant=p.id and 
garden.name='ziba2' and p1.purchasedate='2012-3-1'
group by garden.id,garden.name,p.nameplant

/*روش دوم*/
select gardenid,gardenname,plantname,count(*) as number
from Listpurchaseoperation
where gardenname='ziba2' and purchasedate='2012-3-1'
group by gardenid,gardenname,plantname


/*در تاریخ 2012-3-1  کل در باغ زیبا دو چقدر فروش داشتیم؟*/
select garden.id,garden.name,sum(price) as Totalsales 
from plant as p,customer as c,salesoperation as s,ordercustomer as o,purchaseoperation as p1,gardener as g,garden,exist as e
where o.idcustomer=c.id and o.idplant=p.id and o.idsales=s.id and s.idcustomer=c.id and s.idgardener=g.id
and p1.idgardener=g.id and p1.idcustomer=c.id and garden.id=g.idgarden and e.idgarden=garden.id and e.idplant=p.id and 
garden.name='ziba2' and p1.purchasedate='2012-3-1'
group by garden.id,garden.name

/*روش دوم*/
select gardenid,gardenname,sum(price) as Totalsales 
from Listpurchaseoperation
where gardenname='ziba2' and purchasedate='2012-3-1'
group by gardenid,gardenname
/*می توانیم فروش در تمامی باغ ها را هم ببنیم*/
select gardenid,gardenname,sum(price) as Totalsales 
from Listpurchaseoperation
group by gardenid,gardenname

/*در باغ زیبا ا باغبانی که کار می کنند و تعداد گیاهانی که نگهداری می کنند وتفاوت حقوقش با میانگین حقوق باغبانان ان باغ می توانیم نام باغ را به عنوان پروسیجر بدهیم*/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'info5') AND type in (N'P', N'PC'))
DROP PROCEDURE info5
GO
create procedure info5(@namegarden nvarchar(50))
as 
begin
DECLARE @result1 TABLE (a INT)
INSERT INTO  @result1
select avg(salary)
from gardener as g ,garden as g1
where g1.name=@namegarden and g.idgarden=g1.id

select g.id,g.firstname,g.lastname,count(*) as numberofplant,salary-a as tafavotbaavg,salary,a as miangin
from gardener as g,plant as p,garden as g1,@result1
where g.id=p.idgr and g1.name=@namegarden and g.idgarden=g1.id
group by g.id,g.firstname,g.lastname,salary-a,salary,a
end;
GO
execute info5 'ziba'

/*نام یک باغ را وارد می کنیم و باغبان هایی که در آن کار می کند نمایش می دهد*/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'info6') AND type in (N'P', N'PC'))
DROP PROCEDURE info6
GO
create procedure info6(@namegarden nvarchar(50))
as 
begin


select g.id,g.firstname,g.lastname
from gardener as g,garden as g1
where  g1.name=@namegarden and g.idgarden=g1.id
end;
GO
execute info6 'ziba'

/*باغبانی هایی که در یک باغ مشخص کار می کنند ولی تا حالا گیاهی نفروختند.*/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'info7') AND type in (N'P', N'PC'))
DROP PROCEDURE info7
GO
create procedure info7(@namegarden nvarchar(50))
as 
begin

select g.id,g.firstname,g.lastname
from gardener as g,garden as g1
where  g1.name=@namegarden and g.idgarden=g1.id 
Except
select DISTINCT gardenerid, gardenerfirstname, gardenerlastname
from Listpurchaseoperation
where gardenname=@namegarden
end;
GO
execute info7 'ziba'

/*در یک باغ مشخص هر گیاه چه میزان نورخورشید نیاز دارد و کدوم باغبان از ان نگهداری میکند*/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'info8') AND type in (N'P', N'PC'))
DROP PROCEDURE info8
GO
create procedure info8(@namegarden nvarchar(50))
as 
begin
select *
from Listofmaterialplantgarden
where gardenname=@namegarden
end;
GO
execute info8 'ziba1'


/* در یک باغ مشخص چه گیاه هایی وجود دارد. مثلا باغ شماره 2 */
select nameplant, idgr
from plant
where idgr = 2

/* حقوق باغبان هایی که اسمشان با حرف ای شروع میشود */
select firstname, lastname, salary
from gardener 
where firstname like'a%'

/*  نمایش باغ ها بر اساس مساحت */
select name , area
from garden
order by area desc

/* باغبانی که بیشترین سابقه کاری را دارد */
select top 1 *
from gardener
order by year(datehire)

/* . نام باغ را وارد می کنیم و باغبان هایی که در ان کار می کنند نمایش می دهد */
select distinct firstname, lastname 
from gardener
where gardener.idgarden = (select id
						   from garden
						   where name = 'ziba')


/* نام خانوادگی یا آی دی مشتری هایی که بیش از 2 سفارش داده اند */
/* روش اول */
select lastname
from customer full join ordercustomer on customer.id = ordercustomer.idcustomer
group by lastname
having count(firstname) > 2
/* روش دوم */
select idcustomer
from ordercustomer
group by idcustomer
having count(idplant) > 2 


/* نام و نام خانوادگی مشتری هایی که جمع خریدهای آنها بیش از 600 شده باشد*/
select firstname, lastname
from customer
where customer.id in
					(select idcustomer
					from ordercustomer inner join plant on ordercustomer.idplant = plant.id
					group by idcustomer
					having sum(price) > 600)  


/* آدرس مشتری ای که بیشترین خرید را داشته است از لحاظ قیمت */
select plaque, alley, street, city
from locationcustomer
where locationcustomer.idcustomer in (select top 1 idcustomer
									 from ordercustomer inner join plant on ordercustomer.idplant = plant.id
									 group by idcustomer
									 order by SUM(price) desc)


/* نام و نام خانوادگی مشتری هایی که گیاه هایی که قیمت آن ها بین 200 تا 270 میباشد را سفارش داده اند */
select firstname, lastname
from customer
where customer.id in (select idcustomer
					  from ordercustomer
					  where idplant in
										(select id
										from plant
										where price > 200 and price < 270 ) )


/* برای باغبان هایی که شهر آن ها تهران است آیدی و حقوق را نمایش دهد و در ستونی خاص نام و نام خانوادگی را هم نمایش دهد */
select idgr as gardenerId, salary, CONCAT(firstname , ' ', lastname, ' ' ) as Full_Name
from gardener inner join locationgardener on gardener.id = locationgardener.idgr
where city = 'tehran'


/* درآمد کل هر باغ در هر سال  */
select YEAR(orderdate) as orderYear, idgarden, sum(price) as totalIncome
from (ordercustomer inner join exist on ordercustomer.idplant = exist.idplant)
					inner join plant on plant.id = exist.idplant
group by YEAR(orderdate), idgarden


/* باغی که در یک سال مشخص بیشترین درآمد را داشته است */
select top 1 YEAR(orderdate) as orderYear, idgarden, sum(price) as totalIncome
from (ordercustomer inner join exist on ordercustomer.idplant = exist.idplant)
					inner join plant on plant.id = exist.idplant
group by YEAR(orderdate), idgarden
having YEAR(orderdate) = 2002
order by sum(price) desc


/* گیاهی که در یک سال مشخص بیشترین فروش را داشته است چه مواد اولیه ای نیاز دارد */
select top 1 necessarysoil, necessaryirrigation, necessarymoisture, necessarysunlight
from ((rawmaterial inner join needs on rawmaterial.id = needs.idrawmaterial)
				   inner join plant on plant.id = needs.idplant)
				   inner join ordercustomer on ordercustomer.idplant = needs.id
group by ordercustomer.idplant, necessarysoil, necessaryirrigation, necessarymoisture, necessarysunlight,YEAR(orderdate)
having YEAR(orderdate) = 2011
order by sum(price) desc
				

/* میانگین حقوق همه ی باغبان هایی که در یک باغ مشخص کار میکنند */
select avg(salary)
from gardener
group by idgarden
having idgarden = 1


/* برگرداندن شهر مشتری ای که بیشترین تعداد دفعات خرید را از بزرگ ترین باغ از لحاظ مساحت دارد */
select city
from locationcustomer
where idcustomer = (select top 1 idcustomer --idgr, count(idcustomer)
					 from ordercustomer inner join plant on ordercustomer.idplant = plant.id
					 group by idcustomer, idgr
					 having idgr = (select top 1 id
									from garden
									order by area desc)
									order by count(idcustomer) desc)










