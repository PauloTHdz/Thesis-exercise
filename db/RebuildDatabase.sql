USE master
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ThesisExercise')
BEGIN
  CREATE DATABASE ThesisExercise;
END
GO

USE ThesisExercise
GO

-- Drop Tables --

IF OBJECT_ID('RamConfigurations', 'U') IS NOT NULL 
	DROP TABLE dbo.RamConfigurations;

IF OBJECT_ID('PortConfigurations', 'U') IS NOT NULL 
	DROP TABLE dbo.PortConfigurations;

IF OBJECT_ID('Processors', 'U') IS NOT NULL 
	DROP TABLE dbo.Processors;

IF OBJECT_ID('StorageDevices', 'U') IS NOT NULL 
	DROP TABLE dbo.StorageDevices;
	

IF OBJECT_ID('ComputerConfigurations', 'U') IS NOT NULL 
	DROP TABLE dbo.ComputerConfigurations;


-- Create Schema --

CREATE TABLE RamConfigurations (
    RamId INT IDENTITY(1,1) PRIMARY KEY,
    Capacity INT NOT NULL,
    Unit NVARCHAR(2) DEFAULT 'GB' NOT NULL,
    CONSTRAINT UQ_RamConfigurations_Capacity_Unit UNIQUE (Capacity, Unit)
);

CREATE TABLE StorageDevices (
    StorageId INT IDENTITY(1,1) PRIMARY KEY,
    Capacity INT NOT NULL,
    Unit NVARCHAR(2) NOT NULL,
    Type NVARCHAR(5) NOT NULL,
    CONSTRAINT UQ_StorageDevices_Capacity_Unit_Type UNIQUE (Capacity, Unit, Type)
);

CREATE TABLE Processors (
    ProcessorId INT IDENTITY(1,1) PRIMARY KEY,
    Manufacturer NVARCHAR(30) NOT NULL,
    Description NVARCHAR(160) NOT NULL,
    CONSTRAINT UQ_Processors_Manufacturer_Family_Model UNIQUE (Manufacturer, Description)
);

CREATE TABLE ComputerConfigurations (
    ConfigId INT IDENTITY(1,1) PRIMARY KEY,
    RamId INT NOT NULL,
    StorageId INT NOT NULL,
    ProcessorId INT NOT NULL,
    CONSTRAINT FK_ComputerConfigurations_RamConfigurations FOREIGN KEY (RamId) REFERENCES RamConfigurations(RamId),
    CONSTRAINT FK_ComputerConfigurations_StorageDevices FOREIGN KEY (StorageId) REFERENCES StorageDevices(StorageId),
    CONSTRAINT FK_ComputerConfigurations_Processors FOREIGN KEY (ProcessorId) REFERENCES Processors(ProcessorId)
);

CREATE TABLE PortConfigurations (
    PortConfigId INT IDENTITY(1,1) PRIMARY KEY,
	ConfigId INT NOT NULL,
    PortType NVARCHAR(20) NOT NULL,  -- e.g., 'USB 2.0', 'USB 3.0', 'USB C'
    PortCount INT NOT NULL DEFAULT 0,
    CONSTRAINT FK_PortConfigurations_ComputerConfigurations FOREIGN KEY (ConfigId) REFERENCES ComputerConfigurations(ConfigId),
    CONSTRAINT CK_PortConfigurations_PortCount CHECK (PortCount >= 0)
);



-- Insert Data --

-- Insert RAM Configurations
INSERT INTO RamConfigurations (Capacity, Unit) VALUES
    (8, 'GB'),
    (16, 'GB'),
    (32, 'GB'),
    (2, 'GB'),
    (512, 'MB');

-- Insert Storage Devices
INSERT INTO StorageDevices (Capacity, Unit, Type) VALUES
    (1, 'TB', 'SSD'),
    (2, 'TB', 'HDD'),
    (3, 'TB', 'HDD'),
    (4, 'TB', 'HDD'),
    (750, 'GB', 'SSD'),
    (500, 'GB', 'SSD'),
    (80, 'GB', 'SSD');

-- Insert Processors
INSERT INTO Processors (Manufacturer, Description) VALUES
    ('Intel', 'Celeron N3050 Processor'),
    ('AMD', 'FX 4300 Processor'),
    ('AMD', 'Athlon Quad-Core APU Athlon 5150'),
    ('AMD', 'FX 8-Core Black Edition FX-8350'),
    ('AMD', 'FX 8-Core Black Edition FX-8370'),
    ('Intel', 'Core i7 6700K 4GHz Processor'),
    ('Intel', 'Core i5 6400 Processor'),
    ('Intel', 'Core i7 Extreme Edition 3 GHz Processor');

-- Insert Computer Configurations
INSERT INTO ComputerConfigurations (RamId, StorageId, ProcessorId) VALUES
    (1, 1, 1),  -- 8 GB, 1 TB SSD, Intel Celeron N3050
    (2, 2, 2),  -- 16 GB, 2 TB HDD, AMD FX 4300
    (1, 3, 3),  -- 8 GB, 3 TB HDD, AMD Athlon Quad-Core APU Athlon 5150
    (2, 4, 4),  -- 16 GB, 4 TB HDD, AMD FX 8-Core Black Edition FX-8350
    (3, 5, 5),  -- 32 GB, 750 GB SSD, AMD FX 8-Core Black Edition FX-8370
    (3, 6, 6),  -- 32 GB, 2 TB SSD, Intel Core i7-6700K
    (1, 2, 7),  -- 8 GB, 2 TB HDD, Intel Core i5-6400
    (2, 7, 7),  -- 16 GB, 500 GB SSD, Intel Core i5-6400
    (4, 2, 8),  -- 2 GB, 2 TB HDD, Intel Core i7 Extreme Edition
    (5, 7, 7);  -- 512 MB, 80 GB SSD, Intel Core i5-6400

-- Insert Port Configurations for each Computer Configuration

INSERT INTO PortConfigurations (ConfigId, PortType, PortCount) VALUES
    (1, 'USB 2.0', 4), (1, 'USB 3.0', 2),
    (2, 'USB 2.0', 4), (2, 'USB 3.0', 3),
    (3, 'USB 2.0', 4), (3, 'USB 3.0', 4),
    (4, 'USB 2.0', 5), (4, 'USB 3.0', 4),
    (5, 'USB 2.0', 2), (5, 'USB 3.0', 2), (5, 'USB C', 1),
    (6, 'USB 3.0', 4), (6, 'USB C', 2),
    (7, 'USB 3.0', 8),
    (8, 'USB 2.0', 4),
    (9, 'USB 2.0', 10), (9, 'USB 3.0', 10), (9, 'USB C', 10),
    (10, 'USB 2.0', 4), (10, 'USB 3.0', 19);

GO
