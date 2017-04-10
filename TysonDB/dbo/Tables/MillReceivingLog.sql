CREATE TABLE [dbo].[MillReceivingLog] (
    [PO#]                NVARCHAR (255) NULL,
    [Delivery]           NVARCHAR (255) NULL,
    [Recv #]             FLOAT (53)     NULL,
    [Unload Date]        DATETIME       NULL,
    [Car/Truck #]        FLOAT (53)     NULL,
    [Lbs Rcvd]           FLOAT (53)     NULL,
    [Paid Lbs]           FLOAT (53)     NULL,
    [Variance]           FLOAT (53)     NULL,
    [Product Cost]       FLOAT (53)     NULL,
    [UOM]                NVARCHAR (255) NULL,
    [Total Product Cost] FLOAT (53)     NULL,
    [FOB Terms]          NVARCHAR (255) NULL,
    [Freight Cost]       FLOAT (53)     NULL,
    [Mvt Hdr ID]         FLOAT (53)     NULL,
    [Item]               NVARCHAR (255) NULL,
    [Location]           NVARCHAR (255) NULL,
    [Vendor]             NVARCHAR (255) NULL
);

