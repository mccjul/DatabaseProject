create function fnIsLastYear
(
	@Year datetime
)
returns int	
as
begin
	-- declare the return variable here 
	declare @Return int
	-- to compute the return value
	select @Return = IIF(YEAR(getDate())-1 = YEAR(@Year), 1, 0)
	--  return the result to the function
	return @Return	
end
;
go


SELECT COUNT(Loan.loanID) FROM Activity.Loan
WHERE dbo.fnIsLastYear(Loan.CheckedOutDate) = 1;
;
go
--2


SELECT COUNT( Distinct Loan.MemberID) * 100.0 / (SELECT COUNT(*) FROM Member.Member)  
FROM Member.Member 
INNER JOIN Activity.Loan ON Loan.MemberID = Member.MemberID
;
go



/* 3. What was the greatest number of books borrowed by any one individual?
 */
 
SELECT MAX(x.num)
FROM (SELECT COUNT(Loan.LoanID) as num
FROM Activity.Loan
GROUP BY Loan.MemberID
) AS x
;
go




/* 4. What percentage of the books was loaned out at least once last year?  */
SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Item.Copy)
FROM Item.Copy
INNER JOIN Activity.Loan ON Loan.CopyNo = Copy.CopyNo
WHERE dbo.fnIsLastYear(Loan.CheckedOutDate) = 1
;
go

SELECT distinct Loan.ISBN
FROM Item.Copy
INNER JOIN Activity.Loan ON Loan.CopyNo = Copy.CopyNo AND Loan.ISBN = Copy.ISBN
WHERE dbo.fnIsLastYear(Loan.CheckedOutDate) = 0
;
go


/* 5. What percentage of all loans eventually becomes overdue? 
STORED PROCEDURE */
create procedure uspPercentLoanOverdue
as
SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Activity.Loan)
FROM Activity.Loan
WHERE Loan.DueDate < Loan.ReturnedDate
;
go

exec uspPercentLoanOverdue
;
go

SELECT *
FROM Activity.Loan
WHERE Loan.DueDate > Loan.ReturnedDate
;
go



/* 6. What is the average length of a loan? */
SELECT AVG(x.num)
FROM (SELECT abs(DATEDIFF(day, Loan.checkedOutDate, Loan.returnedDate)) as num
FROM Activity.Loan) AS x
;
go


/* 7. What are the library peak hours for loans? */

SELECT * 
FROM 
(SELECT datepart(hour, Loan.CheckedOutDate), COUNT(*) AS count 
FROM Activity.Loan 
GROUP BY datepart(hour, Loan.CheckedOutDate)
;
go

SELECT distinct datepart(hour, Loan.CheckedOutDate) as [Peak Hours] , count(*) as [Count]
FROM Activity.Loan 
GROUP BY datepart(hour, Loan.CheckedOutDate)
Order by count(*) desc
;
go



/* TRIGGER WHEN NEW LOAN ADDED */
/* TRIGGER WHEN NEW LOAN ADDED */
CREATE TRIGGER trLoanReturned
ON Activity.Loan
AFTER UPDATE
AS
	begin
		DECLARE @CopyNo as int,
				@ISBN as varchar(13),
				@ReturnedDate as datetime

		SELECT	@CopyNo = CopyNo,
				@ISBN = ISBN,
				@ReturnedDate = ReturnedDate
		FROM Inserted
		if(@ReturnedDate is not null)
			begin
				UPDATE Item.Copy
SET Copy.isLoaned = 0
WHERE Copy.CopyNo = @CopyNo AND Copy.ISBN = @ISBN
end
	end
;
go




/* TRIGGER FOR CREATE LOAN SETS COPY LOANED TO 1 */
CREATE TRIGGER trLoanCreated
ON Activity.Loan
AFTER INSERT
AS
	begin
DECLARE @CopyNo as int,
				@ISBN as varchar(13),
				@ReturnedDate as datetime

		SELECT	@CopyNo = CopyNo,
				@ISBN = ISBN,
				@ReturnedDate = ReturnedDate
		FROM Inserted
if(@ReturnedDate is null)
		begin
			UPDATE Item.Copy
SET Copy.isLoaned = 1
WHERE Copy.CopyNo = @CopyNo AND Copy.ISBN = @ISBN
end
	end
;
go



