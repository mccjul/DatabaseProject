/**** TO FINISH ON LATER DATE ****/

/*1. Create a mailing list of Library members that includes the members’ full names and complete address information.*/
SELECT * 
FROM Member.Adult inner join Member.Member ON
Member.Adult.MemberID = Member.Member.MemberID
;
go
/*2. Write and execute a query on the title, item, and copy tables that returns the isbn, copy_no, on_loan, title, translation, and cover, and values for rows in the copy table with an ISBN of 1 (one), 500 (five hundred), or 1000 (thousand). Order the result by isbn column.*/
INSERT INTO Item.Copy (ISBN, CopyNo, isLoaned)
VALUES
('879368921-7',1,1),
('879368921-7',2,1),
('879368921-7',3,0),
('712180393-3',1,1),
('712180393-3',2,1),
('455631415-1',1,0),
('455631415-1',2,1),
('455631415-1',3,0)
;
go

SELECT Item.ISBN, Copy.CopyNo, Copy.isLoaned, Title.Title, Item.Translation, Item.Cover 
FROM Item.Title
INNER JOIN  Item.Item ON Title.TitleID = Item.TitleID
INNER JOIN Item.Copy ON Item.ISBN = Copy.ISBN
WHERE Item.ISBN = '879368921-7' OR Item.ISBN = '455631415-1' OR Item.ISBN = '712180393-3'
ORDER BY Item.ISBN ASC
;
go

/*3. Write and execute a query to retrieve the member’s full name and member_no from the member table and the isbn and log_date values from the reservation table for members 250, 341, 1675. Order the results by member_no. You should show information for these members, even if they have no books or reserve.*/
SELECT Member.FirstName, Member.LastName, Member.MemberID, Reservation.ISBN, Activity.Reservation.ReservedDate
FROM Member.Member 
LEFT OUTER JOIN Activity.Reservation ON Member.MemberID = Reservation.MemberID
WHERE Member.MemberID = 250 OR Member.MemberID = 341 OR Member.MemberID = 1675
ORDER BY MemberID ASC
;
go



/*4. Create a view and save it as adultwideView that queries the member and adult tables. Lists the name & address for all adults.*/


CREATE VIEW  adultwideView 
AS 
SELECT Member.FirstName, Member.LastName, Member.MiddleInitial,  Adult.Address, Adult.Street, Adult.City, Adult.State, Adult.Zip
FROM Member.Member
INNER JOIN Member.Adult ON Member.MemberID = Adult.MemberID
;
go




/*5. Create a view and save it as ChildwideView that queries the member, adult, and juvenile tables. Lists the name & address for the juveniles.*/
CREATE VIEW ChildwideView 
AS 
SELECT Member.FirstName, Member.LastName, Member.MiddleInitial,  Adult.Address, Adult.Street, Adult.City, Adult.State, Adult.Zip
FROM Member.Member
INNER JOIN Member.Juvenile ON  Member.MemberID = Juvenile.MemberID
INNER JOIN Member.Adult ON Juvenile.AdultMemberID = Adult.MemberID
;
go

/*6. Create a view and save it as and CopywideView that queries the copy, title and item tables. Lists complete information about each copy.*/
/* From access
SELECT 
FROM Title INNER JOIN (Item INNER JOIN Copy ON Item.ISBN = Copy.ISBN) ON Title.TitleID = Item.TitleID; */

CREATE VIEW CopywideView
AS 
SELECT Title.TitleID, Title.AuthorFirstName, Title.AuthorLastName, Title.Synopsis, Item.ISBN, Item.Translation, Item.Cover, Item.Loanable, Copy.CopyNo, Copy.IsLoaned 
FROM Item.Title  
INNER JOIN Item.Item ON Title.TitleID =  Item.TitleID
INNER JOIN Item.Copy ON Item.ISBN = Copy.ISBN 
;
go


/*7. Create a view and save it as LoanableView that queries CopywideView (3-table join). Lists complete information about each copy marked as loanable (loanable = 'Y').*/

CREATE VIEW LoanableView 
AS
SELECT * 
FROM CopywideView
WHERE CopywideView.Loanable = 1
;
GO


/*8. Create a view and save it as OnshelfView that queries CopywideView (3-table join). Lists complete information about each copy that is not currently on loan (on_loan ='N').*/
CREATE VIEW OnshelfView
 AS
SELECT * 
FROM CopywideView
WHERE CopywideView.isLoaned = 0
;
GO



/*9. Create a view and save it as OnloanView that queries the loan, title, and member tables. Lists the member, title, and loan information of a copy that is currently on loan.*/

INSERT INTO Activity.Loan (CopyNo,ISBN,MemberID, CheckedOutDate, DueDate)
VALUES
(1,'879368921-7',1,'20171026 10:34:09 AM','20171109 10:34:09 AM'),
(2,'879368921-7',1,'20171125 10:34:09 AM','20171209 10:34:09 AM'),
(1,'712180393-3',1,'20171125 10:34:09 AM','20171209 10:34:09 AM'),
(2,'712180393-3',2,'20171126 10:34:09 AM','20171210 10:34:09 AM'),
(2,'455631415-1',2,'20171126 10:34:09 AM','20171210 10:34:09 AM')
;
go



CREATE VIEW OnloanView
AS 
SELECT Member.MemberID, Title.Title, Loan.DueDate,Loan.CheckedOutDate, Loan.ReturnedDate
FROM Item.Title 
INNER JOIN Item.Item ON Title.TitleID = Item.TitleID
INNER JOIN Item.Copy ON Item.ISBN = Copy.ISBN 
INNER JOIN Activity.Loan ON Copy.ISBN = Loan.ISBN AND Copy.CopyNo = Loan.CopyNo
INNER JOIN Member.Member ON Loan.MemberID = Member.MemberID
WHERE Item.Copy.Isloaned= 1
;
go 



/*10. Create a view and save it as OverdueView that queries OnloanView (3-table join.) 
Lists the member, 
title, 
and loan information 
of a copy on loan that is overdue (due_date)*/

CREATE VIEW OverdueView
AS 
SELECT Member.MemberID, Title.Title, Loan.DueDate,Loan.CheckedOutDate, Loan.ReturnedDate
FROM Item.Title 
INNER JOIN Item.Item ON Title.TitleID = Item.TitleID
INNER JOIN Item.Copy ON Item.ISBN = Copy.ISBN 
INNER JOIN Activity.Loan ON Copy.ISBN = Loan.ISBN AND Copy.CopyNo = Loan.CopyNo
INNER JOIN Member.Member ON Loan.MemberID = Member.MemberID
WHERE Loan.DueDate < getdate ()
;
go

