USE [FoodieDB]
GO

/****** Object:  StoredProcedure [dbo].[SellingReport]    Script Date: 24/11/2023 23:03:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SellingReport]
	@FromDate Date = null,
	@ToDate Date = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS[SrNo],u.Name,u.Email,
	sum(o.Quantity) as TotalOrders,Sum(o.Quantity * p.Price) as TotalPrice
	FROM Orders o
	INNER JOIN Products p on p.ProductId = o.ProductId
	INNER JOIN Users u ON u.UserId = o.UserId
	WHERE CAST(o.OrderDate as Date) Between @FromDate AND @ToDate
	GROUP BY u.Name,u.Email
END
GO

