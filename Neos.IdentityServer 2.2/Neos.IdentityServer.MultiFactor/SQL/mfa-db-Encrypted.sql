USE [%DATABASENAME%];

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

CREATE TABLE [dbo].[REGISTRATIONS](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UPN] [varchar](50) NOT NULL,
	[SECRETKEY] [varchar](8000) COLLATE Latin1_General_BIN2 ENCRYPTED WITH (COLUMN_ENCRYPTION_KEY = [%SQLKEY%], ENCRYPTION_TYPE = Randomized, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NULL,
	[MAILADDRESS] [varchar](50) COLLATE Latin1_General_BIN2 ENCRYPTED WITH (COLUMN_ENCRYPTION_KEY = [%SQLKEY%], ENCRYPTION_TYPE = Deterministic, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NULL,
	[PHONENUMBER] [varchar](50) COLLATE Latin1_General_BIN2 ENCRYPTED WITH (COLUMN_ENCRYPTION_KEY = [%SQLKEY%], ENCRYPTION_TYPE = Deterministic, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NULL,
	[PIN] [int] ENCRYPTED WITH (COLUMN_ENCRYPTION_KEY = [%SQLKEY%], ENCRYPTION_TYPE = Randomized, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NOT NULL,
	[ENABLED] [bit] NOT NULL,
	[METHOD] [int] NOT NULL,
	[OVERRIDE] [nvarchar](1024) NULL,
 CONSTRAINT [PK_REGISTRATIONS] PRIMARY KEY CLUSTERED ([ID] ASC) ,
 CONSTRAINT [IX_REGISTRATIONS_UPN] UNIQUE NONCLUSTERED ([UPN] ASC) 
 );

ALTER TABLE [dbo].[REGISTRATIONS] ADD  CONSTRAINT [DF_REGISTRATIONS_ENABLED]  DEFAULT ((1)) FOR [ENABLED];

ALTER TABLE [dbo].[REGISTRATIONS] ADD  CONSTRAINT [DF_REGISTRATIONS_PREFEREDMETHOD]  DEFAULT ((0)) FOR [METHOD];

USE [master];

ALTER DATABASE [%DATABASENAME%] SET READ_WRITE;

