/*------------------------------------------------------------------------------------------------------------------------------------  
-- SP:             SP_GetMovementHistoricalAnalysis       
-- Arguments:      
-- Tables:           
-- Stored Procs:     
-- Dynamic Tables: None  
-- Overview:       Returns Feed Mill movements with performance measurement details
-- Created by:     Mike Scharf
-- History:        03/26/2017
-- Date Modified Modified By        Modification  
-- ------------- ------------------ -------------------------------------------------------------------------------------------  
-- 
----------------------------------------------------------------------------------------------------------------------------------*/  
/*
Corydon FM Gateway Ramsey does not exist (i.e. no basis or freight)
*/ 

 
CREATE PROCEDURE [dbo].[SP_GetMovementHistoricalAnalysis] (@sdt_FromDate  smalldatetime = '1/1/2012'
												            , @sdt_ToDate smalldatetime = '12/31/2016'
												            , @vc_FeedMill varchar(50) = NULL )  
  
AS  
  
Set NoCount On  
  
/*----------------------------------------------------------- 
-- Declarations.
-----------------------------------------------------------*/
Declare @i_blank int	
		,@d_blank decimal(15,6)
		,@vc_blank varchar(255)	

/*----------------------------------------------------------- 
-- Insert Movements into temp table
-----------------------------------------------------------*/
Select	D.Deal
		,D.Vendor
		,D.VendorType
		,D.IncoTerm
		,D.DealLocation
		,D.DealFromDate
		,D.DealToDate
		,D.TotalDealQty
		,D.CashPrice
		,D.FillPrice
		,D.Offset
		,D.FuturesDeliveryPeriod
		,D.Product
		,D.Trader
		,D.TradeDate
		,M.ReceiverNumber
		,M.TransportationMethod
		,M.FeedMill
		,M.UnloadDate
		,M.MovementOrigin
		,M.ShipDate
		,M.Carrier
		,M.CarTruckNumber
		,M.LbsReceived
		,M.LbsPaid
		,M.MovementProductCost
		,M.FreightCost -- *** need to verify
		,M.CarType
		,M.CarOwnership
		,LGW.Abbreviation As Gateway
		,GW.BANme As GatewayRailroad
		,@d_blank GW2FM_RailTariff
		,@d_blank GW2FM_Mileage
		,@d_blank GW2FM_MileageSurchage
		,@d_blank GW2FM_FuelSurcharge
		,@d_blank GW2FM_PerTonTariff
		/*
		,@d_blank Origin2FM_RailTariff
		,@d_blank Origin2FM_Mileage
		,@d_blank Origin2FM_MileageSurchage
		,@d_blank Origin2FM_FuelSurcharge
		*/
		,@d_blank DerivedGatewayBasis
		,@d_blank GatewayMarketBasis_ReceivedDate
--		,@d_blank GatewayMarketBasis_TradeDate
		,@d_blank MarginPerTon_ReceivedDate
--		,@d_blank MarginPerTon_TradeDate
		,@vc_blank as 'RecordStatus'
		,@vc_blank as 'ErrorMessage'
		/*
		NEED Vendor Class of Trade
		*/
into	#Movements	-- *** Need to remove and create table first
From	vwDeal D
		Join 			vwMovement	M			on D.Deal       = M.Deal
		Join			Location	LFM 		on M.FeedMill   = LFM.Abbreviation
		Left Join 		tf_gateway_mapping GW	on LFM.Name     = GW.FeedMill
												and GW.PrdctNme = '1280 - Soybean Meal 48%'
 		Left Join		Location LGW			on GW.Gateway   = LGW.Name
Where	M.UnloadDate between @sdt_FromDate and @sdt_ToDate
and		M.FeedMill		= ISNULL(@vc_FeedMill,M.FeedMill)

/*----------------------------------------------------------- 
-- Update error status and message if we have missing information
-----------------------------------------------------------*/
Update	#Movements
Set		RecordStatus = 'Error'
		,ErrorMessage = 'Error: Unable to determine Gateway'
Where	Gateway IS NULL

