-- I have created a database for a Doggy Day Care company. 
-- In this database I have held information about the dogs and contact details for their ownsers.
-- The dogs and owners are linked by their IDs in the ownership table. 
-- I have also created a staff table for employees working at the doggy day care as well as records of their working days. 
-- There is also a table about the days that the dogs were in the day care.
-- This database would be used if someone was to set up a doggy day care buisness and wanted to keep track of dogs, owners, ownership and staff. 
-- I have normalised the data by minimizing data duplication by created seperate tables for dogs, owners, ownership and visits. 
-- I have used the queries to show how this data base could be used in real life scenerios. 

-- Create database
CREATE DATABASE doggy_day_care;

-- Identify the database being used
USE doggy_day_care;

-- Create the Dogs table
CREATE TABLE Dogs (
    DogID INT PRIMARY KEY NOT NULL,
    DogName VARCHAR(50) NOT NULL,
    Breed VARCHAR(50) DEFAULT ('Unknown Breed'),	-- Default constraint added incase owner does not know breed
    Weight FLOAT(1), -- In KG
    Age INT,
    SpecialInstructions TEXT DEFAULT ('No Special Instructions')	-- Default constraint added if the dog does not have special instructions
);

-- Create the Owners table
CREATE TABLE Owners(
    OwnerID INT PRIMARY KEY NOT NULL,
    OwnerName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL UNIQUE,		-- 2 constraints added	
    Email VARCHAR(100) UNIQUE
);

-- Create ownership table
CREATE TABLE Ownership (
	OwnerID INT,
    DogID INT,
    PRIMARY KEY (OwnerID, DogID),
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID),
    FOREIGN KEY (DogID) REFERENCES Dogs(DogID)
    );

CREATE TABLE Visits (
    VisitID INT PRIMARY KEY NOT NULL,
    VisitDate DATE NOT NULL,	-- Use of inbuilt functin (DATE)
    DogID INT NOT NULL, -- Foreign key to the Dogs table
    FOREIGN KEY (DogID) REFERENCES Dogs(DogID)
);

-- Create the Staff table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    StaffName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

-- Create the StaffSchedule table to store staff schedules
CREATE TABLE StaffSchedule (
    ScheduleID INT PRIMARY KEY KEY AUTO_INCREMENT, 
    StaffID INT, -- Foreign key to the Staff table
    WorkingDate DATE,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
