/*What is a result set? 
Result is the output from the query

What is the difference between Union and Union All? 
Union All keeps all records from each of the orginal 
datasets while UNION removes any duplicate records

What are the other Set Operators SQL Server has? 
Intersect, Exception

What is the difference between Union and Join? 
joins combine data into new columns
Unions combine data into new rows

What is the difference between INNER JOIN and FULL JOIN? 
Full join will return all rows with or without the match.
Inner join only returns rows with matching data

What is difference between left join and outer join 
left joins only returns the left table and the matching data of the right while outer returns both the tables

What is cross join? 
Cross join returns the Cartesian product of the sets of records from the two joined tables.

What is the difference between WHERE clause and HAVING clause? 
Where clause applies to indivual rows but having applies to group

Can there be multiple group by columns? 
Yes
*/


Select count(*)
from Production.Product


Select count(*)
from Production.Product
where ProductSubcategoryID is not NULL

Select ProductSubcategoryID, count (ProductSubcategoryID) as CountedProducts
from Production.Product
where ProductSubcategoryID is not NULL
group by ProductSubcategoryID


Select count(*)
from Production.Product
where ProductSubcategoryID is NULL

select * from Production.ProductInventory

SELECT ProductID, SUM(quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(quantity) < 100

SELECT Shelf, ProductID, SUM(quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID, shelf
HAVING SUM(quantity) < 100

SELECT AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
Where LocationID = 10

SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY ROLLUP (Shelf, ProductID)

SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE LocationID = 10 AND Shelf <> 'N/A'
GROUP BY ROLLUP (Shelf, ProductID)
ORDER BY Shelf


SELECT Color,Class,COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Class IS NOT NULL AND Color IS NOT NULL
GROUP BY GROUPING SETS ((Color), (Class))

select distinct c.Name as Country, s.Name as Province
from Person.StateProvince s
inner join Person.CountryRegion c
on s.CountryRegionCode = c.CountryRegionCode

select distinct c.Name as Country, s.Name as Province
from Person.StateProvince s
inner join Person.CountryRegion c
on s.CountryRegionCode = c.CountryRegionCode
where c.Name = 'Germany' or c.Name = 'Canada'

select distinct p.ProductName
from Products p inner join [Order Details] o
on p.ProductID = o.ProductID
inner join Orders r
on r.OrderID = o.OrderID
where r.OrderDate between '1995-10-21' and '2020-10-21'

select top 5 ShipPostalCode from Orders
group by ShipPostalCode
order by count(ShipPostalCode) desc

select top 5 ShipPostalCode from Orders
where OrderDate between '1995-10-21' and '2020-10-21'
group by ShipPostalCode
order by count(ShipPostalCode) des

select City, count(ContactName) as 'Number customer for city'
from Customers
group by City

select City, count(ContactName) as 'Number customer for city'
from Customers
group by City
having count(ContactName) > 10

select distinct c.ContactName from Orders o inner join Customers c
on o.CustomerID = c.CustomerID
where OrderDate between '1998-01-01' and '2020-10-21'

select CustomerID, OrderDate from
(select distinct CustomerID, OrderDate ,dense_rank() over (partition by CustomerID order
by orderDate desc) rnk from Orders) dt
where dt.rnk = 1

select c.ContactName, count(c.ContactName)
from Orders o inner join Customers c
on o.CustomerID = c.CustomerID
group by c.ContactName
order by count(c.ContactName) desc

select c.ContactName, sum(r.Quantity)
from Orders o inner join Customers c
on o.CustomerID = c.CustomerID
inner join [Order Details] r
on r.OrderID = o.OrderID
group by c.ContactName
having sum(r.Quantity) > 100
order by sum(r.Quantity) desc
select u.CompanyName, s.CompanyName from Shippers s
cross join Suppliers u

select distinct r.OrderDate, p.ProductName
from Products p inner join [Order Details] o
on p.ProductID = o.ProductID
inner join Orders r
on r.OrderID = o.OrderID

select * from Employees e inner join Employees m
on e.Title = m.Title

select e.EmployeeID, e.LastName, e.FirstName, e.Title from Employees e inner join
Employees m
on e.EmployeeID = m.ReportsTo
where e.Title like '%manager%'
group by e.EmployeeID, e.LastName, e.FirstName, e.Title
having count(m.ReportsTo) > 2

select city, ContactName, 'Customer' as Type from Customers
union
select city, ContactName, 'Supplier' as Type from Suppliers




