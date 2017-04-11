



CREATE VIEW [dbo].[vwMonthlyBasisHistory] AS 

SELECT 
	Locale		=	BH.Locale
,	Product		=	BH.Product
,	FromMonth	=	MONTH(BH.[From Date])
,	FromYear	=	YEAR(BH.[From Date])
,	Basis		=	ROUND(AVG(BH.Settle), 2) 

FROM BasisHistory BH
GROUP BY 
	BH.Locale
,	BH.Product
,	MONTH(BH.[From Date])
,	YEAR(BH.[From Date])