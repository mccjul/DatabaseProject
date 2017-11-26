/**** TO FINISH ON LATER DATE ****/


use WestMunicipalLibrary
;
go

/*1. Create a mailing list of Library members that includes the members’ full names and complete address information.*/
SELECT * 
FROM Member.Adult , Member.Member
ORDER BY Member.MemberID ASC
;
go

/*2. Write and execute a query on the title, item, and copy tables that returns the isbn, copy_no, on_loan, title, translation, and cover, and values for rows in the copy table with an ISBN of 1 (one), 500 (five hundred), or 1000 (thousand). Order the result by isbn column.*/
/* From access
SELECT 
FROM Title INNER JOIN (Item INNER JOIN Copy ON Item.ISBN = Copy.ISBN) ON Title.TitleID = Item.TitleID; */

SELECT Item.ISBN, Copy.CopyNo, Copy.isLoaned, Title.Title, Item.Translation, Item.Cover 
FROM Item.Title INNER JOIN (Item.Item INNER JOIN Item.Copy ON Item.ISBN = Copy.ISBN) ON Title.TitleID = Item.TitleID
WHERE Item.ISBN = 1 OR Item.ISBN = 500 OR Item.ISBN = 1000 --change ISBN to what we have
ORDER BY Item.ISBN ASC
;
go

/*3. Write and execute a query to retrieve the member’s full name and member_no from the member table and the isbn and log_date values from the reservation table for members 250, 341, 1675. Order the results by member_no. You should show information for these members, even if they have no books or reserve.*/

SELECT Member.FirstName, Member.LastName, Member.MemberID, Reservation.ISBN, Reservation.reservationDate
FROM Member.Member LEFT OUTER JOIN Activity.Reservation ON Member.MemberID = Reservation.MemberID
WHERE Member.MemberID = 250 OR Member.MemberID = 341 OR Member.MemberID = 1675
ORDER BY Member.MemberID ASC
;
go

/*4. Create a view and save it as adultwideView that queries the member and adult tables. Lists the name & address for all adults.*/

CREATE VIEW “adultwideView” 
AS 
SELECT Member.FirstName, Member.LastName, Member.MiddleInitial,  Adult.Address, Adult.Street, Adult.City, Adult.State, Adult.Zip
FROM Member.Member
INNER JOIN Member.Adult ON Member.MemberID = Adult.MemberID
;
 

/*5. Create a view and save it as ChildwideView that queries the member, adult, and juvenile tables. Lists the name & address for the juveniles.*/
CREATE VIEW “ChildwideView” AS SELECT Member.FirstName, Member.LastName, 
Member.MiddleInitial,  Adult.Address, Adult.Street, Adult.City, Adult.State, Adult.Zip
FROM Member.Member
INNER JOIN Member.Juvenile ON Member.MemberID = Juvenile.MemberID

/*6. Create a view and save it as and CopywideView that queries the copy, title and item tables. Lists complete information about each copy.*/
/* From access
SELECT 
FROM Title INNER JOIN (Item INNER JOIN Copy ON Item.ISBN = Copy.ISBN) ON Title.TitleID = Item.TitleID; */

CREATE VIEW “CopywideView” AS 
SELECT * FROM Item.Title  

/*7. Create a view and save it as LoanableView that queries CopywideView (3-table join). Lists complete information about each copy marked as loanable (loanable = 'Y').*/

/*8. Create a view and save it as OnshelfView that queries CopywideView (3-table join). Lists complete information about each copy that is not currently on loan (on_loan ='N').*/

CREATE VIEW “OnshelfView” AS
SELECT * FROM CopywideView
WHERE Copy.isLoaned = ‘N’;

/*9. Create a view and save it as OnloanView that queries the loan, title, and member tables. Lists the member, title, and loan information of a copy that is currently on loan.*/
CREATE VIEW “OnloanView” AS SELECT Member.MemberID, Item.Title, Loan.DueDate,Loan.CheckedOutDate, Loan.ReturnedDate
FROM Item.Item, Item.Copy, Item.Title, Activity.Loan,
WHERE Copy.Isloaned= “true”, 
INNER JOIN ON item.ISBN = Loan.ISBN

/*10. Create a view and save it as OverdueView that queries OnloanView (3-table join.) Lists the member, title, and loan information of a copy on loan that is overdue (due_date)*/
CREATE VIEW “OverdueView” AS SELECT Member.MemberID, Item.Title, Loan.DueDate, Loan.CheckedOutDate, Loan.ReturnedDate
FROM Item.Item, Item.Copy, Item.Title, Activity.Loan
WHERE Loan.DueDate < now ()
INNER JOIN ON item.ISBN = Loan.ISBN
INNER JOIN ON Loan.MemberID = Member.MemberID
