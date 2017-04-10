﻿CREATE TABLE [dbo].[SearchDealDetail] (
    [Deal]              NVARCHAR (255) NULL,
    [R/D]               NVARCHAR (255) NULL,
    [Product]           NVARCHAR (255) NULL,
    [Location]          NVARCHAR (255) NULL,
    [From Date]         DATETIME       NULL,
    [To Date]           DATETIME       NULL,
    [Detail Type]       NVARCHAR (255) NULL,
    [Quantity]          FLOAT (53)     NULL,
    [UOM]               NVARCHAR (255) NULL,
    [Volume Term]       NVARCHAR (255) NULL,
    [Origin]            NVARCHAR (255) NULL,
    [Destination]       NVARCHAR (255) NULL,
    [Status]            NVARCHAR (255) NULL,
    [SubType]           NVARCHAR (255) NULL,
    [Revision Level]    FLOAT (53)     NULL,
    [Revision Date]     DATETIME       NULL,
    [Revised By]        NVARCHAR (255) NULL,
    [External BA]       NVARCHAR (255) NULL,
    [Internal BA]       NVARCHAR (255) NULL,
    [Deal From Date]    DATETIME       NULL,
    [Deal To Date]      DATETIME       NULL,
    [Trader]            NVARCHAR (255) NULL,
    [Delivery Term]     NVARCHAR (255) NULL,
    [Aircraft Detail]   NVARCHAR (255) NULL,
    [Deal Display Date] DATETIME       NULL
);

