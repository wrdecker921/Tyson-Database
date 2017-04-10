CREATE VIEW [dbo].[vwHistTradingStrat] AS 
SELECT
	Deal											=	SDD.[Deal]
,	UnloadDate										=	MRL.[Unload Date]
,	ContractExecutionDate							=	SDD.[Deal Display Date]
,	SizeofDealTons									=	SDD.Quantity
,	Product											=	SDD.[Product]
,	Feedmill										=	SDD.[Location]
,	Trader											=	SDD.Trader								   
,	Vendor											=	MRL.Vendor
,	Market											=	BH2.Market
,	PurchasedValue									=	BH.Settle
FROM SearchDealDetail SDD 
JOIN [Tyson].[dbo].[BasisHistory] BH	ON BH.Product = SDD.Product AND BH.Locale = SDD.[Location] AND CAST(BH.[From Date] AS DATE) <= SDD.[Deal Display Date] AND CAST(BH.[To Date] AS DATE) >= SDD.[Deal Display Date]
JOIN MillReceivingLog MRL				ON MRL.PO# = SDD.Deal
JOIN [Tyson].[dbo].[BasisHistory] BH2	ON BH2.Product = SDD.Product AND BH2.Locale = SDD.[Location] AND CAST(BH2.[From Date] AS DATE) <= MRL.[Unload Date] AND CAST(BH2.[To Date] AS DATE) >= MRL.[Unload Date]




