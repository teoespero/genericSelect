-- lets create our temp table that will
-- hold our district names
declare @myTableName nVarChar(100)
declare @whatTosee nVarChar(100)
declare @columnCounter int
declare @SQLString AS nvarchar(4000)
declare @columns AS nvarchar(4000)
declare @looper int

set @myTableName = 'Address'
set @whatTosee = @myTableName

CREATE TABLE #myColumns (
  ID int IDENTITY (1, 1) PRIMARY KEY,
  ColName nvarchar(100),
);

insert into #myColumns(
	ColName
)
select COLUMN_NAME from information_schema.columns where table_name = @myTableName

--select * from #myColumns
select @columnCounter = count(*) from #myColumns


select @columns = (stuff((select ', ' + ColName from #myColumns for xml path ('')), 1, 2, ''))
		

SET @SQLString = 'select '+ @columns +' from '+ @myTableName
EXECUTE sp_executesql @SQLString

drop table #myColumns
