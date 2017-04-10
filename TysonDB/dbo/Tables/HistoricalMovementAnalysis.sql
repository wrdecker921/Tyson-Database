﻿CREATE TABLE [dbo].[HistoricalMovementAnalysis] (
    [Deal]                            NVARCHAR (255)  NULL,
    [Vendor]                          NVARCHAR (255)  NULL,
    [VendorType]                      VARCHAR (255)   NULL,
    [IncoTerm]                        NVARCHAR (255)  NULL,
    [DealLocation]                    NVARCHAR (255)  NULL,
    [DealFromDate]                    DATETIME        NULL,
    [DealToDate]                      DATETIME        NULL,
    [TotalDealQty]                    FLOAT (53)      NULL,
    [CashPrice]                       FLOAT (53)      NULL,
    [FillPrice]                       FLOAT (53)      NULL,
    [Offset]                          FLOAT (53)      NULL,
    [FuturesDeliveryPeriod]           NVARCHAR (255)  NULL,
    [Product]                         NVARCHAR (255)  NULL,
    [Trader]                          NVARCHAR (255)  NULL,
    [TradeDate]                       DATETIME        NULL,
    [ReceiverNumber]                  FLOAT (53)      NULL,
    [TransportationMethod]            NVARCHAR (255)  NULL,
    [FeedMill]                        NVARCHAR (255)  NULL,
    [UnloadDate]                      DATETIME        NULL,
    [MovementOrigin]                  NVARCHAR (255)  NULL,
    [ShipDate]                        DATETIME        NULL,
    [Carrier]                         NVARCHAR (255)  NULL,
    [CarTruckNumber]                  FLOAT (53)      NULL,
    [LbsReceived]                     FLOAT (53)      NULL,
    [LbsPaid]                         FLOAT (53)      NULL,
    [MovementProductCost]             FLOAT (53)      NULL,
    [FreightCost]                     FLOAT (53)      NULL,
    [CarType]                         NVARCHAR (255)  NULL,
    [CarOwnership]                    NVARCHAR (255)  NULL,
    [Gateway]                         VARCHAR (100)   NULL,
    [GatewayRailroad]                 NVARCHAR (255)  NULL,
    [GW2FM_RailTariff]                DECIMAL (15, 6) NULL,
    [GW2FM_Mileage]                   DECIMAL (15, 6) NULL,
    [GW2FM_MileageSurchage]           DECIMAL (15, 6) NULL,
    [GW2FM_FuelSurcharge]             DECIMAL (15, 6) NULL,
    [GW2FM_PerTonTariff]              DECIMAL (15, 6) NULL,
    [DerivedGatewayBasis]             DECIMAL (15, 6) NULL,
    [GatewayMarketBasis_ReceivedDate] DECIMAL (15, 6) NULL,
    [MarginPerTon_ReceivedDate]       DECIMAL (15, 6) NULL,
    [RecordStatus]                    VARCHAR (255)   NULL,
    [ErrorMessage]                    VARCHAR (255)   NULL
);
