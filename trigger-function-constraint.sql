use [profaz4]


select *
from gardener

select *
from plant

select *
from garden

/*update row*/
/*باغبان هایی که از استخدام ان ها بیش از ده سال می کذرد حقوقشان را دو برابر کن*/
update gardener
set salary=2*salary
where datediff( YY, datehire, getdate()) >10

/*اگر قیمت گیاهی بیش تر از 10000000  ریال است قیمتش را همان 10000000  قرار بده*/
update plant
set price =10000000
where price>10000000



/*delete row*/
/*  باغبانی که ای دی ان یک هست میخوام حذف کنم توجه کنید که گیاه به ان فارن کی میداد.*/
delete 
from gardener
where id=1

/*دیلیت کردن گیاهی که تایپ ان یک است*/
delete 
from plant
where typeplant='1'
select *
from garden



select *
from gardener

select *
from plant

select *
from garden




