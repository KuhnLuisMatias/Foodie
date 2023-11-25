USE [FoodieDB]
GO

/****** Object:  StoredProcedure [dbo].[Invoice]    Script Date: 24/11/2023 23:03:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Invoice]
	-- Add the parameters for the stored procedure here
	@Action varchar(10),
	@PaymentId Int = null,
	@UserId int = null,
	@OrderDetailsId int = null,
	@Status varchar(50) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Action = 'INVOICBYID'
	BEGIN
		SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS SrNo,o.OrderNo,p.Name,p.Price,o.Quantity,
		(p.Price * o.Quantity) as TotalPrice,o.OrderDate,o.Status FROM Orders o
		INNER JOIN Products p on p.ProductId = o.ProductId
		WHERE o.PaymentId = @PaymentId and o.UserId = @UserId
	END

	IF @Action = 'ODRHISTORY'
	BEGIN
		SELECT DISTINCT o.PaymentId,p.PaymentMode,p.CardNo FROM Orders o
		INNER JOIN Payment p on p.PaymentId = o.PaymentId
		WHERE o.UserId = @UserId
	END

	IF @Action = 'GETSTATUS'
	BEGIN
		SELECT o.OrderDetailsID,o.OrderNo,(pr.Price * o.Quantity) as TotalPrice,o.Status,
		o.OrderDate,p.PaymentMode,pr.Name FROM Orders o
		INNER JOIN Payment p on p.PaymentId = o.PaymentId
		INNER JOIN Products pr on pr.ProductId = o.ProductId
	END
    
	IF @Action = 'STATUSBYID'
	BEGIN
		SELECT OrderDetailsId,Status FROM Orders
		WHERE OrderDetailsId = @OrderDetailsId
	END

	IF @Action = 'UPDTSTATUS'
	BEGIN
		UPDATE Orders
		SET Status = @Status WHERE OrderDetailsId = @OrderDetailsId
	END

END
GO

