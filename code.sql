
-- Danny Satterthwaite and Siddhartha Kumar Senthil Kumar FINAL PROJECT FULL CODE


-- Table creation statements with a draft of the proper order

-- key choice, foreign keys are alter table statements so we can move them around to get the ordering correct

-- also, made everything a varchar(50) unless it was obviously a date, time, or boolean. This was done as we are creating over 40 tables so to simplify things. this is obviously overkill but done to make sure when we merge etc we know for sure things are of the same type
-- There are few caveats where we made things integers given other constraints we had
-- ALSO, NOTE TO SELF, ONCE THIS IS CONFIRMED AND FINALIZED, UPDATE THE EER DIAGRRAM WITH THEW NEW ATTRIBUTES (HIGHLIGHTED IN GOOGLE DOC)












 -- BookingChannel
 CREATE TABLE BookingChannel (
    BookingID VARCHAR(50) PRIMARY KEY,
    Source VARCHAR(50) CHECK (Source IN ('Directly', 'Booking Site', 'On Location'))
);




INSERT INTO BookingChannel VALUES ('B1001', 'Directly');
INSERT INTO BookingChannel VALUES ('B1002', 'Booking Site');
INSERT INTO BookingChannel VALUES ('B1003', 'On Location');
INSERT INTO BookingChannel VALUES ('B1004', 'Directly');
INSERT INTO BookingChannel VALUES ('B1005', 'Booking Site');
INSERT INTO BookingChannel VALUES ('B1006', 'On Location');
INSERT INTO BookingChannel VALUES ('B1007', 'Directly');
INSERT INTO BookingChannel VALUES ('B1008', 'Booking Site');
INSERT INTO BookingChannel VALUES ('B1009', 'On Location');
INSERT INTO BookingChannel VALUES ('B1010', 'Directly');
INSERT INTO BookingChannel VALUES ('B1011', 'Booking Site');
INSERT INTO BookingChannel VALUES ('B1012', 'On Location');
INSERT INTO BookingChannel VALUES ('B1013', 'Directly');
INSERT INTO BookingChannel VALUES ('B1014', 'Booking Site');
INSERT INTO BookingChannel VALUES ('B1015', 'On Location');






--------------------------


 -- Security
 CREATE TABLE Security (
    PassengerID VARCHAR(50),
    TicketNumber VARCHAR(50),
    TimeThrough TIMESTAMP,
    PRIMARY KEY (PassengerID, TicketNumber)
);



