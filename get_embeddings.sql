 CREATE PROCEDURE [dbo].[GET_EMBEDDINGS]
        @inputText NVARCHAR(MAX),
        @embedding vector(1536) output
    AS
    BEGIN
        DECLARE @retval INT 
        DECLARE @response NVARCHAR(MAX)
        DECLARE @url VARCHAR(MAX)
        DECLARE @payload NVARCHAR(MAX) = JSON_OBJECT('input': @inputText);

        -- Construct the URL for the Azure OpenAI Embeddings API
        SET @url = 'https://<aoai resource name>.openai.azure.com/openai/deployments/<deployment name such as text-embedding-ada-002>/embeddings?api-version=2023-03-15-preview';

        -- Invoke the external REST endpoint
        EXEC dbo.sp_invoke_external_rest_endpoint
            @url = @url,
            @method = 'POST',
            @payload = @payload,
            @headers = '{"api-key":"<api key for azure openai resource>"}',
            @response = @response OUTPUT;

        -- Parse the JSON response to extract the embedding
        SET @embedding = json_query(@response, '$.result.data[0].embedding')
        return @retval
    END;
GO
