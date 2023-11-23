-- QUERIES TO RETRIVE DATA

-- Query 1 - 	SCENARIO: 	Asked to present all dog names and their owners.
SELECT D.DogName, O.OwnerName
FROM Owners O
JOIN Ownership OW ON O.OwnerID = OW.OwnerID
JOIN Dogs d ON OW.DogID = d.DogID;

-- Query 2 -  	SCENARIO: 	Owner arrives and gives their name and I have to find the correct dog or dogs.
-- 							In this example, Anne-Marie would like to collect her dogs. 
SELECT D.DogName, O.OwnerName
FROM Owners O
JOIN Ownership OW ON O.OwnerID = OW.OwnerID
JOIN Dogs D ON OW.DogID = D.DogID
WHERE O.OwnerName = 'Anne-Marie';

-- Query 3 -	 SCENARIO: 	A member of staff is enquiring about the dogs that they have worked with. 
-- 							They presented their staff ID (3) and I seatched for the ID of dogs on their shifts.
SELECT DISTINCT V.DogID
FROM StaffSchedule SS
JOIN Visits V ON SS.WorkingDate = V.VisitDate
WHERE SS.StaffID = (SELECT StaffID FROM Staff WHERE StaffID = 3);

-- Query 4 - 	 SCENARIO: 	An incident took place on 20th August 2023, I would like to find out which dogs were present.
SELECT D.DogName
FROM Dogs D
JOIN Visits V on D.DogID = V.DogID
WHERE V.VisitDate = '2023-08-20';

-- Query 5 -	 SCENARIO:  I would like to check all of the days that staff member (ID#5) worked with dog (ID#6).
SELECT DISTINCT SS.WorkingDate
FROM StaffSchedule SS
JOIN Visits V ON SS.WorkingDate = V.VisitDate
JOIN Dogs D ON V.DogID = D.DogID
JOIN Staff S ON SS.StaffID = S.StaffID
WHERE S.StaffID = 5 AND D.DogID = 6;

-- Query 6 - 	 SCENARIO: 	It's time for the dogs to go home and I am checking the dog register against their owner.
SELECT D.DogName, O.OwnerName
FROM Dogs D 
LEFT JOIN Ownership OW ON D.DogID = OW.DogID
LEFT JOIN Owners O ON OW.OwnerID = O.OwnerID;

-- QUERIES TO INSERT DATA

-- Query 1 -	  SCENARIO: A new dog has registered for Doggy Day Care, I would like to add the dog's details to the dog table.
INSERT INTO Dogs (DogID, DogName, Breed, Weight, Age, SpecialInstructions)
VALUES
(11, 	'Floppy',	'Bull Dog',	 NULL,	10, 'Only sleeps with this teddy bear');

-- Query 2 - 	 SCENARIO: As Floppy the Bull dog's owner is not yet in the database , I am adding a new owner to the owner table.
INSERT INTO Owners (OwnerID, OwnerName, Phone, Email)
VALUES
(8, 	'Fred', 	07937290187,	'fred@dogz.com');

-- Query 3 - 	 SCENARIO: Now that Floppy and Fred are in the database, I am updating the ownership table.
INSERT INTO Ownership (OwnerID, DogID)
VALUES
(8,11);

-- Query 4 - 	 SCENARIO: Floppy had her first visit to Doggy Day Care on 1st September 2023, I am now updating the visit table.
INSERT INTO Visits (VisitID, DogID, VisitDate)
VALUES
(16,	 11,	'2023-09-1');

-- QUERY TO DELETE DATA

-- Query 1 -  	SCENARIO: Sadly, Piddles the dog passed away and must be removed from the dog table.
DELETE FROM Dogs WHERE DogName = 'Piddles';
-- 				SCENARIO: As Piddles is no longer with us, her owner, Katie, must also be removed from the database.
DELETE FROM Owners WHERE OwnerName = 'Katie';
-- 				 SCENARIO: After deleting Piddles and Katie, I am checking to see if Katie owns any other dogs in the day care. 
SELECT COUNT(*) FROM Dogs WHERE OwnerName = 'Katie';

-- AGGREGATE FUNCTION

-- Query 1 -	SCENARIO: 	I would like to check how many dogs are present on each date. 
SELECT V.VisitDate, COUNT(*) AS DogCount
FROM Visits V
GROUP BY V.VisitDate;

-- Query 2 - 	SCENARIO:	I would like to count how many staff members were present on each date
SELECT SS.WorkingDate, COUNT(*) AS StaffCount
FROM StaffSchedule SS
GROUP BY SS.Workingdate;

-- Query 3 - 	SCENARIO:	I would like to find the maximum weight of each dog breed in our database. 
SELECT D.Breed, MAX(D.Weight) AS MaxWeight	-- use of inbuilt function (MAX)
FROM Dogs D
GROUP BY D.Breed;

-- Query 4 - 	SCENARIO:	I would like to find the minimum weight of each dog breed in our database. 
SELECT D.Breed, MIN(D.Weight) AS MinWeight	-- use of inbuilt function (MIN)
FROM Dogs D
GROUP BY D.Breed;

-- ORDER BY
-- Query 1 - 	SCENARIO:	In order to provide suitable play partners, I would like to order the dogs by age. 
SELECT DogName, Age
FROM Dogs
ORDER BY Age;

-- Query 2 - 	SCENARIO:	In order to provide the correct ratio of dog food, I would like to order the dogs by weight. 
SELECT DogName, Weight
FROM Dogs
ORDER BY Weight;

-- CREATE/USE A STORED PROCEDURE
-- Query 1 - 	SCENARIO:	I would like to extract all of the information for a single dog. 
-- 							In order to do so, I have created a procedure. 
DELIMITER //
CREATE PROCEDURE GetDogInfo(IN Dog_Name VARCHAR(50))
BEGIN
	SELECT *
	FROM Dogs
	WHERE DogName = Dog_Name;
END;
--  			SCENARIO: 	I am using the procedure to get all of the information about Toby.
CALL GetDogInfo('Toby');
// DELIMITER 

-- Query 2 - 	SCENARIO:	I would like to extract all of the information about a single owner.
-- 							I have created a procedure in order to do this. 
DELIMITER //
CREATE PROCEDURE GetOwnerInfo(IN Owner_Name VARCHAR(50))
BEGIN
	SELECT *
    FROM Owners
    WHERE OwnerName = Owner_Name;
END;
-- 				SCENARIO:	I am using the procedure to get all of the information about Charlotte from the database.
CALL GetOwnerInfo('Charlotte');
// DELIMITER 

-- CREATE A VEIW TABLE THAT DOES NOT IMPACT THE DATA BASE
-- Query 1 -- Scenario: I would like to display the details of the dog beside the owners details.
CREATE VIEW DogOwners AS
SELECT D.DogName, O.OwnerName, O.Phone, O.Email
FROM Dogs D
JOIN Ownership OW ON D.DogID = OW.DogID
JOIN Owners O ON OW.OwnerID = O.OwnerID;

-- RUNNING THE VEIW TABLE
SELECT * FROM DogOwners;





