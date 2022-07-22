use [profaz4]

DROP TABLE  exist
Drop table purchaseoperation
DROP TABLE  provide
Drop table ordercustomer
Drop table salesoperation
Drop table needs
Drop table locationcustomer
DROP TABLE  plant
DROP TABLE  locationgardener
DROP TABLE  locationgarden
DROP TABLE  rawmaterial
DROP TABLE  gardener
DROP TABLE  garden
Drop table customer


/*tables*/
create table gardener(
id INT identity(1,1) primary key,
firstname varchar(50) not null,
lastname varchar(50) not null,
workex int not null,
marials bit not null,
gender varchar(10) check(gender='male' or gender='female') not null,
datebirth date not null,
datehire date  not null,
salary bigint not null,
idgarden int ,
);

create table locationgardener(
id INT identity(1,1) primary key,
plaque int not null,
alley varchar(50) not null,
street varchar(50) not null,
city varchar(50) not null,
idgr int ,
/*UNIQUE(idgr)*/
);

create table plant(
id INT identity(1,1) primary key,
nameplant varchar(50) not null,
typeplant varchar(50),
price bigint not null,
idgr int 
);

create table garden(
id INT identity(1,1) primary key,
name varchar(50) not null,
area bigint  not null,

);

create table locationgarden(
id INT identity(1,1) primary key,
plaque int not null,
alley varchar(50) not null,
street varchar(50) not null,
city varchar(50) not null,
idgarden int ,
/*UNIQUE(idgarden)*/
);

create table  exist(
id INT identity(1,1) primary key,
idplant int ,
idgarden int ,
);

create table rawmaterial(
id INT identity(1,1) primary key,
necessarysoil varchar(10) check(necessarysoil='low' or necessarysoil='medium' or necessarysoil='high') not null,
necessaryirrigation varchar(10) check(necessaryirrigation='low' or necessaryirrigation='medium' or necessaryirrigation='high') not null,
necessarymoisture varchar(10) check(necessarymoisture='low' or necessarymoisture='medium' or necessarymoisture='high') not null,
necessarysunlight varchar(10)check(necessarysunlight='low' or necessarysunlight='medium' or necessarysunlight='high') not null,
);

create table provide(
id INT identity(1,1) primary key,
idgardener int ,
idrawmaterial int 
);

create table needs(
id INT identity(1,1) primary key,
idplant int ,
idrawmaterial int 
/*UNIQUE(idplant,idrawmaterial)*/
);

create table customer(
id INT identity(1,1) primary key,
firstname varchar(50) not null,
lastname varchar(50) not null,
gender varchar(10) check(gender='male' or gender='female') not null,
);

create table locationcustomer(
id INT identity(1,1) primary key,
plaque int  not null,
alley varchar(50) not null,
street varchar(50) not null,
city varchar(50) not null,
idcustomer int ,
/*UNIQUE(idcustomer)*/
);

create table salesoperation(
id INT identity(1,1) primary key,
idgardener int ,
idcustomer int ,
);

create table ordercustomer(
id INT identity(1,1) primary key,
idsales int ,
idcustomer int ,
idplant  int ,
orderdate date not null,
);

create table purchaseoperation(
id INT identity(1,1) primary key,
accountnumber bigint not null,
idgardener int ,
idcustomer int,
purchasedate date not null
);



/*foreign keys*/
alter table locationgardener add  foreign key (idgr) references gardener(id) on DELETE CASCADE;
alter table plant add foreign key (idgr) references gardener(id) on  DELETE SET NULL;
alter table gardener add foreign key (idgarden) references garden(id) on DELETE CASCADE;
alter table locationgarden add foreign key (idgarden) references garden(id) on DELETE CASCADE;
alter table exist add foreign key (idplant) references plant(id) on DELETE CASCADE;
alter table exist add foreign key (idgarden) references garden(id) on DELETE CASCADE;
alter table provide add foreign key (idgardener) references gardener(id)  ON DELETE SET NULL;
alter table provide add foreign key (idrawmaterial) references rawmaterial(id) ON DELETE SET NULL;
alter table needs add foreign key (idplant) references plant(id) on DELETE CASCADE;
alter table needs add foreign key (idrawmaterial) references rawmaterial(id) on DELETE CASCADE;
alter table locationcustomer add foreign key (idcustomer) references customer(id) on DELETE CASCADE;
alter table salesoperation add foreign key (idgardener) references gardener(id) on DELETE CASCADE;
alter table ordercustomer add foreign key (idsales) references salesoperation(id) on DELETE CASCADE;
alter table ordercustomer add foreign key (idcustomer) references customer(id) on DELETE CASCADE;
alter table ordercustomer add foreign key (idplant) references  plant(id) on DELETE CASCADE;
alter table purchaseoperation add foreign key (idgardener) references gardener(id) on DELETE CASCADE;
alter table purchaseoperation add foreign key (idcustomer) references customer(id) on DELETE CASCADE;




/*insert*/
/*insert into garden values
('toot',10000),
('toot1',20000),
('toot2',10000),
('toot2',10000),
('toot3',100)

insert into locationgarden values
(16,'adib','karghar','tehran',4),
(17,'adib1','karghar1','tehran1',2),
(18,'adib2','karghar2','tehran2',1)

insert into gardener values
('fatemeh','Askari',4,0,'female','2002-11-11','2020-11-11',100000,1),
('mahdi','hosseini',5,0,'male','1990-11-11','2010-11-11',10000,2),
('mahdi2','hosseini2',5,0,'male','2006-11-11','2010-11-11',10000,2)


insert into locationgardener values
(16,'adib','karghar','tehran',1),
(17,'adib1','karghar1','tehran1',2),
(18,'adib2','karghar2','tehran2',3)

insert into plant values
('maryam','1',123,1),
('maryam','3',124,2)*/


