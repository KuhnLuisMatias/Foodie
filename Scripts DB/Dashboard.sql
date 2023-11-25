USE [FoodieDB]
GO

/****** Object:  StoredProcedure [dbo].[Dashboard]    Script Date: 24/11/2023 23:02:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Dashboard]
	-- Add the parameters for the stored procedure here
	@Action varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @Action = 'CATEGORY'
	begin
		select COUNT(1) from Categories
	end

	if @Action = 'PRODUCT'
	begin
	 select COUNT(1) from Products
	end

	if @Action = 'ORDER'
	begin
		select count(1) from Orders
	end

	if @Action = 'DELIVERED'
	begin
		SELECT count(1) from Orders
		WHERE Status = 'Delivered'
	end

	if @Action = 'PENDING'
	begin
		SELECT COUNT(1) from Orders
		where Status in ('Pending','Dispatched')
	end

	if @Action = 'SOLDAMOUNT'
	begin
		SELECT SUM(o.Quantity * p.Price) From Orders o
		Inner Join Products p ON p.ProductId = o.ProductId
	END

	IF @Action = 'CONTACT'
	BEGIN
		SELECT Count(1) from Contact
	END

	IF @Action = 'USER'
	begin
		SELECT COUNT(1) from Users
	END 

END
GO

