BULK INSERT Item.Title
FROM 'C:\library_db\WestMunicipalLibrary\MOCK_tblTitle.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row
  )
;
go


select * from Item.Title
;
go


BULK INSERT Item.Item
FROM 'C:\library_db\WestMunicipalLibrary\MOCK_tblItem.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'  --Use to shift the control to next row
  )
;
go

select * from Item.Item
;
go

BULK INSERT Item.Copy
FROM 'C:\library_db\WestMunicipalLibrary\MOCK_tblCopy.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row
  )
;
go

select * from Item.Copy
;
go

BULK INSERT Member.Member
FROM 'C:\library_db\WestMunicipalLibrary\MOCK_tblMember.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row
  )
;
go

select * from Member.Member
;
go

BULK INSERT Member.Adult
FROM 'C:\library_db\WestMunicipalLibrary\MOCK_tblAdult.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row
  )
;
go

select * from Member.Adult
;
go


BULK INSERT Member.Juvenile
FROM 'C:\library_db\WestMunicipalLibrary\MOCK_tblJuvenile.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row
  )
;
go

select * from Member.Juvenile
;
go

BULK INSERT Activity.Reservation
FROM 'C:\library_db\WestMunicipalLibrary\MOCK_tblReservation.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row
  )
;
go

select * from Activity.Reservation
;
go

BULK INSERT Activity.Loan
FROM 'C:\library_db\WestMunicipalLibrary\MOCK_tblLoan.csv'
WITH
  (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row
  )
;
go

select * from Activity.Loan
;
go