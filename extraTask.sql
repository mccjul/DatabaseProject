/* Query: Given book, get the member that has reserved it that waited the longest */

CREATE PROC dbo.usp_memberWaitedLongestForISBN
@ISBN as varchar(13)
as
SELECT Reservation.MemberID
(FROM SELECT MIN(Reservation.ReservedDate)
FROM Activity.Reservation
WHERE Reservation.ISBN = @ISBN)
FROM Activity.Reservation
;
go

exec dbo.usp_memberWaitedLongestForISBN @ISBN ='879368921-7'
;
go



/* Query: Given a book, how many copies are loaned */
CREATE PROC dbo.usp_copiesLoanedForISBN
@ISBN as varchar(13)
as
SELECT count(*)
FROM Activity.Loan
WHERE Loan.ISBN = @ISBN
;
go

exec dbo.usp_copiesLoanedForISBN @ISBN = '879368921-7'
;
go




/* Query: Given a book, is it reserved?*/
CREATE PROC usp_isReservedForISBN
@ISBN as varchar(13)
as
Select Reservation.MemberID, Reservation.ReservedDate
From Activity.Reservation
Where Reservation.ISBN = @ISBN
;
go

exec usp_isReservedForISBN @ISBN = '879368921-7'
;
go

/*Query: Given a member id, return info on that member (including expiration date, check adult for juvenile’s expiration date (A librarian must notify the member, a month before membership cards expire, ))*/
CREATE PROC usp_MemberInfoForMemberID @MemberID as int
AS
select Member.MemberID, Member.FirstName, Member.LastName, Member.MiddleInitial, Adult.ExpirationDate
from Member.Member
INNER JOIN Member.Juvenile ON Member.MemberID = Juvenile.MemberID 
INNER JOIN Member.Adult ON Juvenile.AdultMemberID = Adult.MemberID 
Where Member.MemberID = @MemberID
UNION
select Member.MemberID, Member.FirstName, Member.LastName, Member.MiddleInitial, Adult.ExpirationDate
from Member.Member
INNER JOIN Member.Adult ON Member.MemberID = Adult.MemberID
Where Member.MemberID = @MemberID
;
go

exec usp_MemberInfoForMemberID @MEmberID = 501
;
go



/*Query: Given a member id, return outstanding loan (order by time)*/
CREATE PROCEDURE usp_MemberOutstandingLoans
@MemberID as int
SELECT * FROM Activity.Loan
INNER JOIN Member.Member ON Member.MemberID = Loan.MemberID
WHERE Member.MemberID = @ MemberID 
AND DATEDIFF(day, Loan.DueDate, GETDATE()) < 0
ORDER BY Loan.DueDate ASC


/*Query: Given a copy, get all information*/

CREATE PROCEDURE dbo.uspGetCopyInfo @CopyNo int, @ISBN varchar(13)
AS
SELECT * 
FROM Item.Copy
WHERE CopyNo = @CopyNo and ISBN=@ISBN
;
GO

EXEC dbo.uspGetCopyInfo @CopyNo = 735, @ISBN = '238044992-9'
;
go 





/*Query: Given a copy, is it loanable*/

ALTER PROCEDURE dbo.uspGetCopyLoanState @CopyNo int, @ISBN varchar(13)
AS
SELECT Item.Copy.ISBN, Item.Copy.IsLoaned as available
FROM Item.Copy
WHERE CopyNo = @CopyNo and ISBN = @ISBN
;
GO
EXEC dbo.uspGetCopyLoanState  @CopyNo = 735, @ISBN = '238044992-9'
;
go 



/*Query: Given a copy, is it already loaned (to check if it was missed on check in)*/
CREATE PROCEDURE dbo.usp_isLoanedForCopy
@CopyNo as int,
@ISBN as varchar(13)
AS
SELECT Copy.isLoaned 
FROM Item.Copy
Where Copy.ISBN = @ISBN AND Copy.CopyNo = @CopyNo
;
go

EXEC dbo.usp_isLoanedForCopy @ISBN = 879368921-7 AND @CopyNo = 1
;
go

/*Query: Given a copy, get the member who loaned it’s information*/
CREATE PROCEDURE dbo.usp_getMemberInfoForCopy
@CopyNo as int,
@ISBN as varchar(13)
AS
SELECT Member.*
FROM Member.Member
INNER JOIN Activity.Loan ON Loan.MemberID = Member.MemberID
WHERE Loan.CopyNo = @CopyNo AND Loan.ISBN = @ISBN
;
go

exec dbo.usp_getMemberInfoForCopy
;
go
