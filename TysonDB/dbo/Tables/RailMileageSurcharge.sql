CREATE TABLE [dbo].[RailMileageSurcharge] (
    [Railroad]         VARCHAR (80)   NULL,
    [Price ID]         DECIMAL (18)   NULL,
    [Location/Product] VARCHAR (80)   NULL,
    [Locale]           VARCHAR (80)   NULL,
    [Product]          VARCHAR (25)   NULL,
    [Modified]         VARCHAR (25)   NULL,
    [Currency/UOM]     VARCHAR (25)   NULL,
    [From Date]        DATETIME       NULL,
    [To Date]          DATETIME       NULL,
    [Type]             VARCHAR (25)   NULL,
    [Delivery Period]  VARCHAR (25)   NULL,
    [Status]           VARCHAR (25)   NULL,
    [Gravity Table]    VARCHAR (25)   NULL,
    [Gravity]          VARCHAR (25)   NULL,
    [Comment]          VARCHAR (25)   NULL,
    [Error Message]    VARCHAR (25)   NULL,
    [Surcharge]        DECIMAL (9, 5) NULL
);

