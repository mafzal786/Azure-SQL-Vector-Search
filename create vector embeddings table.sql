SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SalesLT].[ProductDescriptionVectorEmbeddings](
	[ProductDescriptionID] [int] NOT NULL,
	[ProductDescriptionEmbeddings] [vector](1536) NULL,
	[ModifiedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO

-- Declare variables to hold data from the cursor
DECLARE @ProductDescriptionID INT;
DECLARE @Description NVARCHAR(MAX);

DECLARE @inputText nvarchar(max) 
DECLARE @retval int, @embedding vector(1536)

-- Declare the cursor
DECLARE ProductDescCursor CURSOR FOR
SELECT ProductDescriptionID, Description
FROM SalesLT.ProductDescription;

-- Open the cursor
OPEN ProductDescCursor;

-- Fetch the first row
FETCH NEXT FROM ProductDescCursor INTO @ProductDescriptionID, @Description;

-- Loop through the rows
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Example operation: print the description (or perform any update/logic)
    PRINT 'ID: ' + CAST(@ProductDescriptionID AS NVARCHAR) + ' - Description: ' + @Description;
    
    -- Get the embeddings and insert into the table
    SET @inputText = @Description
    EXEC @retval = dbo.get_embeddings  @inputText, @embedding output
    INSERT INTO [SalesLT].[ProductDescriptionVectorEmbeddings]
    ([ProductDescriptionID],[ProductDescriptionEmbeddings],[ModifiedDate])
    SELECT @ProductDescriptionID, @embedding, GETDATE()
    -- Fetch the next row
    FETCH NEXT FROM ProductDescCursor INTO @ProductDescriptionID, @Description;
END

-- Close and deallocate the cursor
CLOSE ProductDescCursor;
DEALLOCATE ProductDescCursor;
GO


