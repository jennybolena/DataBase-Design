/*query1*/
select TOP 100 coun.country, cus.fname, cus.lname, 
SUM(b.unitCost*b.persons*b.overnights) as totalValueOfBookings
from country as coun, customers as cus, bookings as b
where coun.cID = b.countryId AND cus.custId = b.customerId
group by b.customerId, cus.fname, cus.lname, coun.country
order by totalValueOfBookings DESC
GO

/*query2*/
select camps.CampName, category.category,
SUM(b.unitCost*b.persons*b.overnights) as totalValueOfBookings
from camps, category, timeData, bookings as b
where camps.campCode = b.campCode AND category.catCode = b.categoryCode 
AND timeData.startDate = b.startDate AND timeData.yearD = 2000
Group By camps.campCode, category.catCode, camps.CampName, category.category 
order by camps.CampName, category.category
GO

/*query3*/
select camps.campName, timeData.monthD, SUM(b.unitCost*b.persons*b.overnights) as totalValueOfBookings
from camps, bookings as b, timeData
Where camps.campCode = b.campCode AND timeData.startDate = b.startDate AND timeData.yearD = 2018
Group By camps.campCode, camps.CampName, timeData.monthD 
Order By camps.campCode, timeData.monthD
GO

/*query4*/
select timeData.yearD, camps.campCode, category.catCode, SUM(persons)
from camps, timeData, category, bookings as b
Where camps.campCode = b.campCode AND category.catCode = b.categoryCode
AND timeData.startDate = b.startDate
Group by RollUp (timeData.yearD, camps.campCode,  category.catCode)
GO

/*query5*/
CREATE VIEW personsPerCamp2017 AS
select camps.campCode, camps.CampName, SUM(b.persons) as persons2017
from camps, bookings as b, timeData
Where camps.campCode = b.campCode AND timeData.startDate = b.startDate 
AND timeData.yearD = 2017
Group by camps.campCode, camps.CampName

CREATE VIEW personsPerCamp2018 AS
select camps.campCode, camps.CampName, SUM(b.persons)as persons2018
from camps, bookings as b, timeData
Where camps.campCode = b.campCode AND timeData.startDate = b.startDate 
AND timeData.yearD = 2018
Group by camps.campCode, camps.CampName

select personsPerCamp2018.CampName
From personsPerCamp2017,personsPerCamp2018
where personsPerCamp2017.campCode = personsPerCamp2018.campCode
AND personsPerCamp2018.persons2018 > personsPerCamp2017.persons2017


/*ex3 query*/
select yearD, cID, catCode, SUM(bookings.overnights) 
from country, category, timeData, bookings
Where bookings.countryId = country.cID  AND bookings.categoryCode = category.catCode
AND bookings.startDate = timeData.startDate
Group By CUBE(yearD,  cID, catCode)
order by yearD desc, cID desc, catCode desc