INSERT INTO Security VALUES ('P1001', 'T1001', TO_TIMESTAMP('2024-01-15 06:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1002', 'T1002', TO_TIMESTAMP('2024-02-10 08:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1003', 'T1003', TO_TIMESTAMP('2024-03-05 06:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES('P1004', 'T1004', TO_TIMESTAMP('2024-03-20 15:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1005', 'T1005', TO_TIMESTAMP('2024-04-12 05:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1006', 'T1006', TO_TIMESTAMP('2024-05-10 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1007', 'T1007', TO_TIMESTAMP('2024-06-25 08:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1008', 'T1008', TO_TIMESTAMP('2024-07-15 13:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1009', 'T1009', TO_TIMESTAMP('2024-08-22 06:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1010', 'T1010', TO_TIMESTAMP('2024-09-30 15:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1011', 'T1011', TO_TIMESTAMP('2024-10-10 10:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1012', 'T1012', TO_TIMESTAMP('2024-11-15 10:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1013', 'T1013', TO_TIMESTAMP('2024-12-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1014', 'T1014', TO_TIMESTAMP('2024-12-05 13:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Security VALUES ('P1015', 'T1015', TO_TIMESTAMP('2024-12-07 14:30:00', 'YYYY-MM-DD HH24:MI:SS'));












--------------------------





 -- Flight 
CREATE TABLE Flight (
    Flightnum VARCHAR(50),
    FlightDate DATE NOT NULL,
    RouteNumber VARCHAR(50) NOT NULL,
    Airline VARCHAR(50) NOT NULL,
    Origin VARCHAR(50) NOT NULL,
    Destination VARCHAR(50) NOT NULL,
    IsInternational CHAR(1) NOT NULL CHECK (IsInternational IN ('Y', 'N')),
    DepartureTime TIMESTAMP NOT NULL,
    DepartureRunway VARCHAR(50),
    ArrivalTime TIMESTAMP NOT NULL,
    LandingRunway VARCHAR(50),
    DepartureGate VARCHAR(50),
    ArrivalGate VARCHAR(50),
    NumberOfSeats INT NOT NULL CHECK (NumberOfSeats > 0),
    Booked INT NOT NULL,
    Employees VARCHAR(50),
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('On Time', 'Delayed', 'Cancelled')),
    PRIMARY KEY (Flightnum, FlightDate),
    CONSTRAINT chk_ArrivalTime CHECK (ArrivalTime > DepartureTime),
    CONSTRAINT chk_BookedSeats CHECK (Booked >= 0 AND Booked <= NumberOfSeats)
);


ALTER TABLE Flight ADD CONSTRAINT unique_Flightnum UNIQUE (Flightnum);


--create the index:
CREATE INDEX flight_date_idx ON Flight  (FlightDate);




-- insert statements:
INSERT INTO Flight VALUES ('F1001', TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'R001', 'Delta', 'JFK', 'BOS', 'N', TO_TIMESTAMP('2024-01-15 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW01', TO_TIMESTAMP('2024-01-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW02', 'G1', 'G2', 150, 120, 'E001', 'On Time');
INSERT INTO Flight VALUES ('F1002', TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'R002', 'United', 'LAX', 'SFO', 'N', TO_TIMESTAMP('2024-02-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW03', TO_TIMESTAMP('2024-02-10 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW04', 'G5', 'G6', 200, 180, 'E002', 'Delayed');
INSERT INTO Flight VALUES ('F1003', TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'R003', 'Delta', 'JFK', 'YVR', 'Y', TO_TIMESTAMP('2024-03-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW05', TO_TIMESTAMP('2024-03-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW06', 'G7', 'G8', 180, 160, 'E003', 'On Time');
INSERT INTO Flight VALUES ('F1004', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'R004', 'United', 'ORD', 'EDI', 'Y', TO_TIMESTAMP('2024-03-20 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW07', TO_TIMESTAMP('2024-03-21 05:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW08', 'G9', 'G10', 250, 230, 'E004', 'On Time');
INSERT INTO Flight VALUES ('F1005', TO_DATE('2024-04-12', 'YYYY-MM-DD'), 'R005', 'Delta', 'LAX', 'BOS', 'N', TO_TIMESTAMP('2024-04-12 06:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW09', TO_TIMESTAMP('2024-04-12 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW10', 'G11', 'G12', 180, 150, 'E005', 'Cancelled');
INSERT INTO Flight VALUES ('F1006', TO_DATE('2024-05-10', 'YYYY-MM-DD'), 'R006', 'United', 'JFK', 'SFO', 'N', TO_TIMESTAMP('2024-05-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW11', TO_TIMESTAMP('2024-05-10 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW12', 'G13', 'G14', 220, 200, 'E006', 'Delayed');
INSERT INTO Flight VALUES ('F1007', TO_DATE('2024-06-25', 'YYYY-MM-DD'), 'R007', 'Delta', 'ORD', 'YVR', 'Y', TO_TIMESTAMP('2024-06-25 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW13', TO_TIMESTAMP('2024-06-25 13:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW14', 'G15', 'G16', 170, 140, 'E007', 'On Time');
INSERT INTO Flight VALUES ('F1008', TO_DATE('2024-07-15', 'YYYY-MM-DD'), 'R008', 'United', 'LAX', 'EDI', 'Y', TO_TIMESTAMP('2024-07-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW15', TO_TIMESTAMP('2024-07-16 03:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW16', 'G17', 'G18', 200, 180, 'E008', 'On Time');
INSERT INTO Flight VALUES ('F1009', TO_DATE('2024-08-22', 'YYYY-MM-DD'), 'R009', 'Delta', 'JFK', 'BOS', 'N', TO_TIMESTAMP('2024-08-22 07:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW17', TO_TIMESTAMP('2024-08-22 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW18', 'G19', 'G20', 150, 130, 'E009', 'Delayed');
INSERT INTO Flight VALUES ('F1010', TO_DATE('2024-09-30', 'YYYY-MM-DD'), 'R010', 'United', 'ORD', 'SFO', 'N', TO_TIMESTAMP('2024-09-30 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW19', TO_TIMESTAMP('2024-09-30 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW20', 'G21', 'G22', 200, 190, 'E010', 'On Time');
INSERT INTO Flight VALUES ('F1011', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'R011', 'Delta', 'DEN', 'JFK', 'N', TO_TIMESTAMP('2024-10-10 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW21', TO_TIMESTAMP('2024-10-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW22', 'G23', 'G24', 180, 150, 'E011', 'On Time');
INSERT INTO Flight VALUES ('F1012', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 'R012', 'United', 'MIA', 'ATL', 'N', TO_TIMESTAMP('2024-11-15 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW23', TO_TIMESTAMP('2024-11-15 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW24', 'G25', 'G26', 220, 200, 'E012', 'Delayed');
INSERT INTO Flight VALUES ('F1013', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'R013', 'Delta', 'LAS', 'PHX', 'N', TO_TIMESTAMP('2024-12-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW25', TO_TIMESTAMP('2024-12-01 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW26', 'G27', 'G28', 170, 140, 'E013', 'On Time');
INSERT INTO Flight VALUES ('F1014', TO_DATE('2024-12-05', 'YYYY-MM-DD'), 'R014', 'United', 'ORL', 'LAX', 'N', TO_TIMESTAMP('2024-12-05 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW27', TO_TIMESTAMP('2024-12-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW28', 'G29', 'G30', 200, 180, 'E014', 'On Time');
INSERT INTO Flight VALUES ('F1015', TO_DATE('2024-12-07', 'YYYY-MM-DD'), 'R015', 'Delta', 'SEA', 'DEN', 'N', TO_TIMESTAMP('2024-12-07 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW29', TO_TIMESTAMP('2024-12-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'RW30', 'G31', 'G32', 200, 190, 'E015', 'On Time');


-- drop the index
DROP INDEX flight_date_idx;

--------------------------


CREATE TABLE Airlines (
    CompanyID VARCHAR(50) PRIMARY KEY,
    HeadquartersLocation VARCHAR(50),
    CONSTRAINT chk_HeadquartersLocation_format 
        CHECK (HeadquartersLocation LIKE '%, %, %')
);
------



--insert statements
INSERT INTO Airlines VALUES ('A001', 'Atlanta, Georgia, USA');
INSERT INTO Airlines VALUES ('A002', 'Chicago, Illinois, USA');
INSERT INTO Airlines VALUES ('A003', 'Dallas, Texas, USA');
INSERT INTO Airlines VALUES ('A004', 'Los Angeles, California, USA');
INSERT INTO Airlines VALUES ('A005', 'New York, New York, USA');
INSERT INTO Airlines VALUES ('A006', 'Boston, Massachusetts, USA');
INSERT INTO Airlines VALUES ('A007', 'Seattle, Washington, USA');
INSERT INTO Airlines VALUES ('A008', 'San Francisco, California, USA');
INSERT INTO Airlines VALUES ('A009', 'Denver, Colorado, USA');
INSERT INTO Airlines VALUES ('A010', 'Vancouver, BC, Canada');
INSERT INTO Airlines VALUES ('A011', 'Edinburgh, Scotland, UK');
INSERT INTO Airlines VALUES ('A012', 'Miami, Florida, USA');
INSERT INTO Airlines VALUES ('A013', 'Las Vegas, Nevada, USA');
INSERT INTO Airlines VALUES ('A014', 'Orlando, Florida, USA');
INSERT INTO Airlines VALUES ('A015', 'Phoenix, Arizona, USA');




--------------------------    


--  Airport
CREATE TABLE Airport (
    AirportCode VARCHAR(50) NOT NULL,
    Airportaddress VARCHAR(50) NOT NULL,
    PRIMARY KEY (AirportCode),
    CONSTRAINT chk_AirportCode CHECK (REGEXP_LIKE(AirportCode, '^[A-Z]{3}$')),
    CONSTRAINT chk_Address CHECK (LENGTH(TRIM(Airportaddress)) > 0)
);





--insert statements
INSERT INTO Airport VALUES ('JFK', 'John F. Kennedy International, New York, USA');
INSERT INTO Airport VALUES ('LAX', 'Los Angeles International, Los Angeles, USA');
INSERT INTO Airport VALUES ('ORD', 'OHare International, Chicago, USA');
INSERT INTO Airport VALUES ('SFO', 'San Francisco International, San Francisco, USA');
INSERT INTO Airport VALUES ('BOS', 'Boston Logan International, Boston, USA');
INSERT INTO Airport VALUES ('YVR', 'Vancouver International, Vancouver, Canada');
INSERT INTO Airport VALUES ('EDI', 'Edinburgh Airport, Edinburgh, UK');
INSERT INTO Airport VALUES ('SEA', 'Seattle-Tacoma International, Seattle, USA');
INSERT INTO Airport VALUES ('ATL', 'Hartsfield-Jack Atlana INT, Atlanta, USA');
INSERT INTO Airport VALUES ('DFW', 'Dallas/Fort Worth International, Dallas, USA');
INSERT INTO Airport VALUES ('DEN', 'Denver International, Denver, USA');
INSERT INTO Airport VALUES ('MIA', 'Miami International, Miami, USA');
INSERT INTO Airport VALUES ('LAS', 'McCarran International, Las Vegas, USA');
INSERT INTO Airport VALUES ('ORL', 'Orlando International, Orlando, USA');
INSERT INTO Airport VALUES ('PHX', 'Phoenix Sky Harbor Intrntal, Phoenix, USA');
--------------------------

 -- Passenger

--index cluster setup
CREATE CLUSTER PassengerCluster (
    PassengerID VARCHAR(50)
);


CREATE TABLE Passenger (
    PassengerID VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE NOT NULL,
    StreetName VARCHAR(50),
    StreetNumber VARCHAR(50),
    City VARCHAR(50),
    PassState VARCHAR(50),
    Zip VARCHAR(50) NOT NULL,
    Country VARCHAR(50),
    PhoneNumber VARCHAR(50) NOT NULL,
    BookingID VARCHAR(50),
    CONSTRAINT chk_zip_format CHECK (REGEXP_LIKE(Zip, '^[A-Za-z0-9 -]+$')),
    CONSTRAINT chk_phone_format CHECK (REGEXP_LIKE(PhoneNumber, '^\d{11}$'))
) CLUSTER PassengerCluster (PassengerID);

-- create the cluster index
CREATE INDEX idx_PassengerCluster ON CLUSTER PassengerCluster;
alter table  Passenger add FOREIGN KEY (BookingID) REFERENCES BookingChannel(BookingID);







-- insert statements
INSERT INTO Passenger VALUES ('P1001', 'Danny', 'Satterthwaite', TO_DATE('1985-06-15', 'YYYY-MM-DD'), 'Main St', '123', 'Boston', 'MA', '02134', 'USA', '11234567890', 'B1001');
INSERT INTO Passenger VALUES ('P1002', 'Maggie', 'Eby', TO_DATE('1990-09-22', 'YYYY-MM-DD'), 'Elm St', '456', 'San Francisco', 'CA', '94105', 'USA', '19876543210', 'B1002');
INSERT INTO Passenger VALUES ('P1003', 'Jamie', 'Kumar', TO_DATE('1978-03-10', 'YYYY-MM-DD'), 'Oak St', '789', 'Vancouver', 'BC', 'V6B1A8', 'Canada', '16041234567', 'B1003');
INSERT INTO Passenger VALUES ('P1004', 'Jenn', 'Hoare', TO_DATE('1982-12-01', 'YYYY-MM-DD'), 'Pine St', '321', 'Edinburgh', 'EDH', 'EH12 8TS', 'UK', '41312345678', 'B1004');
INSERT INTO Passenger VALUES ('P1005', 'Sidd', 'Satterthwaite', TO_DATE('1995-07-14', 'YYYY-MM-DD'), 'Maple St', '654', 'Boston', 'MA', '02135', 'USA', '11234567891', 'B1005');
INSERT INTO Passenger VALUES ('P1006', 'Mike', 'Eby', TO_DATE('1988-02-20', 'YYYY-MM-DD'), 'Cedar St', '987', 'San Francisco', 'CA', '94107', 'USA', '19876543211', 'B1006');
INSERT INTO Passenger VALUES ('P1007', 'Danny', 'Kumar', TO_DATE('1975-08-30', 'YYYY-MM-DD'), 'Birch St', '246', 'Vancouver', 'BC', 'V6C2A8', 'Canada', '16041234568', 'B1007');
INSERT INTO Passenger VALUES ('P1008', 'Maggie', 'Hoare', TO_DATE('1991-11-11', 'YYYY-MM-DD'), 'Ash St', '135', 'Edinburgh', 'EDH', 'EH14 7QT', 'UK', '41312345679', 'B1008');
INSERT INTO Passenger VALUES ('P1009', 'Jamie', 'Satterthwaite', TO_DATE('1983-05-25', 'YYYY-MM-DD'), 'Spruce St', '468', 'Boston', 'MA', '02136', 'USA', '11234567892', 'B1009');
INSERT INTO Passenger VALUES ('P1010', 'Jenn', 'Eby', TO_DATE('1986-10-18', 'YYYY-MM-DD'), 'Willow St', '579', 'San Francisco', 'CA', '94108', 'USA', '19876543212', 'B1010');
INSERT INTO Passenger VALUES ('P1011', 'Maggie', 'Kumar', TO_DATE('1980-04-12', 'YYYY-MM-DD'), 'Palm St', '852', 'Seattle', 'WA', '98101', 'USA', '12061234567', 'B1011');
INSERT INTO Passenger VALUES ('P1012', 'Jamie', 'Hoare', TO_DATE('1987-01-22', 'YYYY-MM-DD'), 'Fir St', '753', 'Atlanta', 'GA', '30301', 'USA', '14041234567', 'B1012');
INSERT INTO Passenger VALUES ('P1013', 'Sidd', 'Eby', TO_DATE('1993-02-05', 'YYYY-MM-DD'), 'Cypress St', '159', 'Dallas', 'TX', '75201', 'USA', '12141234567', 'B1013');
INSERT INTO Passenger VALUES ('P1014', 'Mike', 'Satterthwaite', TO_DATE('1992-06-18', 'YYYY-MM-DD'), 'Hickory St', '357', 'Miami', 'FL', '33101', 'USA', '13051234567', 'B1014');
INSERT INTO Passenger VALUES ('P1015', 'Danny', 'Hoare', TO_DATE('1989-09-30', 'YYYY-MM-DD'), 'Dogwood St', '246', 'Las Vegas', 'NV', '89101', 'USA', '17021234567', 'B1015');







--------------------------




 --  Source_Directly
CREATE TABLE Source_Directly (
    BookingID VARCHAR(50),
    AirlineName VARCHAR(50),
    SourceName VARCHAR(50),
    PRIMARY KEY (BookingID, AirlineName)
);

alter table Source_Directly add  FOREIGN KEY (BookingID) REFERENCES BookingChannel(BookingID);
--------------------------
 
 --  Source_Booking_Site
 CREATE TABLE Source_Booking_Site (
    BookingID VARCHAR(50),
    AirlineName VARCHAR(50),
    SourceName VARCHAR(50),
    PRIMARY KEY (BookingID, AirlineName)
);

alter table Source_Booking_Site add  FOREIGN KEY (BookingID) REFERENCES BookingChannel(BookingID);
 --------------------------


 -- Source_On_Location
 CREATE TABLE Source_On_Location (
    BookingID VARCHAR(50),
    AirlineName VARCHAR(50),
    SourceName VARCHAR(50),
    PRIMARY KEY (BookingID, AirlineName)
);

alter table Source_On_Location add  FOREIGN KEY (BookingID) REFERENCES BookingChannel(BookingID);
--------------------------



 -- Transaction Table
CREATE TABLE PaymentTransaction (
    TransactionID VARCHAR(50) PRIMARY KEY,
    BookingID VARCHAR(50),
    DateTime TIMESTAMP,
    PaymentForm VARCHAR(50) CHECK (PaymentForm IN ('Miles', 'Credit Card')),
    CreditCardNumber VARCHAR(50),
    Refund VARCHAR(50) CHECK (Refund IN ('Yes', 'No'))
);

-- insert statements:
INSERT INTO PaymentTransaction VALUES ('TX1001', 'B1001', TO_TIMESTAMP('2024-01-15 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Credit Card', '4111111111111111', 'No');
INSERT INTO PaymentTransaction VALUES ('TX1002', 'B1002', TO_TIMESTAMP('2024-02-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Miles', NULL, 'No');
INSERT INTO PaymentTransaction VALUES ('TX1003', 'B1003', TO_TIMESTAMP('2024-03-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Credit Card', '4222222222222222', 'No');
INSERT INTO PaymentTransaction VALUES ('TX1004', 'B1004', TO_TIMESTAMP('2024-03-20 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Miles', NULL, 'No');
INSERT INTO PaymentTransaction VALUES ('TX1005', 'B1005', TO_TIMESTAMP('2024-04-12 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Credit Card', '4333333333333333', 'No');
INSERT INTO PaymentTransaction VALUES ('TX1006', 'B1006', TO_TIMESTAMP('2024-05-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Miles', NULL, 'No');
INSERT INTO PaymentTransaction VALUES ('TX1007', 'B1007', TO_TIMESTAMP('2024-06-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Credit Card', '4444444444444444', 'No');
INSERT INTO PaymentTransaction VALUES ('TX1008', 'B1008', TO_TIMESTAMP('2024-07-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Miles', NULL, 'No');
INSERT INTO PaymentTransaction VALUES ('TX1009', 'B1009', TO_TIMESTAMP('2024-08-22 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Credit Card', '4555555555555555', 'No');
INSERT INTO PaymentTransaction VALUES ('TX1010', 'B1010', TO_TIMESTAMP('2024-09-30 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Miles', NULL, 'No');
INSERT INTO PaymentTransaction VALUES ('TX1011', 'B1011', TO_TIMESTAMP('2024-10-10 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Credit Card', '4666666666666666', 'No');
INSERT INTO PaymentTransaction VALUES ('TX1012', 'B1012', TO_TIMESTAMP('2024-11-15 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Miles', NULL, 'No');
INSERT INTO PaymentTransaction VALUES ('TX1013', 'B1013', TO_TIMESTAMP('2024-12-01 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Credit Card', '4777777777777777', 'No');
INSERT INTO PaymentTransaction VALUES ('TX1014', 'B1014', TO_TIMESTAMP('2024-12-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Miles', NULL, 'No');
INSERT INTO PaymentTransaction VALUES ('TX1015', 'B1015', TO_TIMESTAMP('2024-12-07 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Credit Card', '4888888888888888', 'No');



-----------------------------------------------

 --  Domestic
 CREATE TABLE Domestic (
    Flightnum VARCHAR(50) PRIMARY KEY,
    MealProvided CHAR(1) NOT NULL CHECK (MealProvided IN ('Y', 'N'))
);

alter table Domestic add FOREIGN KEY (Flightnum) REFERENCES Flight(Flightnum);
--ALTER TABLE Domestic ADD CONSTRAINT CK_Domestic_Flight CHECK (Flightnum IN (SELECT Flightnum FROM Flight WHERE IsInternational = FALSE));

--------------------------



alter table PaymentTransaction add FOREIGN KEY (BookingID) REFERENCES BookingChannel(BookingID);
--------------------------

 --  International
 CREATE TABLE International (
    Flightnum VARCHAR(50) PRIMARY KEY,
    RequiredExtraSecurity CHAR(1) NOT NULL CHECK (RequiredExtraSecurity IN ('Y', 'N'))
);

alter table International add  FOREIGN KEY (Flightnum) REFERENCES Flight(Flightnum);
--ALTER TABLE Domestic ADD CONSTRAINT CK_Domestic_Flight CHECK (Flightnum IN (SELECT Flightnum FROM Flight WHERE IsInternational = TRUE));
--------------------------


 -- Equipment_Infrastructure
 CREATE TABLE Equipment_Infrastructure (
    CompanyID VARCHAR(50),
    ItemNumber VARCHAR(50),
    DatePurchased DATE,
    PRIMARY KEY (CompanyID, ItemNumber)
);
ALTER TABLE Equipment_Infrastructure ADD FOREIGN KEY (CompanyID) REFERENCES Airlines(CompanyID);
--------------------------


 -- AirlineEmployee
CREATE TABLE AirlineEmployee (
    CompanyID VARCHAR(50),
    EmployeeID VARCHAR(50),
    EmpName VARCHAR(50) NOT NULL,
    PRIMARY KEY (CompanyID, EmployeeID)
);

--ALTER TABLE AirlineEmployee ADD CONSTRAINT unique_EmployeeID UNIQUE (EmployeeID);
--ALTER TABLE AirlineEmployee ADD CONSTRAINT unique_CompanyID UNIQUE (CompanyID);
Alter table AirlineEmployee  add FOREIGN KEY (CompanyID) REFERENCES Airlines(CompanyID);






-- insert statements
INSERT INTO AirlineEmployee VALUES ('A001', 'E001', 'John Patrick');
INSERT INTO AirlineEmployee VALUES ('A001', 'E002', 'James Texera');
INSERT INTO AirlineEmployee VALUES ('A002', 'E003', 'Anne Kelly');
INSERT INTO AirlineEmployee VALUES ('A002', 'E004', 'Rohan Chismark');
INSERT INTO AirlineEmployee VALUES ('A003', 'E005', 'Jackie Myers');
INSERT INTO AirlineEmployee VALUES ('A003', 'E006', 'Tim Patrick');
INSERT INTO AirlineEmployee VALUES ('A004', 'E007', 'Chris Texera');
INSERT INTO AirlineEmployee VALUES ('A004', 'E008', 'John Kelly');
INSERT INTO AirlineEmployee VALUES ('A005', 'E009', 'James Chismark');
INSERT INTO AirlineEmployee VALUES ('A005', 'E010', 'Anne Myers');
INSERT INTO AirlineEmployee VALUES ('A006', 'E011', 'Rohan Patrick');
INSERT INTO AirlineEmployee VALUES ('A006', 'E012', 'Jackie Texera');
INSERT INTO AirlineEmployee VALUES ('A007', 'E013', 'Tim Kelly');
INSERT INTO AirlineEmployee VALUES ('A007', 'E014', 'Chris Chismark');
INSERT INTO AirlineEmployee VALUES ('A008', 'E015', 'John Myers');




--------------------------


-- AirportEmployee
CREATE TABLE AirportEmployee (
    AirportCode VARCHAR(50),
    EmployeeID VARCHAR(50),
    EmpName VARCHAR(50) NOT NULL,
    PRIMARY KEY (AirportCode, EmployeeID)
);

ALTER TABLE AirportEmployee  ADD FOREIGN KEY (AirportCode) REFERENCES Airport(AirportCode);
-----------------------------



 --  AirportInfrastructure
CREATE TABLE AirportInfrastructure (
    AirportCode VARCHAR(50),
  --  Inftype VARCHAR(50) CHECK (Type IN ('Other', 'Gates', 'Runways')),
    Inftype VARCHAR(50) CHECK (Inftype IN ('Other', 'Gates', 'Runways')),
    PRIMARY KEY (AirportCode, Inftype)
);

ALTER  TABLE AirportInfrastructure  ADD FOREIGN KEY (AirportCode) REFERENCES Airport(AirportCode);




-- insert statements:
INSERT INTO AirportInfrastructure VALUES ('JFK', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('JFK', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('LAX', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('LAX', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('ORD', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('ORD', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('SFO', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('SFO', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('BOS', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('BOS', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('YVR', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('YVR', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('EDI', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('EDI', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('SEA', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('ATL', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('ATL', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('DFW', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('DFW', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('DEN', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('DEN', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('MIA', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('MIA', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('LAS', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('LAS', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('ORL', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('ORL', 'Gates');
INSERT INTO AirportInfrastructure VALUES ('PHX', 'Runways');
INSERT INTO AirportInfrastructure VALUES ('PHX', 'Gates');



--------------------------


 -- Passenger_Makes_Booking
 CREATE TABLE Passenger_Makes_Booking (
    PassengerID VARCHAR(50),
    BookingID VARCHAR(50),
    PassLastName VARCHAR(50),
    PRIMARY KEY (PassengerID, BookingID)
);

ALTER TABLE Passenger_Makes_Booking ADD FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID);
ALTER TABLE Passenger_Makes_Booking ADD FOREIGN KEY (BookingID) REFERENCES BookingChannel(BookingID);



-- insert statements
INSERT INTO Passenger_Makes_Booking VALUES ('P1001', 'B1001', 'Satterthwaite');
INSERT INTO Passenger_Makes_Booking VALUES ('P1002', 'B1002', 'Eby');
INSERT INTO Passenger_Makes_Booking VALUES ('P1003', 'B1003', 'Kumar');
INSERT INTO Passenger_Makes_Booking VALUES ('P1004', 'B1004', 'Hoare');
INSERT INTO Passenger_Makes_Booking VALUES ('P1005', 'B1005', 'Satterthwaite');
INSERT INTO Passenger_Makes_Booking VALUES ('P1006', 'B1006', 'Eby');
INSERT INTO Passenger_Makes_Booking VALUES ('P1007', 'B1007', 'Kumar');
INSERT INTO Passenger_Makes_Booking VALUES ('P1008', 'B1008', 'Hoare');
INSERT INTO Passenger_Makes_Booking VALUES ('P1009', 'B1009', 'Satterthwaite');
INSERT INTO Passenger_Makes_Booking VALUES ('P1010', 'B1010', 'Eby');
INSERT INTO Passenger_Makes_Booking VALUES ('P1011', 'B1011', 'Myers');
INSERT INTO Passenger_Makes_Booking VALUES ('P1012', 'B1012', 'Chismark');
INSERT INTO Passenger_Makes_Booking VALUES ('P1013', 'B1013', 'Kelly');
INSERT INTO Passenger_Makes_Booking VALUES ('P1014', 'B1014', 'Patrick');
INSERT INTO Passenger_Makes_Booking VALUES ('P1015', 'B1015', 'Texera');



--------------------------


 -- Passenger_Goes_To_Airport 
 CREATE TABLE Passenger_Goes_To_Airport (
    PassengerID VARCHAR(50),
    AirportCode VARCHAR(50),
    PRIMARY KEY (PassengerID, AirportCode)
);


ALTER TABLE Passenger_Goes_To_Airport ADD FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID);
ALTER TABLE Passenger_Goes_To_Airport ADD FOREIGN KEY (AirportCode) REFERENCES Airport(AirportCode);
--------------------------


 -- Purchase
CREATE TABLE Purchase (
    TransactionID VARCHAR(50) PRIMARY KEY,
    TransTime TIMESTAMP
);

--alter table Purchase add FOREIGN KEY (TransactionID) REFERENCES PaymentTransaction(TransactionID) 
--        CHECK (SELECT Refund FROM PaymentTransaction WHERE TransactionID = Purchase.TransactionID = 'No');
--------------------------



 -- Refund
CREATE TABLE Refund (
    TransactionID VARCHAR(50),
    Reason VARCHAR(50) CHECK (Reason IN ('flight cancellation', 'change of plans')),
    DateIssued TIMESTAMP,
    PRIMARY KEY (TransactionID, Reason)
);

alter table Refund add FOREIGN KEY (TransactionID) REFERENCES PaymentTransaction(TransactionID);



-- insert statements

INSERT INTO Refund VALUES ('TX1001', 'flight cancellation', TO_TIMESTAMP('2024-01-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1002', 'change of plans', TO_TIMESTAMP('2024-02-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1003', 'flight cancellation', TO_TIMESTAMP('2024-03-06 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1004', 'change of plans', TO_TIMESTAMP('2024-03-21 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1005', 'flight cancellation', TO_TIMESTAMP('2024-04-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1006', 'change of plans', TO_TIMESTAMP('2024-05-11 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1007', 'flight cancellation', TO_TIMESTAMP('2024-06-26 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1008', 'change of plans', TO_TIMESTAMP('2024-07-16 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1009', 'flight cancellation', TO_TIMESTAMP('2024-08-23 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1010', 'change of plans', TO_TIMESTAMP('2024-10-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1011', 'flight cancellation', TO_TIMESTAMP('2024-10-11 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1012', 'change of plans', TO_TIMESTAMP('2024-11-16 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1013', 'flight cancellation', TO_TIMESTAMP('2024-12-02 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1014', 'change of plans', TO_TIMESTAMP('2024-12-06 21:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Refund VALUES ('TX1015', 'flight cancellation', TO_TIMESTAMP('2024-12-08 08:00:00', 'YYYY-MM-DD HH24:MI:SS'));



--------------------------
 

 
 -- FlightBooking 
 CREATE TABLE FlightBooking (
    BookingID VARCHAR(50) PRIMARY KEY,
    Airline VARCHAR(50),
    FlightNumber VARCHAR(50),
    FlightDate DATE,
    Origin VARCHAR(50),
    Destination VARCHAR(50),
    NumberOfSeats INT CHECK (NumberOfSeats > 0),
    TransactionID VARCHAR(50)
);

alter table FlightBooking add FOREIGN KEY (TransactionID) REFERENCES PaymentTransaction(TransactionID);
alter table FlightBooking add FOREIGN KEY (Origin) REFERENCES Airport(AirportCode);
alter table FlightBooking add FOREIGN KEY (Destination) REFERENCES Airport(AirportCode);
--------------------------



-----------------------------------------------------------------------------------------------------------------------




 -- Passenger_Makes_Payment
CREATE TABLE Passenger_Makes_Payment (
    PassengerID VARCHAR(50),
    TransactionID VARCHAR(50),
    PaymentTime TIMESTAMP,
    PRIMARY KEY (PassengerID, TransactionID)
);

ALTER TABLE Passenger_Makes_Payment ADD FOREIGN KEY (TransactionID) REFERENCES PaymentTransaction(TransactionID);
ALTER TABLE Passenger_Makes_Payment ADD FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID);
 --------------------------




 -- Passed_Customs
CREATE TABLE Passed_Customs (
    Flightnum VARCHAR(50) PRIMARY KEY,
    AgentTalkedTo VARCHAR(50)
);

ALTER table Passed_Customs add FOREIGN KEY (Flightnum) REFERENCES International(Flightnum);
--ALTER TABLE Domestic ADD CONSTRAINT CK_Domestic_Flight CHECK (Flightnum IN (SELECT Flightnum FROM Flight WHERE IsInternational = TRUE));
--------------------------



 -- Not_Allowed_Entry
 CREATE TABLE Not_Allowed_Entry (
    Flightnum VARCHAR(50) PRIMARY KEY,
    Reason VARCHAR(50),
    AgentTalkedTo VARCHAR(50)
);

ALTER table Not_Allowed_Entry ADD FOREIGN KEY (Flightnum) REFERENCES International(Flightnum);
--ALTER TABLE Domestic ADD CONSTRAINT CK_Domestic_Flight CHECK (Flightnum IN (SELECT Flightnum FROM Flight WHERE IsInternational = TRUE));

--------------------------


 --  Support_Helps_Passengers_Who_Missed_Flight

 CREATE TABLE Support_Helps_Passengers_Who_Missed_Flight (
    PassengerID VARCHAR(50),
    TicketNumber VARCHAR(50),
    CompanyID VARCHAR(50),
    EmployeeID VARCHAR(50),
    TimeHelped TIMESTAMP,
    PRIMARY KEY (PassengerID, TicketNumber, CompanyID, EmployeeID)
);

ALTER TABLE Support_Helps_Passengers_Who_Missed_Flight ADD FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID);
--ALTER TABLE Support_Helps_Passengers_Who_Missed_Flight ADD FOREIGN KEY (EmployeeID) REFERENCES AirlineEmployee(EmployeeID);
--ALTER TABLE Support_Helps_Passengers_Who_Missed_Flight ADD FOREIGN KEY (CompanyID) REFERENCES AirlineEmployee(CompanyID);
ALTER TABLE Support_Helps_Passengers_Who_Missed_Flight ADD FOREIGN KEY (CompanyID, EmployeeID) REFERENCES AirlineEmployee(CompanyID, EmployeeID);
 -------------------------






 -- Support_Rebooks_Flight
 CREATE TABLE Support_Rebooks_Flight (
    CompanyID VARCHAR(50),
    EmployeeID VARCHAR(50),
    BookingID VARCHAR(50),
    TimeRebooked TIMESTAMP,
    PRIMARY KEY (CompanyID, EmployeeID, BookingID)
);

ALTER TABLE Support_Rebooks_Flight ADD FOREIGN KEY (BookingID) REFERENCES BookingChannel(BookingID);
--ALTER TABLE Support_Rebooks_Flight ADD FOREIGN KEY (EmployeeID) REFERENCES AirlineEmployee(EmployeeID);
--ALTER TABLE Support_Rebooks_Flight ADD FOREIGN KEY (CompanyID) REFERENCES AirlineEmployee(CompanyID);
ALTER TABLE Support_Rebooks_Flight ADD FOREIGN KEY (CompanyID, EmployeeID) REFERENCES AirlineEmployee(CompanyID, EmployeeID);

------------------------






 --  Support_Staff_Gate_Agents
 CREATE TABLE Support_Staff_Gate_Agents (
    CompanyID VARCHAR(50),
    EmployeeID VARCHAR(50),
    Title VARCHAR(50) CHECK (Title IN ('Gate Agent', 'Support Staff')),
    PRIMARY KEY (CompanyID, EmployeeID)
);

--ALTER TABLE Support_Staff_Gate_Agents ADD FOREIGN KEY (CompanyID) REFERENCES AirlineEmployee(CompanyID);
--ALTER TABLE Support_Staff_Gate_Agents ADD FOREIGN KEY (EmployeeID) REFERENCES AirlineEmployee(EmployeeID);

ALTER TABLE Support_Staff_Gate_Agents ADD FOREIGN KEY (CompanyID, EmployeeID) REFERENCES AirlineEmployee(CompanyID, EmployeeID);
--------------------------



 --  Flight_Attendants
CREATE TABLE Flight_Attendants (
    CompanyID VARCHAR(50),
    EmployeeID VARCHAR(50),
    Position VARCHAR(50) CHECK (Position IN ('Senior', 'Junior')),
    Seniority INT CHECK (Seniority > 0),
    PRIMARY KEY (CompanyID, EmployeeID)
);

--ALTER TABLE Flight_Attendants ADD FOREIGN KEY (CompanyID) REFERENCES AirlineEmployee(CompanyID);
-- ALTER TABLE Flight_Attendants ADD FOREIGN KEY (EmployeeID) REFERENCES AirlineEmployee(EmployeeID);

ALTER TABLE Flight_Attendants  ADD FOREIGN KEY (CompanyID, EmployeeID) REFERENCES AirlineEmployee(CompanyID, EmployeeID);



-- insert statements
INSERT INTO Flight_Attendants VALUES ('A001', 'E001', 'Senior', 10);
INSERT INTO Flight_Attendants VALUES ('A001', 'E002', 'Junior', 5);
INSERT INTO Flight_Attendants VALUES ('A002', 'E003', 'Senior', 8);
INSERT INTO Flight_Attendants VALUES ('A002', 'E004', 'Junior', 3);
INSERT INTO Flight_Attendants VALUES ('A003', 'E005', 'Senior', 12);
INSERT INTO Flight_Attendants VALUES ('A003', 'E006', 'Junior', 6);
INSERT INTO Flight_Attendants VALUES ('A004', 'E007', 'Senior', 15);
INSERT INTO Flight_Attendants VALUES ('A004', 'E008', 'Junior', 4);
INSERT INTO Flight_Attendants VALUES ('A005', 'E009', 'Senior', 9);
INSERT INTO Flight_Attendants VALUES ('A005', 'E010', 'Junior', 7);
INSERT INTO Flight_Attendants VALUES ('A006', 'E011', 'Senior', 11);
INSERT INTO Flight_Attendants VALUES ('A006', 'E012', 'Junior', 2);
INSERT INTO Flight_Attendants VALUES ('A007', 'E013', 'Senior', 14);
INSERT INTO Flight_Attendants VALUES ('A007', 'E014', 'Junior', 5);
INSERT INTO Flight_Attendants VALUES ('A008', 'E015', 'Senior', 13);

--------------------------


 -- Pilot
 CREATE TABLE Pilot (
    CompanyID VARCHAR(50),
    EmployeeID VARCHAR(50),
    Captain CHAR(1) CHECK (Captain IN ('Y', 'N')),
    YearsExperience INT CHECK (YearsExperience >= 0),
    PRIMARY KEY (CompanyID, EmployeeID)
);

  --ALTER TABLE PILOT ADD FOREIGN KEY (CompanyID) REFERENCES AirlineEmployee(CompanyID);
 -- ALTER TABLE PILOT ADD FOREIGN KEY (EmployeeID) REFERENCES AirlineEmployee(EmployeeID);
ALTER TABLE Pilot  ADD FOREIGN KEY (CompanyID, EmployeeID) REFERENCES AirlineEmployee(CompanyID, EmployeeID);

--------------------------









-- Other
CREATE TABLE Other (
    AirportCode VARCHAR(50),
    InventoryIDnum VARCHAR(50),
    Inftype VARCHAR(50),
    Description VARCHAR(200) NOT NULL,
    PRIMARY KEY (AirportCode, InventoryIDnum, Inftype),
    CONSTRAINT Unique_InventoryIDnum_Airport UNIQUE (AirportCode, InventoryIDnum)
);

--ALTER TABLE Other ADD FOREIGN KEY (AirportCode) REFERENCES AirportInfrastructure (AirportCode);
--ALTER TABLE Other ADD FOREIGN KEY (Inftype) REFERENCES AirportInfrastructure (InfType);

ALTER TABLE Other ADD FOREIGN KEY (AirportCode, Inftype) REFERENCES AirportInfrastructure(AirportCode, Inftype);

--------------------------

-- Gates
CREATE TABLE Gates (
    AirportCode VARCHAR(50) NOT NULL,
    GateNum VARCHAR(50) NOT NULL,
    Occupied CHAR(1)  NOT NULL CHECK (Occupied IN ('Y', 'N')),
    InfType VARCHAR(50),
    GateTime TIMESTAMP NOT NULL,
    PRIMARY KEY (AirportCode, Gatenum),
    FOREIGN KEY (AirportCode, InfType) REFERENCES AirportInfrastructure(AirportCode, InfType)
);

--ALTER TABLE Gates ADD FOREIGN KEY (AirporCode) REFERENCES in AirportInfrastructure(AirporCode);
--ALTER TABLE Gates ADD FOREIGN KEY (InfType) REFERENCES in AirportInfrastructure(InfType);




-- insert statements

INSERT INTO Gates VALUES ('JFK', 'G1', 'N', 'Gates', TO_TIMESTAMP('2024-01-15 07:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('LAX', 'G5', 'N', 'Gates', TO_TIMESTAMP('2024-02-10 08:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('ORD', 'G9', 'N', 'Runways', TO_TIMESTAMP('2024-03-05 06:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('SFO', 'G11', 'N', 'Gates', TO_TIMESTAMP('2024-03-20 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('BOS', 'G13', 'Y', 'Runways', TO_TIMESTAMP('2024-04-12 05:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('YVR', 'G15', 'Y', 'Runways', TO_TIMESTAMP('2024-05-10 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('EDI', 'G17', 'N', 'Gates', TO_TIMESTAMP('2024-06-25 08:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('SEA', 'G19', 'Y', 'Gates', TO_TIMESTAMP('2024-07-15 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('ATL', 'G21', 'N', 'Runways', TO_TIMESTAMP('2024-08-22 06:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('DFW', 'G23', 'Y', 'Gates', TO_TIMESTAMP('2024-09-30 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('DEN', 'G25', 'N', 'Gates', TO_TIMESTAMP('2024-10-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('MIA', 'G27', 'Y', 'Runways', TO_TIMESTAMP('2024-11-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('LAS', 'G29', 'N', 'Gates', TO_TIMESTAMP('2024-12-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('ORL', 'G31', 'Y', 'Runways', TO_TIMESTAMP('2024-12-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Gates VALUES ('PHX', 'G33', 'N', 'Gates', TO_TIMESTAMP('2024-12-07 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));

--------------------------


-- Runways
CREATE TABLE Runways (
    AirportCode VARCHAR(50) NOT NULL,
    RunwayID VARCHAR(50) NOT NULL,
    Inftype VARCHAR(50) NOT NULL,
    TimeUsed TIMESTAMP NOT NULL,
    InUse CHAR(1)  NOT NULL CHECK (InUse IN ('Y', 'N')),
    PRIMARY KEY (AirportCode, RunwayID)
);

--ALTER TABLE Runways ADD FOREIGN KEY (AirportCode) REFERENCES AirportInfrastructure(AirportCode);
--ALTER TABLE Runways ADD FOREIGN KEY (Inftype) REFERENCES AirportInfrastructure(Inftype);

ALTER TABLE Runways ADD FOREIGN KEY (AirportCode, InfType) REFERENCES AirportInfrastructure(AirportCode, InfType);
--------------------------



-- Flight_Attendants_Pilots_Work_Flight
CREATE TABLE Flight_Attendants_Pilots_Work_Flight (
    CompanyID VARCHAR(50),
    EmployeeID VARCHAR(50),
    Flightnum VARCHAR(50),
    Flightdate DATE,
    AirlineName VARCHAR(50),
    PRIMARY KEY (CompanyID, EmployeeID, Flightnum)
 );

--ALTER TABLE Flight_Attendants_Pilots_Work_Flight ADD FOREIGN KEY (CompanyID) REFERENCES Flight_Attendants (CompanyID);
--ALTER TABLE Flight_Attendants_Pilots_Work_Flight ADD FOREIGN KEY (EmployeeID) REFERENCES Flight_Attendants(EmployeeID);
--ALTER TABLE Flight_Attendants_Pilots_Work_Flight ADD FOREIGN KEY (Flightnum) REFERENCES Flight(Flightnum);
ALTER TABLE Flight_Attendants_Pilots_Work_Flight ADD FOREIGN KEY (CompanyID, EmployeeID) REFERENCES Flight_Attendants(CompanyID, EmployeeID);
ALTER TABLE Flight_Attendants_Pilots_Work_Flight ADD FOREIGN KEY (Flightnum, Flightdate) REFERENCES Flight(Flightnum, FlightDate);




-- insert statements
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A001', 'E001', 'F1001', TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Delta');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A001', 'E002', 'F1002', TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'United');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A002', 'E003', 'F1003', TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'Delta');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A002', 'E004', 'F1004', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'United');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A003', 'E005', 'F1005', TO_DATE('2024-04-12', 'YYYY-MM-DD'), 'Delta');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A003', 'E006', 'F1006', TO_DATE('2024-05-10', 'YYYY-MM-DD'), 'United');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A004', 'E007', 'F1007', TO_DATE('2024-06-25', 'YYYY-MM-DD'), 'Delta');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A004', 'E008', 'F1008', TO_DATE('2024-07-15', 'YYYY-MM-DD'), 'United');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A005', 'E009', 'F1009', TO_DATE('2024-08-22', 'YYYY-MM-DD'), 'Delta');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A005', 'E010', 'F1010', TO_DATE('2024-09-30', 'YYYY-MM-DD'), 'United');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A006', 'E011', 'F1011', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'Delta');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A006', 'E012', 'F1012', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 'United');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A007', 'E013', 'F1013', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'Delta');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A007', 'E014', 'F1014', TO_DATE('2024-12-05', 'YYYY-MM-DD'), 'United');
INSERT INTO Flight_Attendants_Pilots_Work_Flight VALUES ('A008', 'E015', 'F1015', TO_DATE('2024-12-07', 'YYYY-MM-DD'), 'Delta');








--------------------------

 --  Ticket
CREATE TABLE Ticket (
    TicketNumber VARCHAR(50) PRIMARY KEY,
    PassengerName VARCHAR(50),
    FlightNum VARCHAR(50),
    SeatNumber VARCHAR(50) CHECK (REGEXP_LIKE (SeatNumber, '^[1-9][0-9]*[A-F]$') OR SeatNumber = 'see gate agent'),
    Class VARCHAR(50) CHECK (Class IN ('First', 'Business', 'Economy')),
    NumberOfBags INT CHECK (NumberOfBags >= 0),
    BoardingTime TIMESTAMP,
    GateNum VARCHAR(50),
    AirportCode VARCHAR(50),
    BoardingGroup VARCHAR(50),
    BookingID VARCHAR(50)
);

ALTER TABLE Ticket ADD CONSTRAINT ticket_seatnumber_unique UNIQUE (SeatNumber);
alter table Ticket add FOREIGN KEY (BookingID) REFERENCES BookingChannel(BookingID);
--alter table Ticket add FOREIGN KEY (Gatenum) REFERENCES Gates(Gatenum);
alter table Ticket add FOREIGN KEY (AirportCode, GateNum) REFERENCES Gates(AirportCode, GateNum);





-- insert statements
INSERT INTO Ticket VALUES ('T1001', 'Danny Satterthwaite', 'F1001', '12A', 'Economy', 1, TO_TIMESTAMP('2024-01-15 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'G1', 'JFK', 'Group 1', 'B1001');
INSERT INTO Ticket VALUES ('T1002', 'Maggie Eby', 'F1002', '14B', 'Business', 2, TO_TIMESTAMP('2024-02-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'G5', 'LAX', 'Group 2', 'B1002');
INSERT INTO Ticket VALUES ('T1003', 'Jamie Kumar', 'F1003', '18C', 'First', 3, TO_TIMESTAMP('2024-03-05 06:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'G1', 'JFK', 'Group 3', 'B1003');
INSERT INTO Ticket VALUES ('T1004', 'Jenn Hoare', 'F1004', '10D', 'Economy', 0, TO_TIMESTAMP('2024-03-20 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'G9', 'ORD', 'Group 4', 'B1004');
INSERT INTO Ticket VALUES ('T1005', 'Sidd Satterthwaite', 'F1005', '8E', 'Business', 1, TO_TIMESTAMP('2024-04-12 06:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'G5', 'LAX', 'Group 5', 'B1005');
INSERT INTO Ticket VALUES ('T1006', 'Mike Eby', 'F1006', '6F', 'Economy', 2, TO_TIMESTAMP('2024-05-10 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'G1', 'JFK', 'Group 6', 'B1006');
INSERT INTO Ticket VALUES ('T1007', 'Danny Kumar', 'F1007', '4A', 'First', 1, TO_TIMESTAMP('2024-06-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'G9', 'ORD', 'Group 7', 'B1007');
INSERT INTO Ticket VALUES ('T1008', 'Maggie Hoare', 'F1008', '2B', 'Economy', 0, TO_TIMESTAMP('2024-07-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'G5', 'LAX', 'Group 8', 'B1008');
INSERT INTO Ticket VALUES ('T1009', 'Jamie Satterthwaite', 'F1009', '3C', 'Business', 1, TO_TIMESTAMP('2024-08-22 06:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'G1', 'JFK', 'Group 9', 'B1009');
INSERT INTO Ticket VALUES ('T1010', 'Jenn Eby', 'F1010', '5D', 'Economy', 2, TO_TIMESTAMP('2024-09-30 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'G9', 'ORD', 'Group 10', 'B1010');
INSERT INTO Ticket VALUES ('T1011', 'Anne Myers', 'F1011', '1A', 'First', 1, TO_TIMESTAMP('2024-10-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'G25', 'DEN', 'Group 11', 'B1011');
INSERT INTO Ticket VALUES ('T1012', 'Rohan Patrick', 'F1012', '7B', 'Economy', 2, TO_TIMESTAMP('2024-11-15 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'G27', 'MIA', 'Group 12', 'B1012');
INSERT INTO Ticket VALUES ('T1013', 'Jackie Texera', 'F1013', '5C', 'Business', 0, TO_TIMESTAMP('2024-12-01 12:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'G29', 'LAS', 'Group 13', 'B1013');
INSERT INTO Ticket VALUES ('T1014', 'Chris Chismark', 'F1014', '9D', 'Economy', 1, TO_TIMESTAMP('2024-12-05 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'G31', 'ORL', 'Group 14', 'B1014');
INSERT INTO Ticket VALUES ('T1015', 'Tim Kelly', 'F1015', '1F', 'Business', 2, TO_TIMESTAMP('2024-12-07 14:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'G33', 'PHX', 'Group 15', 'B1015');



-------------------------


 --Departs_From
 CREATE TABLE Departs_From (
    Flightnum VARCHAR(50) PRIMARY KEY,
    AirportCode VARCHAR(50),
    Gatenum VARCHAR(50)
);

ALTER TABLE Departs_From ADD FOREIGN KEY (Flightnum) REFERENCES Flight(Flightnum);
ALTER TABLE Departs_From ADD FOREIGN KEY (AirportCode) REFERENCES Airport(AirportCode);
--ALTER TABLE Departs_From ADD FOREIGN KEY (Gatenum) REFERENCES Gates(Gatenum);

ALTER TABLE Departs_From ADD FOREIGN KEY (AirportCode, Gatenum) REFERENCES Gates(AirportCode, GateNum);
-------------------------


-- Arrives_At
CREATE TABLE Arrives_At (
    Flightnum VARCHAR(50) PRIMARY KEY,
    AirportCode VARCHAR(50),
    Gatenum VARCHAR(50)
);

ALTER TABLE Arrives_At ADD FOREIGN KEY (Flightnum) REFERENCES Flight(Flightnum);
ALTER TABLE Arrives_At ADD FOREIGN KEY (AirportCode) REFERENCES Airport(AirportCode);
--ALTER TABLE Arrives_At ADD FOREIGN KEY (Gatenum) REFERENCES Gates(Gatenum);

ALTER TABLE Arrives_At  ADD FOREIGN KeY (AirportCode, Gatenum) REFERENCES Gates(AirportCode, GateNum);
-------------------------



-- InAir
CREATE TABLE InAir (
    FlightNumber VARCHAR(50),
    RunwayID VARCHAR(50),
    Dest_Airport_Code  VARCHAR(50),
    InAirTime TIMESTAMP,
    PRIMARY KEY (FlightNumber, RunwayID)
);

ALTER TABLE InAir ADD FOREIGN KEY (FlightNumber) REFERENCES Flight(Flightnum);
ALTER TABLE InAir ADD FOREIGN KEY (Dest_Airport_Code, RunwayID) REFERENCES Runways(AirportCode, RunwayID);
--------------------------



 -- BookingSeatNumbers
 CREATE TABLE BookingSeatNumbers (
    BookingID VARCHAR(50),
    SeatNumber VARCHAR(50),
    Timing TIMESTAMP,
    PRIMARY KEY (BookingID, SeatNumber)
);

ALTER TABLE BookingSeatNumbers ADD FOREIGN KEY (BookingID) REFERENCES BookingChannel(BookingID);
ALTER TABLE BookingSeatNumbers ADD FOREIGN KEY (SeatNumber) REFERENCES Ticket(SeatNumber);
--------------------------
 


 --  TicketSeatNumbers
 CREATE TABLE TicketSeatNumbers (
    TicketNumber VARCHAR(50),
    SeatNumber VARCHAR(50),
    SeatGroup VARCHAR(50),
    PRIMARY KEY (TicketNumber, SeatNumber)
);

ALTER TABLE TicketSeatNumbers ADD FOREIGN KEY (SeatNumber) REFERENCES Ticket(SeatNumber);
ALTER TABLE TicketSeatNumbers ADD FOREIGN KEY (TicketNumber) REFERENCES Ticket(TicketNumber);
--------------------------

 
 
 -- On_No_Fly_List

 CREATE TABLE On_No_Fly_List (
    PassengerID VARCHAR(50),
    TicketNumber VARCHAR(50),
    Reason VARCHAR(50) CHECK (Reason IN ('Security Threat', 'No Valid Documents', 'Fraudulent Activity', 'Other')),
    PRIMARY KEY (PassengerID, TicketNumber)
);

--alter table On_No_Fly_List add FOREIGN KEY (PassengerID) REFERENCES Security(PassengerID);
--alter table On_No_Fly_List add FOREIGN KEY (TicketNumber) REFERENCES Ticket(TicketNumber)


ALTER TABLE On_No_Fly_List ADD FOREIGN KEY (PassengerID, TicketNumber)REFERENCES Security (PassengerID, TicketNumber);

-- insert statements
INSERT INTO On_No_Fly_List VALUES ('P1001', 'T1001', 'Security Threat');
INSERT INTO On_No_Fly_List VALUES ('P1002', 'T1002', 'No Valid Documents');
INSERT INTO On_No_Fly_List VALUES ('P1003', 'T1003', 'Fraudulent Activity');
INSERT INTO On_No_Fly_List VALUES ('P1004', 'T1004', 'Other');
INSERT INTO On_No_Fly_List VALUES ('P1005', 'T1005', 'Other');
INSERT INTO On_No_Fly_List VALUES ('P1006', 'T1006', 'Security Threat');
INSERT INTO On_No_Fly_List VALUES ('P1007', 'T1007', 'No Valid Documents');
INSERT INTO On_No_Fly_List VALUES ('P1008', 'T1008', 'Fraudulent Activity');
INSERT INTO On_No_Fly_List VALUES ('P1009', 'T1009', 'Other');
INSERT INTO On_No_Fly_List VALUES ('P1010', 'T1010', 'Security Threat');
INSERT INTO On_No_Fly_List VALUES ('P1011', 'T1011', 'No Valid Documents');
INSERT INTO On_No_Fly_List VALUES ('P1012', 'T1012', 'Other');
INSERT INTO On_No_Fly_List VALUES ('P1013', 'T1013', 'Fraudulent Activity');
INSERT INTO On_No_Fly_List VALUES ('P1014', 'T1014', 'Security Threat');
INSERT INTO On_No_Fly_List VALUES ('P1015', 'T1015', 'No Valid Documents');








-------------------------
 

 -- Free_To_Fly
 CREATE TABLE Free_To_Fly (
    PassengerID VARCHAR(50),
    TicketNumber VARCHAR(50),
    MakeFlight CHAR(1)  CHECK (MakeFlight IN ('Y', 'N')),
    PRIMARY KEY (PassengerID, TicketNumber)
);


--alter table Free_To_Fly add FOREIGN KEY (PassengerID) REFERENCES Security(PassengerID);
ALTER TABLE Free_To_Fly  ADD FOREIGN KEY (PassengerID, TicketNumber)REFERENCES Security (PassengerID, TicketNumber);
alter table Free_To_Fly add FOREIGN KEY (TicketNumber) REFERENCES Ticket(TicketNumber);
--------------------------







 -- Ticketed_Passengers_and_Workers_Through_Security
 CREATE TABLE Ticketed_Passengers_and_Workers_Through_Security (
    TicketNumber VARCHAR(50),
    PassengerID VARCHAR(50),
    CompanyID VARCHAR(50),
    EmployeeID VARCHAR(50),
    TimeThrough TIMESTAMP,
    PRIMARY KEY (TicketNumber, PassengerID, CompanyID, EmployeeID)
);

ALTER TABLE Ticketed_Passengers_and_Workers_Through_Security ADD FOREIGN KEY (TicketNumber) REFERENCES Ticket (TicketNumber);
ALTER TABLE Ticketed_Passengers_and_Workers_Through_Security ADD FOREIGN KEY (PassengerID) REFERENCES Passenger (PassengerID);
--ALTER TABLE Ticketed_Passengers_and_Workers_Through_Security ADD FOREIGN KEY (EmployeeID) REFERENCES AirlineEmployee (EmployeeID);
--ALTER TABLE Ticketed_Passengers_and_Workers_Through_Security ADD FOREIGN KEY (CompanyID) REFERENCES AirlineEMployee (CompanyID);
ALTER TABLE Ticketed_Passengers_and_Workers_Through_Security ADD FOREIGN KEY (CompanyID, EmployeeID) REFERENCES AirlineEmployee (CompanyID, EmployeeID);

------------------------
 
 

 
 -- Misses_Flight
CREATE TABLE Misses_Flight (
    PassengerID VARCHAR(50),
    TicketNumber VARCHAR(50),
    Reason VARCHAR(50) CHECK (Reason IN ('late arrival', 'personal issues', 'medical emergency', 'weather-related', 'other')),
    WantToRebook CHAR(1)  CHECK (WantToRebook IN ('Y', 'N')),
    PRIMARY KEY (PassengerID, TicketNumber)
);
--alter table Misses_Flight add FOREIGN KEY (PassengerID) REFERENCES Free_To_Fly(PassengerID);
--alter table Misses_Flight add FOREIGN KEY (TicketNumber) REFERENCES Free_To_Fly(TicketNumber);

ALTER TABLE Misses_Flight ADD FOREIGN KEY (PassengerID, TicketNumber) REFERENCES Free_To_Fly (PassengerID, TicketNumber);
-------------------------

 




 -- Set_To_Make_Flight
 CREATE TABLE Set_To_Make_Flight (
    PassengerID VARCHAR(50),
    TicketNumber VARCHAR(50),
    Flightnum VARCHAR(50),
    FlightDate DATE,
    Time TIMESTAMP,
    PRIMARY KEY (PassengerID, TicketNumber, Flightnum)
);

--alter table Set_To_Make_Flight add FOREIGN KEY (PassengerID) REFERENCES Free_To_Fly(PassengerID);
--alter table Set_To_Make_Flight add FOREIGN KEY (TicketNumber) REFERENCES Free_To_Fly(TicketNumber);
--alter table Set_To_Make_Flight add  FOREIGN KEY (Flightnum) REFERENCES Flight(Flightnum);


-- Add foreign key referencing composite key in Flight
ALTER TABLE Set_To_Make_Flight  ADD FOREIGN KEY (Flightnum, FlightDate) REFERENCES Flight (Flightnum, FlightDate);


ALTER TABLE Set_To_Make_Flight ADD FOREIGN KEY (PassengerID, TicketNumber)  REFERENCES Free_To_Fly (PassengerID, TicketNumber);
--------------------------









--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--NEXT STEP, function, procedures, and triggers
-- many of functions use triggers, and many of the triggers use functions --> and the same thing for procedure.
-- THUS, THIS SECTION HAS ALL FUNCTIONS, TRIGGERS AND PROCEDURES ORDERED SO THAT THEY ARE DEFINED BEFRE THEY ARE CALLED



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------

-- FUNCTION getNumberOfFlights
CREATE OR REPLACE FUNCTION getNumberOfFlights(
    origin VARCHAR,
    destination VARCHAR,
    startDate DATE,
    endDate DATE
) RETURN NUMBER IS
    numberOfFlights NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO numberOfFlights
    FROM Flight
    WHERE Origin = origin
      AND Destination = destination
      AND FlightDate BETWEEN startDate AND endDate;

    RETURN numberOfFlights;
END;
/




DECLARE
    flightCount NUMBER;
BEGIN
    flightCount := getNumberOfFlights('LAX', 'JFK', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-31', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Number of flights: ' || flightCount);
END;
/


----------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------


-- FUNCTION getOccupancyRate
CREATE OR REPLACE FUNCTION getOccupancyRate(
    origin VARCHAR,
    destination VARCHAR,
    startDate DATE,
    endDate DATE
) RETURN NUMBER IS
    averageOccupancyRate NUMBER;
BEGIN
    SELECT AVG(Booked / NumberOfSeats * 100)
    INTO averageOccupancyRate
    FROM Flight
    WHERE Origin = origin
      AND Destination = destination
      AND FlightDate BETWEEN startDate AND endDate;

    RETURN averageOccupancyRate;
END;
/


DECLARE
    occupancyRate NUMBER;
BEGIN
    occupancyRate := getOccupancyRate('LAX', 'JFK', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-31', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Occupancy Rate: ' || occupancyRate || '%');
END;
/ 
----------------------------------------------------------------------------------------------------------------------------------


-- FUNCTION flightNumberOfSeatsLeft
CREATE OR REPLACE FUNCTION flightNumberOfSeatsLeft(
    flightNum VARCHAR,
    flightDate DATE
) RETURN NUMBER IS
    numberOfSeatsLeft NUMBER;
BEGIN
    BEGIN
        SELECT SUM(NumberOfSeats) - SUM(Booked)
        INTO numberOfSeatsLeft
        FROM Flight
        WHERE Flightnum = flightNum
          AND FlightDate = flightDate;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            numberOfSeatsLeft := NULL; -- Or set to 0 based on your requirements
    END;

    RETURN numberOfSeatsLeft;
END;
/


DECLARE
    seatsLeft NUMBER;
BEGIN
    seatsLeft := flightNumberOfSeatsLeft('F1001', TO_DATE('2024-01-15', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Seats Left: ' || seatsLeft);
END;
/


----------------------------------------------------------------------------------------------------------------------------------



-- FUNCTION refund
CREATE OR REPLACE FUNCTION refundFlight(
    flightNum VARCHAR,   
    reason VARCHAR
) RETURN VARCHAR IS
    transactionID VARCHAR2(50);
BEGIN
    -- Validate the `reason` value to match the table's `CHECK` constraint
    IF reason NOT IN ('flight cancellation', 'change of plans') THEN
        RETURN 'ERROR: Invalid Reason';
    END IF;

    INSERT INTO Refund (TransactionID, Reason, DateIssued)
    VALUES (SYS_GUID(), reason, SYSDATE)
    RETURNING TransactionID INTO transactionID;

    RETURN transactionID;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'ERROR';
END;
/



SHOW ERRORS FUNCTION refundFlight;




----------------------------------------------------------------------------------------------------------------------------------


-- first create the table outline (strcutred data type) of the avalaible flight info we are going to return
CREATE OR REPLACE TYPE FlightInfo AS OBJECT (
    Flightnum VARCHAR(50),
    Airline VARCHAR(50),
    DepartureTime DATE,
    ArrivalTime DATE,
    SeatsLeft NUMBER
);
/

CREATE OR REPLACE TYPE FlightInfoTable AS TABLE OF FlightInfo;
/


-- Now actually do it 
CREATE OR REPLACE FUNCTION getAvailableFlights(
    P_origin VARCHAR,
    p_destination VARCHAR,
    p_flightDate DATE
) RETURN FlightInfoTable IS
    availableFlights FlightInfoTable := FlightInfoTable();
BEGIN
    SELECT FlightInfo(Flightnum, Airline, DepartureTime, ArrivalTime, NumberOfSeats - Booked)
    BULK COLLECT INTO availableFlights
    FROM Flight
    WHERE Origin = p_origin
      AND Destination = p_destination
      AND FlightDate = p_flightDate
      AND Booked < NumberOfSeats;

    RETURN availableFlights;
END;
/
SHOW ERRORS FUNCTION getAvailableFlights;

-- testing

DECLARE
    availableFlights FlightInfoTable;
BEGIN
    availableFlights := getAvailableFlights('JFK', 'BOS', TO_DATE('2024-01-15', 'YYYY-MM-DD'));

    FOR i IN 1..availableFlights.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Flight Number: ' || availableFlights(i).Flightnum);
        DBMS_OUTPUT.PUT_LINE('Airline: ' || availableFlights(i).Airline);
        DBMS_OUTPUT.PUT_LINE('Departure Time: ' || TO_CHAR(availableFlights(i).DepartureTime, 'YYYY-MM-DD HH24:MI:SS'));
        DBMS_OUTPUT.PUT_LINE('Arrival Time: ' || TO_CHAR(availableFlights(i).ArrivalTime, 'YYYY-MM-DD HH24:MI:SS'));
        DBMS_OUTPUT.PUT_LINE('Seats Left: ' || availableFlights(i).SeatsLeft);
        DBMS_OUTPUT.PUT_LINE('--------------------------');
    END LOOP;
END;
/

--------------------------------------------------------------------------------------------------------------------------------

-- TRIGGER  adjustAvailableSeats
CREATE OR REPLACE TRIGGER adjustAvailableSeats
AFTER UPDATE ON Ticket
FOR EACH ROW
WHEN (NEW.SeatNumber IS NOT NULL OR OLD.SeatNumber IS NOT NULL)
BEGIN
    -- IF booking a new seat, increment the number of booked seats
    IF :NEW.SeatNumber IS NOT NULL AND :OLD.SeatNumber IS NULL THEN
        UPDATE Flight
        SET Booked = Booked + 1
        WHERE Flightnum = :NEW.FlightNum;

    -- IF refunding a seat, decrement the number of booked seats
    ELSIF :NEW.SeatNumber IS NULL AND :OLD.SeatNumber IS NOT NULL THEN
        UPDATE Flight
        SET Booked = Booked - 1
        WHERE Flightnum = :OLD.FlightNum;
    END IF;
  END;
  /



--testing


SELECT Flightnum, Booked FROM Flight WHERE Flightnum = 'F1002';


UPDATE Ticket
SET SeatNumber = NULL
WHERE TicketNumber = 'T1002';


SELECT Flightnum, Booked FROM Flight WHERE Flightnum = 'F1002';

----------------------------------------------------------------------------------------------------------------------------------

-- TRIGGER enforceNoFlyList
CREATE OR REPLACE TRIGGER enforceNoFlyList
BEFORE INSERT ON Passenger_Makes_Booking
FOR EACH ROW
DECLARE
    isOnNoFlyList NUMBER; -- Variable to hold the  result
BEGIN
    SELECT COUNT(*)
    INTO isOnNoFlyList
    FROM On_No_Fly_List
    WHERE PassengerID = :NEW.PassengerID;


    IF isOnNoFlyList > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Passenger is on the no-fly list and cannot book a ticket.');
    END IF;
END;
/

--Generates an error if the passenger is on no fly list
--Testing
INSERT INTO Passenger_Makes_Booking (PassengerID, BookingID, PassLastName)
VALUES ('P1001', 'B1016', 'Satterthwaite');
----------------------------------------------------------------------------------------------------------------------------------



-- TRIGGER auditTrail

-- trable to hold all logged info
CREATE TABLE AuditTrail (
    AuditID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    TableName VARCHAR2(50) NOT NULL,
    OperationType VARCHAR2(10) NOT NULL,
    OldValue VARCHAR2(100),
    NewValue VARCHAR2(100),
    ChangeTimestamp TIMESTAMP DEFAULT SYSTIMESTAMP,
    ChangedBy VARCHAR2(50) DEFAULT USER
);

-- then need one seperate for each table we want to track


CREATE OR REPLACE TRIGGER auditTrailLog_Flight
AFTER INSERT OR UPDATE OR DELETE ON Flight
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO AuditTrail (TableName, OperationType, OldValue, NewValue, ChangeTimestamp, ChangedBy)
        VALUES (
            'Flight',
            'Insert',
            NULL,
            'FlightNum: ' || :NEW.Flightnum || ', Airline: ' || :NEW.Airline,
            SYSTIMESTAMP,
            USER
        );
    ELSIF UPDATING THEN
        INSERT INTO AuditTrail (TableName, OperationType, OldValue, NewValue, ChangeTimestamp, ChangedBy)
        VALUES (
            'Flight',
            'Update',
            'FlightNum: ' || :OLD.Flightnum || ', Airline: ' || :OLD.Airline,
            'FlightNum: ' || :NEW.Flightnum || ', Airline: ' || :NEW.Airline,
            SYSTIMESTAMP,
            USER
        );
    ELSIF DELETING THEN
        INSERT INTO AuditTrail (TableName, OperationType, OldValue, NewValue, ChangeTimestamp, ChangedBy)
        VALUES (
            'Flight',
            'Delete',
            'FlightNum: ' || :OLD.Flightnum || ', Airline: ' || :OLD.Airline,
            NULL,
            SYSTIMESTAMP,
            USER
        );
    END IF;
END;
/
--Testing

UPDATE Flight
SET Status = 'Delayed'
WHERE Flightnum = 'F1001';

SELECT * FROM AuditTrail WHERE TableName = 'Flight';



-- for passenger:
CREATE OR REPLACE TRIGGER auditTrailLog_Passenger
AFTER INSERT OR UPDATE OR DELETE ON Passenger
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO AuditTrail (TableName, OperationType, OldValue, NewValue, ChangeTimestamp, ChangedBy)
        VALUES (
            'Passenger',
            'Insert',
            NULL,
            'PassengerID: ' || :NEW.PassengerID || ', FirstName: ' || :NEW.FirstName || ', LastName: ' || :NEW.LastName,
            SYSTIMESTAMP,
            USER
        );
    ELSIF UPDATING THEN
        INSERT INTO AuditTrail (TableName, OperationType, OldValue, NewValue, ChangeTimestamp, ChangedBy)
        VALUES (
            'Passenger',
            'Update',
            'PassengerID: ' || :OLD.PassengerID || ', FirstName: ' || :OLD.FirstName || ', LastName: ' || :OLD.LastName,
            'PassengerID: ' || :NEW.PassengerID || ', FirstName: ' || :NEW.FirstName || ', LastName: ' || :NEW.LastName,
            SYSTIMESTAMP,
            USER
        );
    ELSIF DELETING THEN
        INSERT INTO AuditTrail (TableName, OperationType, OldValue, NewValue, ChangeTimestamp, ChangedBy)
        VALUES (
            'Passenger',
            'Delete',
            'PassengerID: ' || :OLD.PassengerID || ', FirstName: ' || :OLD.FirstName || ', LastName: ' || :OLD.LastName,
            NULL,
            SYSTIMESTAMP,
            USER
        );
    END IF;
END;
\

-- the analagous holds for booking... it would be exactly the same.
----------------------------------------------------------------------------------------------------------------------------------
 
--TRIGGER  checkOverbooking
CREATE OR REPLACE TRIGGER checkOverbooking
BEFORE INSERT ON FlightBooking
FOR EACH ROW
DECLARE
    seats_left NUMBER; -- Variable to store the result of the function
BEGIN
    -- call function to calculate the number of seats left
    seats_left := flightNumberOfSeatsLeft(:NEW.FlightNumber, :NEW.FlightDate);

    -- check it 
    IF seats_left <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Flight is overbooked and cannot accept more bookings.');
    END IF;
END;
/


SHOW ERRORS TRIGGER checkOverbooking;
----------------------------------------------------------------------------------------------------------------------------------



CREATE OR REPLACE FUNCTION bookFlight(
    passengerName VARCHAR,
    flightNum VARCHAR,
    seatNumber VARCHAR,
    flightDate DATE,
    airlineName VARCHAR
) RETURN VARCHAR2 IS
    bookingID VARCHAR(50);
    ticketNumber VARCHAR(50);
    seatsLeft NUMBER;
BEGIN
    -- Check if seats are available
    seatsLeft := flightNumberOfSeatsLeft(flightNum, flightDate);

    IF seatsLeft <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No seats available on this flight.');
    END IF;

    -- Insert Booking
    bookingID := SYS_GUID();
    INSERT INTO BookingChannel (BookingID, Source)
    VALUES (bookingID, 'Directly');

    -- Insert Ticket
    ticketNumber := SYS_GUID();
    INSERT INTO Ticket (TicketNumber, PassengerName, FlightNum, SeatNumber, Class, NumberOfBags, BoardingTime, GateNum, AirportCode, BoardingGroup, BookingID)
    VALUES (ticketNumber, passengerName, flightNum, seatNumber, 'Economy', 0, NULL, NULL, NULL, 'Group 1', bookingID);

    -- Return Booking ID and Ticket Number
    RETURN 'Booking ID: ' || bookingID || ', Ticket Number: ' || ticketNumber;




END;
/

SHOW ERRORS FUNCTION bookFlight;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--PROCEDURE: See avalaible flights 


CREATE OR REPLACE PROCEDURE seeAvailableFlights(
    p_origin VARCHAR,
    p_destination VARCHAR,
    p_flightDate DATE
) AS
    CURSOR availableFlights IS
        SELECT *
        FROM TABLE(getAvailableFlights(p_origin, p_destination, p_flightDate))
        ORDER BY SeatsLeft DESC;

    flightRecord availableFlights%ROWTYPE;
BEGIN
    -- cursor
    OPEN availableFlights;

    DBMS_OUTPUT.PUT_LINE('Available Flights:');
    LOOP
        FETCH availableFlights INTO flightRecord;
        EXIT WHEN availableFlights%NOTFOUND;

        -- Display flight information
        DBMS_OUTPUT.PUT_LINE('Flight: ' || flightRecord.Flightnum || 
                             ', Airline: ' || flightRecord.Airline || 
                             ', Seats Left: ' || flightRecord.SeatsLeft || 
                             ', Departure: ' || TO_CHAR(flightRecord.DepartureTime, 'YYYY-MM-DD HH24:MI:SS') || 
                             ', Arrival: ' || TO_CHAR(flightRecord.ArrivalTime, 'YYYY-MM-DD HH24:MI:SS'));
    END LOOP;

  
    CLOSE availableFlights;

END;
/


--Testing
BEGIN
    seeAvailableFlights('JFK', 'BOS', TO_DATE('2024-12-15', 'YYYY-MM-DD'));
END;
/


----------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------

--PROCEDURE: See who can work
CREATE OR REPLACE PROCEDURE seeCrewWhoCanWork(
flightDate IN DATE,
airlineName IN VARCHAR2)
AS 
    -- loop through crew and select
    
    CURSOR crew_cursor IS
    --unique
        SELECT DISTINCT FAP.EmployeeID AS AvailableEmployeeID
        FROM Flight_Attendants_Pilots_Work_Flight FAP -- from flight attendants and pilots
	-- for the desired airline
        WHERE FAP.AirlineName = airlineName
	-- THAT ARENT ALREADY WORKING THE FLIGHT
          AND NOT EXISTS (
              SELECT 1
              FROM Flight F
              WHERE F.FlightDate = flightDate
                AND F.Airline = airlineName
                AND EXISTS (
                    SELECT 1
                    FROM Flight_Attendants_Pilots_Work_Flight FAP2
                    WHERE FAP2.Flightnum = F.Flightnum
                      AND FAP2.FlightDate = F.FlightDate
                      AND FAP2.EmployeeID = FAP.EmployeeID
                )
          );
    
    -- holder
    v_employee_id Flight_Attendants_Pilots_Work_Flight.EmployeeID%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Available Crew Members:');


-- loop through and display results
    OPEN crew_cursor;
    LOOP
        FETCH crew_cursor INTO v_employee_id;
        EXIT WHEN crew_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Crew ID: ' || v_employee_id);
    END LOOP;
    CLOSE crew_cursor;
END;
/


SHOW ERRORS PROCEDURE seeCrewWhoCanWork;

--Testing
BEGIN
  seeCrewWhoCanWork(TO_DATE('2024-12-15', 'YYYY-MM-DD'), 'Delta');
END;
/
-----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------


--PROCEDURE TO HANDLE MISSED FLIGHTS


CREATE OR REPLACE PROCEDURE handleMissedFlights(passengerID IN VARCHAR2,
    flightDate IN DATE,
    flightNum IN VARCHAR2
) AS
    origin VARCHAR2(50);
    destination VARCHAR2(50);
    airlineName VARCHAR2(50);
    availableFlights FlightInfoTable := FlightInfoTable();
    bookingDetails VARCHAR2(200);
    refundTransactionID VARCHAR2(50);
BEGIN
    BEGIN
        SELECT Origin, Destination, Airline
        INTO origin, destination, airlineName
        FROM Flight
        WHERE Flightnum = flightNum AND FlightDate = flightDate AND ROWNUM = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Flight not found for the given Flightnum and Date.');
            RETURN;
    END;

    availableFlights := getAvailableFlights(origin, destination, flightDate);

    IF availableFlights.COUNT > 0 THEN
        FOR i IN 1..availableFlights.COUNT LOOP
            BEGIN
                IF availableFlights(i).Flightnum != flightNum AND availableFlights(i).SeatsLeft > 0 THEN
                    DBMS_OUTPUT.PUT_LINE('Attempting to rebook on flight: ' || availableFlights(i).Flightnum ||
                                         ' Airline: ' || availableFlights(i).Airline);

                    bookingDetails := bookFlight(
		    	passengerName => passengerID,
                        flightNum => availableFlights(i).Flightnum,
                        seatNumber => 'see gate agent',
                        flightDate => flightDate,
                        airlineName => availableFlights(i).Airline
                    );

                    DBMS_OUTPUT.PUT_LINE('Passenger successfully rebooked: ' || bookingDetails);
                    RETURN;
                END IF;
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('Failed to book on flight: ' || availableFlights(i).Flightnum || '. Trying next available flight...');
            END;
        END LOOP;
    END IF;

    BEGIN
        refundTransactionID := refundFlight(
            flightNum,
            'Missed flight'
        );

        DBMS_OUTPUT.PUT_LINE('Refund processed successfully. Transaction ID: ' || refundTransactionID);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Refund failed for Passenger ID: ' || passengerID || ' on Flight: ' || flightNum || '. Please contact support.');
    END;
END;
/

SHOW ERRORS PROCEDURE handleMissedFlights;


--Testing
BEGIN
    handleMissedFlights('P1002', TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'F1002');
END;
/

----------------------------------------------------------------------------------------------------------------------------------
--PROCEDURE GET EXECUTIVE SUMMARY

CREATE OR REPLACE PROCEDURE executiveFlightSummary(startDate DATE,
    endDate DATE
) AS

BEGIN
    DBMS_OUTPUT.PUT_LINE('Executive Flight Summary:');
    -- call object sumamry so we can access the results
    FOR summary IN (
        SELECT 
            Origin, Destination,
            
            -- call the get number of flights and get occupacny rate
            getNumberOfFlights(Origin, Destination, startDate, endDate) AS NumberOfFlights,
            getOccupancyRate(Origin, Destination, startDate, endDate) AS AverageOccupancyRate
        FROM Flight

        -- given date range
        WHERE FlightDate BETWEEN startDate AND endDate

        --origin destination pair
        GROUP BY Origin, Destination

    ) 
    -- loop through and print results
    LOOP
        DBMS_OUTPUT.PUT_LINE('Route: ' || summary.Origin || ' to ' || summary.Destination || 
                             ', Number of Flights: ' || summary.NumberOfFlights || 
                             ', Average Occupancy Rate: ' || summary.AverageOccupancyRate || '%');
    END LOOP;
END;
/
SHOW ERRORS PROCEDURE executiveFlightSummary;


--testing
BEGIN
    executiveFlightSummary(TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-31', 'YYYY-MM-DD'));
END;
/
----------------------------------------------------------------------------------------------------------------------------------





---------------

CREATE OR REPLACE TRIGGER sendNotification
AFTER UPDATE OF Status ON Flight
FOR EACH ROW
WHEN (OLD.Status != NEW.Status)
DECLARE
    -- Cursor to fetch passengers from the Ticket table
    CURSOR passengersCursor IS
        SELECT PassengerName, FlightNum
        FROM Ticket
        WHERE FlightNum = :NEW.FlightNum;

    passenger passengersCursor%ROWTYPE;
BEGIN
    -- Loop through all tickets and notify passengers
    OPEN passengersCursor;
    LOOP
        FETCH passengersCursor INTO passenger;
        EXIT WHEN passengersCursor%NOTFOUND;

        -- Output status change notification
        DBMS_OUTPUT.PUT_LINE('Notification to Passenger: ' || passenger.PassengerName ||
                             ' - Flight ' || passenger.FlightNum ||
                             ' has a new status: ' || :NEW.Status);

        -- If the flight is canceled, provide alternative flights
        IF :NEW.Status = 'Cancelled' THEN
            DBMS_OUTPUT.PUT_LINE('Alternative flights are available:');
            seeAvailableFlights(:NEW.Origin, :NEW.Destination, :NEW.FlightDate);
        END IF;
    END LOOP;
    CLOSE passengersCursor;
END;
/



SHOW ERRORS TRIGGER sendNotification;

DROP TRIGGER sendNotification;
COMMIT;

DROP TRIGGER adjustAvailableSeats;
DROP TRIGGER enforceNoFlyList;
DROP TRIGGER auditTrailLog_Flight;
DROP TRIGGER auditTrailLog_Passenger;
COMMIT;

----------------------------------------------------------------------------------------------------------------------------------


-- Packages

----------------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE PACKAGE quickNumbersandFact AS
    
    -- function to get number of flights
    FUNCTION getNumberOfFlights(
        origin VARCHAR,
        destination VARCHAR,
        startDate DATE,
        endDate DATE
    ) RETURN NUMBER;

    -- function avg occupeancy rate 
    FUNCTION getOccupancyRate(
        origin VARCHAR,
        destination VARCHAR,
        startDate DATE,
        endDate DATE
    ) RETURN NUMBER;

    -- function to get number of seats left on a flgith
    FUNCTION flightNumberOfSeatsLeft(
        flightNum VARCHAR,
        flightDate DATE
    ) RETURN NUMBER;

    -- function to get an executive summmary of flight info (pretty much everything abobe)
    PROCEDURE executiveFlightSummary(
        startDate DATE,
        endDate DATE
    );
END quickNumbersandFact;
/


-- body holding the actual logic 
CREATE OR REPLACE PACKAGE BODY quickNumbersandFact AS


-- getNumberOfFlights    
    FUNCTION getNumberOfFlights(
        origin VARCHAR,
        destination VARCHAR,
        startDate DATE,
        endDate DATE
    ) RETURN NUMBER IS
        numberOfFlights NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO numberOfFlights
        FROM Flight
        WHERE Origin = origin
          AND Destination = destination
          AND FlightDate BETWEEN startDate AND endDate;

        RETURN numberOfFlights;
    END getNumberOfFlights;




    -- getOccupancyRate
    FUNCTION getOccupancyRate(
        origin VARCHAR,
        destination VARCHAR,
        startDate DATE,
        endDate DATE
    ) RETURN NUMBER IS
        averageOccupancyRate NUMBER;
    BEGIN
        SELECT AVG(Booked / NumberOfSeats * 100)
        INTO averageOccupancyRate
        FROM Flight
        WHERE Origin = origin
          AND Destination = destination
          AND FlightDate BETWEEN startDate AND endDate;

        RETURN averageOccupancyRate;
    END getOccupancyRate;




-- flightNumberOfSeatsLeft
    FUNCTION flightNumberOfSeatsLeft(
        flightNum VARCHAR,
        flightDate DATE
    ) RETURN NUMBER IS
        numberOfSeatsLeft NUMBER;
    BEGIN
        SELECT NumberOfSeats - Booked
        INTO numberOfSeatsLeft
        FROM Flight
        WHERE Flightnum = flightNum
          AND FlightDate = flightDate;

        RETURN numberOfSeatsLeft;
    END flightNumberOfSeatsLeft;



-- executiveFlightSummary
    PROCEDURE executiveFlightSummary(
        startDate DATE,
        endDate DATE
    ) AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Executive Flight Summary:');
        
        FOR summary IN (
            SELECT 
                Origin, 
                Destination,
                quickNumbersandFact.getNumberOfFlights(Origin, Destination, startDate, endDate) AS NumberOfFlights,
                quickNumbersandFact.getOccupancyRate(Origin, Destination, startDate, endDate) AS AverageOccupancyRate
            FROM Flight
            WHERE FlightDate BETWEEN startDate AND endDate
            GROUP BY Origin, Destination
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Route: ' || summary.Origin || ' to ' || summary.Destination || 
                ', Number of Flights: ' || summary.NumberOfFlights || 
                ', Average Occupancy Rate: ' || summary.AverageOccupancyRate || '%'
            );
        END LOOP;
    END executiveFlightSummary;

END quickNumbersandFact;
/


-- testing (using exectuive summary as it calls the other functions)
BEGIN
    quickNumbersandFact.executiveFlightSummary(TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-31', 'YYYY-MM-DD'));
END;
/

---------------------------------

-- Second package

CREATE OR REPLACE PACKAGE flightInfoandHandling AS
    

    -- refund function
    FUNCTION refundFlight(
        flightNum VARCHAR,
        reason VARCHAR
    ) RETURN VARCHAR;

    -- function to get avaialbe flights
    FUNCTION getAvailableFlights(
       p_origin VARCHAR,
        p_destination VARCHAR,
        p_flightDate DATE
    ) RETURN FlightInfoTable;


    -- function to book flight
    FUNCTION bookFlight(
        passengerName VARCHAR,
        flightNum VARCHAR,
        seatNumber VARCHAR,
        flightDate DATE,
        airlineName VARCHAR
    ) RETURN VARCHAR2;

  -- procedure that handles missed flights
    PROCEDURE handleMissedFlights(
        passengerID IN VARCHAR2,
        flightDate IN DATE,
        flightNum IN VARCHAR2
    );

    -- see avaiable flights procedure
    PROCEDURE seeAvailableFlights(
        p_origin VARCHAR,
        p_destination VARCHAR,
        p_flightDate DATE
    );
END flightInfoandHandling;
/

-- body
CREATE OR REPLACE PACKAGE BODY flightInfoandHandling AS



    -- refundFlight
    FUNCTION refundFlight(
        flightNum VARCHAR,
        reason VARCHAR
    ) RETURN VARCHAR IS
        transactionID VARCHAR(50);
    BEGIN
        IF reason NOT IN ('flight cancellation', 'change of plans') THEN
            RETURN 'ERROR: Invalid Reason';
        END IF;

        INSERT INTO Refund (TransactionID, Reason, DateIssued)
        VALUES (SYS_GUID(), reason, SYSDATE)
        RETURNING TransactionID INTO transactionID;

        RETURN transactionID;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 'ERROR';
    END refundFlight;





    -- getAvailableFlights
    FUNCTION getAvailableFlights(
        p_origin VARCHAR,
        p_destination VARCHAR,
        p_flightDate DATE
    ) RETURN FlightInfoTable IS
        availableFlights FlightInfoTable := FlightInfoTable();
    BEGIN
        SELECT FlightInfo(Flightnum, Airline, DepartureTime, ArrivalTime, NumberOfSeats - Booked)
        BULK COLLECT INTO availableFlights
        FROM Flight
        WHERE Origin = p_origin
          AND Destination = p_destination
          AND FlightDate = p_flightDate
          AND Booked < NumberOfSeats;

        RETURN availableFlights;
    END getAvailableFlights;







    -- bookFlight
    FUNCTION bookFlight(
        passengerName VARCHAR,
        flightNum VARCHAR,
        seatNumber VARCHAR,
        flightDate DATE,
        airlineName VARCHAR
    ) RETURN VARCHAR2 IS
        bookingID VARCHAR(50);
        ticketNumber VARCHAR(50);
        seatsLeft NUMBER;
    BEGIN
        seatsLeft := quickNumbersandFact.flightNumberOfSeatsLeft(flightNum, flightDate);

        IF seatsLeft <= 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'No seats available on this flight.');
        END IF;

        bookingID := SYS_GUID();
        INSERT INTO BookingChannel (BookingID, Source)
        VALUES (bookingID, 'Directly');

        ticketNumber := SYS_GUID();
        INSERT INTO Ticket (TicketNumber, PassengerName, FlightNum, SeatNumber, Class, NumberOfBags, BoardingTime, GateNum, AirportCode, BoardingGroup, BookingID)
        VALUES (ticketNumber, passengerName, flightNum, seatNumber, 'Economy', 0, NULL, NULL, NULL, 'Group 1', bookingID);

        RETURN 'Booking ID: ' || bookingID || ', Ticket Number: ' || ticketNumber;
    END bookFlight;







    -- handleMissedFlights
    PROCEDURE handleMissedFlights(
        passengerID IN VARCHAR2,
        flightDate IN DATE,
        flightNum IN VARCHAR2
    ) AS
        origin VARCHAR2(50);
        destination VARCHAR2(50);
        airlineName VARCHAR2(50);
        availableFlights FlightInfoTable := FlightInfoTable();
        bookingDetails VARCHAR2(200);
        refundTransactionID VARCHAR2(50);
    BEGIN
        BEGIN
            SELECT Origin, Destination, Airline
            INTO origin, destination, airlineName
            FROM Flight
            WHERE Flightnum = flightNum AND FlightDate = flightDate;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Flight not found for the given Flightnum and Date.');
                RETURN;
        END;

        availableFlights := getAvailableFlights(origin, destination, flightDate);

        IF availableFlights.COUNT > 0 THEN
            FOR i IN 1..availableFlights.COUNT LOOP
                BEGIN
                    IF availableFlights(i).Flightnum != flightNum AND availableFlights(i).SeatsLeft > 0 THEN
                        DBMS_OUTPUT.PUT_LINE('Attempting to rebook on flight: ' || availableFlights(i).Flightnum ||
                                             ' Airline: ' || availableFlights(i).Airline);

                        bookingDetails := bookFlight(
                            passengerName => passengerID,
                            flightNum => availableFlights(i).Flightnum,
                            seatNumber => 'see gate agent',
                            flightDate => flightDate,
                            airlineName => availableFlights(i).Airline
                        );

                        DBMS_OUTPUT.PUT_LINE('Passenger successfully rebooked: ' || bookingDetails);
                        RETURN;
                    END IF;
                EXCEPTION
                    WHEN OTHERS THEN
                        DBMS_OUTPUT.PUT_LINE('Failed to book on flight: ' || availableFlights(i).Flightnum || '. Trying next available flight...');
                END;
            END LOOP;
        END IF;

        BEGIN
            refundTransactionID := refundFlight(
                flightNum,
                'Missed flight'
            );

            DBMS_OUTPUT.PUT_LINE('Refund processed successfully. Transaction ID: ' || refundTransactionID);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Refund failed for Passenger ID: ' || passengerID || ' on Flight: ' || flightNum || '. Please contact support.');
        END;
    END handleMissedFlights;






  -- seeAvailableFlights
    PROCEDURE seeAvailableFlights(
        p_origin VARCHAR,
        p_destination VARCHAR,
        p_flightDate DATE
    ) AS
        CURSOR availableFlights IS
            SELECT *
            FROM TABLE(getAvailableFlights(p_origin,p_destination,p_flightDate))
            ORDER BY SeatsLeft DESC;

        flightRecord availableFlights%ROWTYPE;
    BEGIN
        OPEN availableFlights;

        DBMS_OUTPUT.PUT_LINE('Available Flights:');
        LOOP
            FETCH availableFlights INTO flightRecord;
            EXIT WHEN availableFlights%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Flight: ' || flightRecord.Flightnum || 
                                 ', Airline: ' || flightRecord.Airline || 
                                 ', Seats Left: ' || flightRecord.SeatsLeft || 
                                 ', Departure: ' || TO_CHAR(flightRecord.DepartureTime, 'YYYY-MM-DD HH24:MI:SS') || 
                                 ', Arrival: ' || TO_CHAR(flightRecord.ArrivalTime, 'YYYY-MM-DD HH24:MI:SS'));
        END LOOP;

        CLOSE availableFlights;
    END seeAvailableFlights;

END flightInfoandHandling;
/

SHOW ERRORS PACKAGE BODY flightInfoandHandling;

-- example testing

BEGIN
    flightInfoandHandling.seeAvailableFlights('JFK', 'LAX', TO_DATE('2024-12-15', 'YYYY-MM-DD'));
END;
/


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DROP EVERYTHING

------------------------------------------------------------------------------------------------------------------------------------

-- tables
DROP TABLE BookingChannel  CASCADE CONSTRAINTS;
DROP TABLE Security  CASCADE CONSTRAINTS;
DROP TABLE Flight CASCADE CONSTRAINTS;
DROP TABLE Airlines  CASCADE CONSTRAINTS;
DROP TABLE Airport CASCADE CONSTRAINTS;
DROP TABLE Passenger CASCADE CONSTRAINTS;
DROP TABLE Source_Directly CASCADE CONSTRAINTS;
DROP TABLE Source_Booking_Site CASCADE CONSTRAINTS;
DROP TABLE Source_On_Location CASCADE CONSTRAINTS;
DROP TABLE PaymentTransaction CASCADE CONSTRAINTS;
DROP TABLE Domestic CASCADE CONSTRAINTS;
DROP TABLE International CASCADE CONSTRAINTS;
DROP TABLE Equipment_Infrastructure CASCADE CONSTRAINTS;
DROP TABLE AirlineEmployee CASCADE CONSTRAINTS;
DROP TABLE AirportEmployee CASCADE CONSTRAINTS;
DROP TABLE AirportInfrastructure CASCADE CONSTRAINTS;
DROP TABLE Passenger_Makes_Booking CASCADE CONSTRAINTS;
DROP TABLE Passenger_Goes_To_Airport CASCADE CONSTRAINTS;
DROP TABLE Purchase CASCADE CONSTRAINTS;
DROP TABLE Refund CASCADE CONSTRAINTS;
DROP TABLE FlightBooking CASCADE CONSTRAINTS;
DROP TABLE Passenger_Makes_Payment  CASCADE CONSTRAINTS;
DROP TABLE Passed_Customs  CASCADE CONSTRAINTS;
DROP TABLE Not_Allowed_Entry  CASCADE CONSTRAINTS;
DROP TABLE Support_Helps_Passengers_Who_Missed_Flight  CASCADE CONSTRAINTS;
DROP TABLE Support_Rebooks_Flight  CASCADE CONSTRAINTS;
DROP TABLE Support_Staff_Gate_Agents  CASCADE CONSTRAINTS;
DROP TABLE Flight_Attendants  CASCADE CONSTRAINTS;
DROP TABLE Pilot  CASCADE CONSTRAINTS;
DROP TABLE Other  CASCADE CONSTRAINTS;
DROP TABLE Gates  CASCADE CONSTRAINTS;
DROP TABLE Runways  CASCADE CONSTRAINTS;
DROP TABLE Flight_Attendants_Pilots_Work_Flight  CASCADE CONSTRAINTS;
DROP TABLE Ticket  CASCADE CONSTRAINTS;
DROP TABLE Departs_From  CASCADE CONSTRAINTS;
DROP TABLE Arrives_At  CASCADE CONSTRAINTS;
DROP TABLE InAir  CASCADE CONSTRAINTS;
DROP TABLE BookingSeatNumbers  CASCADE CONSTRAINTS;
DROP TABLE TicketSeatNumbers  CASCADE CONSTRAINTS;
DROP TABLE On_No_Fly_List  CASCADE CONSTRAINTS;
DROP TABLE Free_To_Fly  CASCADE CONSTRAINTS;
DROP TABLE Ticketed_Passengers_and_Workers_Through_Security  CASCADE CONSTRAINTS;
DROP TABLE Misses_Flight  CASCADE CONSTRAINTS;
DROP TABLE Set_To_Make_Flight  CASCADE CONSTRAINTS;
--flight info table we created in the procedures sections 
DROP TYPE FlightInfoTable;
DROP TYPE FlightInfo;
--for the audit trail trigger
DROP TABLE AuditTrail CASCADE CONSTRAINTS;


--indexes
--DROP INDEX flight_date_idx; already dropped above
DROP INDEX idx_PassengerCluster;
DROP CLUSTER PassengerCluster;

-- procedures and functions
DROP FUNCTION getNumberOfFlights;
DROP FUNCTION getOccupancyRate;
DROP FUNCTION flightNumberOfSeatsLeft;
DROP FUNCTION refundFlight;
DROP FUNCTION getAvailableFlights;
DROP FUNCTION bookFlight;
DROP PROCEDURE seeAvailableFlights;
DROP PROCEDURE seeCrewWhoCanWork;
DROP PROCEDURE handleMissedFlights;
DROP PROCEDURE executiveFlightSummary;

--triggers
-- dropped earlier
-- drop packages
DROP PACKAGE quickNumbersandFact; 
DROP PACKAGE flightInfoandHandling;

COMMIT;
