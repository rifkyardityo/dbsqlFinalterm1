--1
select PaintingID ,PaintingName,PaintingPrice 
from painting
where (len (PaintingName) > 15)
--2
select TransactionID,CustomerName,TransactionDate 
from HeaderTransaction ht join customer ct on
ht.customerid=ct.customerid
where datename (month,TransactionDate) like 'september'

--3
select PaintingName, 'IDR ' + cast(PaintingPrice as varchar) + ',-' as price, 
'IDR ' + cast(sum(quantity * paintingprice)as varchar) + ',-' as [total profit]
from painting pt join DetailTransaction dt
on pt.PaintingID= dt.paintingid
where paintingname like '%d%'
group by pt.PaintingName, pt.paintingprice

--5
select CustomerName, CustomerAddress, CustomerEmail, convert (varchar, CustomerDOB , 106) as [Date of Birth]
from customer cu join HeaderTransaction ht on
cu.customerid = ht.CustomerID join DetailTransaction dt on
ht.TransactionID=dt.TransactionID join painting ptg on
dt.PaintingID= ptg.PaintingID join paintingtype ptp on
ptp.PaintingTypeID = ptg.PaintingTypeID
where month (transactiondate) = 7 and ptp.PaintingTypeName in  ('Abstract')

--9
alter table customer 
add CustomerSocialMedia varchar (30) 

alter table customer 
add constraint CheckCustomerSocialMedia check (CustomerSocialMedia between 5 and 25)

--10
begin tran
delete customer 
from customer ct
join HeaderTransaction ht on
ct.customerid= ht.CustomerID join DetailTransaction dt on
dt.TransactionID= ht.TransactionID
  where month (transactiondate) %2 = 0 and Quantity > 6
  rollback