SELECT 
    e.FirstName,
    e.LastName
FROM 
    HumanResources.Employee emp
JOIN 
    Person.Person e ON emp.BusinessEntityID = e.BusinessEntityID
WHERE 
    e.FirstName LIKE '%a%';