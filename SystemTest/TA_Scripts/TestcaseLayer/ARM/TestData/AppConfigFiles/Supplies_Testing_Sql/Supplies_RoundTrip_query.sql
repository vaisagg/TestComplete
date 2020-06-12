
UPDATE Consumables_Details 
		SET StatusID = 1,
			OperationStatusID = 0,
			AvailableCapacity = 120,
			ActualCapacity = 120
		WHERE ConsumableID IN (1, 2, 3)
			AND TypeID = 2;


UPDATE Consumables_Details 
		SET InstallationDate = GETDATE(),
			ExpirationDate = DATEADD(MONTH, 1, GETDATE()),
			StatusID = 1,
			OperationStatusID = 0,
			AvailableCapacity = 10000000,
			ActualCapacity = 10000000
		WHERE ConsumableID IN (5)
			AND TypeID = 1;

if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 1   )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 1, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1500000, 1500000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 1;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 6 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 6, 1, 0, NULL, NULL, N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 0, 0, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 6;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 2 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 2, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1500000, 1500000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 2;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 7 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 7, 1, 0, NULL, NULL, N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 0, 0, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 7;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 3 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 3, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1500000, 1500000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 3;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 8 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 8, 1, 0, NULL, NULL, N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 0, 0, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 8;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 4 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 4, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 3000000, 3000000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 4;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 9 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 9, 1, 0, NULL, NULL, N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 0, 0, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 9;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 10 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 10, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1500000, 1500000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 10;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 14 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 14, 1, 0, NULL, NULL, N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 0, 0, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 14;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 11 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 11, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1500000, 1500000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 11;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 15 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 15, 1, 0, NULL, NULL, N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 0, 0, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 15;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 12 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 12, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 3000000, 3000000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 12;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 16 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 16, 1, 0, NULL, NULL, N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 0, 0, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 16;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 13 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 13, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 3000000, 3000000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 13;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 17 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 17, 1, 0, NULL, NULL, N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 0, 0, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 17;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 18 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 18, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1100000, 1100000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 18;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 19 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 19, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1100000, 1100000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 19;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 20 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 20, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1100000, 1100000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 20;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 21 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 21, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1100000, 1100000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 21;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 1 and ConsumableID = 22 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (1, 22, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1100000, 1100000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 1 And ConsumableID = 22;

GO
if not exists(select 1 from [Consumables_Details] where [TypeID] = 2 and ConsumableID = 4 )
INSERT [dbo].[Consumables_Details] ([TypeID], [ConsumableID], [StatusID], [OperationStatusID], [Barcode], [Concentration], [LotNumber], [SequenceNumber], [InstallationDate], [ExpirationDate], [AvailableCapacity], [ActualCapacity], [OnBoard]) VALUES (2, 4, 1, 0, N'', N'', N'000001', N'0001', GETDATE(), DATEADD(MONTH, 1, GETDATE()), 5000, 5000, 1)
ELSE
UPDATE Consumables_Details  SET InstallationDate = GETDATE(), ExpirationDate = DATEADD(MONTH, 1, GETDATE()), StatusID = 1,  OperationStatusID = 0	WHERE TypeID = 2 And ConsumableID = 4;
GO