/*----------------------------------------------------------- 
-- Determine the Rail Costs from Gateway to FM
----------------------------------------------------------*/
	/*----------------------------------------------------------- 
	-- Get the Rail Tariff from Gateway to FM
	----------------------------------------------------------*/
	Update #Movements 
	Set		GW2FM_RailTariff		= Convert(decimal(15,6),RT.SingleStandardRR) -- *** is this the right tariff to use 
	From	RailTariff RT	
	Where	#Movements.Gateway          = RT.FromLocation
	and 	#Movements.FeedMill         = RT.ToLocation
	and		#Movements.Product          = RT.Product
	and 	#Movements.ShipDate      between RT.[From Date] and RT.[To Date]
	-- *** should we qualify by Railroad?

	/*----------------------------------------------------------- 
	-- Get the Mileage from Gateway to FM
	----------------------------------------------------------*/
	Update #Movements 
	Set		GW2FM_Mileage					= Mileage 
	From	RailMileage RM	
	Where	#Movements.Gateway          = RM.FromLocation
	and 	#Movements.FeedMill         = RM.ToLocation
	and		#Movements.Product          = RM.Product
	and 	#Movements.UnloadDate      between RM.[From Date] and RM.[To Date]

	/*----------------------------------------------------------- 
	-- Get the Mileage Surcharge for Railroad and Product 
	----------------------------------------------------------*/
	Update #Movements 
	Set		GW2FM_MileageSurchage			= Surcharge 
	From	RailMileageSurcharge RMS	
	Where	#Movements.GatewayRailroad  = RMS.RailRoad
	and		#Movements.Product          = RMS.Product
	and 	#Movements.UnloadDate      between RMS.[From Date] and RMS.[To Date]

	/*----------------------------------------------------------- 
	-- Get the Fuel Surcharge for Railroad and Product 
	----------------------------------------------------------*/
	--- *** Need to add	

	/*----------------------------------------------------------- 
	-- Update error status and message if we have missing information
	-----------------------------------------------------------*/
	Update	#Movements
	Set		RecordStatus = 'Error'
			,ErrorMessage = 'Error: Unable to determine Rail Tariff or Milege from Gateway to FeedMill'
	Where	(GW2FM_RailTariff IS NULL 
	or 		GW2FM_Mileage	IS NULL)
	and		RecordStatus IS NULL

/*----------------------------------------------------------- 
-- Convert the Rail Tariff to a per ton value
----------------------------------------------------------*/
Update #Movements
Set		GW2FM_PerTonTariff  = (GW2FM_RailTariff + (GW2FM_Mileage * ISNULL(GW2FM_MileageSurchage,0))) / 100
Where	RecordStatus IS NULL

/*----------------------------------------------------------- 
-- Calculate Derived Gateway Basis 
-- Derived Gateway Basis = Deal Basis + Freight/Ton - Gateway to FeedMill Freight / Ton
-- Freight/Ton includes the adjustments when the actual ship to or delivered location is different from the contractual location

--- *** Should we being using the received weight or a notional weight per transport type
----------------------------------------------------------*/
Update #Movements
Set		DerivedGatewayBasis = (Offset + ((ISNULL(FreightCost,0)/(Case When LbsReceived = 0 Then 1 Else LbsReceived End))*2000)) 

- GW2FM_PerTonTariff
Where	RecordStatus IS NULL

/*----------------------------------------------------------- 
-- Calculate the Gateway market basis
----------------------------------------------------------*/
	/*----------------------------------------------------------- 
	-- Calculate the Gateway market basis using the received date
	-- *** Should we be using the settle or market?
	----------------------------------------------------------*/
	Update #Movements 
	Set		GatewayMarketBasis_ReceivedDate  = BH.Settle
	From	BasisHistory BH
	Where	#Movements.Gateway 			= BH.Locale
	and		#Movements.Product			= BH.Product
	and		#Movements.UnloadDate      between BH.[From Date] and BH.[To Date]	and		RecordStatus IS NULL

	/*----------------------------------------------------------- 
	-- Calculate the Gateway market basis using the trade date
	-- *** We don't have forward basis so we're not able to do this calculation
	----------------------------------------------------------*/
/*
	Update #Movements 
	Set		GatewayMarketBasis_TradeDate  = BH.Settle
	From	BasisHistory BH
	Where	#Movements.Gateway 			= BH.Locale
	and		#Movements.Product			= BH.Product
	and		#Movements.TradeDate      between BH.[From Date] and BH.[To Date]	and		RecordStatus IS NULL
*/

	/*----------------------------------------------------------- 
	-- Update error status and message if we have missing information
	-----------------------------------------------------------*/
	Update	#Movements
	Set		RecordStatus = 'Error'
			,ErrorMessage = 'Error: Unable to determine Market Gateway Basis'
	Where	GatewayMarketBasis_ReceivedDate IS NULL
	and		RecordStatus IS NULL

/*----------------------------------------------------------- 
-- Update Margin
----------------------------------------------------------*/
Update	#Movements
Set		MarginPerTon_ReceivedDate = GatewayMarketBasis_ReceivedDate - DerivedGatewayBasis
--		,MarginPerTon_TradeDate = GatewayMarketBasis_TradeDate - DerivedGatewayBasis
Where	RecordStatus IS NULL

/*----------------------------------------------------------- 
-- Set the record status for record that did not get an error
----------------------------------------------------------*/
Update #Movements
Set		RecordStatus = 'Complete'
Where	RecordStatus IS NULL

/*----------------------------------------------------------- 
-- Return Results Set
----------------------------------------------------------*/
DROP TABLE IF EXISTS HistoricalMovementAnalysis

Select * 
Into	 HistoricalMovementAnalysis
From	#Movements
--Where	RecordStatus = 'Complete'