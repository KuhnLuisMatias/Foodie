USE [FoodieDB]
GO

/****** Object:  StoredProcedure [dbo].[Save_Payment]    Script Date: 24/11/2023 23:03:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Save_Payment] 
	@Name VARCHAR(100)= NULL,
	@CardNo VARCHAR(50)= NULL,
	@ExpiryDate VARCHAR(50)= NULL,
	@Cvv INT= NULL,
	@Address VARCHAR(MAX)= NULL,
	@PaymentMode VARCHAR(10) = 'card',
	@InsertedId int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO dbo.Payment(Name,CardNo,ExpiryDate,CvvNo,Address,PaymentMode)
	VALUES(@Name,@CardNo,@ExpiryDate,@Cvv,@Address,@PaymentMode)

	SELECT @InsertedId = SCOPE_IDENTITY();
END
GO

