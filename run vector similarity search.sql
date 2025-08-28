declare @inputText nvarchar(max) = 'show me stuff related to bike'
declare @retval int, @embedding vector(1536)
exec @retval = dbo.get_embeddings  @inputText, @embedding output

select top 10
	a.ProductDescriptionID, a.Description, b.ProductDescriptionEmbeddings,
	--c.Name,c.ProductNumber, c.ListPrice,
	vector_distance('cosine',@embedding, b.ProductDescriptionEmbeddings) as cosine_distance

	from [SalesLT].[ProductDescription] a
	JOIN [SalesLT].[ProductDescriptionVectorEmbeddings] b on a.ProductDescriptionID = b.ProductDescriptionID
	--JOIN [SalesLT].[Product] c on c.ProductID = a.ProductDescriptionID
	Order By
	cosine_distance
