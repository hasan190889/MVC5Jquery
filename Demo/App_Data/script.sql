USE [master]
GO
/****** Object:  Database [Work]    Script Date: 1/18/2018 11:26:08 PM ******/
CREATE DATABASE [Work]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Work', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Work.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Work_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Work_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Work] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Work].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Work] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Work] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Work] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Work] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Work] SET ARITHABORT OFF 
GO
ALTER DATABASE [Work] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Work] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Work] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Work] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Work] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Work] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Work] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Work] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Work] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Work] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Work] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Work] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Work] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Work] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Work] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Work] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Work] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Work] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Work] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Work] SET  MULTI_USER 
GO
ALTER DATABASE [Work] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Work] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Work] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Work] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Work]
GO
/****** Object:  StoredProcedure [dbo].[tmUser_Delete]    Script Date: 1/18/2018 11:26:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hasan Siddiqui
-- Create date: 01-17-2017
-- Description:	Delete user
-- =============================================
CREATE PROCEDURE [dbo].[tmUser_Delete] 
(
	@Id	[INT]
)
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM [dbo].[tmUser] WHERE [Id] = @Id
	
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[tmUser_InserUpdate]    Script Date: 1/18/2018 11:26:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hasan Siddiqui
-- Create date: 01-17-2017
-- Description:	Add, update user
-- =============================================
CREATE PROCEDURE [dbo].[tmUser_InserUpdate]
(
	@Id		[INT],
	@Name	[NVARCHAR](50),
	@Age	[INT]
)
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT 1 FROM [dbo].[tmUser] WHERE [Id] = @Id)
		BEGIN
			UPDATE [dbo].[tmUser]
			SET [Name] = @Name,
				[Age] = @Age
			WHERE [Id] = @Id
		END
	ELSE
		BEGIN
			INSERT INTO [dbo].[tmUser]
			(
				[Name],
				[Age]
			)
			VALUES 
			(
				@Name,
				@Age
			)
		END

	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[tmUser_SelectAll]    Script Date: 1/18/2018 11:26:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hasan Siddiqui
-- Create date: 01-17-2017
-- Description:	Select all users
-- =============================================
CREATE PROCEDURE [dbo].[tmUser_SelectAll]	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT	[Id], 
			[Name], 
			[Age]
	FROM	[dbo].[tmUser]

	SET NOCOUNT OFF;
END

GO
/****** Object:  Table [dbo].[tmUser]    Script Date: 1/18/2018 11:26:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Age] [int] NOT NULL,
 CONSTRAINT [PK_tmUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
USE [master]
GO
ALTER DATABASE [Work] SET  READ_WRITE 
GO
