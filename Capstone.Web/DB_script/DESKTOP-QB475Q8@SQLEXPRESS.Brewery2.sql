/*=============================================================
SCRIPT HEADER

VERSION:   1.01.0003
DATE:      05-19-2018 13:41:35
SERVER:    DESKTOP-QB475Q8\SQLEXPRESS

DATABASE:	Brewery
	Tables:
		beerPhotos, beers, breweries, breweryPhotos, operation, reviews
		users


=============================================================*/
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET ARITHABORT ON
SET NOCOUNT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
GO
-- BEGINNING TRANSACTION STRUCTURE
PRINT 'Beginning transaction STRUCTURE'
BEGIN TRANSACTION _STRUCTURE_
GO
-- Create Table [dbo].[breweries]
Print 'Create Table [dbo].[breweries]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
CREATE TABLE [dbo].[breweries] (
		[id]                [int] IDENTITY(1, 1) NOT NULL,
		[name]              [varchar](100) NOT NULL,
		[history]           [varchar](max) NULL,
		[imagery]           [varchar](max) NULL,
		[address]           [varchar](300) NULL,
		[contact_name]      [varchar](100) NULL,
		[contact_email]     [varchar](100) NULL,
		[contact_phone]     [varchar](30) NULL,
		CONSTRAINT [pk_breweries]
		PRIMARY KEY
		CLUSTERED
		([id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[breweries] SET (LOCK_ESCALATION = TABLE)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Table [dbo].[beers]
Print 'Create Table [dbo].[beers]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
CREATE TABLE [dbo].[beers] (
		[id]              [int] IDENTITY(1, 1) NOT NULL,
		[name]            [varchar](max) NOT NULL,
		[description]     [varchar](max) NOT NULL,
		[IMAGE]           [varchar](100) NULL,
		[abv]             [varchar](20) NULL,
		[beer_type]       [varchar](100) NOT NULL,
		[brewery_id]      [int] NOT NULL,
		[show_hide]       [bit] NOT NULL,
		CONSTRAINT [pk_beers]
		PRIMARY KEY
		CLUSTERED
		([id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[beers]
	ADD
	CONSTRAINT [DF__beers__show_hide__66EA454A]
	DEFAULT ((1)) FOR [show_hide]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[beers] SET (LOCK_ESCALATION = TABLE)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Table [dbo].[breweryPhotos]
Print 'Create Table [dbo].[breweryPhotos]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
CREATE TABLE [dbo].[breweryPhotos] (
		[BreweryPhotoID]     [int] IDENTITY(1, 1) NOT NULL,
		[FILE_NAME]          [varchar](100) NULL,
		[brewery_id]         [int] NULL,
		[profile_pic]        [bit] NULL
) ON [PRIMARY]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[breweryPhotos]
	ADD
	CONSTRAINT [DF__breweryPh__profi__69C6B1F5]
	DEFAULT ((0)) FOR [profile_pic]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[breweryPhotos] SET (LOCK_ESCALATION = TABLE)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Table [dbo].[operation]
Print 'Create Table [dbo].[operation]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
CREATE TABLE [dbo].[operation] (
		[brewery_id]     [int] NOT NULL,
		[DAY]            [varchar](12) NULL,
		[opens]          [varchar](50) NULL,
		[closes]         [varchar](50) NULL
) ON [PRIMARY]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[operation] SET (LOCK_ESCALATION = TABLE)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Table [dbo].[users]
Print 'Create Table [dbo].[users]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
CREATE TABLE [dbo].[users] (
		[id]               [int] IDENTITY(1, 1) NOT NULL,
		[email]            [varchar](200) NOT NULL,
		[username]         [varchar](100) NOT NULL,
		[slowhashsalt]     [varchar](100) NOT NULL,
		[is_brewer]        [bit] NOT NULL,
		[brewery_id]       [int] NULL,
		[is_admin]         [bit] NOT NULL,
		CONSTRAINT [UQ__users__AB6E616420E70295]
		UNIQUE
		NONCLUSTERED
		([email])
		ON [PRIMARY],
		CONSTRAINT [pk_users]
		PRIMARY KEY
		CLUSTERED
		([id])
	ON [PRIMARY]
) ON [PRIMARY]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[users]
	ADD
	CONSTRAINT [DF__users__is_admin__6319B466]
	DEFAULT ((0)) FOR [is_admin]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[users]
	ADD
	CONSTRAINT [DF__users__is_brewer__6225902D]
	DEFAULT ((0)) FOR [is_brewer]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[users] SET (LOCK_ESCALATION = TABLE)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Table [dbo].[beerPhotos]
Print 'Create Table [dbo].[beerPhotos]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
CREATE TABLE [dbo].[beerPhotos] (
		[BeerPhotoID]     [int] IDENTITY(1, 1) NOT NULL,
		[FILE_NAME]       [varchar](100) NULL,
		[beer_id]         [int] NULL,
		[breweryID]       [int] NOT NULL
) ON [PRIMARY]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[beerPhotos] SET (LOCK_ESCALATION = TABLE)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Table [dbo].[reviews]
Print 'Create Table [dbo].[reviews]'
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
CREATE TABLE [dbo].[reviews] (
		[id]              [int] IDENTITY(1, 1) NOT NULL,
		[USER_ID]         [int] NOT NULL,
		[beer_id]         [int] NOT NULL,
		[rating]          [int] NOT NULL,
		[review]          [varchar](max) NOT NULL,
		[review_date]     [date] NULL,
		CONSTRAINT [pk_reviews]
		PRIMARY KEY
		CLUSTERED
		([id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
ALTER TABLE [dbo].[reviews] SET (LOCK_ESCALATION = TABLE)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Foreign Key fk_beers_brewery_info on beers
Print 'Create Foreign Key fk_beers_brewery_info on beers'
GO
ALTER TABLE [dbo].[beers]
	WITH CHECK
	ADD CONSTRAINT [fk_beers_brewery_info]
	FOREIGN KEY ([brewery_id]) REFERENCES [dbo].[breweries] ([id])
ALTER TABLE [dbo].[beers]
	CHECK CONSTRAINT [fk_beers_brewery_info]

GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Foreign Key fk_breweryPhotos_breweries on breweryPhotos
Print 'Create Foreign Key fk_breweryPhotos_breweries on breweryPhotos'
GO
ALTER TABLE [dbo].[breweryPhotos]
	WITH CHECK
	ADD CONSTRAINT [fk_breweryPhotos_breweries]
	FOREIGN KEY ([brewery_id]) REFERENCES [dbo].[breweries] ([id])
ALTER TABLE [dbo].[breweryPhotos]
	CHECK CONSTRAINT [fk_breweryPhotos_breweries]

GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Foreign Key fk_operation_breweries on operation
Print 'Create Foreign Key fk_operation_breweries on operation'
GO
ALTER TABLE [dbo].[operation]
	WITH CHECK
	ADD CONSTRAINT [fk_operation_breweries]
	FOREIGN KEY ([brewery_id]) REFERENCES [dbo].[breweries] ([id])
ALTER TABLE [dbo].[operation]
	CHECK CONSTRAINT [fk_operation_breweries]

GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Foreign Key fk_users_breweries on users
Print 'Create Foreign Key fk_users_breweries on users'
GO
ALTER TABLE [dbo].[users]
	WITH CHECK
	ADD CONSTRAINT [fk_users_breweries]
	FOREIGN KEY ([brewery_id]) REFERENCES [dbo].[breweries] ([id])
ALTER TABLE [dbo].[users]
	CHECK CONSTRAINT [fk_users_breweries]

GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Foreign Key fk_beerPhotos_beerid on beerPhotos
Print 'Create Foreign Key fk_beerPhotos_beerid on beerPhotos'
GO
ALTER TABLE [dbo].[beerPhotos]
	WITH CHECK
	ADD CONSTRAINT [fk_beerPhotos_beerid]
	FOREIGN KEY ([beer_id]) REFERENCES [dbo].[beers] ([id])
ALTER TABLE [dbo].[beerPhotos]
	CHECK CONSTRAINT [fk_beerPhotos_beerid]

GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create Foreign Key fk_beerPhotos_breweries on beerPhotos
Print 'Create Foreign Key fk_beerPhotos_breweries on beerPhotos'
GO
ALTER TABLE [dbo].[beerPhotos]
	WITH CHECK
	ADD CONSTRAINT [fk_beerPhotos_breweries]
	FOREIGN KEY ([breweryID]) REFERENCES [dbo].[breweries] ([id])
ALTER TABLE [dbo].[beerPhotos]
	CHECK CONSTRAINT [fk_beerPhotos_breweries]

GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- Create Foreign Key fk_reviews_beers on reviews
Print 'Create Foreign Key fk_reviews_beers on reviews'
GO
ALTER TABLE [dbo].[reviews]
	WITH CHECK
	ADD CONSTRAINT [fk_reviews_beers]
	FOREIGN KEY ([beer_id]) REFERENCES [dbo].[beers] ([id])
ALTER TABLE [dbo].[reviews]
	CHECK CONSTRAINT [fk_reviews_beers]

GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO
-- Create Foreign Key fk_reviews_user_info on reviews
Print 'Create Foreign Key fk_reviews_user_info on reviews'
GO
ALTER TABLE [dbo].[reviews]
	WITH CHECK
	ADD CONSTRAINT [fk_reviews_user_info]
	FOREIGN KEY ([USER_ID]) REFERENCES [dbo].[users] ([id])
ALTER TABLE [dbo].[reviews]
	CHECK CONSTRAINT [fk_reviews_user_info]

GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

-- COMMITTING TRANSACTION STRUCTURE
PRINT 'Committing transaction STRUCTURE'
IF @@TRANCOUNT>0
	COMMIT TRANSACTION _STRUCTURE_
GO

SET NOEXEC OFF
GO
-- BEGINNING TRANSACTION DATA
PRINT 'Beginning transaction DATA'
BEGIN TRANSACTION _DATA_
GO
SET NOEXEC OFF
SET IMPLICIT_TRANSACTIONS OFF
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

-- Foreign Key Constraint Disable's for Table: [dbo].[beers]
Print 'Foreign Key Constraint Disable''s for Table: [dbo].[beers]'
ALTER TABLE [dbo].[beers] NOCHECK CONSTRAINT [fk_beers_brewery_info]

-- Foreign Key Constraint Disable's for Table: [dbo].[breweryPhotos]
Print 'Foreign Key Constraint Disable''s for Table: [dbo].[breweryPhotos]'
ALTER TABLE [dbo].[breweryPhotos] NOCHECK CONSTRAINT [fk_breweryPhotos_breweries]

-- Foreign Key Constraint Disable's for Table: [dbo].[operation]
Print 'Foreign Key Constraint Disable''s for Table: [dbo].[operation]'
ALTER TABLE [dbo].[operation] NOCHECK CONSTRAINT [fk_operation_breweries]

-- Foreign Key Constraint Disable's for Table: [dbo].[users]
Print 'Foreign Key Constraint Disable''s for Table: [dbo].[users]'
ALTER TABLE [dbo].[users] NOCHECK CONSTRAINT [fk_users_breweries]

-- Foreign Key Constraint Disable's for Table: [dbo].[beerPhotos]
Print 'Foreign Key Constraint Disable''s for Table: [dbo].[beerPhotos]'
ALTER TABLE [dbo].[beerPhotos] NOCHECK CONSTRAINT [fk_beerPhotos_beerid]
ALTER TABLE [dbo].[beerPhotos] NOCHECK CONSTRAINT [fk_beerPhotos_breweries]

-- Foreign Key Constraint Disable's for Table: [dbo].[reviews]
Print 'Foreign Key Constraint Disable''s for Table: [dbo].[reviews]'
ALTER TABLE [dbo].[reviews] NOCHECK CONSTRAINT [fk_reviews_beers]
ALTER TABLE [dbo].[reviews] NOCHECK CONSTRAINT [fk_reviews_user_info]

-- Deleting from table: [beerPhotos]
PRINT 'Deleting from table: [beerPhotos]'
DELETE FROM [dbo].[beerPhotos]
-- Deleting from table: [reviews]
PRINT 'Deleting from table: [reviews]'
DELETE FROM [dbo].[reviews]
-- Deleting from table: [beers]
PRINT 'Deleting from table: [beers]'
DELETE FROM [dbo].[beers]
-- Deleting from table: [breweryPhotos]
PRINT 'Deleting from table: [breweryPhotos]'
DELETE FROM [dbo].[breweryPhotos]
-- Deleting from table: [operation]
PRINT 'Deleting from table: [operation]'
DELETE FROM [dbo].[operation]
-- Deleting from table: [users]
PRINT 'Deleting from table: [users]'
DELETE FROM [dbo].[users]
-- Deleting from table: [breweries]
PRINT 'Deleting from table: [breweries]'
DELETE FROM [dbo].[breweries]
GO

-- Insert scripts for table: breweries
PRINT 'Inserting rows into table: breweries'
SET IDENTITY_INSERT [dbo].[breweries] ON

INSERT INTO [dbo].[breweries] ([id], [name], [history], [imagery], [address], [contact_name], [contact_email], [contact_phone]) VALUES (1, N'MadTree Brewing', N'Taproom, carryout, café, family hangout, meeting place… the MadTree taproom is a little bit of everything. Whether you want to fill up your growler or meet up with some of your friends for dinner and a beer, we are happy to have you drop in. ', NULL, N'3301 Madison Rd, Cincinnati, OH 45209', N'Mataan', N'MadTreeBrew@OTR.com', N'(513) 836-8733')
INSERT INTO [dbo].[breweries] ([id], [name], [history], [imagery], [address], [contact_name], [contact_email], [contact_phone]) VALUES (2, N'The Woodburn Brewery', N'Legend tells us the phoenix was a creature of unmatched beauty, living for a thousand years before going out in a blaze of glory. And just when you thought that bird was dead, it would rise from its own ashes, full of new life. That’s why we chose the phoenix as our brand mark. We believe in the rebirth of Cincinnati’s proud brewing legacy. The best is yet to come. And it’ll be delicious.', NULL, N'2800 Woodburn Ave, Cincinnati, OH 45206', N'Owner', N'WoodburnBrewery@OTR.com', N'(513) 221-2337')
INSERT INTO [dbo].[breweries] ([id], [name], [history], [imagery], [address], [contact_name], [contact_email], [contact_phone]) VALUES (3, N'Nine Giant', N'Nine Giant started with a simple question:  “What would make the ultimate taproom experience?”  For us, the answers were pretty easy.  Constant evolution of hand-crafted beers.  Scratch-made food, sourced from the highest quality ingredients.  A smaller, more intimate environment.  And a glistening wall of blue subway tile.', NULL, N'6095 Montgomery Rd, Cincinnati, OH 45213', N'Adam', N'9Giant@nine.com', N'(513) 366-4550')
INSERT INTO [dbo].[breweries] ([id], [name], [history], [imagery], [address], [contact_name], [contact_email], [contact_phone]) VALUES (4, N'Rhinegeist Brewery', N'Our name, Rhinegeist, translates to "Ghost of the Rhine" and refers to our place in the historic Over-the-Rhine Brewery District in Cincinnati. Built within the skeleton of the old Moerlein bottling plant (1895), we brew batches of beer that sing with flavor.', NULL, N'1910 Elm St, Cincinnati, OH 45202', N'Mary Rachel', N'MadTreeBrew@OTR.com', N'(513) 381-1367')
INSERT INTO [dbo].[breweries] ([id], [name], [history], [imagery], [address], [contact_name], [contact_email], [contact_phone]) VALUES (5, N'Fifty West Brewing Company', N'Located in a former roadside speakeasy on US Route 50 heading west into the city of Cincinnati, Fifty West Brewing Company first opened its doors in November of 2012. Since then, one thing has remained the same. Every time you have a Fifty West beer, you know it was handmade in small batches with a focus on the four virtues we hold closest to our hearts: craftsmanship, tradition, innovation, and patience.', NULL, N'7668 Route 50 Cincinnati, OH', N'Owner', N'WoodburnBrewery@OTR.com', N'(513) 834-8789')
GO

SET IDENTITY_INSERT [dbo].[breweries] OFF

-- Insert scripts for table: beers
PRINT 'Inserting rows into table: beers'
SET IDENTITY_INSERT [dbo].[beers] ON

INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (1, N'PSYCHOPATHY', N'Explore the blend of citrus, bright, and floral aromas. Additional citrus flavors follow alongside a smooth bitterness. It finishes with a medium body and a slightly sweet, malty backbone. Trust your senses.', NULL, N'6.9%', N'IPA', 1, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (2, N'LIFT', N'Whether taking a break from a hard day of work or just a huge day of hops, this crisp refreshing beer with a hint of orange will lift your spirits without lowering your expectations for what a craft beer should be.', NULL, N'4.7%', N'KÖLSCH', 1, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (3, N'PSA', N'PSA was designed to be just that, a Public Service Announcement that craft beer can be both thoughtful and approachable. ', NULL, N'4.5%', N'PALE ALE', 1, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (4, N'HAPPY AMBER', N'This dry-hopped ale combines carmel and biscuit malt flavors in happy equilibrium with late addition American hops. The approachable balance is intentional although the name is "hoppy accident."', NULL, N'6%', N'AMBER', 1, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (5, N'BERLINER WEISSE', N'Tart, bubbly, and refreshing Berliner.', NULL, N'4.0%', N'WHEAT', 2, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (6, N'BREAKFAST PORTER', N'Notes of chocolate, honey, and graham cracker…said to taste like a Teddy Graham.', NULL, N'6.3%', N'PORTER', 2, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (7, N'CEDAR IPA', N'Earthy and life-changing.', NULL, N'6.8%', N'IPA', 2, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (8, N'HAMMER SESSION IPA', N'Juicy, floral, citrus.', NULL, N'5.3%', N'IPA', 2, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (9, N'CREAM', N'Light and tasty. Nice way to start the night.', NULL, N'5.2%', N'Cream Ale', 3, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (10, N'Electrify', N'A beautifully hazy pale ale featuring Wakatu, Motueka and Idaho 7 hops for aromas of fresh crushed citrus and orange blossom.', NULL, N'5%', N'PALE ALE', 3, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (11, N'Infinite Spark', N'Our latest one-off IPA series featuring Galaxy and Columbus hops, ripe with aromas of tangerine peel and juicy, dank herbaciousness.', NULL, N'6.6%', N'IPA ', 3, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (12, N'Codex', N'A crisp, dry saison with aromas of fresh tangerine, honeysuckle and lilac', NULL, N'5.5%', N'FARMHOUSE ALE', 3, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (13, N'TRUTH', N'Brewed with a nod to the Pacific, hops sizzle with tropical fruit aroma, grapefruit and mango notes and a dry finish.', NULL, N'7.2%', N'IPA', 4, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (14, N'COUGAR', N'Hopped with arguable restraint with Crystal and Bravo hops, Cougar stays fierce enough to raise eyebrows yet is tame enough to be called sessionable.', NULL, N'4.8%', N'BLONDE ALE', 4, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (15, N'BUBBLES', N'A Rosé Ale made with apple, peach and cranberry, for additional pink hue, tartness and juicy fruitiness.', NULL, N'6.2%', N'ROSÉ ALE', 4, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (16, N'HUSTLE', N'This India Pale Ale takes a hard, hoppy cut at a soft, fluffy hanging curve, driving notes of peach, tangerine and citrus back, back, back...gone.', NULL, N'6.0%', N'IPA', 4, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (17, N'Coast to Coast', N'...', NULL, N'%', N'IPA', 5, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (18, N'Doom Pedal', N'...', NULL, N'%', N'White Ale', 5, 1)
INSERT INTO [dbo].[beers] ([id], [name], [description], [IMAGE], [abv], [beer_type], [brewery_id], [show_hide]) VALUES (19, N'American Lager', N'...', NULL, N'%', N'Pilsner', 5, 1)
GO

SET IDENTITY_INSERT [dbo].[beers] OFF

-- Insert scripts for table: breweryPhotos
PRINT 'Inserting rows into table: breweryPhotos'
SET IDENTITY_INSERT [dbo].[breweryPhotos] ON

INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (1, N'defaultPhoto.jpg', 1, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (2, N'defaultPhoto.jpg', 2, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (3, N'defaultPhoto.jpg', 3, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (4, N'defaultPhoto.jpg', 4, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (5, N'defaultPhoto.jpg', 5, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (6, N'MadTree Brewing1.jpg', 1, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (7, N'MadTree Brewing1.jpg', 1, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (8, N'MadTree Brewing1.jpg', 1, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (9, N'The Woodburn Brewery35.jpg', 2, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (10, N'The Woodburn Brewery46.jpg', 2, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (11, N'The Woodburn Brewery49.jpg', 2, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (12, N'The Woodburn Brewery50.jpg', 2, 1)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (13, N'MadTree Brewing45.jpg', 1, 1)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (14, N'MadTree Brewing40.jpg', 1, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (15, N'MadTree Brewing41.jpg', 1, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (16, N'MadTree Brewing42.jpg', 1, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (17, N'MadTree Brewing43.jpg', 1, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (18, N'MadTree Brewing44.jpg', 1, 0)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (19, N'Nine Giant36.jpg', 3, 1)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (20, N'Rhinegeist Brewery37.jpg', 4, 1)
INSERT INTO [dbo].[breweryPhotos] ([BreweryPhotoID], [FILE_NAME], [brewery_id], [profile_pic]) VALUES (21, N'Fifty West Brewing Company6.jpg', 5, 1)
GO

SET IDENTITY_INSERT [dbo].[breweryPhotos] OFF

-- Insert scripts for table: operation
PRINT 'Inserting rows into table: operation'
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (1, N'Monday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (1, N'Tuesday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (1, N'Wednesday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (1, N'Thursday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (1, N'Friday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (1, N'Saturday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (1, N'Sunday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (2, N'Monday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (2, N'Tuesday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (2, N'Wednesday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (2, N'Thursday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (2, N'Friday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (2, N'Saturday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (2, N'Sunday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (3, N'Monday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (3, N'Tuesday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (3, N'Wednesday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (3, N'Thursday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (3, N'Friday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (3, N'Saturday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (3, N'Sunday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (4, N'Monday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (4, N'Tuesday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (4, N'Wednesday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (4, N'Thursday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (4, N'Friday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (4, N'Saturday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (4, N'Sunday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (5, N'Monday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (5, N'Tuesday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (5, N'Wednesday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (5, N'Thursday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (5, N'Friday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (5, N'Saturday', N'1:00pm', N'2:30am')
INSERT INTO [dbo].[operation] ([brewery_id], [DAY], [opens], [closes]) VALUES (5, N'Sunday', N'1:00pm', N'2:30am')
GO

-- Insert scripts for table: users
PRINT 'Inserting rows into table: users'
SET IDENTITY_INSERT [dbo].[users] ON

INSERT INTO [dbo].[users] ([id], [email], [username], [slowhashsalt], [is_brewer], [brewery_id], [is_admin]) VALUES (1, N'admin@admin.com', N'Administrator', N'6/SSwmQGW6KxMQ==:47adbf593674b27f31725fbcc8fdb1348cf810f7158e8fbe035ab06c3ba50da8', 0, NULL, 1)
INSERT INTO [dbo].[users] ([id], [email], [username], [slowhashsalt], [is_brewer], [brewery_id], [is_admin]) VALUES (2, N'mabucar88@gmail.com', N'mataan', N'5m9F7wGkCYDJSA==:666d2885db33411cb1bd2a909b706ccc52dbcfdcb14b13c6a352a57a8470a8ad', 0, NULL, 0)
INSERT INTO [dbo].[users] ([id], [email], [username], [slowhashsalt], [is_brewer], [brewery_id], [is_admin]) VALUES (3, N'btbam513@gmail.com', N'abucar', N'gyvEy6Y8Z8CyfQ==:e3ccb229cae1b1907e2974a53a195c2919462925c4231ba45a401a1375a3afce', 0, NULL, 0)
INSERT INTO [dbo].[users] ([id], [email], [username], [slowhashsalt], [is_brewer], [brewery_id], [is_admin]) VALUES (4, N'mataanabucar@gmail.com', N'mattom88', N'd64TjHPt/Z4DZw==:1aa2399fba58be518a6f47590943cb6a6bcc1bbc5b3beb5df6a4235ce27c3c80', 1, 5, 0)
GO

SET IDENTITY_INSERT [dbo].[users] OFF

-- Insert scripts for table: beerPhotos
PRINT 'Inserting rows into table: beerPhotos'
SET IDENTITY_INSERT [dbo].[beerPhotos] ON

INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (1, N'PSYCHOPATHY.jpg		', 1, 1)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (2, N'LIFT.jpg				', 2, 1)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (3, N'PSA.jpg				', 3, 1)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (4, N'HAPPY AMBER.jpg		', 4, 1)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (5, N'BERLINER WEISSE.jpg	', 5, 2)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (6, N'BREAKFAST PORTER.jpg	', 6, 2)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (7, N'CEDAR IPA.jpg		 	', 7, 2)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (8, N'HAMMER SESSION IPA.jpg	', 8, 2)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (9, N'CREAM.jpg			', 9, 3)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (10, N'Electrify.jpg			', 10, 3)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (11, N'Infinite Spark.jpg	 	', 11, 3)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (12, N'Codex.jpg			', 12, 3)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (13, N'TRUTH.jpg			', 13, 4)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (14, N'COUGAR.jpg			', 14, 4)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (15, N'BUBBLES.jpg			', 15, 4)
INSERT INTO [dbo].[beerPhotos] ([BeerPhotoID], [FILE_NAME], [beer_id], [breweryID]) VALUES (16, N'HUSTLE.jpg			', 16, 4)
GO

SET IDENTITY_INSERT [dbo].[beerPhotos] OFF

-- Insert scripts for table: reviews
PRINT 'Inserting rows into table: reviews'
SET IDENTITY_INSERT [dbo].[reviews] ON

INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (1, 2, 3, 3, N'Good!', '2018-05-17')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (2, 2, 1, 1, N'Nope nope nope', '2018-05-18')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (3, 2, 2, 2, N'Nope nope nope', '2018-05-18')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (4, 2, 2, 5, N'Outstanding', '2018-05-22')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (5, 2, 11, 1, N'Nope nope nope', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (6, 2, 11, 1, N'Nope nope nope', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (7, 2, 11, 4, N'Outstanding', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (8, 3, 11, 4, N'tasty', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (9, 3, 11, 4, N'I would drink it again', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (10, 3, 11, 4, N'Outstanding', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (11, 3, 7, 4, N'Blam', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (12, 4, 7, 2, N'Nope nope nope', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (13, 4, 7, 1, N'Nope nope nope', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (14, 4, 7, 1, N'%$@# this beer!', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (15, 4, 7, 2, N'Nope nope nope', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (16, 2, 17, 2, N'Nope nope nope', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (17, 2, 17, 2, N'Nope nope nope', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (18, 2, 17, 5, N'Outstanding', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (19, 3, 17, 4, N'tasty', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (20, 3, 13, 5, N'I would drink it again', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (21, 3, 10, 2, N'Nope nope nope', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (22, 3, 9, 3, N'Blam', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (23, 4, 9, 1, N'Nope nope nope', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (24, 4, 9, 1, N'Yuck', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (25, 4, 9, 1, N'%$@# this beer!', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (26, 4, 9, 1, N'It will get you drunk!', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (27, 2, 13, 2, N'Outstanding', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (28, 2, 17, 1, N'Nope nope nope', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (29, 2, 13, 5, N'Outstanding', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (30, 3, 13, 4, N'tasty', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (31, 3, 15, 5, N'I would drink it again', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (32, 3, 10, 2, N'Nope nope nope', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (33, 3, 19, 3, N'Blam', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (34, 4, 19, 1, N'OMG', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (35, 4, 12, 1, N'Yuck', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (36, 4, 19, 1, N'Nope nope nope', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (37, 4, 10, 1, N'It will get you drunk!', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (44, 2, 3, 2, N'Outstanding', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (45, 2, 7, 3, N'Pretty good brew', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (46, 2, 3, 5, N'Outstanding', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (47, 3, 3, 4, N'tasty', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (48, 3, 5, 5, N'I would drink it again', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (49, 3, 10, 2, N'Outstanding', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (50, 3, 9, 3, N'Blam', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (51, 4, 9, 1, N'OMG', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (52, 4, 2, 1, N'Yuck', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (53, 4, 9, 1, N'%$@# this beer!', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (54, 4, 2, 1, N'It will get you drunk!', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (55, 2, 3, 2, N'Good!					 ', '2018-05-17')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (56, 2, 1, 2, N'Outstanding				 ', '2018-05-18')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (57, 2, 2, 2, N'Outstanding				 ', '2018-05-18')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (58, 2, 2, 2, N'Outstanding				 ', '2018-05-22')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (59, 2, 11, 2, N'Outstanding				 ', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (60, 2, 11, 2, N'Pretty good brew		 ', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (61, 2, 11, 2, N'Outstanding				 ', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (62, 3, 11, 2, N'tasty					 ', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (63, 3, 11, 2, N'I would drink it again	 ', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (64, 3, 11, 2, N'Outstanding				 ', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (65, 3, 7, 2, N'Blam					 ', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (66, 4, 7, 2, N'OMG						 ', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (67, 4, 7, 4, N'Yuck					 ', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (68, 4, 7, 4, N'%$@# this beer!			 ', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (69, 4, 7, 4, N'It will get you drunk!	 ', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (70, 2, 17, 4, N'Outstanding				 ', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (71, 2, 17, 4, N'Pretty good brew		 ', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (72, 2, 17, 4, N'Outstanding				 ', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (73, 3, 17, 4, N'tasty					 ', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (74, 3, 13, 4, N'I would drink it again	 ', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (75, 3, 10, 4, N'Outstanding				 ', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (76, 3, 9, 4, N'Blam					 ', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (77, 4, 9, 4, N'OMG						 ', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (78, 4, 9, 1, N'Yuck					 ', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (79, 4, 9, 1, N'%$@# this beer!			 ', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (80, 4, 9, 3, N'It will get you drunk!	 ', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (81, 2, 13, 3, N'Outstanding				 ', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (82, 2, 17, 3, N'Pretty good brew		 ', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (83, 2, 13, 3, N'Outstanding				 ', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (84, 3, 13, 3, N'tasty					 ', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (85, 3, 15, 3, N'I would drink it again	 ', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (86, 3, 10, 3, N'Outstanding				 ', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (87, 3, 19, 3, N'Blam					 ', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (88, 4, 19, 3, N'OMG						 ', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (89, 4, 12, 3, N'Yuck					 ', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (90, 4, 19, 3, N'%$@# this beer!			 ', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (91, 4, 10, 3, N'It will get you drunk!	 ', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (92, 2, 3, 2, N'Nope nope nope', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (93, 2, 7, 3, N'Pretty good brew		 ', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (94, 2, 3, 3, N'Outstanding				 ', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (95, 3, 3, 4, N'tasty					 ', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (96, 3, 5, 5, N'I would drink it again	 ', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (97, 3, 10, 5, N'Outstanding				 ', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (98, 3, 9, 5, N'Blam					 ', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (99, 4, 9, 5, N'OMG						 ', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (100, 4, 2, 5, N'Yuck					 ', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (101, 4, 9, 5, N'%$@# this beer!			 ', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (102, 4, 2, 5, N'It will get you drunk!	 ', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (103, 2, 1, 3, N'Good!					 ', '2018-05-17')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (104, 2, 1, 5, N'Outstanding				 ', '2018-05-18')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (105, 2, 1, 5, N'Outstanding				 ', '2018-05-18')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (106, 2, 1, 5, N'Outstanding				 ', '2018-05-22')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (107, 2, 1, 4, N'Outstanding				 ', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (108, 2, 1, 4, N'Pretty good brew		 ', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (109, 2, 1, 4, N'Outstanding				 ', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (110, 3, 5, 4, N'tasty					 ', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (111, 3, 5, 4, N'I would drink it again	 ', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (112, 3, 5, 4, N'Outstanding				 ', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (113, 3, 5, 4, N'Blam					 ', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (114, 4, 5, 4, N'OMG						 ', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (115, 4, 5, 4, N'Yuck					 ', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (116, 4, 5, 4, N'%$@# this beer!			 ', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (117, 4, 5, 4, N'It will get you drunk!	 ', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (118, 2, 5, 2, N'Outstanding				 ', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (119, 2, 5, 3, N'Pretty good brew		 ', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (120, 2, 15, 5, N'Outstanding				 ', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (121, 3, 15, 4, N'tasty					 ', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (122, 3, 15, 5, N'I would drink it again	 ', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (123, 3, 15, 2, N'Outstanding				 ', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (124, 3, 15, 3, N'Blam					 ', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (125, 4, 15, 2, N'OMG						 ', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (126, 4, 15, 1, N'Yuck					 ', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (127, 4, 15, 1, N'%$@# this beer!			 ', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (128, 4, 15, 1, N'It will get you drunk!	 ', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (129, 2, 15, 2, N'Outstanding				 ', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (130, 2, 15, 3, N'Pretty good brew		 ', '2018-05-13')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (131, 2, 15, 5, N'Outstanding				 ', '2018-05-11')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (132, 3, 12, 4, N'tasty					 ', '2018-05-10')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (133, 3, 12, 5, N'I would drink it again	 ', '2018-05-09')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (134, 3, 12, 2, N'Outstanding				 ', '2018-05-08')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (135, 3, 12, 3, N'Blam					 ', '2018-05-06')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (136, 4, 12, 2, N'OMG						 ', '2018-05-05')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (137, 4, 12, 1, N'Yuck					 ', '2018-05-04')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (138, 4, 12, 1, N'%$@# this beer!			 ', '2018-05-03')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (139, 4, 12, 1, N'It will get you drunk!	 ', '2018-05-02')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (140, 2, 5, 5, N'Good!					 ', '2018-05-17')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (141, 3, 5, 5, N'Outstanding				 ', '2018-05-18')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (142, 4, 5, 5, N'Outstanding				 ', '2018-05-18')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (143, 2, 5, 5, N'Outstanding				 ', '2018-05-22')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (144, 3, 5, 5, N'Outstanding				 ', '2018-05-14')
INSERT INTO [dbo].[reviews] ([id], [USER_ID], [beer_id], [rating], [review], [review_date]) VALUES (145, 4, 5, 5, N'Pretty good brew		 ', '2018-05-13')
GO

SET IDENTITY_INSERT [dbo].[reviews] OFF

-- Foreign Key Constraint Enable's for Table: [dbo].[beers]
Print 'Foreign Key Constraint Enable''s for Table: [dbo].[beers]'
ALTER TABLE [dbo].[beers] CHECK CONSTRAINT [fk_beers_brewery_info]

-- Foreign Key Constraint Enable's for Table: [dbo].[breweryPhotos]
Print 'Foreign Key Constraint Enable''s for Table: [dbo].[breweryPhotos]'
ALTER TABLE [dbo].[breweryPhotos] CHECK CONSTRAINT [fk_breweryPhotos_breweries]

-- Foreign Key Constraint Enable's for Table: [dbo].[operation]
Print 'Foreign Key Constraint Enable''s for Table: [dbo].[operation]'
ALTER TABLE [dbo].[operation] CHECK CONSTRAINT [fk_operation_breweries]

-- Foreign Key Constraint Enable's for Table: [dbo].[users]
Print 'Foreign Key Constraint Enable''s for Table: [dbo].[users]'
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [fk_users_breweries]

-- Foreign Key Constraint Enable's for Table: [dbo].[beerPhotos]
Print 'Foreign Key Constraint Enable''s for Table: [dbo].[beerPhotos]'
ALTER TABLE [dbo].[beerPhotos] CHECK CONSTRAINT [fk_beerPhotos_beerid]
ALTER TABLE [dbo].[beerPhotos] CHECK CONSTRAINT [fk_beerPhotos_breweries]

-- Foreign Key Constraint Enable's for Table: [dbo].[reviews]
Print 'Foreign Key Constraint Enable''s for Table: [dbo].[reviews]'
ALTER TABLE [dbo].[reviews] CHECK CONSTRAINT [fk_reviews_beers]
ALTER TABLE [dbo].[reviews] CHECK CONSTRAINT [fk_reviews_user_info]


-- COMMITTING TRANSACTION DATA
PRINT 'Committing transaction DATA'
IF @@TRANCOUNT>0
	COMMIT TRANSACTION _DATA_
GO

SET NOEXEC OFF
GO

SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET ARITHABORT ON
SET NOCOUNT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
GO
