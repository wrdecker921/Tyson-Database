


CREATE VIEW [dbo].[vwDeal] AS 

WITH OPP AS (


SELECT 		
		PurchaseOrder			=	OPP.[Purchase Order]
,		Vendor					=	OPP.[Vendor]
,		DealQty					=	OPP.[Deal Qty]
,		ShippedQty				=	SUM(OPP.[Shipped Qty]) 
,		ReceivedQty				=	SUM(OPP.[Received Qty]) 
,		TransMethod				=	OPP.[Trans Method]
,		Price					=	OPP.[Price]
,		FillPrice				=	OPP.[Fill Price]
,		Offset					=	OPP.[Offset]
,		CashPrice				=	OPP.[Cash Price]
,		BUCustomer				=	OPP.[BU Customer]
,		Region					=	OPP.[Region]
,		DeliveryPeriod			=	OPP.[Delivery Period]
FROM OpenandPendingPOReport OPP

GROUP BY	
		OPP.[Purchase Order]
,		OPP.[Vendor]
,		OPP.[Deal Qty]
,		OPP.[Trans Method]
,		OPP.[Price]
,		OPP.[Fill Price]
,		OPP.[Offset]
,		OPP.[Cash Price]
,		OPP.[BU Customer]
,		OPP.[Region]
,		OPP.[Delivery Period]

)


SELECT 		
		Deal 						=	OPP.[PurchaseOrder]  				
,		Vendor						=	OPP.[Vendor]
,		VendorType					=	V.BATypeCode
,		INCOTerm					=	SDD.[Delivery Term] 				
,		DealLocation				=	SDD.[Location] 				
,		DealOrigin 					=	SDD.[Origin] 						
,		DealDestination				=	SDD.[Destination] 						
--, OPP.Location ScheduleLocation
,		DealFromDate				=	SDD.[From Date] 					 
,		DealToDate					=	SDD.[To Date] 					 			
,		TotalDealQty				=	OPP.[DealQty]						
,		TotalShippedQuantity		=	OPP.[ShippedQty] 				 
,		TotalReceivedQuantity		=	OPP.[ReceivedQty]
,		DealTransportationMethod	=	CASE WHEN OPP.[TransMethod] = 'C' THEN 'Railcar' 
											 WHEN OPP.[TransMethod] = 'R' THEN 'Truck' 
											 ELSE 'Other'
											 END 								
--	,Price 
,		FillPrice					=	OPP.[FillPrice] 								
,		Offset 						=	OPP.[Offset]
,		CashPrice					=	OPP.[FillPrice] + OPP.[Offset] 					
,		BUCustomer					=	OPP.[BUCustomer] 						
--	,Region 									As Region
,		FuturesDeliveryPeriod		=	OPP.[DeliveryPeriod]
,		Product						=	SDD.[Product] --top
,		Trader						=	SDD.[Trader]									
--	,Sdd.Quantity		
,		TradeDate					=	SDD.[Deal Display Date] 					

 FROM  OPP
 LEFT JOIN SearchDealDetail SDD ON SDD.Deal = OPP.PurchaseOrder -- 9,710
  JOIN Vendor V				ON V.BusinessAssociate = OPP.Vendor




