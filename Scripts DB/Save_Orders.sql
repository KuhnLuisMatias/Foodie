USE [FoodieDB]
GO

/****** Object:  StoredProcedure [dbo].[Save_Orders]    Script Date: 24/11/2023 23:03:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Save_Orders] 
	@tblOrders OrderDetails READONLY
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Orders(OrderNo,ProductId,Quantity,UserId,Status,PaymentId,OrderDate)
	SELECT OrderNo,ProductId,Quantity,UserId,Status,PaymentId,OrderDate FROM @tblOrders
END
GO

