# Azure-SQL-Vector-Search

This example shows how to use Azure OpenAI from Azure SQL database to get the vector embeddings and perform vector similarity search. This example used AdventureWorkLT as demo database. you can download this database from the following link.
https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms

Restore this database into your SQL server. Vector data type is supported in SQL Server 2025, Azure SQL, Azure SQL Managed Instance, or SQL Database in Fabric (Preview). For more details follow. https://learn.microsoft.com/en-us/sql/t-sql/data-types/vector-data-type?view=sql-server-ver17&tabs=csharp

## Steps

- Make sure, you have Azure OpenAI resource is provisioned. Modify the get_embeddings.sql with Azure OpenAI endpoint and access key.
- Run create vector embeddings table.sql
- 

