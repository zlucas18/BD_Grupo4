USE Northwind
--Obtener la cantidad total de pedidos realizados.
select count(*)as total_pedidos from Orders 

--Mostrar el nombre de los empleados que tienen el título "Sales Representative".
SELECT FirstName FROM Employees WHERE Title like 'Sales Representative'

--Obtener el total de ventas por categoría de producto
select count(*)as Total_Ventas from [Products] group by CategoryID

--Mostrar los 10 clientes con más pedidos realizados.
select OrderID, COUNT(order) As 

