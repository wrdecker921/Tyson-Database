CREATE PROCEDURE spDealsMissingMRL AS 

SET NOCOUNT ON 
DROP TABLE IF EXISTS #temp
SELECT * INTO #temp FROM (
SELECT 
		Deal 									
FROM vwDeal D
where Product = 'SM48'	
group by 		
		Deal 									
,		DealFromDate			
,		DealToDate					
,		DealLocation

EXCEPT 

SELECT 
		Deal 									

  FROM [Tyson].[dbo].[HistoricalMovementAnalysis]


group by 		
		Deal 									
,		DealFromDate			
,		DealToDate					
,		DealLocation
) A

select * FROM vwdeal WHERE Deal IN (SELECT * FROM #temp) 
AND DealFromDate <= '12/31/2016'