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


-- Create Schema

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


