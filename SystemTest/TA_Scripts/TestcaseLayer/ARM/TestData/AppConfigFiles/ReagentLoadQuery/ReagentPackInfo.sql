USE [SIM]
GO

DROP TABLE [dbo].[reagentPackInfo]
GO

/****** Object:  Table [dbo].[reagentPackInfo]    Script Date: 5/30/2019 4:40:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[reagentPackInfo](
	[iReagentPackInfoSN] [int] IDENTITY(1,1) NOT NULL,
	[szBarcode] [nvarchar](128) NOT NULL,
	[szLastModule] [nvarchar](64) NOT NULL,
	[szMatchingBarcode] [nvarchar](128) NOT NULL,
	[dtLastLoaded] [datetime] NOT NULL,
 CONSTRAINT [reagentPackInfo_PK] PRIMARY KEY CLUSTERED 
(
	[iReagentPackInfoSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[reagentPackInfo] ADD  DEFAULT (N'*') FOR [szBarcode]
GO

ALTER TABLE [dbo].[reagentPackInfo] ADD  DEFAULT (N'*') FOR [szLastModule]
GO

ALTER TABLE [dbo].[reagentPackInfo] ADD  DEFAULT (N'*') FOR [szMatchingBarcode]
GO

ALTER TABLE [dbo].[reagentPackInfo] ADD  DEFAULT ('01/01/1999') FOR [dtLastLoaded]
GO
