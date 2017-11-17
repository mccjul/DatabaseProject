BULK INSERT Title
FROM 'C:\CSVData\MOCK_tblTitle.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
  )
;
go
BULK INSERT Item
FROM 'C:\CSVData\MOCK_tblItem.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
  )
;
go
BULK INSERT Copy
FROM 'C:\CSVData\MOCK_tblCopy.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
  )
;
go
BULK INSERT Member
FROM 'C:\CSVData\MOCK_tblMember.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
  )
;
go
BULK INSERT Adult
FROM 'C:\CSVData\MOCK_tblAdult.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
  )
;
go
BULK INSERT Juvenile
FROM 'C:\CSVData\MOCK_tblJuvenile.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
  )
;
go
BULK INSERT Reservation
FROM 'C:\CSVData\MOCK_tblReservation.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
  )
;
go
BULK INSERT Loan
FROM 'C:\CSVData\MOCK_tblLoan.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
  )
;
go
