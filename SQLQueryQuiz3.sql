/*
 Subqueries can be used to return either a scalar (single) value or a row set; whereas, joins are used to return rows.

 A Common Table Expression, also called as CTE in short form, is a temporary named result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. The CTE can also be used in a View.

 Table varibale is a local variable that store data temporarily

 Delete can be used to delete specific data and used with a clause while Truncate deletes the entier table. Truncate is faster in performance
 
 Delete retains the identity and does not reset it to the seed value while Truncate command reset the identity to its seed value.

 They both do the same thing but in turncate there is no rollback

 */

 select distinct City from Customers
where city in (SELECT City from Employees)

select distinct City
from Customers
where city not in (SELECT City from Employees)

select distinct c.City
from Customers c
left join Employees e
on c.City = e.City

SELECT c.CustomerID, c.CompanyName, c.ContactName,
SUM(od.Quantity) AS QTY FROM
Customers c
LEFT JOIN
Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN
[Order Details] od
ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName, c.ContactName
ORDER BY QTY desc


SELECT c.City,
SUM(od.Quantity) AS QTY FROM
Customers c
LEFT JOIN
Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN
[Order Details] od
ON o.OrderID = od.OrderID
GROUP BY c.City
ORDER BY QTY desc

select u.City from Customers u group by u.City having COUNT(u.City) > 2
union
select c.City from Customers c group by c.City having COUNT(c.City) = 2

select distinct c.Cityfrom Customers c
where c.City in (select u.City from Customers u group by u.City having COUNT(u.City) >= 2 )

select distinct c.City
from Orders o inner join Customers c
on o.CustomerID = c.CustomerID
inner join [Order Details] r
on r.OrderID = o.OrderID
group by c.City, r.ProductID
having count(r.ProductID) > 2
select * from Customers c
where c.City not in
(select o.ShipCity from Orders o inner join Customers c on o.ShipCity = c.City)

WITH cte_ordersc
as(
SELECT oc.ShipCity,oc.ProductID, oc.average,DENSE_RANK() over (partition by
oc.ProductID order by oc.number) rnk FROM (
SELECT TOP(5) od.ProductID,o.ShipCity, SUM(Quantity) number,AVG(od.UnitPrice)
average FROM dbo.Orders o left join dbo.[Order Details] od on o.OrderID=od.OrderID
GROUP BY o.ShipCity, od.ProductID
ORDER BY number DESC
) oc
)
select * from cte_ordersc where rnk=1

select e.City from Employees e
where e.City not in (
select c.City from Orders o inner join Customers c
on c.CustomerID = o.CustomerID

select distinct e.City from Employees e
left join Customers c
on e.City = c.City
where c.City is null

select * from
(select Top 1 e.City, count(o.OrderID) countOrder from Employees e inner join Orders o
on e.EmployeeID = o.EmployeeID
group by e.City) T1
inner join (
select Top 1 c.City, count(r.Quantity) countQuantity from [Order Details] r inner join
Orders d on r.OrderID = d.OrderID
inner join Customers c on c.CustomerID = d.CustomerID group by c.City) T2
on T1.City = T2.City

/* use groupby and count and delete*/

SELECT deptname,empid,salary
FROM(
SELECT d.deptname, e.empid, e.salary, rank() OVER ( PARTITION BY e.deptid ORDER BY
 e.salary DESC ) AS ran
 FROM dept d, employee e
 WHERE d.deptid = e.deptid
 )
WHERE rnk <= 3
ORDER BY deptname,ran


select countbydept.*
from (
 select deptid, count(*) as departCount
 from Employee
 group by deptid
 order by departCount desc
 limit 1
) as maxcount
inner join
( select dept.id, dept.`name`, count(*) as employeeCount
 from Dept 
 inner join Employee on Employee.deptid = deptid
 group by deptid, deptname
) countbydept


SELECT deptname,empid,salary
FROM (
SELECT d.deptname, e.empid, e.salary, rank() OVER ( PARTITION BY e.deptid ORDER BY
e.salary DESC ) AS ran
 FROM dept d, employee e
 WHERE d.deptid = e.deptid
 )
WHERE rnk <= 3
ORDER BY deptname,ran