/*add column and add constraint*/
ALTER TABLE plant
ADD planningtime int 
CONSTRAINT planningtime DEFAULT 1
WITH VALUES;

Alter table gardener
ADD Insurancestatus bit 
CONSTRAINT Insurancestatus DEFAULT 0
WITH VALUES;


/*add constraint and function*/
/*فاصله استخدام شخص وسن تولدش حداقل 20 سال باشد*/
delete 
from gardener
where datediff(YY,datebirth,getdate())-datediff(YY,datehire,getdate())<=20
ALTER TABLE gardener
ADD CONSTRAINT CHK_PersonAge check(datediff(YY,datebirth,getdate())-datediff(YY,datehire,getdate())>=20);

/*سابقه کاری فردی اگر از 20 سال بیشتر باشد نباید حقوقش کمتر 10000ریال باشد*/
delete 
from gardener
where datediff(YY,datebirth,getdate())>=20 and salary<10000

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'myFunction1') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION myFunction1
Go
CREATE FUNCTION myFunction1 ()
RETURNS VARCHAR(5)
AS
BEGIN
    IF not EXISTS (select *
                 from gardener
                 where datediff(YY,datebirth,getdate())>=20 and salary<10000)
    return 'True'
    return 'False'
END
Go

ALTER TABLE gardener
ADD CONSTRAINT CHK_rulessalary check([dbo].[myFunction1]()='true')

/*باغ هایی که در شهر تهران هستند نباید مساحتشان کمتر از 1000 متر مربع باشد*/

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'areafunction') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION areafunction
Go
CREATE FUNCTION areafunction ()
RETURNS VARCHAR(5)
AS
BEGIN
    IF not EXISTS (select *
                 from garden as g,locationgarden as l
                 where g.id=l.idgarden and l.city='tehran' and g.area<1000)
    return 'True'
    return 'False'
END
Go

Alter table garden
ADD CONSTRAINT CHK_area check([dbo].[areafunction]()='true')

/*update constraint*/
/*فاصله استخدام شخص وسن تولدش حداقل 15 سال باشد*/
Alter table gardener
Drop CONSTRAINT CHK_PersonAge

ALTER TABLE gardener
ADD CONSTRAINT CHK_PersonAge check(datediff(YY,datebirth,getdate())-datediff(YY,datehire,getdate())>=15);

/*باغ هایی که در شهر تهران هستند نباید مساحتشان کمتر از 10000 متر مربع باشد*/

Alter table garden
Drop CONSTRAINT CHK_area

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'areafunction1') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION areafunction1
Go
CREATE FUNCTION areafunction1 ()
RETURNS VARCHAR(5)
AS
BEGIN
    IF not EXISTS (select *
                 from garden as g,locationgarden as l
                 where g.id=l.idgarden and l.city='tehran' and g.area<10000)
    return 'True'
    return 'False'
END
Go

Alter table garden
ADD CONSTRAINT CHK_area check([dbo].[areafunction1]()='true')


/*delete constraint*/
Alter table garden
Drop CONSTRAINT CHK_area

Alter table gardener
Drop CONSTRAINT CHK_rulessalary 

/*trigger*/
DROP TRIGGER IF EXISTS tr_chkpurchaseorder;
Go
CREATE TRIGGER tr_chkpurchaseorder ON purchaseoperation
for insert 
AS
BEGIN
    

	Declare @Idgardener int
	Declare @Idcustomer int
	Declare @date date
	select @date = purchasedate from inserted
	select @Idgardener =idgardener from inserted
	select @Idcustomer =idcustomer from inserted

	DECLARE @result1 TABLE (a date)

    IF EXISTS (
    select o.orderdate
    from plant as p,customer as c,salesoperation as s,ordercustomer as o,gardener as g,garden,exist as e
    where o.idcustomer=c.id and o.idplant=p.id and o.idsales=s.id and s.idcustomer=c.id and s.idgardener=g.id
    and @Idgardener=g.id and @Idcustomer=c.id and garden.id=g.idgarden and e.idgarden=garden.id and e.idplant=p.id
	and @date<o.orderdate)
	raiserror( 50005, 10, 1)
END
Go


DROP TRIGGER IF EXISTS tr_material;
Go
CREATE TRIGGER tr_material ON rawmaterial
for insert 
AS
BEGIN
     declare @soil varchar(10)
	 declare @irrigation varchar(10)
	 declare @smoisture varchar(10)
	 declare @sunlight varchar(10)

	 select @soil =necessarysoil from inserted
	 select @irrigation =necessaryirrigation from inserted
	 select @smoisture =necessarymoisture from inserted
	 select @sunlight  =necessarysunlight from inserted

	 if(@soil='low' and @irrigation='low' and @smoisture='low' and @sunlight='low')
	 raiserror( 50005, 10, 1)
END
Go

/*insert into rawmaterial values
/*(necessarysoil,necessaryirrigation,neccarymositure,necessarysunlight)*/
/*1*/('low','low','low','low')*/










