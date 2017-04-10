
CREATE VIEW [dbo].[vwMovement] AS 

SELECT 		
	Deal					=	MRL.[PO#] 							 
,	TransportationMethod	=	MRL.[Delivery] 							
,	ReceiverNumber			=	MRL.[Recv #] 							
,	UnloadDate				=	MRL.[Unload Date] 					
--,M.[Movement Date] UnloadMovementdate
,	CarTruckNumber			=	MRL.[Car/Truck #]						
,	LbsReceived				=	MRL.[Lbs Rcvd]						
,	LbsPaid					=	MRL.[Paid Lbs]						
,	GallonsReceived			=	M.[Net Quantity]				
,	MovementProductCost		=	MRL.[Total Product Cost]				
--,[FOB Terms] INCOLocation
,	Carrier					=	M.[Line Item Carrier BA]			
,	FeedMill				=	ISNULL(M.[Line Item Destination],M.[Line Item Move Location])
,	FeedMillOLD				=	MRL.[Location] 						
,	FreightCost				=	MRL.[Freight Cost]				
,	MovementOrigin			=	ISNULL(M2.[Line Item Move Location], M.[Line Item Move Location])
,	CarType					=	M2.[Car Type]					 				
,	CarOwnerShip			=	M2.[Car Ownership]				
,	GallonsLoaded			=	M2.[Net Quantity]				
,	ShipDate				=	M2.[Movement Date]				

FROM 	MillReceivingLog MRL
JOIN 	Movement M					ON M.[Line Item ID]  = MRL.[Mvt Hdr ID]
LEFT JOIN Movement M2				ON M.Receiver        = M2.Receiver
WHERE 1=1
AND CASE WHEN delivery = 'truck' THEN -1 ELSE M2.[Line Item ID] END <> M.[Line Item ID]



