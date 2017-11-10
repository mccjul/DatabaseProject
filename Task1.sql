
/*	Task 1 - I. Create Library database
	Script Date: November 05, 2017
	Developed by: Julian Mccarthy, Dany Lyth, Eric Berrier, Karely Lu 
*/

-- Switch to the master database
use master
;
go

/**** DATABASE CREATION ****/
create database WestMunicipalLibrary
on primary
(
	-- Rows data file name
	name = 'WestMunicipalLibrary_data',
	-- Path and rows data filename
	filename = 'C:\library_db\WestMunicipalLibrary\WestMunicipalLibrary.mdf',
	-- Rows data initial size
	size = 10MB,
	-- Rows data file growth
	filegrowth = 2MB,
	-- Maximum rows data file size
	maxsize = 100MB
)
log on
(
	-- log file name
	name = 'WestMunicipalLibrary_log',
	-- Path and log filename
	filename = 'C:\library_db\WestMunicipalLibrary\WestMunicipalLibrary_log.mdf',
	-- log initial size
	size = 2MB,
	-- log file growth
	filegrowth = 10%,
	-- Maximum log file size
	maxsize = 25MB
)
;
go



/**** SCHEMA CREATION ****/
create schema Item authorization dbo
;  
go
create schema Member authorization dbo
;  
go
create schema Activity authorization dbo
; 
go 


/* Task 1 - II. Create tables in the Library Database */
/**** TABLE CREATION ****/

-- Create Title table
create table Item.Title (
	TitleID int identity (1,1) not null,
	Title varchar(100) not null,
	AuthorFirstName varchar(20) not null,
	AuthorLastName varchar(20) not null,
	Synopsis text not null,
	constraint pk_Title primary key clustered(TitleID asc)
)
;
go

-- Create Item table
create table Item.Item (
	ISBN varchar(13) not null,
	TitleID int not null,
	Translation varchar(20) not null,
	Cover char(1) not null,
	Loanable Boolean not null,
	constraint pk_Item primary key clustered(ISBN asc),
	constraint fk_ItemTitle foreign key(TitleID) references Item.Title(TitleID)
)
;
go


-- Create Copy table
create table Item.Copy
(
	ISBN varchar(13) not null,
	CopyNo  int not null,
	IsLoaned  boolean not null,
)
;
go

-- Create Member table
create table Member.Member
(
	MemberID smallInt identity(1,1) not null,
	LastName varchar(20) not null,
FirstName varchar(20) not null,
	MiddleInitial varchar(1) not null,
            Photograph Image not null,
)
;
Go

-- Create Adult table
create table Member.Adult
(
	MemberID int unique not null,
	Address varchar(6) not null,
	Street varchar(60) not null,
	City varchar(20) not null,
	State char(2) not null default ‘WA’,
	Zip char(5) not null check (Zip like ‘[0-9]+’),
	PhoneNumber varchar(10) not null check (PhoneNumber like ‘[0-9]+’),
	ExpirationDate date not null
)
;
Go

-- Create Juvenile table
create table Member.Juvenile
(
	MemberID int unique not null,
AdultMemberID int not null,
	BirthDate Date not null
)
;
go
-- Create Reservation table
create table Activity.Reservation
(
	ReservationID int identity(1,1) not null,
	MemberID int not null,
	ISBN varchar(13) not null,
	ReservedDate smalldatetime not null,
)
;
go

-- Create Loan table
create table Activity.Loan
(
	LoanID int identity(1,1) not null,
	CopyNo int not null,
	ISBN varchar(13) not null,
	MemberID int not null,
	DueDate smalldatetime not null,
	CheckedOutDate smalldatetime not null,
	ReturnedDate smalldatetime null,
)
;
go
