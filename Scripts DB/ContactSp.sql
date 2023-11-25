USE [FoodieDB]
GO

/****** Object:  StoredProcedure [dbo].[ContactSp]    Script Date: 24/11/2023 23:02:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ContactSp]
	@Action varchar(10),
	@ContactId int=null,
	@Name varchar(50)=null,
	@Email varchar(200)=null,
	@Subject varchar(200) = null,
	@Message varchar(max) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Action = 'INSERT'
	BEGIN
		INSERT INTO Contact(Name,Email,Subject,Message,CreatedDate)
		Values(@Name,@Email,@Subject,@Message,GetDate())
	END

	IF @Action = 'SELECT'
	BEGIN
		SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) As [SrNo],* FROM Contact
	END

	IF @Action = 'DELETE'
	BEGIN
		DELETE FROM Contact WHERE ContactId = @ContactId
	END
END
GO

