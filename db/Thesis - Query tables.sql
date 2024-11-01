
Use ThesisExercise

Select *  from Processors Order By ProcessorId
Select *  from StorageDevices Order By StorageId
Select *  from RamConfigurations Order By RamId
Select *  from PortConfigurations Order By PortConfigId
Select *  from ComputerConfigurations Order By ConfigId

/*

Delete PortConfigurations Where PortConfigId > 20 
DBCC CHECKIDENT ('[PortConfigurations]', RESEED, 20);

Delete ComputerConfigurations Where ConfigId > 10 
DBCC CHECKIDENT ('[ComputerConfigurations]', RESEED, 10);

Delete Processors Where ProcessorId > 8 
DBCC CHECKIDENT ('[Processors]', RESEED, 8);

Delete StorageDevices Where StorageId > 7 
DBCC CHECKIDENT ('[StorageDevices]', RESEED, 7);

Delete RamConfigurations Where RamId > 5 
DBCC CHECKIDENT ('[RamConfigurations]', RESEED, 5);

*/





