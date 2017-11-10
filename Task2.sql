
/* Task 2 - 
I. Define and use Default and Check constraints to enforce domain integrity 
II. Define and use PRIMARY KEY and FOREIGN KEY constraint to enforce entity and referential integrity
*/
/**** PRIMARY KEY CONSTRAINTS ****/
/**** ITEM AND TITLE PRIMARY CONSTRAINTS DONE IN TABLE CREATION ****/

-- Add Copy table Composite Primary Key
alter table Item.Copy
	add constraint pk_Copy primary key clustered (ISBN asc, CopyNo asc)
;
go
 
-- TODO **Check if its okay for 3 pks to be the same name…?
-- Add Member table Primary Key 
alter table Member.Member
	add constraint pk_MemberID primary key clustered (MemberID asc)
;
go


-- Add Adult table Primary Key
alter table Member.Adult
	add constraint pk_MemberID primary key clustered (MemberID asc)
;
go

-- Add Juvenile table Primary Key
alter table Member.Juvenile
	add constraint pk_MemberID primary key clustered (MemberID asc)
;
go


-- Add Reservation table Primary Key
alter table Activity.Reservation
	add constraint pk_ReservationID primary key clustered (ReservationID asc)
;
go

-- Add Loan table Primary Key
alter table Activity.Loan
	add constraint pk_LoanID primary key clustered (LoanID asc)
;
go


/**** FOREIGN KEY CONSTRAINTS ****/
/**** ITEM AND TITLE FOREIGN CONSTRAINTS ****/
/**** DONE IN TABLE CREATION ****/

-- Between the Item.Copy and Item.Item tables
alter table Item.Copy
	add constraint fk_CopyItem foreign key(ISBN, CopyNo)
references Item.Item(ISBN, CopyNo)
;
go

-- Between the Member.Adult and Member.Member tables
alter table Member.Adult
	add constraint fk_AdultMember foreign key (MemberID) references Member.Member(MemberID)
;
go

-- Between the Member.Juvenile and Member.Member tables
alter table Member.Juvenile
	add constraint fk_JuvenileMember foreign key (MemberID) references Member.Member(MemberID)
;
go

-- Between the Member.Juvenile and Member.Adult tables
alter table Member.Juvenile
	add constraint fk_JuvenileAdult foreign key (AdultMemberID) references Member.Member(MemberID)
;
go


-- Between the Activity.Reservation and Member.Member tables
alter table Activity.Reservation
	add constraint fk_ReservationMember foreign key (MemberID) references Member.Member(MemberID)
;
go

-- Between the Activity.Reservation and Item.Item tables
alter table Activity.Reservation
	add constraint fk_ReservationItem foreign key (ISBN) references Item.Item(ISBN)
;
go

-- Betweem the Activity.Loan and Item.Copy tables
alter table Activity.Loan
	add constraint fk_LoanCopy foreign key (CopyNo) references Item.Copy(CopyNo)
;
go

-- Betweem the Activity.Loan and Item.Item tables
alter table Activity.Loan
	add constraint fk_LoanItem foreign key (ISBN) references Item.Item(ISBN)
;
go

-- Betweem the Activity.Loan and Member.Member tables
alter table Activity.Loan
	add constraint fk_ActivityMember foreign key (MemberID) references Member.Member(MemberID)
;
go

/**** OTHER CONSTRAINTS ****/

/**** ADULT AND JUVENILE OTHER CONSTRAINTS ****/
/**** DONE IN TABLE CREATION ****/


-- Add check constraint to dueDate in Activity.Loan table
alter table Activity.Loan
	add constraint ck_DueDate_Loan check (DueDate >= CheckedOutDate)
;
go

