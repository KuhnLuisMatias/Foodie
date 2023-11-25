USE [FoodieDB]
GO

/****** Object:  StoredProcedure [dbo].[Cart_Crud]    Script Date: 24/11/2023 23:02:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Cart_Crud] @Action VARCHAR(10)
	,@ProductId INT = NULL
	,@Quantity INT = NULL
	,@UserId INT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	--SELECT--
	IF @Action = 'SELECT'
	BEGIN
		SELECT c.ProductId
			,p.Name
			,p.ImageUrl
			,p.Price
			,c.Quantity AS Qty
			,p.Quantity AS PrdQty
		FROM dbo.Carts c
		INNER JOIN dbo.Products p ON p.ProductId = c.ProductId
		WHERE c.UserId = @UserId
	END

	--INSERT--
	IF @Action = 'INSERT'
	BEGIN
		INSERT INTO dbo.Carts (
			ProductId
			,Quantity
			,UserId
			)
		VALUES (
			@ProductId
			,@Quantity
			,@UserId
			)
	END

	--UPDATE--
	IF @Action = 'UPDATE'
	BEGIN
		UPDATE dbo.Carts
		SET Quantity = @Quantity
		WHERE ProductId = @ProductId
			AND UserId = @UserId
	END

	--DELETE--
	IF @Action = 'DELETE'
	BEGIN
		DELETE
		FROM dbo.Carts
		WHERE ProductId = @ProductId
			AND UserId = @UserId
	END

	--GETBYID(PRODUCTID)
	IF @Action = 'GETBYID'
	BEGIN
		SELECT *
		FROM dbo.Carts
		WHERE ProductId = @ProductId
			AND UserId = @UserId
	END
END
GO

