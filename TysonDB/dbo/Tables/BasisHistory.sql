CREATE TABLE [dbo].[BasisHistory] (
    [Price ID]         FLOAT (53)     NULL,
    [Location/Product] NVARCHAR (255) NULL,
    [Locale]           NVARCHAR (255) NULL,
    [Product]          NVARCHAR (255) NULL,
    [Modified]         NVARCHAR (255) NULL,
    [Currency/UOM]     NVARCHAR (255) NULL,
    [From Date]        DATETIME       NULL,
    [To Date]          DATETIME       NULL,
    [Type]             NVARCHAR (255) NULL,
    [Delivery Period]  NVARCHAR (255) NULL,
    [Status]           NVARCHAR (255) NULL,
    [Gravity Table]    NVARCHAR (255) NULL,
    [Gravity]          NVARCHAR (255) NULL,
    [Comment]          NVARCHAR (255) NULL,
    [Error Message]    NVARCHAR (255) NULL,
    [Settle]           FLOAT (53)     NULL,
    [Market]           FLOAT (53)     NULL
);

