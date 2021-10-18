BULK INSERT campdata
FROM 'C:\Users\JennyB\Desktop\CAMPDATA\CAMPDATA.TXT' 
WITH (FIRSTROW =2, FIELDTERMINATOR='|', ROWTERMINATOR = '\n');



create table campdata(
custId integer,
fname varchar(50),
lname varchar(50),
cID integer,
country varchar(50),
bookID integer,
bookDate  Date,
campCode char(3),
CampName varchar(50),
empno integer,
catCode char(1),
category varchar(50),
unitCost numeric(4,2),
startDate Date,
overnights integer,
persons integer
);

create table country(
	cID integer,
	country varchar(50),
	PRIMARY KEY (cID)
);

Insert Into country
SELECT distinct cID, country from campdata;

create table customers(
	custId integer,
	fname varchar(50),
	lname varchar(50),
	PRIMARY KEY (custId)
);

Insert Into customers
SELECT distinct custId, fname, lname from campdata;

create table camps(
	campCode char(3),
	CampName varchar(50),
	PRIMARY KEY (campCode)
);
Insert Into camps
SELECT distinct campCode, CampName from campdata;

create table category(
	catCode char(1),
	category varchar(50),
	PRIMARY KEY (catCode)
);
Insert Into category
SELECT distinct catCode, category from campdata;


create table timeData(
	startDate Date,
	dayD integer,
	monthD integer,
	yearD integer,
	Primary Key (startDate)
);


Insert Into timeData
select distinct startDate,
		datepart(day, startDate),
		datepart(month, startDate),
		datepart(year, startDate)
	FROM campdata

create table bookings(
	customerId integer,
	countryId integer,
	campCode char(3),
	categoryCode char(1),
	startDate Date,
	bookID integer,
	unitCost numeric(4,2),
	overnights integer,
	persons integer,
	empno integer,
	PRIMARY KEY (customerId, campCode, startDate, empno),
	FOREIGN KEY (customerId) REFERENCES customers(custId),
	FOREIGN KEY (countryId) REFERENCES country(cID),
	FOREIGN KEY (campCode) REFERENCES camps(campCode),
	FOREIGN KEY (categoryCode) REFERENCES category(catCode),
	FOREIGN KEY (startDate) REFERENCES timeData(startDate)
);

Insert into bookings
Select custId, cID, campCode, catCode, startDate, bookID, unitCost, overnights, persons, empno
From campdata


/*pk for bookings*/
Select distinct custId, campCode, startDate, empno
From campdata
