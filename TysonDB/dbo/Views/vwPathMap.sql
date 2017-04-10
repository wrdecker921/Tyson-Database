CREATE VIEW vwPathMap AS 

SELECT 
	   PathID = [Deal] 
      ,[DealLocation]
      ,Origin = [MovementOrigin]      
      ,Destination = [FeedMill]
	  ,Latitude
	  ,Longitude
	  ,PathOrder = 1
	  --,[IncoTerm]
	  ,[Vendor]
   --   ,[DealFromDate]
   --   ,[DealToDate]
   --   ,[TotalDealQty]
   --   ,[CashPrice]
   --   ,[FillPrice]
   --   ,[Offset]
   --   ,[FuturesDeliveryPeriod]
   --   ,[Product]
   --   ,[Trader]
   --   ,[TradeDate]
   --   ,[ReceiverNumber]
   --   ,[TransportationMethod]

      ,YEAR([UnloadDate]) as UnloadDate

   --   ,[ShipDate]
   --   ,[Carrier]
   --   ,[CarTruckNumber]
      , [LbsReceived]
   --   ,[LbsPaid]
   --   ,[MovementProductCost]
   --   ,[FreightCost]
   --   ,[CarType]
   --   ,[CarOwnership]
   --   ,[Gateway]
   --   ,[GatewayRailroad]
   --   ,[GW2FM_RailTariff]
   --   ,[GW2FM_Mileage]
   --   ,[GW2FM_MileageSurchage]
   --   ,[GW2FM_FuelSurcharge]
   --   ,[GW2FM_PerTonTariff]
   --   ,[DerivedGatewayBasis]
   --   ,[GatewayMarketBasis_ReceivedDate]
      ,[MarginPerTon_ReceivedDate]
   --   ,[RecordStatus]
   --   ,[ErrorMessage]
  FROM [Tyson].[dbo].[HistoricalMovementAnalysis] M
  JOIN Location L ON L.Abbreviation = M.MovementOrigin
  GROUP BY 
	   [Deal] 
      ,[DealLocation]
      ,[MovementOrigin]      
      ,[FeedMill]
	  ,Latitude
	  ,Longitude
,Vendor
,YEAR(UnloadDate)
,[LbsReceived]
,[MarginPerTon_ReceivedDate]


  UNION ALL 

  SELECT 
		
		[Deal]

      ,[DealLocation]
      ,Origin = [MovementOrigin]      
      ,Destination = [FeedMill]
	  ,Latitude
	  ,Longitude
	  ,PathOrder = 2
	  --,[IncoTerm]
	  ,[Vendor]
   --   ,[DealFromDate]
   --   ,[DealToDate]
   --   ,[TotalDealQty]
   --   ,[CashPrice]
   --   ,[FillPrice]
   --   ,[Offset]
   --   ,[FuturesDeliveryPeriod]
   --   ,[Product]
   --   ,[Trader]
   --   ,[TradeDate]
   --   ,[ReceiverNumber]
   --   ,[TransportationMethod]

       ,YEAR([UnloadDate]) as UnloadDate

   --   ,[ShipDate]
   --   ,[Carrier]
   --   ,[CarTruckNumber]
      , [LbsReceived]
   --   ,[LbsPaid]
   --   ,[MovementProductCost]
   --   ,[FreightCost]
   --   ,[CarType]
   --   ,[CarOwnership]
   --   ,[Gateway]
   --   ,[GatewayRailroad]
   --   ,[GW2FM_RailTariff]
   --   ,[GW2FM_Mileage]
   --   ,[GW2FM_MileageSurchage]
   --   ,[GW2FM_FuelSurcharge]
   --   ,[GW2FM_PerTonTariff]
   --   ,[DerivedGatewayBasis]
   --   ,[GatewayMarketBasis_ReceivedDate]
      ,[MarginPerTon_ReceivedDate]
   --   ,[RecordStatus]
   --   ,[ErrorMessage]
  FROM [Tyson].[dbo].[HistoricalMovementAnalysis] M
  JOIN Location L ON L.Abbreviation = M.FeedMill
    GROUP BY 
	   [Deal] 
      ,[DealLocation]
      ,[MovementOrigin]      
      ,[FeedMill]
	  ,Latitude
	  ,Longitude
,Vendor
,YEAR(UnloadDate)
,[LbsReceived]
,[MarginPerTon_ReceivedDate]


