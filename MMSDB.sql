USE [master]
GO
/****** Object:  Database [UpdatedDB]    Script Date: 3/22/2024 10:06:57 AM ******/
CREATE DATABASE [UpdatedDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UpdatedDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\UpdatedDB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'UpdatedDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\UpdatedDB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [UpdatedDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UpdatedDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UpdatedDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UpdatedDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UpdatedDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UpdatedDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UpdatedDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [UpdatedDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UpdatedDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UpdatedDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UpdatedDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UpdatedDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UpdatedDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UpdatedDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UpdatedDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UpdatedDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UpdatedDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [UpdatedDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UpdatedDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UpdatedDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UpdatedDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UpdatedDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UpdatedDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UpdatedDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UpdatedDB] SET RECOVERY FULL 
GO
ALTER DATABASE [UpdatedDB] SET  MULTI_USER 
GO
ALTER DATABASE [UpdatedDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UpdatedDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UpdatedDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UpdatedDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UpdatedDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [UpdatedDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'UpdatedDB', N'ON'
GO
ALTER DATABASE [UpdatedDB] SET QUERY_STORE = OFF
GO
USE [UpdatedDB]
GO
/****** Object:  Schema [HangFire]    Script Date: 3/22/2024 10:06:57 AM ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  UserDefinedFunction [dbo].[Decrypt]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Decrypt]
(
	@Value AS VARBINARY(256),
	@PassphraseKey AS VARCHAR(50) 
)
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @Result VARCHAR(255)

    SET @Result = DECRYPTBYPASSPHRASE (@PassphraseKey, @Value)

    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[Encrypt]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Encrypt]
(
	@Value AS VARCHAR(255),
	@PassphraseKey AS VARCHAR(50) 
)
RETURNS VARBINARY(256)
AS
BEGIN
    DECLARE @Result varbinary(256)

    SET @Result = ENCRYPTBYPASSPHRASE (@PassphraseKey, @Value)

    RETURN @Result
END
GO
/****** Object:  Table [dbo].[Member_Outstanding]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Outstanding](
	[OutstandingID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [varchar](12) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[OutstandingDate] [datetime] NULL,
	[ChargeCode] [varchar](3) NOT NULL,
	[Description] [varchar](100) NULL,
	[TaxableAmount] [numeric](10, 2) NULL,
	[IncludeGST] [char](1) NULL,
	[GSTAmount] [numeric](8, 2) NULL,
	[SvcTaxable] [numeric](10, 2) NULL,
	[SvcTax] [numeric](8, 2) NULL,
	[OutstandingAmount] [numeric](10, 2) NULL,
	[PaymentDueDate] [datetime] NULL,
	[PaymentStatus] [varchar](15) NULL,
	[PaidAmount] [numeric](10, 2) NULL,
	[Remarks] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[Status] [varchar](1) NULL,
	[Interest] [numeric](18, 10) NULL,
	[IsBankTransfer] [tinyint] NULL,
	[AdvBill] [varchar](1) NULL,
 CONSTRAINT [PK__Member_O__2A9893E2F01B9442] PRIMARY KEY CLUSTERED 
(
	[OutstandingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChargeCode]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChargeCode](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](50) NULL,
	[ShortDescription] [varchar](30) NULL,
	[ChargeType] [varchar](3) NULL,
	[GLAccount] [varchar](20) NULL,
	[Amount] [numeric](18, 2) NULL,
	[ExclusiveGovTax] [char](1) NULL,
	[GovTax] [numeric](10, 2) NULL,
	[SystemUse] [char](1) NULL,
	[IsInsurance] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_ChargeCode] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Title]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Title](
	[Code] [varchar](2) NOT NULL,
	[Description] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Title] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyCode]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyCode](
	[Code] [varchar](8) NOT NULL,
	[Name] [varchar](64) NULL,
	[Status] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_CompanyCode] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Person]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Person](
	[PersonID] [varchar](15) NOT NULL,
	[NRIC] [varchar](15) NULL,
	[Title] [varchar](2) NULL,
	[SurName] [varchar](20) NULL,
	[Name] [varchar](50) NULL,
	[Gender] [char](1) NULL,
	[DateOfBirth] [datetime] NULL,
	[MaritalStatus] [varchar](15) NULL,
	[WeddingDate] [datetime] NULL,
	[Nationality] [varchar](3) NULL,
	[Race] [varchar](3) NULL,
	[PassportNo] [varchar](15) NULL,
	[HighestQualification] [varchar](50) NULL,
	[GraduatedYear] [int] NULL,
	[NSService] [varchar](2) NULL,
	[NSServiceStatus] [varchar](2) NULL,
	[PhoneNo] [varchar](50) NULL,
	[MobileNo] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[HomePostalCode] [varchar](15) NULL,
	[HomeAddress] [varchar](150) NULL,
	[CompanyCode] [varchar](8) NULL,
	[Rank] [varchar](2) NULL,
	[Occupation] [varchar](100) NULL,
	[Unit] [varchar](100) NULL,
	[ChronoNo] [varchar](50) NULL,
	[IDAmount] [decimal](10, 2) NULL,
	[OfficePostalCode] [varchar](15) NULL,
	[OfficeAddress] [varchar](150) NULL,
	[PreferedMailingAddress] [varchar](10) NULL,
	[MailingType] [varchar](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_Person] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[ProspectID] [varchar](15) NOT NULL,
	[MemberID] [varchar](10) NULL,
	[MembershipCategory] [varchar](3) NULL,
	[MembershipType] [varchar](3) NULL,
	[MembershipStatus] [varchar](3) NULL,
	[SubscriptionType] [varchar](3) NULL,
	[ApplicationDate] [datetime] NULL,
	[AcctStatus] [varchar](15) NULL,
	[JoinedDate] [datetime] NULL,
	[EffectiveDate] [datetime] NULL,
	[ExpiryDate] [datetime] NULL,
	[CompanyID] [varchar](15) NULL,
	[PersonID] [varchar](15) NULL,
	[EntranceFee] [decimal](10, 2) NULL,
	[SecurityDeposit] [decimal](10, 2) NULL,
	[PermanentDeposit] [decimal](10, 2) NULL,
	[CreditLimit] [decimal](10, 2) NULL,
	[SpendingCredit] [decimal](10, 2) NULL,
	[CreditLimitUtilized] [decimal](10, 2) NULL,
	[SpendingCreditUtilized] [decimal](10, 2) NULL,
	[MonthlySubFee] [decimal](10, 2) NULL,
	[NextSubBillDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[ProspectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Company]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Company](
	[CompanyID] [varchar](15) NOT NULL,
	[CompanyCode] [varchar](8) NOT NULL,
	[CompanyName] [varchar](50) NULL,
	[Industry] [varchar](3) NULL,
	[MailingType] [varchar](2) NULL,
	[AttentionTo] [varchar](50) NULL,
	[PhoneNo] [varchar](50) NULL,
	[MobileNo] [varchar](50) NULL,
	[Email] [varchar](50) NOT NULL,
	[PostalCode] [varchar](15) NULL,
	[Address] [varchar](150) NULL,
	[CommunicationChannel] [varchar](15) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Relation]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Relation](
	[RelationID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[PrincipleProspectID] [varchar](15) NOT NULL,
	[Relationship] [varchar](15) NULL,
	[NomineeType] [varchar](10) NULL,
	[JoinedDate] [datetime] NULL,
	[ChargeToPrinciple] [char](1) NULL,
	[Status] [char](1) NULL,
	[InactiveDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_Relation] PRIMARY KEY CLUSTERED 
(
	[RelationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MembershipCategory]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MembershipCategory](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_MembershipCategory] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllMembers]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






 

CREATE VIEW [dbo].[AllMembers]
AS  
select 
  m.ProspectID, 
  [MemberID], 
  [MembershipCategory], 
  MembershipCategory.Description as 'MembershipCategoryDescription',
  [MembershipType], 
  [MembershipStatus], 
  [SubscriptionType], 
  [ApplicationDate], 
  [AcctStatus], 
  m.JoinedDate, 
  [EffectiveDate], 
  [ExpiryDate], 
  m.PersonID, 
  [EntranceFee], 
  [SecurityDeposit], 
  [PermanentDeposit], 
  [CreditLimit], 
  [SpendingCredit], 
  [CreditLimitUtilized], 
  [SpendingCreditUtilized], 
  [MonthlySubFee], 
  [NextSubBillDate], 
  mp.Title, 
  mp.NRIC,
  CASE WHEN (
    m.PersonID IS NULL 
    OR m.PersonID = ''
  ) THEN mc.CompanyName ELSE CONCAT(mp.Name, ' ', mp.SurName) END as 'Name', 
  CASE WHEN (
    m.PersonID IS NULL 
    OR m.PersonID = ''
  ) THEN 'Company' ELSE 'Person' END as 'MemberInfo', 
  CASE WHEN (
    m.PersonID IS NULL 
    OR m.PersonID = ''
  ) THEN mc.CompanyID ELSE mp.PersonID END as 'MemberInfoID', 
  CASE WHEN (
    m.PersonID IS NULL 
    OR m.PersonID = ''
  ) THEN mc.CompanyName ELSE CONCAT(
    mp.Title, ' ', mp.Name, ' ', mp.SurName
  ) END as 'MemberName', 
  CASE WHEN (
    m.PersonID IS NULL 
    OR m.PersonID = ''
  ) THEN mc.Email ELSE mp.Email END as 'Email', 
  CASE WHEN (
    m.PersonID IS NULL 
    OR m.PersonID = ''
  ) THEN mc.PhoneNo ELSE mp.PhoneNo END as 'PhoneNo', 
  CASE WHEN (
    m.PersonID IS NULL 
    OR m.PersonID = ''
  ) THEN mc.Address ELSE mp.HomeAddress END as 'Address', 
  CASE WHEN (
    m.PersonID IS NULL 
    OR m.PersonID = ''
  ) THEN mc.PostalCode ELSE mp.HomePostalCode END as 'PostalCode', 
  mp.OfficeAddress,
  json_query(
    (
      select 
        m.ProspectID,
        m.MemberID, 
        [MembershipCategory], 
        [MembershipType], 
        [MembershipStatus], 
        [SubscriptionType], 
        [ApplicationDate], 
        [AcctStatus], 
        m.JoinedDate, 
        [EffectiveDate], 
        [ExpiryDate], 
        m.PersonID, 
        [EntranceFee], 
        [SecurityDeposit], 
        [PermanentDeposit], 
        [CreditLimit], 
        [SpendingCredit], 
        [CreditLimitUtilized], 
        [SpendingCreditUtilized], 
        [MonthlySubFee], 
        [NextSubBillDate], 
        mp.Title, 
        CASE WHEN (
          m.PersonID IS NULL 
          OR m.PersonID = ''
        ) THEN mc.CompanyName ELSE CONCAT(mp.Name, ' ', mp.SurName) END as 'Name', 
        CASE WHEN (
          m.PersonID IS NULL 
          OR m.PersonID = ''
        ) THEN 'Company' ELSE 'Person' END as 'MemberInfo', 
        CASE WHEN (
          m.PersonID IS NULL 
          OR m.PersonID = ''
        ) THEN mc.CompanyID ELSE mp.PersonID END as 'MemberInfoID', 
        CASE WHEN (
          m.PersonID IS NULL 
          OR m.PersonID = ''
        ) THEN mc.CompanyName ELSE CONCAT(
          mp.Title, ' ', mp.Name, ' ', mp.SurName
        ) END as 'MemberName', 
        CASE WHEN (
          m.PersonID IS NULL 
          OR m.PersonID = ''
        ) THEN mc.Email ELSE mp.Email END as 'Email', 
        CASE WHEN (
          m.PersonID IS NULL 
          OR m.PersonID = ''
        ) THEN mc.PhoneNo ELSE mp.PhoneNo END as 'PhoneNo', 
        CASE WHEN (
          m.PersonID IS NULL 
          OR m.PersonID = ''
        ) THEN mc.Address ELSE mp.HomeAddress END as 'Address', 
        CASE WHEN (
          m.PersonID IS NULL 
          OR m.PersonID = ''
        ) THEN mc.PostalCode ELSE mp.HomePostalCode END as 'PostalCode' 
      from 
        (
          select 
            * 
          from 
            Member_Relation 
          where 
            PrincipleProspectID = m.ProspectID
        ) as mr 
        left join member as m on mr.ProspectID = m.ProspectID 
        LEFT JOIN (
          select 
            Member_Person.PersonID, 
            Title.Description as 'Title', 
            Member_Person.SurName, 
            Member_Person.Name, 
            Member_Person.Email, 
            Member_Person.PhoneNo, 
            Member_Person.HomeAddress, 
            Member_Person.HomePostalCode 
          from 
            Member_Person 
            left join Title on Member_Person.Title = Title.Code
        ) as mp ON m.PersonID = mp.PersonID 
        LEFT JOIN (
          select 
            Member_Company.CompanyID, 
            Member_Company.CompanyName, 
            Member_Company.Email, 
            Member_Company.PhoneNo, 
            Member_Company.Address, 
            Member_Company.PostalCode 
          from 
            Member_Company 
            left join CompanyCode on Member_Company.CompanyCode = CompanyCode.Code
        ) as mc ON m.CompanyID = mc.CompanyID FOR JSON PATH
    )
  ) as 'SubMemberList' ,
  json_query(
    ( 
        SELECT 
       [ProspectID],
       [OutstandingID]
      ,[OutstandingDate]
      ,[ChargeCode]
      ,ChargeType
      ,Member_Outstanding.Description
      ,[TaxableAmount]
      ,[IncludeGST]
      ,[GSTAmount]
      ,[SvcTaxable]
      ,[SvcTax]
      ,(OutstandingAmount + isnull(Interest, 0)) as 'OutstandingAmount'
      ,[PaymentDueDate]
      ,[PaymentStatus]
      ,[PaidAmount]
      FROM [dbo].[Member_Outstanding] 
      left join ChargeCode on Member_Outstanding.ChargeCode = ChargeCode.Code
      where ProspectID = m.ProspectID  AND (PaymentStatus IS NULL or PaymentStatus != 'Paid') AND Status = 'A'
      FOR JSON PATH
    )
  ) as 'OutstandingList'
FROM 
  (
    select 
      * 
    from 
      [Member] 
    -- where AcctStatus in ('Approved','Activated')
  ) as m 
  left join MembershipCategory on m.MembershipCategory = MembershipCategory.Code
  LEFT JOIN (
    select 
      Member_Person.PersonID, 
      Title.Description as 'Title', 
      Member_Person.SurName, 
      Member_Person.Name, 
      Member_Person.Email, 
      Member_Person.PhoneNo, 
      Member_Person.HomeAddress, 
      Member_Person.HomePostalCode,
      Member_Person.OfficeAddress,
	  Member_Person.NRIC
    from 
      Member_Person 
      left join Title on Member_Person.Title = Title.Code
  ) as mp ON m.PersonID = mp.PersonID 
  LEFT JOIN (
    select 
      Member_Company.CompanyID, 
      Member_Company.CompanyName, 
      Member_Company.Email, 
      Member_Company.PhoneNo, 
      Member_Company.Address, 
      Member_Company.PostalCode 
    from 
      Member_Company 
      left join CompanyCode on Member_Company.CompanyCode = CompanyCode.Code
  ) as mc ON m.CompanyID = mc.CompanyID

 

GO
/****** Object:  Table [dbo].[Member_ChangeStatus]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_ChangeStatus](
	[TransID] [bigint] IDENTITY(1,1) NOT NULL,
	[ApplicationNo] [varchar](15) NOT NULL,
	[StatusFrom] [varchar](2) NULL,
	[StatusTo] [varchar](2) NULL,
	[EffectiveStartDate] [datetime] NULL,
	[EffectiveEndDate] [datetime] NULL,
	[Reason] [varchar](150) NULL,
	[Remark] [varchar](150) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_ChangeStatus] PRIMARY KEY CLUSTERED 
(
	[TransID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Application]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Application](
	[ApplicationNo] [varchar](15) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[ApplicationDate] [datetime] NULL,
	[ApplicationType] [int] NULL,
	[ApplySource] [varchar](15) NULL,
	[ApplicationStatus] [varchar](15) NULL,
	[Remark] [varchar](200) NULL,
	[SalePerson] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_Application] PRIMARY KEY CLUSTERED 
(
	[ApplicationNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MembershipType]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MembershipType](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](100) NULL,
	[GLCode] [varchar](20) NULL,
	[EntranceFee] [numeric](10, 2) NULL,
	[TermLifeIndctr] [char](1) NULL,
	[YearsPerTerm] [int] NULL,
	[Criteria] [varchar](100) NULL,
	[ProfessionalTitle] [varchar](50) NULL,
	[Prefix] [varchar](30) NULL,
	[ClassType] [varchar](10) NULL,
	[NoOfNominee] [int] NULL,
	[SubscriptionType] [varchar](3) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_MembershipType] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AmortisationMonths]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[AmortisationMonths]
AS 
WITH MonthParam AS (
    select dateFrom = (select CONVERT(DATE,  CONCAT(YEAR(MIN(EffectiveStartDate)),'-01-01')) from Member_ChangeStatus),
	dateTo = DATEADD(year, 1, CAST( (select CONVERT(DATE,  CONCAT(YEAR(MIN(EffectiveStartDate)),'-01-01')) from Member_ChangeStatus) AS Date )) 
), MonthTbl (date)
AS
(
    SELECT (select dateFrom from MonthParam) as 'AmtDate'
    UNION ALL
    SELECT DATEADD(month,1,date) as 'AmtDate'
    from MonthTbl
    where DATEADD(month,1,date) < (select dateTo from MonthParam)
), YearParam AS (
    select yearFrom = (select CONVERT(DATE,  CONCAT(YEAR(MIN(EffectiveStartDate)),'-01-01')) from Member_ChangeStatus),
	yearTo = DATEADD(year, 20, CAST( (select CONVERT(DATE,  CONCAT(YEAR(MAX(EffectiveStartDate)),'-01-01')) from Member_ChangeStatus) AS Date )) 
), YearTbl (date)
AS
(
    SELECT (select yearFrom from YearParam) as 'AmtDate'
    UNION ALL
    SELECT DATEADD(year,1,date) as 'AmtDate'
    from YearTbl
    where DATEADD(year,1,date) < (select yearTo from YearParam)
),ChangeMonths AS(
      select ma.ProspectID, datefromparts(year(mc.EffectiveStartDate), month(mc.EffectiveStartDate), 1) as ChangeMonth, mc.EffectiveStartDate, mc.EffectiveEndDate, mc.StatusTo, mc.CreatedDate
      from 
(select * from Member_Application ) as ma
right join Member_ChangeStatus as mc on ma.ApplicationNo = mc.ApplicationNo
      union all
    SELECT ProspectID, DATEADD(month,1,ChangeMonth), EffectiveStartDate, EffectiveEndDate, StatusTo, CreatedDate
    from ChangeMonths
    where DATEADD(month,1,ChangeMonth) >=EffectiveStartDate AND DATEADD(month,1,ChangeMonth) <=EffectiveEndDate
)


-- select AllMembers.ProspectID, CONCAT(YEAR(AmtMonth),'-', RIGHT('00' + CAST(DATEPART(mm, AmtMonth) AS varchar(2)), 2), '-' , '01' ) as 'AmtMonth', AmtYear, DENSE_RANK() over (order by AmtYear) as 'AmtYearCount' from (from
select months.AmtMonth, months.ProspectID,months.AmtYear,EffectiveDate,
datefromparts(year(EffectiveStartDate), month(EffectiveStartDate), 1) as EffectiveStartDate,
datefromparts(year(EffectiveEndDate), month(EffectiveEndDate), 1) as EffectiveEndDate,
CASE  
    WHEN mc.EffectiveStartDate IS null AND mc.EffectiveEndDate is null THEN 'V'
    ELSE mc.StatusTo 
END as MembershipStatus,
CASE  
    WHEN mc.CreatedDate IS null THEN months.EffectiveDate
    ELSE mc.CreatedDate
END as ProcessDate
 from (
select am.ProspectID, m.AmtMonth, MembershipType.YearsPerTerm as 'AmtYear', am.EffectiveDate
from (
select CONCAT(YEAR(YearTbl.date),'-', RIGHT('00' + CAST(DATEPART(mm, MonthTbl.date) AS varchar(2)), 2), '-' , '01' ) as 'AmtMonth' from YearTbl cross join MonthTbl
) as m
cross join AllMembers as am
left join MembershipType on am.MembershipType = MembershipType.Code
) as months
left join (
select CONCAT(YEAR(ChangeMonth),'-', RIGHT('00' + CAST(DATEPART(mm, ChangeMonth) AS varchar(2)), 2), '-' , '01' ) as 'AmtMonth',ProspectID, EffectiveStartDate, EffectiveEndDate, StatusTo, CreatedDate from ChangeMonths
) as mc on mc.ProspectID = months.ProspectID AND mc.AmtMonth = months.AmtMonth
GO
/****** Object:  View [dbo].[Amortisation]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[Amortisation]
AS 
select  t.*
from (
    select
        * ,
        (Amt.EntranceFee-Amt.SpendingCredit) - (Amt.MonthyAmount * Amt.monthCount) as 'AllBalanceAmount'
    from(
        select 
            AmortisationMonths.AmtMonth as 'AsAt',
            EntranceFee,SpendingCredit,MembershipType,MemberID,
            AllMembers.ExpiryDate,
            AmortisationMonths.*,
            DENSE_RANK() OVER(ORDER BY AmortisationMonths.AmtMonth ASC) AS 'monthCount',
            (EntranceFee-SpendingCredit) / NULLIF((AmortisationMonths.AmtYear * 12 ),0)  as 'MonthyAmount',
            DATEADD(month, -1, AmtMonth) as 'subOneMonth',
            DATEADD(month, -2, AmtMonth) as 'subTwoMonth'
        from AmortisationMonths 
        left join AllMembers on AllMembers.ProspectID = AmortisationMonths.ProspectID
        where AmtMonth between AllMembers.EffectiveDate AND AllMembers.ExpiryDate
    ) as Amt
) as t

GO
/****** Object:  View [dbo].[AmortisationProjectionMonths]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[AmortisationProjectionMonths]
AS 
select ProspectID, sum(Amount) as Amount , AmtMonth from (
    select 
	AmortisationMonths.ProspectID,
	AmortisationMonths.AmtMonth,
	-- CASE  
    --     WHEN MONTH(AmortisationMonths.AmtMonth) > 3  THEN  CONCAT(YEAR(AmortisationMonths.AmtMonth), '04','TO',CONCAT(YEAR(AmortisationMonths.AmtMonth)+1, '03'))
    --     ELSE CONCAT(YEAR(AmortisationMonths.AmtMonth)-1, '04','TO',CONCAT(YEAR(AmortisationMonths.AmtMonth), '03'))
    -- END as 'Title', 
	ISNULL(Amortisation.MonthyAmount,0) as 'Amount' from AmortisationMonths 
	left join Amortisation on AmortisationMonths.ProspectID = Amortisation.ProspectID AND AmortisationMonths.AmtMonth = Amortisation.AmtMonth
) as tbl group by ProspectID, AmtMonth
GO
/****** Object:  Table [dbo].[AR_TransactionDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_TransactionDetail](
	[TransactionId] [int] NOT NULL,
	[TransactionDetailId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionDate] [datetime] NULL,
	[OutstandingID] [int] NOT NULL,
	[InvoiceNo] [varchar](15) NULL,
	[OutstandingAmount] [numeric](18, 10) NULL,
	[PaymentCode] [varchar](50) NULL,
	[PaymentMethod] [varchar](5) NULL,
	[ChequeDate] [datetime] NULL,
	[BankCode] [varchar](50) NULL,
	[ChargeType] [varchar](3) NULL,
	[ChargeCode] [varchar](3) NOT NULL,
	[Section] [varchar](20) NULL,
	[TaxableAmount] [numeric](18, 10) NULL,
	[IsGST] [tinyint] NULL,
	[GSTAmount] [numeric](18, 10) NULL,
	[Amount] [numeric](18, 10) NOT NULL,
	[RndAdjustment] [numeric](18, 10) NULL,
	[Reference] [varchar](100) NULL,
	[AmountInformation] [varchar](100) NULL,
	[Description] [text] NULL,
	[Guid] [varchar](255) NOT NULL,
	[IsBankIn] [tinyint] NULL,
	[IsPosted] [tinyint] NULL,
	[IsMonthEnd] [tinyint] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[ProspectID] [varchar](15) NULL,
	[FinancialMonth] [datetime] NULL,
	[OutstandingDate] [datetime] NULL,
	[PaymentDueDate] [datetime] NULL,
	[StartBillDate] [datetime] NULL,
	[NextSubBillDate] [datetime] NULL,
	[Status] [varchar](15) NULL,
	[RecuBillID] [varchar](15) NULL,
 CONSTRAINT [PK__AR_Trans__F2B27FC6B1B65528] PRIMARY KEY CLUSTERED 
(
	[TransactionDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[AgingOutstanding]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[AgingOutstanding]
AS  

select 
	am.MemberID, am.MemberName, am.ExpiryDate, am.SecurityDeposit, am.MembershipStatus,
	outstanding.*,(CrCurr+Cr30+Cr60+Cr90+Cr120+Cr150+Cr180) as 'Total', (Cr30+Cr60+Cr90+Cr120+Cr150+Cr180) as 'TotalCurrentBalance' from (
select  am.ProspectID,
ISNULL((select
sum(ISNULL(Member_Outstanding.OutstandingAmount - PaidAmount, 0 )) as 'Amount'
from Member_Outstanding 
left join AR_TransactionDetail on AR_TransactionDetail.OutstandingID =  Member_Outstanding.OutstandingID
where AR_TransactionDetail.IsPosted = 1 and (Member_Outstanding 
.Status is null or Member_Outstanding 
.Status != 'I') and MONTH(Member_Outstanding 
.OutstandingDate) = MONTH(CAST( GETDATE() AS Date ) ) AND YEAR(Member_Outstanding 
.OutstandingDate) = YEAR(CAST( GETDATE() AS Date )) AND Member_Outstanding 
.ProspectID = am.ProspectID), 0) as 'Unposted',
ISNULL((select
sum(ISNULL(OutstandingAmount - PaidAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -1, CAST( GETDATE() AS Date )) ) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -1, CAST( GETDATE() AS Date )) ) AND ProspectID = am.ProspectID), 0) as 'CrCurr',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -2, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -2, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr30', 
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -3, CAST( GETDATE() AS Date )) ) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -3, CAST( GETDATE() AS Date )) ) AND ProspectID = am.ProspectID ), 0) as 'Cr60', 
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -4, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -4, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr90',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -5, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -5, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr120',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -6, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -6, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr150',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -7, CAST( GETDATE() AS Date )) ) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -7, CAST( GETDATE() AS Date )) ) AND ProspectID = am.ProspectID) , 0) as 'Cr180'
from Member_Outstanding as mo
left join AllMembers as am on mo.ProspectID = am.ProspectID
where mo.Status != 'I' group by am.ProspectID
) as outstanding
left join AllMembers as am on outstanding.ProspectID = am.ProspectID

GO
/****** Object:  Table [dbo].[AR_Transaction]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Transaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionDate] [datetime] NULL,
	[BatchID] [nchar](10) NULL,
	[ProspectID] [varchar](15) NULL,
	[MemberID] [varchar](50) NULL,
	[Type] [varchar](50) NOT NULL,
	[Guid] [varchar](255) NOT NULL,
	[Status] [varchar](50) NULL,
	[Module] [varchar](3) NOT NULL,
	[NextBillDate] [datetime] NULL,
	[SubscriptionType] [varchar](10) NULL,
	[SubscriptionMonths] [int] NULL,
	[SubscriptionAmount] [numeric](18, 10) NOT NULL,
	[SubscriptionSubMemberAmount] [numeric](18, 10) NOT NULL,
	[TotalAmount] [numeric](18, 10) NOT NULL,
	[Description] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[AgingOutstandingMonthEnd]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[AgingOutstandingMonthEnd]
AS  

select 
	am.MemberID, am.MemberName, am.ExpiryDate, am.SecurityDeposit, am.MembershipStatus,
	outstanding.*,(CrCurr+Cr30+Cr60+Cr90+Cr120+Cr150+Cr180) as 'Total', (Cr30+Cr60+Cr90+Cr120+Cr150+Cr180) as 'TotalCurrentBalance' from (
select  am.ProspectID,
ISNULL((select
sum(ISNULL(OutstandingAmount - PaidAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -1, CAST( GETDATE() AS Date )) ) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -1, CAST( GETDATE() AS Date )) ) AND ProspectID = am.ProspectID), 0) as 'CrCurr',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -2, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -2, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr30', 
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -3, CAST( GETDATE() AS Date )) ) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -3, CAST( GETDATE() AS Date )) ) AND ProspectID = am.ProspectID ), 0) as 'Cr60', 
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -4, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -4, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr90',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -5, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -5, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr120',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -6, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -6, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr150',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -7, CAST( GETDATE() AS Date )) ) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -7, CAST( GETDATE() AS Date )) ) AND ProspectID = am.ProspectID) , 0) as 'Cr180'
from Member_Outstanding as mo
left join AllMembers as am on mo.ProspectID = am.ProspectID
join (
	select OutstandingID from AR_TransactionDetail 
	left join AR_Transaction on AR_TransactionDetail.TransactionId = AR_Transaction.TransactionId
	where AR_TransactionDetail.IsMonthEnd = 1 group by OutstandingID
) as td on mo.OutstandingID = td.OutstandingID
where mo.Status != 'I' group by am.ProspectID
) as outstanding
left join AllMembers as am on outstanding.ProspectID = am.ProspectID

GO
/****** Object:  Table [dbo].[AccountCode]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountCode](
	[Code] [varchar](10) NOT NULL,
	[Description] [varchar](100) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AccountCode] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminGroup]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminGroup](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](3) NULL,
	[Name] [varchar](100) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminGroupPermission]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminGroupPermission](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NULL,
	[ModuleID] [bigint] NULL,
	[IsView] [char](1) NULL,
	[IsInsert] [char](1) NULL,
	[IsEdit] [char](1) NULL,
	[IsDelete] [char](1) NULL,
	[Status] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AdminGroupPermission] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminLocation]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminLocation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LocationCode] [varchar](7) NOT NULL,
	[LocationName] [varchar](64) NULL,
	[SystemUse] [varchar](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AdminLocation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminModule]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminModule](
	[ModuleID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleLevel] [int] NULL,
	[ParentID] [int] NULL,
	[ModuleCode] [varchar](3) NULL,
	[ModuleName] [varchar](50) NULL,
	[Description] [varchar](100) NULL,
	[MerchantID] [varchar](4) NULL,
	[SystemUse] [varchar](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AdminModule] PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminUserGroup]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminUserGroup](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](100) NULL,
	[GroupID] [int] NULL,
	[Status] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AdminUserGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminUserLocationPermission]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminUserLocationPermission](
	[AccessID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](100) NOT NULL,
	[GroupID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[AccessRights] [char](1) NULL,
	[Description] [varchar](50) NULL,
	[Status] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AdminUserLocationPermission] PRIMARY KEY CLUSTERED 
(
	[AccessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdvRenewalReason]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvRenewalReason](
	[Code] [varchar](2) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AdvRenewalReason] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationType]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationType] [varchar](50) NULL,
	[RelatedTable] [varchar](50) NULL,
	[Remark] [varchar](150) NULL,
	[Status] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_ApplicationType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_Aging]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Aging](
	[AgingId] [int] IDENTITY(1,1) NOT NULL,
	[DaysFrom] [int] NULL,
	[DaysTo] [int] NULL,
	[Code] [varchar](20) NULL,
	[Description] [varchar](255) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[AmountFrom] [decimal](10, 5) NULL,
	[AmountTo] [decimal](10, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[AgingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_BankIn]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_BankIn](
	[BankInId] [int] IDENTITY(1,1) NOT NULL,
	[BatchNo] [varchar](50) NULL,
	[PaymentDateFrom] [datetime] NULL,
	[PaymentDateTo] [datetime] NULL,
	[BankInDate] [datetime] NOT NULL,
	[Location] [int] NOT NULL,
	[Total] [numeric](18, 10) NOT NULL,
	[Status] [varchar](50) NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BankInId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_BankInDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_BankInDetail](
	[BankInId] [int] NOT NULL,
	[BankInDetailId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionDetailGuid] [varchar](255) NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BankInDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_BankTransferStatus]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_BankTransferStatus](
	[BankTransferStatusId] [int] IDENTITY(1,1) NOT NULL,
	[Status] [varchar](15) NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BankTransferStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_Batch]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Batch](
	[BatchID] [int] IDENTITY(1,1) NOT NULL,
	[BatchCode] [nvarchar](3) NULL,
	[BatchDescription] [nvarchar](50) NULL,
	[ComparatorMMS] [nvarchar](50) NULL,
	[MembershipStatus] [nvarchar](50) NULL,
	[ComparatorMailingType] [nvarchar](50) NULL,
	[MailingType] [nvarchar](50) NULL,
	[ComparatorNoofPage] [nvarchar](50) NULL,
	[NoofPages] [int] NULL,
	[ComparatorTaxInvoice] [nvarchar](50) NULL,
	[TaxInvoice] [nvarchar](5) NULL,
	[Operator1] [nvarchar](5) NULL,
	[Operator2] [nvarchar](5) NULL,
	[Operator3] [nvarchar](5) NULL,
	[SystemUse] [nvarchar](1) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_AR_Batch] PRIMARY KEY CLUSTERED 
(
	[BatchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_BatchStatement]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_BatchStatement](
	[BatchStatementID] [int] IDENTITY(1,1) NOT NULL,
	[BatchName] [nvarchar](50) NULL,
	[NoOfMember] [int] NULL,
	[SystemUse] [varchar](1) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreateAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_AR_BatchStatement] PRIMARY KEY CLUSTERED 
(
	[BatchStatementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_Comparator]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Comparator](
	[ComparatorId] [int] IDENTITY(1,1) NOT NULL,
	[Comparator] [nvarchar](50) NULL,
 CONSTRAINT [PK_AR_Comparator] PRIMARY KEY CLUSTERED 
(
	[ComparatorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_CreditDebitProcess]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_CreditDebitProcess](
	[CreditDebitProcessId] [int] IDENTITY(1,1) NOT NULL,
	[UploadFileName] [varchar](255) NULL,
	[TransactionDate] [datetime] NULL,
	[PaymentMethod] [varchar](10) NULL,
	[BankTransferStatus] [int] NULL,
	[AccountType] [varchar](255) NULL,
	[FileHeaderRecordType] [varchar](50) NULL,
	[FileName] [varchar](255) NOT NULL,
	[HeaderDate] [datetime] NULL,
	[SequenceNo] [varchar](50) NULL,
	[BatchHeaderRecordType] [varchar](50) NULL,
	[FileDescriptor] [varchar](50) NULL,
	[FileType] [varchar](50) NULL,
	[Version] [varchar](50) NULL,
	[ProductId] [varchar](50) NULL,
	[BatchIndicator] [varchar](50) NULL,
	[PaymentGroup] [varchar](50) NULL,
	[ProductCode] [varchar](50) NULL,
	[MerchantId] [varchar](50) NULL,
	[TerminalId] [varchar](50) NULL,
	[HostNo] [varchar](50) NULL,
	[BatchRecordType] [varchar](50) NULL,
	[BatchRecordCount] [varchar](50) NULL,
	[BatchTotalAmount] [varchar](50) NULL,
	[FileRecordType] [varchar](50) NULL,
	[FileRecordCount] [varchar](50) NULL,
	[FileTotalAmount] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CreditDebitProcessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_CreditDebitProcessDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_CreditDebitProcessDetail](
	[CreditDebitProcessId] [int] NOT NULL,
	[CreditDebitProcessDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OutstandingID] [int] NULL,
	[ProspectID] [varchar](15) NULL,
	[RecordType] [varchar](50) NULL,
	[UserAccount] [varchar](255) NULL,
	[LengthOfCardNo] [varchar](15) NULL,
	[CardNo] [varchar](255) NULL,
	[ExpiryDate] [varchar](255) NULL,
	[TransactionAmount] [varchar](255) NULL,
	[TransactionCurrency] [varchar](15) NULL,
	[PolicyReference] [varchar](255) NULL,
	[BillingDate] [datetime] NULL,
	[DocumentNo] [varchar](255) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CreditDebitProcessDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_DebitSubscriptionDue]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_DebitSubscriptionDue](
	[DebitSubscriptionDueId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionDate] [datetime] NULL,
	[AdvanceMemberNo] [int] NULL,
	[AdvanceSubscriptionNo] [int] NULL,
	[AbsentMemberNo] [int] NULL,
	[NomineeNo] [int] NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DebitSubscriptionDueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_GiroDebitProcess]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_GiroDebitProcess](
	[GiroDebitProcessId] [int] IDENTITY(1,1) NOT NULL,
	[UploadFileName] [varchar](255) NULL,
	[TransactionDate] [datetime] NULL,
	[PaymentMethod] [varchar](10) NULL,
	[BankTransferStatus] [int] NULL,
	[AccountType] [varchar](255) NULL,
	[RecordType] [varchar](50) NULL,
	[TypeCode] [varchar](50) NULL,
	[Clearing] [varchar](50) NULL,
	[ReportGenDate] [datetime] NULL,
	[OrginatingBank] [varchar](50) NULL,
	[Filler] [varchar](255) NULL,
	[TrailerRecordType] [varchar](50) NULL,
	[TotalNoOfAcceptedDRTran] [varchar](50) NULL,
	[TotalAmtOfAcceptedDRTran] [varchar](50) NULL,
	[TotalNoOfRejectedDRTran] [varchar](50) NULL,
	[TotalAmtOfRejectedDRTran] [varchar](50) NULL,
	[TotalNoOfReturnedDRTran] [varchar](50) NULL,
	[TotalAmtOfReturnedDRTran] [varchar](50) NULL,
	[TotalNoOfDRTran] [varchar](50) NULL,
	[TotalAmtOfDRTran] [varchar](50) NULL,
	[TrailerFiller] [varchar](255) NOT NULL,
	[IsCheck] [tinyint] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[GiroDebitProcessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_GiroDebitProcessDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_GiroDebitProcessDetail](
	[GiroDebitProcessDetailId] [int] IDENTITY(1,1) NOT NULL,
	[GiroDebitProcessId] [int] NOT NULL,
	[OutstandingID] [int] NULL,
	[ProspectID] [varchar](15) NULL,
	[RecordType] [varchar](50) NULL,
	[DebitingAccNo] [varchar](255) NULL,
	[DebitingAccCurrency] [varchar](15) NULL,
	[ValueDate] [datetime] NULL,
	[ValueTime] [datetime] NULL,
	[CustomerBatchNo] [varchar](255) NULL,
	[CustomerReference] [varchar](255) NULL,
	[PayEmployeeBankCode] [varchar](255) NULL,
	[PayEmployeeName] [varchar](255) NULL,
	[PayEmployeeAccNo] [varchar](255) NULL,
	[RemittingAmount] [varchar](255) NULL,
	[RemittingCurrency] [varchar](15) NULL,
	[PurposeCode] [varchar](255) NULL,
	[CollectionRefNo] [varchar](255) NULL,
	[PayDetails] [varchar](255) NULL,
	[RejectCode] [varchar](255) NULL,
	[ReturnCode] [varchar](255) NULL,
	[ProxyType] [varchar](255) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[GiroDebitProcessDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_GLPosting]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_GLPosting](
	[GLPostingId] [int] IDENTITY(1,1) NOT NULL,
	[financialMonth] [datetime] NULL,
	[processingDate] [datetime] NULL,
	[totalCredit] [numeric](18, 10) NULL,
	[totalDebit] [numeric](18, 10) NULL,
	[postedItems] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[GLPostingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_GLPostingAdjustment]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_GLPostingAdjustment](
	[GLPostingAdjustmentId] [int] IDENTITY(1,1) NOT NULL,
	[GLPostingId] [int] NOT NULL,
	[TransactionDetailId] [int] NOT NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK__AR_GLPos__29DEA0CAFB93B10C] PRIMARY KEY CLUSTERED 
(
	[GLPostingAdjustmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_GLVoucher]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_GLVoucher](
	[GLVoucherId] [int] IDENTITY(1,1) NOT NULL,
	[GLPostingId] [int] NOT NULL,
	[period] [varchar](20) NULL,
	[year] [varchar](20) NULL,
	[num] [int] NULL,
	[accbook_pk] [varchar](255) NULL,
	[vouchertype_code] [varchar](255) NULL,
	[prepared_name] [varchar](255) NULL,
	[prepared_code] [varchar](255) NULL,
	[accbook_code] [varchar](255) NULL,
	[accbook_name] [varchar](255) NULL,
	[prepared_pk] [varchar](255) NULL,
	[vouchertype_name] [varchar](255) NULL,
	[vouchertype_pk] [varchar](255) NULL,
	[pk_voucher] [varchar](255) NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[GLVoucherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_ImportBillReport]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_ImportBillReport](
	[ImportBillReportId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](10) NULL,
	[ProcessingDate] [datetime] NULL,
	[ProcessThruDate] [datetime] NULL,
	[TransactionDate] [datetime] NULL,
	[SystemUse] [varchar](1) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[UpdatedAt] [datetime] NULL,
	[tatementMonth] [int] NULL,
 CONSTRAINT [PK_AR_ImportBillReport] PRIMARY KEY CLUSTERED 
(
	[ImportBillReportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_ImportBillReportDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_ImportBillReportDetail](
	[ImportBillReportDetailId] [int] IDENTITY(1,1) NOT NULL,
	[ImportBillReportId] [int] NOT NULL,
	[MemberId] [varchar](10) NULL,
	[InvoiceNo] [varchar](11) NULL,
	[NRIC] [varchar](15) NULL,
	[PaymentAmount] [decimal](10, 2) NULL,
	[Source] [varchar](10) NULL,
	[ProspectId] [varchar](15) NULL,
	[OutstandingID] [int] NULL,
	[SystemUse] [varchar](1) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_AR_ImportBillReportDetail] PRIMARY KEY CLUSTERED 
(
	[ImportBillReportDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_ItemForSelection]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_ItemForSelection](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_AR_ItemForSelection] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_Location]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Location](
	[ARLocationId] [int] IDENTITY(1,1) NOT NULL,
	[LocID] [varchar](5) NOT NULL,
	[Code] [varchar](5) NULL,
	[Organization] [varchar](20) NULL,
	[LocationName] [varchar](100) NULL,
	[PostalCode] [varchar](6) NULL,
	[Country] [varchar](15) NULL,
	[Telephone] [varchar](20) NULL,
	[Fax] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AR_Location] PRIMARY KEY CLUSTERED 
(
	[ARLocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_MemberAccount]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_MemberAccount](
	[MemberAccountId] [int] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[IsWaiveInterest] [tinyint] NULL,
	[WaiveAmount] [numeric](18, 10) NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MemberAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_MemberAccountDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_MemberAccountDetail](
	[MemberAccountDetailId] [int] IDENTITY(1,1) NOT NULL,
	[MemberAccountId] [int] NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[MailingType] [varchar](1) NULL,
	[PaymentMethod] [varchar](15) NULL,
	[AccountNo] [varchar](255) NOT NULL,
	[Reference] [varchar](255) NOT NULL,
	[GiroBank] [varchar](4) NULL,
	[GiroBranch] [varchar](255) NULL,
	[GiroSwiftCode] [varchar](20) NULL,
	[GiroLimitAmount] [decimal](18, 10) NULL,
	[CreditCardType] [varchar](3) NULL,
	[CreditCardExpiry] [varchar](255) NULL,
	[CreditCardReference] [varchar](255) NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK__AR_Membe__62EDE6C1788438E0] PRIMARY KEY CLUSTERED 
(
	[MemberAccountDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_Module]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Module](
	[ModuleId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](3) NOT NULL,
	[Name] [varchar](225) NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ModuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_MonthEndProcess]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_MonthEndProcess](
	[MonthEndProcessId] [int] IDENTITY(1,1) NOT NULL,
	[ClosingDate] [datetime] NULL,
	[PaymentDueMonth] [int] NULL,
	[PaymentDueYear] [int] NULL,
	[PaymentDueDay] [int] NULL,
	[GiroDueDay] [int] NULL,
	[CreditCardDueDay] [int] NULL,
	[PaymentDueDate] [date] NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MonthEndProcessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_Office]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Office](
	[officeID] [varchar](5) NOT NULL,
	[Code] [varchar](5) NULL,
	[Name] [varchar](100) NULL,
	[Tel] [varchar](20) NULL,
	[Fax] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AR_Office] PRIMARY KEY CLUSTERED 
(
	[officeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_Payable]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Payable](
	[PayableId] [int] IDENTITY(1,1) NOT NULL,
	[RefundGuid] [varchar](255) NULL,
	[pk_bill] [varchar](255) NULL,
	[billmaker] [varchar](255) NULL,
	[billno] [varchar](255) NULL,
	[pk_org] [varchar](255) NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PayableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_Recurring]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Recurring](
	[RecurringId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [char](1) NOT NULL,
	[Month] [int] NOT NULL,
	[Description] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecurringId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_Refund]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Refund](
	[RefundID] [int] IDENTITY(1,1) NOT NULL,
	[RefundDate] [datetime] NULL,
	[BatchID] [nchar](10) NULL,
	[PaymentCode] [varchar](3) NOT NULL,
	[Reference] [varchar](100) NOT NULL,
	[RefundOption] [varchar](20) NOT NULL,
	[AutoOffset] [tinyint] NOT NULL,
	[AutoInvoice] [tinyint] NOT NULL,
	[TotalRefundAmount] [numeric](18, 10) NULL,
	[Guid] [varchar](255) NOT NULL,
	[Description] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RefundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_RefundDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_RefundDetail](
	[RefundID] [int] NOT NULL,
	[RefundDetailID] [int] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[RefundableID] [varchar](11) NOT NULL,
	[RefundAmount] [numeric](18, 10) NULL,
	[OutstandingAmount] [numeric](18, 10) NULL,
	[SecurityDeposit] [numeric](18, 10) NULL,
	[CreditLimit] [numeric](18, 10) NULL,
	[Description] [text] NULL,
	[Guid] [varchar](255) NOT NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[isPosted] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[RefundDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_RefundOutstanding]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_RefundOutstanding](
	[RefundOutstandingId] [int] IDENTITY(1,1) NOT NULL,
	[RefundDetailID] [int] NOT NULL,
	[OutstandingID] [int] NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RefundOutstandingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_Reminder]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Reminder](
	[ReminderId] [int] IDENTITY(1,1) NOT NULL,
	[ReminderDate] [datetime] NULL,
	[TotalAmount] [numeric](18, 10) NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ReminderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_ReminderDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_ReminderDetail](
	[ReminderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[ReminderId] [int] NOT NULL,
	[ProspectID] [varchar](15) NULL,
	[OutstandingID] [int] NULL,
	[Amount] [numeric](18, 10) NULL,
	[AgingCode] [varchar](20) NULL,
	[AccountStatus] [varchar](20) NULL,
	[ReminderStatus] [varchar](20) NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[ReminderFormat] [varchar](3) NULL,
	[ReminderDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReminderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_ReminderFormat]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_ReminderFormat](
	[FormatID] [varchar](3) NOT NULL,
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](150) NULL,
	[SystemUse] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AR_ReminderFormat] PRIMARY KEY CLUSTERED 
(
	[FormatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_ReminderUser]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_ReminderUser](
	[ReminderUserId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Position] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[PhoneNo] [varchar](50) NULL,
	[ReminderType] [varchar](50) NULL,
	[DateFrom] [date] NULL,
	[DateTo] [date] NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ReminderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_SelectionComparator]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_SelectionComparator](
	[SelectionComparatorId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[ComparatorId] [int] NULL,
 CONSTRAINT [PK_AR_SelectionComparator] PRIMARY KEY CLUSTERED 
(
	[SelectionComparatorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_TransactionCancel]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_TransactionCancel](
	[PaymentCsoCancelId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionDetailGuid] [varchar](255) NULL,
	[Description] [text] NULL,
	[ReasonCode] [varchar](3) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[CancelDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentCsoCancelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_TransactionMonthEnd]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_TransactionMonthEnd](
	[TransactionMonthEndId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionDetailId] [int] NOT NULL,
	[MonthEndProcessId] [int] NOT NULL,
	[Remark] [text] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[HistoryNextBillDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionMonthEndId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AR_UploadFile]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_UploadFile](
	[UploadFileId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionId] [int] NULL,
	[FileName] [varchar](255) NULL,
	[FileType] [varchar](255) NULL,
	[Module] [varchar](3) NULL,
	[Guid] [varchar](255) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UploadFileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[FullName] [nvarchar](max) NULL,
	[Status] [nvarchar](max) NULL,
	[ProspectID] [varchar](15) NULL,
	[MemberType] [varchar](50) NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[LastLoginDate] [datetime] NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLog]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLog](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProgramID] [varchar](50) NULL,
	[AdminModuleID] [int] NULL,
	[ProspectID] [varchar](15) NULL,
	[ActionName] [varchar](15) NULL,
	[UserID] [varchar](50) NULL,
	[LogDate] [datetime] NULL,
	[AffectedTable] [varchar](100) NULL,
	[AffectedID] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AuditLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLogDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogDetail](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[AuditLogID] [bigint] NOT NULL,
	[ColumnName] [varchar](100) NULL,
	[OriginalValue] [varchar](max) NULL,
	[NewValue] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_AuditLogDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bank]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bank](
	[Code] [varchar](5) NOT NULL,
	[Description] [varchar](100) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Bank] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CarParkCategory]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarParkCategory](
	[Code] [varchar](8) NOT NULL,
	[Description] [varchar](100) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_CarParkCategory] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChargeType]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChargeType](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](50) NULL,
	[ChargeTypeFor] [varchar](50) NULL,
	[ChargeLateInterest] [char](1) NULL,
	[AutoApplyPayment] [char](1) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_ChargeType] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CostCentre]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CostCentre](
	[Code] [varchar](5) NOT NULL,
	[Description] [varchar](100) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_CostCentre] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreditCardType]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditCardType](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_CreditCardType] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeclarationandAgreement]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeclarationandAgreement](
	[DeclarationID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](50) NULL,
	[FileType] [varchar](25) NULL,
	[Description] [nvarchar](300) NULL,
	[FileVirtualPath] [varchar](200) NULL,
	[IsCurrentUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_DeclarationandAgreement] PRIMARY KEY CLUSTERED 
(
	[DeclarationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryMedium]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryMedium](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](64) NULL,
	[CodeType] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_EnquiryMedium] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquirySource]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquirySource](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](64) NULL,
	[CodeType] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_EnquirySource] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryType]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryType](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](64) NULL,
	[CodeType] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_EnquiryType] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiftCode]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiftCode](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](20) NULL,
	[CodeType] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_GiftCode] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiroBank]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiroBank](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](4) NULL,
	[Description] [varchar](50) NULL,
	[SwiftCode] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_GiroBank] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GLAccount]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GLAccount](
	[AccountCode] [varchar](20) NOT NULL,
	[AccountName] [varchar](50) NULL,
	[CompanyName] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_GLAccount] PRIMARY KEY CLUSTERED 
(
	[AccountCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GolfKakiReferral]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GolfKakiReferral](
	[MembershipType] [varchar](5) NOT NULL,
	[ApplicantCredit] [numeric](10, 2) NULL,
	[ReferralCredit] [numeric](10, 2) NULL,
	[Status] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_GolfKakiReferral] PRIMARY KEY CLUSTERED 
(
	[MembershipType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](3) NULL,
	[Name] [varchar](100) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Group_1] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GST]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GST](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](5) NULL,
	[Value] [decimal](10, 2) NULL,
	[Description] [varchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_GST] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Holiday]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Holiday](
	[HolidayDate] [date] NOT NULL,
	[Description] [varchar](50) NULL,
	[CountryName] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Holiday] PRIMARY KEY CLUSTERED 
(
	[HolidayDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Industry]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Industry](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](64) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Industry] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InterestOption]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InterestOption](
	[OptionID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_InterestOption] PRIMARY KEY CLUSTERED 
(
	[OptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LetterType]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LetterType](
	[TypeID] [int] NOT NULL,
	[Description] [varchar](150) NULL,
	[SystemUse] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_LetterType] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MailingType]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MailingType](
	[Code] [varchar](1) NOT NULL,
	[Description] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_MailingType] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Absent]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Absent](
	[TransID] [bigint] IDENTITY(1,1) NOT NULL,
	[ApplicationNo] [varchar](15) NOT NULL,
	[SubscriptionType] [varchar](3) NULL,
	[AbsentFrom] [datetime] NULL,
	[AbsentTo] [datetime] NULL,
	[NoOfMonths] [int] NULL,
	[BillUpfrontType] [varchar](20) NULL,
	[UpfrontMonths] [int] NULL,
	[ReduceAmount] [numeric](10, 2) NULL,
	[ReduceGST] [numeric](10, 2) NULL,
	[TotalSubscriptionFee] [numeric](10, 2) NULL,
	[Description] [varchar](150) NULL,
	[PrivilegeFrom] [datetime] NULL,
	[PrivilegeTo] [datetime] NULL,
	[PrivilegeRemarks] [varchar](150) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_Absent] PRIMARY KEY CLUSTERED 
(
	[TransID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_ApplicationBill]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_ApplicationBill](
	[RefNo] [varchar](10) NOT NULL,
	[ApplicationNo] [varchar](15) NULL,
	[OutstandingID] [varchar](12) NULL,
	[Description] [varchar](150) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_ApplicationBill] PRIMARY KEY CLUSTERED 
(
	[RefNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Apply]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Apply](
	[TransID] [bigint] IDENTITY(1,1) NOT NULL,
	[ApplicationNo] [varchar](15) NOT NULL,
	[MembershipCategory] [varchar](3) NULL,
	[MembershipType] [varchar](3) NULL,
	[MembershipStatus] [varchar](3) NULL,
	[SubscriptionType] [varchar](3) NULL,
	[EffectiveDate] [datetime] NULL,
	[ExpiryDate] [datetime] NULL,
	[TermMonths] [int] NULL,
	[EntranceFee] [decimal](10, 2) NULL,
	[SecurityDeposit] [decimal](10, 2) NULL,
	[PermanentDeposit] [decimal](10, 2) NULL,
	[MonthlySubFee] [decimal](10, 2) NULL,
	[CreditLimit] [decimal](10, 2) NULL,
	[SpendingCredit] [decimal](10, 2) NULL,
	[NoOfNominee] [int] NULL,
	[RecruitmentSource] [int] NULL,
	[Promotion] [int] NULL,
	[EDM] [char](1) NULL,
	[EStatements] [char](1) NULL,
	[HardCopyLetter] [char](1) NULL,
	[DNC] [char](1) NULL,
	[IntroducerID] [varchar](15) NULL,
	[IntroducedName] [varchar](100) NULL,
	[IntroducedDate] [datetime] NULL,
	[PreviousApplicationNo] [varchar](15) NULL,
	[PreviousRemainingMonths] [int] NULL,
	[AdminCharge] [char](1) NULL,
	[AdminFees] [decimal](10, 2) NULL,
	[EntranceFeeUpfrontBill] [char](1) NULL,
	[AutoReinstate] [char](1) NULL,
	[CreationRemark] [varchar](250) NULL,
	[ActivationRemark] [varchar](250) NULL,
	[DeletionRemark] [varchar](3) NULL,
	[ByEmail] [char](1) NULL,
	[ByMailingLetters] [char](1) NULL,
	[ByPhone] [char](1) NULL,
	[BySms] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_Apply] PRIMARY KEY CLUSTERED 
(
	[TransID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Attachment]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Attachment](
	[AttachID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[AttachedType] [varchar](20) NULL,
	[AttachedName] [varchar](64) NULL,
	[FileVirtualPath] [varchar](200) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_Attachment] PRIMARY KEY CLUSTERED 
(
	[AttachID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_CardInfo]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_CardInfo](
	[CardID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[CardNo] [varchar](10) NULL,
	[Name] [varchar](100) NULL,
	[MembershipType] [varchar](100) NULL,
	[SpecialIndication] [varchar](50) NULL,
	[ExpiryDate] [datetime] NULL,
	[BackSignatureFileName] [varchar](64) NULL,
	[BackSignatureFilePath] [varchar](200) NULL,
	[SendDate] [datetime] NULL,
	[Status] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_CardInfo] PRIMARY KEY CLUSTERED 
(
	[CardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_CarLabel]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_CarLabel](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[CarLabel] [varchar](50) NULL,
	[CarLabelIU] [varchar](50) NULL,
	[CarLabelDate] [datetime] NULL,
	[Remarks] [varchar](150) NULL,
	[Status] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_CarLabel] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_ChangeMemberID]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_ChangeMemberID](
	[TransID] [bigint] NOT NULL,
	[ApplicationNo] [varchar](15) NOT NULL,
	[FromNameTitle] [varchar](2) NULL,
	[FromSurName] [varchar](20) NULL,
	[FromName] [varchar](50) NULL,
	[FromMemberID] [varchar](15) NULL,
	[NewMemberTitle] [varchar](2) NULL,
	[NewSurName] [varchar](20) NULL,
	[NewName] [varchar](50) NULL,
	[NewMemberID] [varchar](15) NULL,
	[Remark] [varchar](150) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_ChangeMemberID] PRIMARY KEY CLUSTERED 
(
	[TransID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_CreditUtilized]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_CreditUtilized](
	[TransID] [varchar](15) NOT NULL,
	[MerchantID] [int] NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[RequestID] [varchar](64) NULL,
	[ProductCode] [varchar](15) NULL,
	[Description] [varchar](150) NULL,
	[CreditLimitUtilized] [numeric](10, 2) NULL,
	[SpendingCreditUtilized] [numeric](10, 2) NULL,
	[TotalUtilized] [numeric](10, 2) NULL,
	[Currency] [varchar](3) NULL,
	[PaymentMethod] [varchar](3) NULL,
	[Status] [varchar](15) NULL,
	[PaymentDate] [datetime] NULL,
	[CancelDate] [datetime] NULL,
	[RefundDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_CreditUtilized] PRIMARY KEY CLUSTERED 
(
	[TransID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_CreditUtilizedDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_CreditUtilizedDetail](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TransID] [varchar](15) NOT NULL,
	[RefundedAmount] [numeric](10, 2) NULL,
	[RefundedDate] [datetime] NULL,
	[Remarks] [text] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_CreditUtilizedDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_GenerateLetter]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_GenerateLetter](
	[LetterID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[LetterType] [int] NOT NULL,
	[DueDate] [datetime] NULL,
	[MailSend] [char](1) NULL,
	[SendTo] [varchar](50) NULL,
	[SendDate] [datetime] NULL,
	[Remarks] [varchar](150) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_GenerateLetter] PRIMARY KEY CLUSTERED 
(
	[LetterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_GolfDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_GolfDetail](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NULL,
	[BillingType] [varchar](20) NULL,
	[InstallmentPlan] [varchar](15) NULL,
	[JoinedDate] [datetime] NULL,
	[ExpiredDate] [datetime] NULL,
	[EntranceFee] [decimal](10, 2) NULL,
	[InstallmentAmount] [decimal](10, 2) NULL,
	[GolfCategory] [varchar](200) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_GolfDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_GolfInsurance]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_GolfInsurance](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NULL,
	[StartDate] [datetime] NULL,
	[ExpiryDate] [datetime] NULL,
	[IsAutoRenew] [char](1) NULL,
	[Status] [varchar](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_GolfInsurance] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_GolfInsuranceTransaction]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_GolfInsuranceTransaction](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[GolfInsuranceID] [bigint] NULL,
	[ChargeCode] [varchar](3) NULL,
	[PaymentMode] [varchar](3) NULL,
	[Amount] [numeric](8, 2) NULL,
	[GSTAmount] [numeric](8, 2) NULL,
	[StartDate] [datetime] NULL,
	[ExpiryDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_GolfInsuranceDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_NSCheckExport]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_NSCheckExport](
	[ExportID] [varchar](15) NOT NULL,
	[ExportDate] [datetime] NULL,
	[ApplicationType] [varchar](25) NULL,
	[ApplicationDateFrom] [datetime] NULL,
	[ApplicationDateTo] [datetime] NULL,
	[NSService] [varchar](2) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_NSCheckExport] PRIMARY KEY CLUSTERED 
(
	[ExportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_NSCheckExportDetail]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_NSCheckExportDetail](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ExportID] [varchar](15) NULL,
	[ProspectID] [varchar](15) NULL,
	[ApplicationDate] [datetime] NULL,
	[NSService] [varchar](3) NULL,
	[NSServiceStatus] [varchar](2) NULL,
	[NSCheckStatus] [char](1) NULL,
	[NSCheckRemarks] [varchar](150) NULL,
	[NSReplyDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_NSCheckExportDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_OnlinePayment]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_OnlinePayment](
	[TransID] [bigint] IDENTITY(1,1) NOT NULL,
	[PaymentRefNo] [varchar](15) NOT NULL,
	[InvoiceNo] [varchar](12) NOT NULL,
	[ProspectID] [varchar](15) NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentStatus] [char](1) NULL,
	[PaymentAmount] [numeric](10, 2) NOT NULL,
	[Remark] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_OnlinePayment] PRIMARY KEY CLUSTERED 
(
	[TransID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_RecurrentBill]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_RecurrentBill](
	[RecuBillID] [varchar](15) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[ApplyTransID] [bigint] NULL,
	[ChargeCode] [varchar](3) NULL,
	[Frequency] [char](1) NULL,
	[StartYearMonth] [date] NULL,
	[EndYearMonth] [date] NULL,
	[NoTimesForBill] [int] NULL,
	[NoTimesBilled] [int] NULL,
	[InitialAmount] [decimal](10, 0) NULL,
	[RecurrentAmount] [decimal](10, 2) NULL,
	[FinalAmount] [decimal](10, 2) NULL,
	[PaymentMethod] [varchar](5) NULL,
	[LastBilledYearMonth] [date] NULL,
	[LastPaidYearMonth] [date] NULL,
	[LastPartialPayment] [decimal](10, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_RecurrentBill] PRIMARY KEY CLUSTERED 
(
	[RecuBillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Refundable]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Refundable](
	[RefundableID] [varchar](11) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[RefundableOption] [varchar](3) NULL,
	[RefundableDate] [datetime] NULL,
	[RefundableAmount] [numeric](10, 2) NULL,
	[Description] [varchar](150) NULL,
	[RefundedAmount] [numeric](10, 2) NULL,
	[RefundedDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_Refundable] PRIMARY KEY CLUSTERED 
(
	[RefundableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Remark]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Remark](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NULL,
	[RemarksType] [varchar](2) NULL,
	[RemarksCode] [varchar](3) NULL,
	[SuspendDate] [datetime] NULL,
	[Remarks] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_Remark] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_SpendingCredit]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_SpendingCredit](
	[ID] [varchar](11) NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[Description] [varchar](128) NULL,
	[Amount] [decimal](10, 2) NULL,
	[GSTInclude] [char](1) NULL,
	[GSTAmount] [decimal](10, 2) NULL,
	[RefNo] [varchar](10) NULL,
	[IssuedDate] [datetime] NULL,
	[ExpiryDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_SpendingCredit] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_StatusHistory]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_StatusHistory](
	[TransID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProspectID] [varchar](15) NULL,
	[AcctStatus] [varchar](50) NULL,
	[ProcessedDate] [datetime] NULL,
	[ProcessedStatus] [varchar](15) NULL,
	[ProcessedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_StatusHistory] PRIMARY KEY CLUSTERED 
(
	[TransID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Transfer]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Transfer](
	[TransID] [bigint] IDENTITY(1,1) NOT NULL,
	[ApplicationNo] [varchar](15) NOT NULL,
	[TransferCode] [varchar](3) NULL,
	[MembershipCategory] [varchar](3) NULL,
	[MembershipType] [varchar](3) NULL,
	[SubscriptionType] [varchar](3) NULL,
	[TermYears] [int] NULL,
	[EffectiveDate] [datetime] NULL,
	[ExpiryDate] [datetime] NULL,
	[TotalOutstandingBal] [numeric](10, 2) NULL,
	[SecurityDeposit] [numeric](10, 2) NULL,
	[PermanentDeposit] [numeric](10, 2) NULL,
	[SubscriptionBal] [numeric](10, 2) NULL,
	[NewProspectID] [varchar](15) NULL,
	[NewMembershipCategory] [varchar](3) NULL,
	[NewMembershipType] [varchar](3) NULL,
	[NewSubscriptionType] [varchar](3) NULL,
	[NewTermYears] [int] NULL,
	[NewEffectiveDate] [datetime] NULL,
	[NewExpiryDate] [datetime] NULL,
	[NewEntranceFee] [decimal](10, 2) NULL,
	[NewSubscriptionFee] [decimal](10, 2) NULL,
	[AdminFee] [decimal](10, 2) NULL,
	[AdminDescription] [varchar](150) NULL,
	[TransferFee] [decimal](10, 2) NULL,
	[TransferDescription] [varchar](150) NULL,
	[TransferPrice] [decimal](10, 2) NULL,
	[Reason] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_Transfer] PRIMARY KEY CLUSTERED 
(
	[TransID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_UserDefine]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_UserDefine](
	[ID] [bigint] NOT NULL,
	[ProspectID] [varchar](15) NOT NULL,
	[FieldID] [int] NULL,
	[FieldValue] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Member_UserDefine] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MembershipStatus]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MembershipStatus](
	[Code] [varchar](2) NOT NULL,
	[Description] [varchar](20) NULL,
	[BillInterest] [char](1) NULL,
	[BillSubscription] [char](1) NULL,
	[AllowUsageFE] [char](1) NULL,
	[AllowChargeFE] [char](1) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_MembershipStatus] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Merchant]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Merchant](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MerchantID] [varchar](4) NULL,
	[MerchantName] [varchar](40) NULL,
	[AuthToken] [varchar](12) NULL,
	[Status] [varchar](10) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Merchant] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MMSSystemSetup]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MMSSystemSetup](
	[SetupID] [varchar](15) NOT NULL,
	[ResortName] [varchar](150) NULL,
	[CompanyName] [varchar](150) NULL,
	[MonthEnd] [datetime] NULL,
	[YearEnd] [datetime] NULL,
	[JuniorMaxAge] [int] NULL,
	[JuniorMinAge] [int] NULL,
	[PrintingDay] [int] NULL,
	[PayDueDay] [int] NULL,
	[GiroDueDay] [int] NULL,
	[CreditCardDueDay] [int] NULL,
	[NoOfLinesSOA] [int] NULL,
	[IsCalcServiceTax] [char](1) NULL,
	[ServiceTaxRate] [decimal](10, 2) NULL,
	[GovTaxRate] [decimal](10, 2) NULL,
	[IsAutoSubscriptionBill] [char](1) NULL,
	[IsAutoAbsentSubBill] [char](1) NULL,
	[IsAutoNomineeSubBill] [char](1) NULL,
	[SubscriptionBased] [varchar](50) NULL,
	[EntranceBillBased] [varchar](50) NULL,
	[MinFreezeAmount] [decimal](10, 2) NULL,
	[FreezeCreditOverdueDay] [int] NULL,
	[CreditLimitMin] [decimal](10, 2) NULL,
	[LocalCurrency] [varchar](3) NULL,
	[InterestOption] [varchar](15) NULL,
	[LateInterestRate] [decimal](10, 2) NULL,
	[InterestOverdue] [int] NULL,
	[InterestMinAmount] [decimal](10, 2) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_MMSSystemSetup_1] PRIMARY KEY CLUSTERED 
(
	[SetupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nationality]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nationality](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Nationality] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NationalService]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NationalService](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_NationalService] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NationalServiceStatus]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NationalServiceStatus](
	[Code] [varchar](2) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_NationalServiceStatus] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NSRCCResource]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NSRCCResource](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IDNo] [varchar](15) NULL,
	[Name] [varchar](50) NULL,
	[Title] [varchar](2) NULL,
	[SurName] [varchar](20) NULL,
	[NRIC] [varchar](15) NULL,
	[Gender] [char](1) NULL,
	[Category] [varchar](15) NULL,
	[Remark] [varchar](100) NULL,
	[Status] [varchar](3) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_NSRCCResource] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NSRCCResource_CarLabel]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NSRCCResource_CarLabel](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ResourceID] [bigint] NULL,
	[CarParkCategory] [varchar](15) NULL,
	[CarLabel] [varchar](50) NULL,
	[CarLabelIU] [varchar](50) NULL,
	[Remarks] [varchar](150) NULL,
	[Status] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_NSRCCResource_CarLabel] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OtherClub]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtherClub](
	[Code] [varchar](10) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_OtherClub] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Outlet]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Outlet](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](30) NULL,
	[ChargeType] [varchar](3) NULL,
	[ChargeCode] [varchar](3) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Outlet] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentCode]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentCode](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](50) NULL,
	[ShortDescription] [varchar](30) NULL,
	[GLAccount] [varchar](20) NULL,
	[BankInType] [varchar](15) NULL,
	[PrintReceipt] [char](1) NULL,
	[Status] [char](1) NULL,
	[InactiveDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_PaymentCode] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethod]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethod](
	[Code] [varchar](5) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [varchar](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_PaymentMethod] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[PromoCode] [varchar](3) NOT NULL,
	[PromoCategory] [varchar](3) NOT NULL,
	[PromoOption] [int] NOT NULL,
	[Status] [char](1) NULL,
	[EffectiveDate] [datetime] NULL,
	[Remarks] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Promotion] PRIMARY KEY CLUSTERED 
(
	[PromoCode] ASC,
	[PromoCategory] ASC,
	[PromoOption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PromotionCode]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromotionCode](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](64) NULL,
	[CodeType] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_PromotionCode] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Race]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Race](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Race] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rank]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rank](
	[Code] [varchar](2) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Rank] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecruitmentSource]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecruitmentSource](
	[Code] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_RecruitmentSource] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RejectionReason]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RejectionReason](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](100) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_RejectionReason] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RemarksCode]    Script Date: 3/22/2024 10:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RemarksCode](
	[Code] [varchar](3) NOT NULL,
	[RemarksType] [varchar](2) NULL,
	[Description] [varchar](50) NULL,
	[RemarksLabel] [varchar](50) NULL,
	[DateLabel] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_RemarksCode] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RemarksType]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RemarksType](
	[Type] [varchar](2) NOT NULL,
	[Description] [varchar](100) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_RemarksType] PRIMARY KEY CLUSTERED 
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RunningNumber]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RunningNumber](
	[TransactionType] [varchar](3) NOT NULL,
	[NextNumber] [int] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_RunningNumber] PRIMARY KEY CLUSTERED 
(
	[TransactionType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](50) NULL,
	[CodeType] [varchar](20) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubscriptionType]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionType](
	[Code] [varchar](10) NOT NULL,
	[Description] [varchar](50) NULL,
	[ShortDescription] [varchar](20) NULL,
	[Amount] [numeric](10, 2) NULL,
	[ExclusiveGovTax] [char](1) NULL,
	[GovTax] [numeric](10, 2) NULL,
	[ReducedAmount] [numeric](10, 2) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_SubscriptionType] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemLog]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemLog](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProgramID] [varchar](50) NULL,
	[ActionName] [varchar](15) NULL,
	[Type] [varchar](15) NULL,
	[Description] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
 CONSTRAINT [PK_SystemLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TermsandCondition]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TermsandCondition](
	[TermsID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](50) NULL,
	[FileType] [varchar](25) NULL,
	[Description] [nvarchar](300) NULL,
	[FileVirtualPath] [varchar](200) NULL,
	[IsCurrentUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_TermsandCondition] PRIMARY KEY CLUSTERED 
(
	[TermsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp](
	[ProspectID] [varchar](15) NOT NULL,
	[CarLabel1] [varchar](50) NULL,
	[CarLabel2] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransferCode]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransferCode](
	[Code] [varchar](3) NOT NULL,
	[Description] [varchar](50) NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_TransferCode] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDefinedField]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDefinedField](
	[FieldID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NULL,
	[Type] [char](1) NULL,
	[Size] [int] NULL,
	[SystemUse] [char](1) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_UserDefinedField] PRIMARY KEY CLUSTERED 
(
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [int] NOT NULL,
	[ExpireAt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CX_HangFire_Counter]    Script Date: 3/22/2024 10:06:58 AM ******/
CREATE CLUSTERED INDEX [CX_HangFire_Counter] ON [HangFire].[Counter]
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Key] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Job]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NULL,
	[StateName] [nvarchar](20) NULL,
	[InvocationData] [nvarchar](max) NOT NULL,
	[Arguments] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Queue] [nvarchar](50) NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Queue] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[List]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Server]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](200) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Set]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Key] [nvarchar](100) NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[State]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_AggregatedCounter_ExpireAt]    Script Date: 3/22/2024 10:06:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_AggregatedCounter_ExpireAt] ON [HangFire].[AggregatedCounter]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Hash_ExpireAt]    Script Date: 3/22/2024 10:06:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_ExpireAt] ON [HangFire].[Hash]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Job_ExpireAt]    Script Date: 3/22/2024 10:06:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_ExpireAt] ON [HangFire].[Job]
(
	[ExpireAt] ASC
)
INCLUDE([StateName]) 
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Job_StateName]    Script Date: 3/22/2024 10:06:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_StateName] ON [HangFire].[Job]
(
	[StateName] ASC
)
WHERE ([StateName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_List_ExpireAt]    Script Date: 3/22/2024 10:06:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_List_ExpireAt] ON [HangFire].[List]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Server_LastHeartbeat]    Script Date: 3/22/2024 10:06:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Server_LastHeartbeat] ON [HangFire].[Server]
(
	[LastHeartbeat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Set_ExpireAt]    Script Date: 3/22/2024 10:06:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_ExpireAt] ON [HangFire].[Set]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Set_Score]    Script Date: 3/22/2024 10:06:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_Score] ON [HangFire].[Set]
(
	[Key] ASC,
	[Score] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AR_TransactionDetail] ADD  DEFAULT ((0)) FOR [IsBankIn]
GO
ALTER TABLE [dbo].[AR_TransactionDetail] ADD  DEFAULT ((0)) FOR [IsPosted]
GO
ALTER TABLE [dbo].[AR_TransactionDetail] ADD  DEFAULT ((0)) FOR [IsMonthEnd]
GO
ALTER TABLE [dbo].[Member_Outstanding] ADD  CONSTRAINT [DF__Member_Ou__Statu__0CA5D9DE]  DEFAULT ('A') FOR [Status]
GO
ALTER TABLE [dbo].[Member_Outstanding] ADD  CONSTRAINT [DF__Member_Ou__isBan__1D9B5BB6]  DEFAULT ((0)) FOR [IsBankTransfer]
GO
ALTER TABLE [dbo].[Member_Outstanding] ADD  CONSTRAINT [DF__Member_Ou__AdvBi__1E8F7FEF]  DEFAULT ('N') FOR [AdvBill]
GO
ALTER TABLE [dbo].[AR_GLVoucher]  WITH CHECK ADD  CONSTRAINT [FK_GLVoucher] FOREIGN KEY([GLPostingId])
REFERENCES [dbo].[AR_GLPosting] ([GLPostingId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AR_GLVoucher] CHECK CONSTRAINT [FK_GLVoucher]
GO
ALTER TABLE [dbo].[AR_RefundDetail]  WITH CHECK ADD  CONSTRAINT [FK_RefundDetail] FOREIGN KEY([RefundID])
REFERENCES [dbo].[AR_Refund] ([RefundID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AR_RefundDetail] CHECK CONSTRAINT [FK_RefundDetail]
GO
ALTER TABLE [dbo].[AR_SelectionComparator]  WITH CHECK ADD  CONSTRAINT [FK_AR_SelectionComparator_AR_Comparator] FOREIGN KEY([SelectionComparatorId])
REFERENCES [dbo].[AR_Comparator] ([ComparatorId])
GO
ALTER TABLE [dbo].[AR_SelectionComparator] CHECK CONSTRAINT [FK_AR_SelectionComparator_AR_Comparator]
GO
ALTER TABLE [dbo].[AR_SelectionComparator]  WITH CHECK ADD  CONSTRAINT [FK_AR_SelectionComparator_AR_ItemForSelection] FOREIGN KEY([SelectionComparatorId])
REFERENCES [dbo].[AR_ItemForSelection] ([ItemId])
GO
ALTER TABLE [dbo].[AR_SelectionComparator] CHECK CONSTRAINT [FK_AR_SelectionComparator_AR_ItemForSelection]
GO
ALTER TABLE [dbo].[AR_TransactionDetail]  WITH CHECK ADD  CONSTRAINT [FK_TransactionDetail] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[AR_Transaction] ([TransactionId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AR_TransactionDetail] CHECK CONSTRAINT [FK_TransactionDetail]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AuditLog]  WITH CHECK ADD  CONSTRAINT [FK_AuditLog_AdminModule] FOREIGN KEY([AdminModuleID])
REFERENCES [dbo].[AdminModule] ([ModuleID])
GO
ALTER TABLE [dbo].[AuditLog] CHECK CONSTRAINT [FK_AuditLog_AdminModule]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Member_Member_Person] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Member_Person] ([PersonID])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Member_Member_Person]
GO
ALTER TABLE [dbo].[Member_Absent]  WITH CHECK ADD  CONSTRAINT [FK_Member_Absent_Member_Application] FOREIGN KEY([ApplicationNo])
REFERENCES [dbo].[Member_Application] ([ApplicationNo])
GO
ALTER TABLE [dbo].[Member_Absent] CHECK CONSTRAINT [FK_Member_Absent_Member_Application]
GO
ALTER TABLE [dbo].[Member_Application]  WITH CHECK ADD  CONSTRAINT [FK_Member_Application_ApplicationType] FOREIGN KEY([ApplicationType])
REFERENCES [dbo].[ApplicationType] ([ID])
GO
ALTER TABLE [dbo].[Member_Application] CHECK CONSTRAINT [FK_Member_Application_ApplicationType]
GO
ALTER TABLE [dbo].[Member_Application]  WITH CHECK ADD  CONSTRAINT [FK_Member_Application_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_Application] CHECK CONSTRAINT [FK_Member_Application_Member]
GO
ALTER TABLE [dbo].[Member_Apply]  WITH CHECK ADD  CONSTRAINT [FK_Member_Apply_Member_Application] FOREIGN KEY([ApplicationNo])
REFERENCES [dbo].[Member_Application] ([ApplicationNo])
GO
ALTER TABLE [dbo].[Member_Apply] CHECK CONSTRAINT [FK_Member_Apply_Member_Application]
GO
ALTER TABLE [dbo].[Member_Attachment]  WITH CHECK ADD  CONSTRAINT [FK_Member_Attachment_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_Attachment] CHECK CONSTRAINT [FK_Member_Attachment_Member]
GO
ALTER TABLE [dbo].[Member_CardInfo]  WITH CHECK ADD  CONSTRAINT [FK_Member_CardInfo_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_CardInfo] CHECK CONSTRAINT [FK_Member_CardInfo_Member]
GO
ALTER TABLE [dbo].[Member_CarLabel]  WITH CHECK ADD  CONSTRAINT [FK_Member_CarLabel_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_CarLabel] CHECK CONSTRAINT [FK_Member_CarLabel_Member]
GO
ALTER TABLE [dbo].[Member_ChangeMemberID]  WITH CHECK ADD  CONSTRAINT [FK_Member_ChangeMemberID_Member_Application] FOREIGN KEY([ApplicationNo])
REFERENCES [dbo].[Member_Application] ([ApplicationNo])
GO
ALTER TABLE [dbo].[Member_ChangeMemberID] CHECK CONSTRAINT [FK_Member_ChangeMemberID_Member_Application]
GO
ALTER TABLE [dbo].[Member_ChangeStatus]  WITH CHECK ADD  CONSTRAINT [FK_Member_ChangeStatus_Member_Application] FOREIGN KEY([ApplicationNo])
REFERENCES [dbo].[Member_Application] ([ApplicationNo])
GO
ALTER TABLE [dbo].[Member_ChangeStatus] CHECK CONSTRAINT [FK_Member_ChangeStatus_Member_Application]
GO
ALTER TABLE [dbo].[Member_Company]  WITH CHECK ADD  CONSTRAINT [FK_Member_Company_CompanyCode] FOREIGN KEY([CompanyCode])
REFERENCES [dbo].[CompanyCode] ([Code])
GO
ALTER TABLE [dbo].[Member_Company] CHECK CONSTRAINT [FK_Member_Company_CompanyCode]
GO
ALTER TABLE [dbo].[Member_CreditUtilized]  WITH CHECK ADD  CONSTRAINT [FK_Member_CreditUtilized_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_CreditUtilized] CHECK CONSTRAINT [FK_Member_CreditUtilized_Member]
GO
ALTER TABLE [dbo].[Member_CreditUtilized]  WITH CHECK ADD  CONSTRAINT [FK_Member_CreditUtilized_Merchant] FOREIGN KEY([MerchantID])
REFERENCES [dbo].[Merchant] ([ID])
GO
ALTER TABLE [dbo].[Member_CreditUtilized] CHECK CONSTRAINT [FK_Member_CreditUtilized_Merchant]
GO
ALTER TABLE [dbo].[Member_CreditUtilizedDetail]  WITH CHECK ADD  CONSTRAINT [FK_Member_CreditUtilizedDetail_Member_CreditUtilized] FOREIGN KEY([TransID])
REFERENCES [dbo].[Member_CreditUtilized] ([TransID])
GO
ALTER TABLE [dbo].[Member_CreditUtilizedDetail] CHECK CONSTRAINT [FK_Member_CreditUtilizedDetail_Member_CreditUtilized]
GO
ALTER TABLE [dbo].[Member_GenerateLetter]  WITH CHECK ADD  CONSTRAINT [FK_Member_GenerateLetter_LetterType] FOREIGN KEY([LetterType])
REFERENCES [dbo].[LetterType] ([TypeID])
GO
ALTER TABLE [dbo].[Member_GenerateLetter] CHECK CONSTRAINT [FK_Member_GenerateLetter_LetterType]
GO
ALTER TABLE [dbo].[Member_GenerateLetter]  WITH CHECK ADD  CONSTRAINT [FK_Member_GenerateLetter_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_GenerateLetter] CHECK CONSTRAINT [FK_Member_GenerateLetter_Member]
GO
ALTER TABLE [dbo].[Member_GolfDetail]  WITH CHECK ADD  CONSTRAINT [FK_Member_GolfDetail_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_GolfDetail] CHECK CONSTRAINT [FK_Member_GolfDetail_Member]
GO
ALTER TABLE [dbo].[Member_GolfInsurance]  WITH CHECK ADD  CONSTRAINT [FK_Member_GolfInsurance_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_GolfInsurance] CHECK CONSTRAINT [FK_Member_GolfInsurance_Member]
GO
ALTER TABLE [dbo].[Member_NSCheckExportDetail]  WITH CHECK ADD  CONSTRAINT [FK_Member_NSCheckExportDetail_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_NSCheckExportDetail] CHECK CONSTRAINT [FK_Member_NSCheckExportDetail_Member]
GO
ALTER TABLE [dbo].[Member_NSCheckExportDetail]  WITH CHECK ADD  CONSTRAINT [FK_Member_NSCheckExportDetail_Member_NSCheckExport] FOREIGN KEY([ExportID])
REFERENCES [dbo].[Member_NSCheckExport] ([ExportID])
GO
ALTER TABLE [dbo].[Member_NSCheckExportDetail] CHECK CONSTRAINT [FK_Member_NSCheckExportDetail_Member_NSCheckExport]
GO
ALTER TABLE [dbo].[Member_NSCheckExportDetail]  WITH CHECK ADD  CONSTRAINT [FK_Member_NSCheckExportDetail_NationalService] FOREIGN KEY([NSService])
REFERENCES [dbo].[NationalService] ([Code])
GO
ALTER TABLE [dbo].[Member_NSCheckExportDetail] CHECK CONSTRAINT [FK_Member_NSCheckExportDetail_NationalService]
GO
ALTER TABLE [dbo].[Member_NSCheckExportDetail]  WITH CHECK ADD  CONSTRAINT [FK_Member_NSCheckExportDetail_NationalServiceStatus] FOREIGN KEY([NSServiceStatus])
REFERENCES [dbo].[NationalServiceStatus] ([Code])
GO
ALTER TABLE [dbo].[Member_NSCheckExportDetail] CHECK CONSTRAINT [FK_Member_NSCheckExportDetail_NationalServiceStatus]
GO
ALTER TABLE [dbo].[Member_Outstanding]  WITH CHECK ADD  CONSTRAINT [FK_Member_Outstanding_ChargeCode] FOREIGN KEY([ChargeCode])
REFERENCES [dbo].[ChargeCode] ([Code])
GO
ALTER TABLE [dbo].[Member_Outstanding] CHECK CONSTRAINT [FK_Member_Outstanding_ChargeCode]
GO
ALTER TABLE [dbo].[Member_Outstanding]  WITH CHECK ADD  CONSTRAINT [FK_Member_Outstanding_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_Outstanding] CHECK CONSTRAINT [FK_Member_Outstanding_Member]
GO
ALTER TABLE [dbo].[Member_RecurrentBill]  WITH CHECK ADD  CONSTRAINT [FK_Member_RecurrentBill_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_RecurrentBill] CHECK CONSTRAINT [FK_Member_RecurrentBill_Member]
GO
ALTER TABLE [dbo].[Member_RecurrentBill]  WITH CHECK ADD  CONSTRAINT [FK_Member_RecurrentBill_Member_Apply] FOREIGN KEY([ApplyTransID])
REFERENCES [dbo].[Member_Apply] ([TransID])
GO
ALTER TABLE [dbo].[Member_RecurrentBill] CHECK CONSTRAINT [FK_Member_RecurrentBill_Member_Apply]
GO
ALTER TABLE [dbo].[Member_Refundable]  WITH CHECK ADD  CONSTRAINT [FK_Member_Refundable_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_Refundable] CHECK CONSTRAINT [FK_Member_Refundable_Member]
GO
ALTER TABLE [dbo].[Member_Relation]  WITH CHECK ADD  CONSTRAINT [FK_Member_Relation_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_Relation] CHECK CONSTRAINT [FK_Member_Relation_Member]
GO
ALTER TABLE [dbo].[Member_Relation]  WITH CHECK ADD  CONSTRAINT [FK_Member_Relation_Member1] FOREIGN KEY([PrincipleProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_Relation] CHECK CONSTRAINT [FK_Member_Relation_Member1]
GO
ALTER TABLE [dbo].[Member_SpendingCredit]  WITH CHECK ADD  CONSTRAINT [FK_Member_SpendingCredit_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_SpendingCredit] CHECK CONSTRAINT [FK_Member_SpendingCredit_Member]
GO
ALTER TABLE [dbo].[Member_StatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_Member_StatusHistory_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_StatusHistory] CHECK CONSTRAINT [FK_Member_StatusHistory_Member]
GO
ALTER TABLE [dbo].[Member_Transfer]  WITH CHECK ADD  CONSTRAINT [FK_Member_Transfer_Member_Application] FOREIGN KEY([ApplicationNo])
REFERENCES [dbo].[Member_Application] ([ApplicationNo])
GO
ALTER TABLE [dbo].[Member_Transfer] CHECK CONSTRAINT [FK_Member_Transfer_Member_Application]
GO
ALTER TABLE [dbo].[Member_UserDefine]  WITH CHECK ADD  CONSTRAINT [FK_Member_UserDefine_Member] FOREIGN KEY([ProspectID])
REFERENCES [dbo].[Member] ([ProspectID])
GO
ALTER TABLE [dbo].[Member_UserDefine] CHECK CONSTRAINT [FK_Member_UserDefine_Member]
GO
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
GO
/****** Object:  StoredProcedure [dbo].[GetAgingReport]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetAgingReport]
	@Date AS date,
	@ChargeCode AS VARCHAR(100),
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = 20000000;

DECLARE @crCurr AS date
SET @crCurr = DATEADD(month, -1, CAST( @Date AS Date )) 

DECLARE @cr30Date AS date
SET @cr30Date = DATEADD(month, 1, CAST( @Date AS Date )) 

DECLARE @cr60Date AS date
SET @cr60Date = DATEADD(month, 2, CAST( @Date AS Date )) 

DECLARE @cr90Date AS date
SET @cr90Date = DATEADD(month, 3, CAST( @Date AS Date )) 

DECLARE @cr120Date AS date
SET @cr120Date = DATEADD(month, 4, CAST( @Date AS Date )) 

DECLARE @cr150Date AS date
SET @cr150Date = DATEADD(month, 5, CAST( @Date AS Date )) 

DECLARE @cr180Date AS date
SET @cr180Date = DATEADD(month, 6, CAST( @Date AS Date )) 

select tbl.ProspectID, tbl.ChargeCode, tbl.ChargeCodeDescription,
sum(ISNULL(CrCurr, 0 )) as 'CrCurr',
sum(ISNULL(Cr30, 0 )) as 'Cr30',
sum(ISNULL(Cr60, 0 )) as 'Cr60',
sum(ISNULL(Cr90, 0 )) as 'Cr90',
sum(ISNULL(Cr120, 0 )) as 'Cr120',
sum(ISNULL(Cr150, 0 )) as 'Cr150',
sum(ISNULL(Cr180, 0 )) as 'Cr180'
from (
    select am.ProspectID, am.MemberID, am.MemberName,Member_Outstanding.ChargeCode,ChargeCode.Description as 'ChargeCodeDescription',
(select
sum(ISNULL(OutstandingAmount - PaidAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(@crCurr) AND YEAR(OutstandingDate) = YEAR(@crCurr) AND ProspectID = am.ProspectID) as 'CrCurr',
(select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(@cr30Date) AND YEAR(OutstandingDate) = YEAR(@cr30Date) AND ProspectID = am.ProspectID ) as 'Cr30', 
(select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(@cr60Date) AND YEAR(OutstandingDate) = YEAR(@cr60Date) AND ProspectID = am.ProspectID ) as 'Cr60', 
(select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(@cr90Date) AND YEAR(OutstandingDate) = YEAR(@cr90Date) AND ProspectID = am.ProspectID ) as 'Cr90',
(select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(@cr120Date) AND YEAR(OutstandingDate) = YEAR(@cr120Date) AND ProspectID = am.ProspectID ) as 'Cr120',
(select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(@cr150Date) AND YEAR(OutstandingDate) = YEAR(@cr150Date) AND ProspectID = am.ProspectID ) as 'Cr150',
(select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(@cr180Date) AND YEAR(OutstandingDate) = YEAR(@cr180Date) AND ProspectID = am.ProspectID) as 'Cr180'
from Member_Outstanding
inner join AllMembers as am on Member_Outstanding.ProspectID = am.ProspectID
inner join ChargeCode on Member_Outstanding.ChargeCode = ChargeCode.Code
where (@ChargeCode is null or Member_Outstanding.ChargeCode = @ChargeCode)
) as tbl
group by tbl.ProspectID, tbl.ChargeCode, tbl.ChargeCodeDescription
ORDER BY tbl.ProspectID ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllMember]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllMember]
    @ProspectID AS VARCHAR(100),
	@Outstanding AS VARCHAR(100),
	@MemberID AS VARCHAR(100),
	@Name AS VARCHAR(100),
	@MembershipType AS VARCHAR(100),
	@MembershipStatus AS VARCHAR(100),
	@EffectiveDate AS VARCHAR(100),
	@ExpiryDate AS VARCHAR(100),
	@NextSubBillDate AS VARCHAR(100),
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = 2000000;

select *, COUNT(*) OVER () as 'Count' from AllMembers as members 

where (ProspectID LIKE ISNULL(@ProspectID,'')+'%') AND 
(MemberID LIKE ISNULL(@MemberID,'')+'%') AND
(@Outstanding IS NULL OR OutstandingList is not null) AND
(Name LIKE '%'+ISNULL(@Name,'')+'%') AND
(MembershipType LIKE ISNULL(@MembershipType,'')+'%') AND
(@MembershipStatus is null or MembershipStatus = @MembershipStatus) AND
(@EffectiveDate IS NULL OR (CAST(EffectiveDate as DATE) = @EffectiveDate)) AND
(@ExpiryDate IS NULL OR (CAST(ExpiryDate as DATE) = @ExpiryDate)) AND 
(@NextSubBillDate IS NULL OR NextSubBillDate is not null)
ORDER BY [ProspectID] ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllTransaction]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetAllTransaction]
	@MemberID AS VARCHAR(100),
	@TransactionDate AS VARCHAR(100),
	@Module AS VARCHAR(100),
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = 2000000

select COUNT(*) OVER () as 'Count', trans.*, ChargeCode.Description as 'ChargeCodeDescription', AR_UploadFile.FileName, null as ArTransactionDetails, null as SubMemberLists  from (
	select t.*, am.MemberName, SubscriptionType.Description as 'SubscriptionTypeDescription',
		(select TOP 1 ChargeCode from AR_TransactionDetail where AR_TransactionDetail.TransactionId = t.TransactionId and SystemUse = 'Y' and Status is null  order by AR_TransactionDetail.TransactionDetailId desc) as 'ChargeCode',
		CASE 
			WHEN ((select count(isBankIn) from AR_TransactionDetail where AR_TransactionDetail.TransactionId = t.TransactionId and SystemUse = 'Y' and Status is null  and IsBankIn = 1 ) = (select count(isBankIn) from AR_TransactionDetail where AR_TransactionDetail.TransactionId = t.TransactionId and SystemUse = 'Y')) THEN CAST(1 AS tinyint)
			ELSE  CAST(0 AS tinyint) 
		END as 'IsBankIn',
		CASE 
			WHEN((select count(IsMonthEnd) from AR_TransactionDetail where AR_TransactionDetail.TransactionId = t.TransactionId and SystemUse = 'Y' and Status is null  and IsMonthEnd = 1 ) = (select count(IsMonthEnd) from AR_TransactionDetail where AR_TransactionDetail.TransactionId = t.TransactionId and SystemUse = 'Y')) THEN CAST(1 AS tinyint)
			ELSE CAST(0 AS tinyint)
		END as 'IsMonthEnd',
		CASE 
			WHEN((select count(IsPosted) from AR_TransactionDetail where AR_TransactionDetail.TransactionId = t.TransactionId and SystemUse = 'Y' and Status is null  and IsPosted = 1 ) = (select count(IsPosted) from AR_TransactionDetail where AR_TransactionDetail.TransactionId = t.TransactionId and SystemUse = 'Y')) THEN CAST(1 AS tinyint)
			ELSE CAST(0 AS tinyint)
		END as 'IsPosted'
	from (select * from AR_Transaction where (Module LIKE ISNULL(@Module,'')+'%') and SystemUse = 'Y') as t
	left join AllMembers as am on am.ProspectID = t.ProspectID
	left join SubscriptionType on am.SubscriptionType = SubscriptionType.Code
) as trans
left join ChargeCode on trans.ChargeCode = ChargeCode.Code
left join AR_UploadFile on trans.TransactionId = AR_UploadFile.TransactionId
where (@MemberID IS NULL OR MemberID LIKE CONCAT('%', @MemberID, '%'))  AND 
(@TransactionDate IS NULL OR (CAST(TransactionDate as DATE) = @TransactionDate)) 
ORDER BY TransactionId DESC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetAmortisationListing]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetAmortisationListing]
	@AmtMonth AS date,
	@DateFrom AS date,
    @DateTo AS date,
	@MembershipStatus AS VARCHAR(10),
	@ProspectID AS VARCHAR(255),
	@NoOfYear AS INT,
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON

IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM Amortisation);
WITH AmtList as (
select 
 t.*,
	CASE  
        WHEN NoOfTerminate = 1  THEN 0
        ELSE AllBalanceAmount
    END as BalanceAmount,
    CASE  
        WHEN NoOfTerminate = 1 and MembershipStatus = 'T'AND (
        select MembershipStatus from AmortisationMonths where (AmtMonth between EffectiveDate AND ExpiryDate)  AND AmtMonth = t.EffectiveStartDate and ProspectID = t.ProspectID AND MembershipStatus = 'T'
        ) = 'T'  THEN ( 
            select AllBalanceAmount from Amortisation where ProspectID = t.ProspectID and AmtMonth = t.EffectiveStartDate 
        )
        ELSE MonthyAmount
    END  as LastAmtAmount,
	CASE  
        WHEN NoOfTerminate = 1  and MembershipStatus = 'T'AND (
        select MembershipStatus from AmortisationMonths where (AmtMonth between EffectiveDate AND ExpiryDate)  AND AmtMonth = t.EffectiveStartDate and ProspectID = t.ProspectID AND MembershipStatus = 'T'
        ) = 'T'  THEN ( 
		   select DATEADD(month, 1, Amortisation.AmtMonth)  from Amortisation where ProspectID = t.ProspectID and AmtMonth = t.EffectiveStartDate 
        )
        ELSE AsAt
    END  as LastAmtDate,
    CASE  
        WHEN NoOfSubTwoTerminate = 0  THEN row_number() over (partition by NoOfSubTwoTerminate order by AmtMonth)
        ELSE 0
    END as 'NoOfMonth',
    CASE  
        WHEN NoOfTerminate = 1  THEN t.EntranceFee-t.SpendingCredit
        ELSE t.EntranceFee-t.SpendingCredit-t.AllBalanceAmount
    END as TotalAmt,
    CASE  
        WHEN NoOfReverse = 1 THEN AllBalanceAmount + MonthyAmount
        ELSE 0
    END as ReverseTotalAmt,
    CASE  
        WHEN NoOfTerminate = 1  THEN EntranceFee-SpendingCredit
        ELSE EntranceFee-SpendingCredit-AllBalanceAmount
    END as AmtInGL,
    1 as NoOfMonthAmt,
    0 as SNoFromAdvRenew,
    '' as UserID,
    '' as ProcessRemarks,
    '' as Remarks,
    '' as CheckListInd,
    '' as AR130_CreatedDate,
    '' as Type,
    10 as SNo,
    13.00 as CurrentMthSpendingCredit,
    13.00 as PastMthSpendingCredit,
    10.22 as LastMthSpendingCredit,
    10.22 as BalanceAddedBack,
    '' as FreeTerm,
    '' as FreeTermSNo,
    10 as EntendMth
    from (
    select *,
        CASE  
            WHEN MembershipStatus = 'T' AND AmtMonth != EffectiveStartDate  THEN 1
            WHEN MembershipStatus = 'B' AND AmtMonth != EffectiveStartDate  THEN 1
            ELSE 0
        END as NoOfTerminate,
		CASE  
            WHEN MembershipStatus = 'T'AND (AmtMonth between DATEADD(month, 2, EffectiveStartDate) and EffectiveEndDate) THEN 1
            WHEN MembershipStatus = 'B'AND (AmtMonth between DATEADD(month, 2, EffectiveStartDate) and EffectiveEndDate)  THEN 1
            ELSE 0
        END as  NoOfSubTwoTerminate,
		CASE  
            WHEN MembershipStatus = 'V' AND AmtMonth = EffectiveStartDate  THEN 1
            ELSE 0
        END as NoOfReverse
from Amortisation where (ProspectID LIKE ISNULL(@ProspectID,'')+'%') AND
(@AmtMonth IS NULL OR (CAST(AmtMonth as DATE) = @AmtMonth))
) as t
)

select ROW_NUMBER() OVER(ORDER BY AmtList.ProspectID,AmtList.AmtMonth ASC) AS 'RowCount',
	CASE  
        WHEN AmtList.NoOfMonth = 0  THEN 
		(
			select NoOfMonth from AmtList as a where 
            a.ProspectID = AmtList.ProspectID AND a.MembershipStatus = 'T' AND a.NoOfTerminate = 1 AND a.NoOfSubTwoTerminate = 0
            AND (a.AmtMonth between AmtList.EffectiveStartDate AND AmtList.EffectiveEndDate)
        )
        ELSE NoOfMonth
    END as 'NoOfMonthAccured',
* from AmtList WHERE (MembershipStatus LIKE ISNULL(@MembershipStatus,'')+'%')
order by convert(datetime, AmtMonth, 103) ASC
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetAmortisationProjection]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAmortisationProjection]

    @AmtMonth AS date,

    @DateFrom AS VARCHAR(255),

    @DateTo AS VARCHAR(255),

    @ProspectID AS VARCHAR(255),

    @RowsToSkip INT,

    @FetchRows INT

AS
BEGIN

SET NOCOUNT ON
SELECT ROW_NUMBER() OVER(ORDER BY AmortisationProjectionMonths.ProspectID) AS 'RowCount', * from AmortisationProjectionMonths
END
GO
/****** Object:  StoredProcedure [dbo].[GetAmortisationReconcilation]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetAmortisationReconcilation]
	@AmtMonth AS date,
	@DateFrom AS date,
    @DateTo AS date,
	@MembershipStatus AS VARCHAR(10),
	@ProspectID AS VARCHAR(255),
	@NoOfYear AS INT,
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON

IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM Amortisation);
WITH AmtList as (
select 
 t.*,
	AllBalanceAmount as BalanceAmount,
    CASE  
        WHEN NoOfTerminate = 1 and MembershipStatus = 'T'AND (
        select MembershipStatus from AmortisationMonths where (AmtMonth between EffectiveDate AND ExpiryDate)  AND AmtMonth = t.EffectiveStartDate and ProspectID = t.ProspectID AND MembershipStatus = 'T'
        ) = 'T'  THEN ( 
            select AllBalanceAmount from Amortisation where ProspectID = t.ProspectID and AmtMonth = t.EffectiveStartDate 
        )
        ELSE MonthyAmount
    END  as LastAmtAmount,
	CASE  
        WHEN NoOfTerminate = 1  and MembershipStatus = 'T'AND (
        select MembershipStatus from AmortisationMonths where (AmtMonth between EffectiveDate AND ExpiryDate)  AND AmtMonth = t.EffectiveStartDate and ProspectID = t.ProspectID AND MembershipStatus = 'T'
        ) = 'T'  THEN ( 
		   select DATEADD(month, 1, Amortisation.AmtMonth)  from Amortisation where ProspectID = t.ProspectID and AmtMonth = t.EffectiveStartDate 
        )
        ELSE AsAt
    END  as LastAmtDate,
    CASE  
        WHEN NoOfSubTwoTerminate = 0  THEN row_number() over (partition by NoOfSubTwoTerminate order by AmtMonth)
        ELSE 0
    END as 'NoOfMonth',
    CASE  
        WHEN NoOfTerminate = 1  THEN t.EntranceFee-t.SpendingCredit
        ELSE t.EntranceFee-t.SpendingCredit-t.AllBalanceAmount
    END as TotalAmt,
    CASE  
        WHEN NoOfReverse = 1 THEN AllBalanceAmount + MonthyAmount
        ELSE 0
    END as ReverseTotalAmt,
    CASE  
        WHEN NoOfTerminate = 1  THEN EntranceFee-SpendingCredit
        ELSE EntranceFee-SpendingCredit-AllBalanceAmount
    END as AmtInGL,
    1 as NoOfMonthAmt,
    0 as SNoFromAdvRenew,
    '' as UserID,
    '' as ProcessRemarks,
    '' as Remarks,
    '' as CheckListInd,
    '' as AR130_CreatedDate,
    '' as Type,
    10 as SNo,
    13.00 as CurrentMthSpendingCredit,
    13.00 as PastMthSpendingCredit,
    10.22 as LastMthSpendingCredit,
    10.22 as BalanceAddedBack,
    '' as FreeTerm,
    '' as FreeTermSNo,
    10 as EntendMth
    from (
    select *,
        CASE  
            WHEN MembershipStatus = 'T' AND AmtMonth != EffectiveStartDate  THEN 1
            WHEN MembershipStatus = 'B' AND AmtMonth != EffectiveStartDate  THEN 1
            ELSE 0
        END as NoOfTerminate,
		CASE  
            WHEN MembershipStatus = 'T'AND (AmtMonth between DATEADD(month, 2, EffectiveStartDate) and EffectiveEndDate) THEN 1
            WHEN MembershipStatus = 'B'AND (AmtMonth between DATEADD(month, 2, EffectiveStartDate) and EffectiveEndDate)  THEN 1
            ELSE 0
        END as  NoOfSubTwoTerminate,
		CASE  
            WHEN MembershipStatus = 'V' AND AmtMonth = EffectiveStartDate  THEN 1
            ELSE 0
        END as NoOfReverse
from Amortisation where (ProspectID LIKE ISNULL(@ProspectID,'')+'%') AND
(@AmtMonth IS NULL OR (CAST(AmtMonth as DATE) = @AmtMonth))
) as t
)

select ROW_NUMBER() OVER(ORDER BY AmtList.ProspectID,AmtList.AmtMonth ASC) AS 'RowCount',
	CASE  
        WHEN AmtList.NoOfMonth = 0  THEN 
		(
			select NoOfMonth from AmtList as a where 
            a.ProspectID = AmtList.ProspectID AND a.MembershipStatus = 'T' AND a.NoOfTerminate = 1 AND a.NoOfSubTwoTerminate = 0
            AND (a.AmtMonth between AmtList.EffectiveStartDate AND AmtList.EffectiveEndDate)
        )
        ELSE NoOfMonth
    END as 'NoOfMonthAccured',
* from AmtList WHERE (MembershipStatus LIKE ISNULL(@MembershipStatus,'')+'%')
order by convert(datetime, AmtMonth, 103) ASC
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetAmortisationSpendingCredit]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[GetAmortisationSpendingCredit]
	@AmtMonth AS date,
    @DateFrom AS VARCHAR(255),
	@DateTo AS VARCHAR(255),
	@ProspectID AS VARCHAR(255),
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON

IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM AR_TransactionDetail)

select am.MemberID, am.MembershipType, am.EffectiveDate, am.ExpiryDate, am.EntranceFee, tbl.*, tbl.CurrentMonthSpendingCredit as Amount, 'C' as 'Type' from (
	select 
		td.TransactionDate, td.ProspectID, sum(Amount) as 'CurrentMonthSpendingCredit'
	from AR_TransactionDetail as td
	left join AR_Transaction as t on td.TransactionId = t.TransactionId
	where t.type = 'CREDIT' 
	group by td.ProspectID, td.TransactionDate
) as tbl left join AllMembers as am on tbl.ProspectID = am.ProspectID
AND (@AmtMonth IS NULL OR (CAST(TransactionDate as DATE) = @AmtMonth))

order by ProspectID
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetBankInList]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetBankInList]
    @IsBankIn AS tinyint,
	@TransactionDateFrom AS date,
	@TransactionDateTo AS date,
    @RowsToSkip INT,
    @FetchRows INT
AS
BEGIN
SET NOCOUNT ON



IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM AR_TransactionDetail);



SELECT pcd.TransactionDetailId as 'Key', [payc].Description as 'ChargeType', pcd.BankCode, pcd.PaymentCode,[Reference],[ChequeDate], am.MemberID, [Amount], AdminLocation.LocationName as Location,COUNT(*) OVER () as 'Count'  from 
[AR_TransactionDetail] as pcd
INNER JOIN [dbo].[AR_Transaction] as pc ON pcd.TransactionId = pc.TransactionId
INNER JOIN [dbo].AllMembers as am ON pc.ProspectID = am.ProspectID
LEFT JOIN [dbo].AR_BankInDetail as bid ON pcd.Guid = bid.TransactionDetailGuid
LEFT JOIN AR_BankIn as bi ON bid.BankInId = bi.BankInId
LEFT JOIN PaymentCode as payc ON pcd.[PaymentCode] = payc.Code
left join AdminLocation on bi.Location = AdminLocation.ID
WHERE pc.Module = 'CSO'  
AND (@IsBankIn is null or pcd.IsBankIn = @IsBankIn)
AND (
    (@TransactionDateFrom IS NULL OR (CONVERT(char(10), pcd.TransactionDate,126) >= @TransactionDateFrom)) AND
	(@TransactionDateTo IS NULL OR (CONVERT(char(10), pcd.TransactionDate,126) <= @TransactionDateTo))
)
AND pcd.Status is null and pcd.SystemUse = 'Y'
ORDER BY [TransactionDetailId] ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetBankInReport]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[GetBankInReport]
    @IsBankIn AS tinyint,
    @RowsToSkip INT,
    @FetchRows INT
AS
BEGIN
SET NOCOUNT ON



IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM AR_TransactionDetail);



SELECT pcd.TransactionDetailId as 'Key', [payc].Description as 'ChargeType', pcd.BankCode, pcd.PaymentCode,[Reference],[ChequeDate], am.MemberID, [Amount], AdminLocation.LocationName as Location,COUNT(*) OVER () as 'Count'  from 
[AR_TransactionDetail] as pcd
INNER JOIN [dbo].[AR_Transaction] as pc ON pcd.TransactionId = pc.TransactionId
INNER JOIN [dbo].AllMembers as am ON pc.ProspectID = am.ProspectID
LEFT JOIN [dbo].AR_BankInDetail as bid ON pcd.Guid = bid.TransactionDetailGuid
LEFT JOIN AR_BankIn as bi ON bid.BankInId = bi.BankInId
LEFT JOIN PaymentCode as payc ON pcd.[PaymentCode] = payc.Code
left join AdminLocation on bi.Location = AdminLocation.ID
WHERE pc.Module = 'CSO'  
AND (@IsBankIn is null or pcd.IsBankIn = @IsBankIn)
and pcd.Status is null and pcd.SystemUse = 'Y'
ORDER BY [TransactionDetailId] ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetBeforeRefundList]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetBeforeRefundList]
	@MembershipStatus AS VARCHAR(100),
	@ProspectID AS VARCHAR(100),
	@RefundDateFrom AS VARCHAR(100),
	@RefundDateTo AS VARCHAR(100),
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = 2000000;

select mr.ProspectID, mr.RefundableID as 'RefundableID' , mr.RefundableAmount, mr.RefundedAmount, mr.RefundableDate, am.MemberID, am.MemberName,
ms.Description as 'Status', am.SecurityDeposit as Deposit, am.CreditLimit as Credit,
0 as 'Unposted', mo.OutstandingAmount, '' as ChargeCode, COUNT(*) OVER () as 'Count' 
from (select * from Member_Refundable where RefundableAmount > 0) as mr
inner join AllMembers as am on mr.ProspectID = am.ProspectID
inner join MembershipStatus as ms on am.MembershipStatus = ms.Code
left join (select ProspectID, (sum(OutstandingAmount) - sum(paidAmount)) as OutstandingAmount from [Member_Outstanding] group by ProspectID ) as mo on  mr.ProspectID = mo.ProspectID
where (@MembershipStatus IS NULL OR (am.MembershipStatus in (select value from string_split(@MembershipStatus, ',')))) AND
(@RefundDateFrom IS NULL OR (CAST( mr.RefundableDate as DATE) >= @RefundDateFrom)) AND
(@RefundDateTo IS NULL OR (CAST( mr.RefundableDate as DATE) <= @RefundDateTo)) AND
(mr.RefundableAmount != mr.RefundedAmount OR  mr.RefundedAmount IS NULL)  AND
(@ProspectID IS NULL OR (cast(am.ProspectID as varchar(255)) = @ProspectID))
ORDER BY mr.RefundableID ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetCancelPaymentReport]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetCancelPaymentReport]
    @ProcessDateFrom AS date,
	@ProcessDateTo AS date,
	@TransactionDateFrom AS date,
	@TransactionDateTo AS date,
	@PaymentCode AS VARCHAR(255),
	@UserID AS VARCHAR(50),
	@MembershipType AS VARCHAR(255),
	@MembershipStatus AS VARCHAR(100),
	@month AS VARCHAR(50),
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM [AR_TransactionDetail] WHERE SystemUse = 'Y');

SELECT COUNT(*) OVER () as 'Count', td.InvoiceNo as 'TrxNo', am.MemberID, am.MemberName, td.Reference, pcc.Description, 
rr.Description as ReasonCode, td.ChequeDate,td.Amount, td.CreatedBy as UserID,
am.MembershipType, am.MembershipStatus, td.UpdatedAt, t.TransactionDate as 'PaymentDate', pcode.Description as PaymentCodeDescription,td.PaymentCode, MONTH(t.TransactionDate) as month
from AR_TransactionDetail as td
INNER JOIN AR_Transaction as t on td.TransactionId = t.TransactionId
INNER JOIN AR_TransactionCancel as pcc on td.Guid = pcc.TransactionDetailGuid
INNER JOIN RejectionReason as rr on pcc.ReasonCode = rr.Code
LEFT JOIN AllMembers as am on t.ProspectID = am.ProspectID
LEFT JOIN PaymentCode as pcode on td.PaymentCode = pcode.Code
where td.SystemUse = 'Y' 
-- AND td.Status = 'CANCEL' 
AND (td.CreatedBy LIKE ISNULL(@UserID,'')+'%') AND
(MONTH(t.TransactionDate) LIKE ISNULL(@month,'')+'%') AND
(
    (@TransactionDateFrom IS NULL OR (CONVERT(char(10), t.TransactionDate,126) >= @TransactionDateFrom)) AND
	(@TransactionDateTo IS NULL OR (CONVERT(char(10), t.TransactionDate,126) <= @TransactionDateTo))
) AND
(
	(@ProcessDateFrom IS NULL OR (CONVERT(char(10), pcc.CancelDate,126) >= @ProcessDateFrom )) AND 
	(@ProcessDateTo IS NULL OR (CONVERT(char(10), pcc.CancelDate ,126) <= @ProcessDateTo))
) AND
(@PaymentCode IS NULL OR (@PaymentCode like '%;'+cast(PaymentCode as varchar(20))+';%')) AND
(@MembershipType IS NULL OR (@MembershipType like '%;'+cast(MembershipType as varchar(20))+';%'))
ORDER BY TransactionDetailId ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetCarLabel]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
       
 --exec [GetCarLabel]      
      
 CREATE PROCEDURE [dbo].[GetCarLabel]       
 AS      
   BEGIN        
      
     BEGIN TRY       
  SELECT                                             
                    ISNULL(CL.CarLabelIU, '') AS CarIU,     
                    ISNULL(CONVERT(VARCHAR, CL.CarLabelDate, 103), '') AS DateExpiry,    
                    ISNULL(CL.CarLabel, '') AS CarLabel    
    
        FROM        Member_CarLabel AS CL    
    
        WHERE       CL.Status = 'A' 
  --AND   COALESCE(CL.CarLabelIU, ISNULL(CONVERT(VARCHAR, CL.CarLabelDate, 103), NULL),CL.CarLabel) IS NOT NULL  
        ORDER BY    CL.CarLabelIU    
      
     END TRY      
      
     BEGIN CATCH      
          SELECT        
      ERROR_NUMBER() AS ErrorNumber ,      
      ERROR_SEVERITY() AS ErrorSeverity ,      
      ERROR_STATE() AS ErrorState  ,      
      ERROR_PROCEDURE() AS ErrorProcedure ,      
      ERROR_LINE() AS ErrorLine  ,      
      ERROR_MESSAGE() AS ErrorMessage;        
     END CATCH        
  END
GO
/****** Object:  StoredProcedure [dbo].[GetCategoryGroupBy]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCategoryGroupBy]
AS
BEGIN
   
    SET NOCOUNT ON
	create table #tempA(id varchar(15)) 
insert into #tempA select distinct Member_Relation.PrincipleProspectID from Member_Relation
 SELECT MembershipCategory.Code, COUNT(Member.ProspectId) as MemberCount from MembershipCategory
left join Member on MembershipCategory.Code = Member.MembershipCategory
	right join #tempA on Member.ProspectID = #tempA.id
	group by MembershipCategory.Code,Member.MembershipCategory
drop table #tempA
END
GO
/****** Object:  StoredProcedure [dbo].[GetDebitSubscriptionDue]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDebitSubscriptionDue]
    @RowsToSkip INT,
    @FetchRows INT
AS
BEGIN
SET NOCOUNT ON

IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM AR_TransactionDetail);
DECLARE @LastMonth date;
DECLARE @AdvanceMemberNo int;
DECLARE @AdvanceSubscriptionNo int;
DECLARE @AbsentMemberNo int;
DECLARE @NomineeNo int;


SET @LastMonth = DATEADD(month, -1, GETDATE())
SET @AdvanceMemberNo = (select count(*) from Member_Outstanding)
SET @AdvanceSubscriptionNo = (select count(*) from Member_Outstanding left join AllMembers on Member_Outstanding.ProspectID = AllMembers.ProspectID where SubscriptionType != null)
SET @AbsentMemberNo = (select count(*) from Member_Outstanding left join AllMembers on Member_Outstanding.ProspectID = AllMembers.ProspectID where MembershipStatus = 'B')
SET @NomineeNo = (select count(*) from Member_Outstanding left join AllMembers on Member_Outstanding.ProspectID = AllMembers.ProspectID where SubscriptionType != null)

SELECT @AdvanceMemberNo as 'AdvanceMemberNo', @AdvanceSubscriptionNo as 'AdvanceSubscriptionNo', @AbsentMemberNo as 'AbsentMemberNo', @NomineeNo as 'NomineeNo'
END
GO
/****** Object:  StoredProcedure [dbo].[GetDebtorReconcilationReport]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDebtorReconcilationReport]
    @TransactionDateFrom AS date,
	@TransactionDateTo AS date,
	@FinancialMonth as date,
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM AR_TransactionDetail);

select 
COUNT(*) OVER () as 'Count',
t.Module,
t.TransactionDate,
td.TransactionDetailId,
td.Guid as 'TransactionDetailGuid',
ga.AccountCode,
ga.AccountName,
td.ChargeCode,
cc.Description as 'ChargeCodeDescription',
'Description' as Description,
td.TaxableAmount as 'TaxableAmount',
case when t.Type = 'CREDIT' then td.Amount end as 'Credit',
case when t.Type = 'DEBIT' then td.Amount end as 'Debit',
case when t.Type = 'CREDIT' then td.TaxableAmount end as 'BeforeGST',
case when t.Type = 'DEBIT' then td.TaxableAmount end as 'BeforeGSTDebit',
case when t.Type = 'CREDIT' then td.GSTAmount end as 'GST',
case when t.Type = 'DEBIT' then td.GSTAmount end as 'GSTDebit',
case when t.Type = 'CREDIT' then td.RndAdjustment end as 'Rnd',
case when t.Type = 'DEBIT' then td.RndAdjustment end as 'RndDebit'
from (select * from AR_TransactionDetail where SystemUse = 'Y' and Status is null) as td
inner join (select * from AR_Transaction where SystemUse = 'Y') as t on td.TransactionId = t.TransactionId
inner join ChargeCode as cc on td.ChargeCode = cc.Code
left join GLAccount as ga on cc.GLAccount = ga.AccountCode
where (@TransactionDateFrom IS NULL OR (CONVERT(char(10), t.TransactionDate,126) >= @TransactionDateFrom and CONVERT(char(10), t.TransactionDate,126) <= @TransactionDateTo))
ORDER BY td.TransactionDetailId ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetDifferenceReconciliationData]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GetDifferenceReconciliationData]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

   select MembershipCategory.code as Category, member.memberid as MemberId, member.monthlysubfee as BilledAmount
from MembershipCategory
left join Member on Member.MembershipCategory  = MembershipCategory.Code
left join Member_Relation on Member.ProspectID = Member_Relation.PrincipleProspectID

where  member.memberid not in (

select member.memberid 
 from Member
 join Member_Outstanding on Member.ProspectID = Member_Outstanding.ProspectID and Member_Outstanding.PaymentStatus = 'Active'
 join Member_Relation on Member.ProspectID = Member_Relation.PrincipleProspectID
)
END
GO
/****** Object:  StoredProcedure [dbo].[GetExceptionReportReconciliation]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GetExceptionReportReconciliation]

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
   select *, (SCount - MCount) as Count from (select MembershipCategory.Code as SCode, COUNT(Member.ProspectID) as SCount, Member.MonthlySubFee from MembershipCategory
left join Member on MembershipCategory.Code = Member.MembershipCategory
left join (select * from AllMembers
where SubMemberList is not null) as pricipals on Member.ProspectID = pricipals.ProspectID
group by MembershipCategory.Code, Member.MonthlySubFee) as subBilling 
left join (select MembershipCategory.Code as MCode, COUNT(Member_Outstanding.ProspectID) as MCount, Member_Outstanding.OutstandingAmount from MembershipCategory
left join Member on MembershipCategory.Code = Member.MembershipCategory
left join Member_Outstanding on Member.ProspectID = Member_Outstanding.ProspectID
left join (select * from AllMembers
where SubMemberList is not null) as pricipals on Member.ProspectID = pricipals.ProspectID
group by MembershipCategory.Code, Member_Outstanding.OutstandingAmount) as MembershipBilling
on subBilling.SCode = MembershipBilling.MCode
END
GO
/****** Object:  StoredProcedure [dbo].[GetGLPostingList]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[GetGLPostingList]
    @TransactionDateFrom AS date,
	@TransactionDateTo AS date,
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM AR_TransactionDetail WHERE SystemUse = 'Y');

select 
COUNT(*) OVER () as 'Count',
t.Module,
t.TransactionDate,
td.TransactionDetailId,
td.Guid as 'TransactionDetailGuid',
ga.AccountCode,
ga.AccountName,
td.ChargeCode,
cc.Description as 'ChargeCodeDescription',
'Description' as Description,
td.TaxableAmount,
case when t.Type = 'CREDIT' then td.Amount end as 'Credit',
case when t.Type = 'DEBIT' then td.Amount end as 'Debit',
case when t.Type = 'CREDIT' then td.TaxableAmount end as 'BeforeGST',
case when t.Type = 'DEBIT' then td.TaxableAmount end as 'BeforeGSTDebit',
case when t.Type = 'CREDIT' then td.GSTAmount end as 'GST',
case when t.Type = 'DEBIT' then td.GSTAmount end as 'GSTDebit',
case when t.Type = 'CREDIT' then td.RndAdjustment end as 'Rnd',
case when t.Type = 'DEBIT' then td.RndAdjustment end as 'RndDebit'
from (select * from AR_TransactionDetail where SystemUse = 'Y' and Status is null and IsPosted=0) as td
inner join (select * from AR_Transaction where SystemUse = 'Y') as t on td.TransactionId = t.TransactionId
inner join ChargeCode as cc on td.ChargeCode = cc.Code
left join GLAccount as ga on cc.GLAccount = ga.AccountCode
where (@TransactionDateFrom IS NULL OR (CONVERT(char(10), t.TransactionDate,126) >= @TransactionDateFrom and CONVERT(char(10), t.TransactionDate,126) <= @TransactionDateTo))
ORDER BY td.TransactionDetailId ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetGSTPercent]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetGSTPercent]
    @CurrentDate AS date
AS
BEGIN

IF ( @CurrentDate IS NULL ) SET @CurrentDate = CAST( GETDATE() AS Date );
     

select GSTPercent,GSTName
from AR_GSTPercent as a
WHERE @CurrentDate BETWEEN DateFrom AND DateTo

END

GO
/****** Object:  StoredProcedure [dbo].[GetMemberCarLabel]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
       
 --exec [GetMemberCarLabel]      
      
 CREATE PROCEDURE [dbo].[GetMemberCarLabel]       
 AS      
   BEGIN        
      
     BEGIN TRY 

	 BEGIN /** drop temp table**/  
  IF OBJECT_ID(N'tempdb..##tmpCarLabel_Pivot') IS NOT NULL      
  BEGIN      
   DROP TABLE ##tmpCarLabel_Pivot      
  END      
      
  IF OBJECT_ID(N'tempdb..##tmpCarLabel') IS NOT NULL      
  BEGIN      
   DROP TABLE ##tmpCarLabel      
  END      
      
  IF OBJECT_ID(N'tempdb..##tmpCarLabelIU_Pivot') IS NOT NULL      
  BEGIN      
   DROP TABLE ##tmpCarLabelIU_Pivot      
  END      
      
  IF OBJECT_ID(N'tempdb..##tmpCarLabelIU') IS NOT NULL      
  BEGIN      
   DROP TABLE ##tmpCarLabelIU  
   
     IF OBJECT_ID(N'tempdb..##tmp') IS NOT NULL        
  BEGIN        
   DROP TABLE ##tmp        
  END  
  END   
   END /** drop temp table**/  
               
  BEGIN /** tmpCarLabel **/       
     DECLARE @DynamicQueryCarLabel AS NVARCHAR(MAX)      
     DECLARE @ColumnCarLabel AS NVARCHAR(MAX)      
      
     SELECT * INTO ##tmpCarLabel_Pivot      
     FROM       
     (SELECT ProspectID, CarLabel, 'CarLabel' + CAST(ROW_NUMBER() OVER (PARTITION BY ProspectID ORDER BY ProspectID) AS VARCHAR(45)) AS ColumnSequenceCarLabel FROM Member_CarLabel WHERE Status = 'A' ) MemberCarLabel      
      
     SELECT @ColumnCarLabel= COALESCE(@ColumnCarLabel+ ', ','') + QUOTENAME(ColumnSequenceCarLabel)      
     FROM       
     (      
     SELECT ColumnSequenceCarLabel from ##tmpCarLabel_Pivot      
     WHERE ProspectID =       
     (SELECT TOP 1 ProspectID FROM ##tmpCarLabel_Pivot       
     GROUP BY ProspectID      
     ORDER BY COUNT(ColumnSequenceCarLabel) DESC)      
     ) tableCarLabel_Pivot      
      
     SET @DynamicQueryCarLabel =       
   N'SELECT ProspectID, ' +@ColumnCarLabel+ ' INTO ##tmpCarLabel FROM ' +      
   '(SELECT ProspectID, ' +@ColumnCarLabel+ 'FROM ##tmpCarLabel_Pivot      
   PIVOT      
   (      
    MAX(CarLabel)      
    FOR ColumnSequenceCarLabel IN (' +@ColumnCarLabel+ ')      
   ) PIV) tableCarLabel'      
      
     EXEC(@DynamicQueryCarLabel);      
     --SELECT * FROM ##tmpCarLabel;      
  END /** tmpCarLabel **/      
      
  BEGIN /** tmpCarLabelIU **/      
     DECLARE @DynamicQueryCarLabelIU AS NVARCHAR(MAX) 	 
     DECLARE @ColumnCarLabelIU AS NVARCHAR(MAX)      
      
     SELECT * INTO ##tmpCarLabelIU_Pivot      
     FROM       
     (SELECT ProspectID, CarLabelIU, 'CarLabelIU' + CAST(ROW_NUMBER() OVER (PARTITION BY ProspectID ORDER BY ProspectID) AS VARCHAR(45)) AS ColumnSequenceCarLabelIU FROM Member_CarLabel WHERE Status = 'A' ) MemberCarLabelIU      
      
     SELECT @ColumnCarLabelIU= COALESCE(@ColumnCarLabelIU+ ', ','') + QUOTENAME(ColumnSequenceCarLabelIU)      
     FROM       
     (      
     SELECT ColumnSequenceCarLabelIU from ##tmpCarLabelIU_Pivot      
     WHERE ProspectID =       
     (SELECT TOP 1 ProspectID FROM ##tmpCarLabelIU_Pivot       
     GROUP BY ProspectID      
     ORDER BY COUNT(ColumnSequenceCarLabelIU) DESC)      
     ) tableCarLabelIU_Pivot      
      
     SET @DynamicQueryCarLabelIU=       
     N'SELECT ProspectID, ' +@ColumnCarLabelIU+ ' INTO ##tmpCarLabelIU FROM ' +      
     '(SELECT ProspectID, ' +@ColumnCarLabelIU+ 'FROM ##tmpCarLabelIU_Pivot      
     PIVOT      
     (      
   MAX(CarLabelIU)      
   FOR ColumnSequenceCarLabelIU IN (' +@ColumnCarLabelIU+ ')      
     ) PIV) tableCarLabelIU'      
      
     EXEC(@DynamicQueryCarLabelIU);      
     --SELECT * FROM ##tmpCarLabelIU      
  END /** tmpCarLabelIU **/      
   
  BEGIN /** join two carlabel temp table **/ 
  DECLARE @DynamicQueryCarLabelIUJoin AS NVARCHAR(MAX); 
  SET @ColumnCarLabelIU = REPLACE(@ColumnCarLabelIU,'[', ' CLIUR.[');  
  SET @DynamicQueryCarLabelIUJoin =   
    N'SELECT * INTO ##tmp ' +  
    'FROM ' +  
    '(SELECT CLR.*, ' +@ColumnCarLabelIU +   
    'FROM  ##tmpCarLabel AS CLR   
    INNER JOIN ##tmpCarLabelIU AS CLIUR   
    ON   CLIUR.ProspectID = CLR.ProspectID) tmpclr ';  
  
  EXEC(@DynamicQueryCarLabelIUJoin);    
  --SELECT * FROM ##tmp;  
 END /** join two carlabel temp table **/ 

  BEGIN /*Member Info*/      
   SELECT       
       CASE WHEN MR.ProspectID IS NULL THEN M.MemberID ELSE MM.MemberID END AS MemberID,       
       M.MemberID AS NomineeID,            
       CLR.*,          
       CASE WHEN M.PersonID IS NULL THEN ISNULL(C.CompanyName, '') ELSE ISNULL(P.Name, '') END AS Name,         
       CASE WHEN M.PersonID IS NULL THEN '' ELSE ISNULL(T.Description, '') END AS Title,         
       CASE WHEN M.PersonID IS NULL THEN '' ELSE ISNULL(P.SurName, '') END AS SurName,        
       --'' AS Salutation,      
       ISNULL(P.Gender, '') AS Sex,      
       ISNULL(MC.Code + ' - ', '') + ISNULL(MC.Description, '') AS Category,      
       CASE WHEN MR.ProspectID IS NULL THEN 'Member' ELSE 'Nominee' END AS CarParkCategoryDesc,      
       ISNULL(MS.Code + ' - ', '') + ISNULL(MS.Description, '') AS Status      
      
   FROM   Member AS M      
    
   LEFT OUTER JOIN Member_Person P           
   ON    P.PersonID = M.PersonID      
    
   LEFT OUTER JOIN Member_Relation MR           
   ON    MR.ProspectID = M.ProspectID      
       
   LEFT OUTER JOIN Member AS MM           
   ON    MM.ProspectID = MR.PrincipleProspectID     
    
   LEFT OUTER JOIN Member_Company C           
   ON    C.CompanyID = M.CompanyID     
    
   LEFT OUTER JOIN MembershipCategory MC           
   ON    MC.Code = M.MembershipCategory           
          
   LEFT OUTER JOIN MembershipType MT           
   ON    MT.Code = M.MembershipType          
          
   LEFT OUTER JOIN MembershipStatus MS           
   ON    MS.Code = M.MembershipStatus  
     
   LEFT OUTER JOIN Title T          
   ON    T.Code = P.Title  
    
   LEFT OUTER JOIN ##tmp AS CLR  
   ON    CLR.ProspectID = M.ProspectID
      
   WHERE   M.MembershipStatus IS NOT NULL          
   AND    M.MemberID IS NOT NULL      
      AND    M.MembershipStatus = 'V'    
      --AND    M.MemberID = 'JE10037'     
       
   ORDER BY  M.MemberID      
  END /*Member Info*/      
      
 END TRY      
      
    BEGIN CATCH      
  SELECT        
   ERROR_NUMBER() AS ErrorNumber ,      
   ERROR_SEVERITY() AS ErrorSeverity ,      
   ERROR_STATE() AS ErrorState  ,      
   ERROR_PROCEDURE() AS ErrorProcedure ,      
   ERROR_LINE() AS ErrorLine  ,      
   ERROR_MESSAGE() AS ErrorMessage;        
 END CATCH       
  END
GO
/****** Object:  StoredProcedure [dbo].[GetMemberDetailsByStatus]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
     
  --exec GetMemberDetailsByStatus  't'
  
 CREATE PROCEDURE [dbo].[GetMemberDetailsByStatus]           
  @MembershipStatus AS VARCHAR(50)          
 AS          
   BEGIN            
          
     BEGIN TRY                    
            
  SELECT           
  --M.MembershipStatus,          
  --M.ProspectID,M.MemberID,MR.ProspectID,MR.PrincipleProspectID,MM.ProspectID,MM.MemberID,          
  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.CompanyName, '') ELSE ISNULL(T.Description, '') + ' '+ ISNULL(P.SurName, '') + ' ' + ISNULL(P.Name, '') END AS Name,          
  CASE WHEN MR.ProspectID IS NULL THEN M.MemberID ELSE MM.MemberID END AS MemberID,           
  M.MemberID AS NomineeID,          
  ISNULL(NRIC, '') AS NRIC,          
  P.DateOfBirth,          
  ISNULL(P.Gender, '') AS Gender,          
  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.Address, '') ELSE ISNULL(P.HomeAddress, '') END AS Address,          
  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.PostalCode, '') ELSE ISNULL(P.HomePostalCode, '') END AS PostalCode,          
  CASE WHEN M.PersonID IS NULL THEN '' ELSE ISNULL(P.OfficeAddress, '') END AS OfficeAddress,          
  CASE WHEN M.PersonID IS NULL THEN '' ELSE ISNULL(P.OfficePostalCode, '') END AS OfficePostalCode,          
  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.PhoneNo, '')  ELSE ISNULL(P.PhoneNo, '') END AS PhoneNo,          
  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.MobileNo, '') ELSE ISNULL(P.MobileNo, '') END AS MobileNo,          
  '' AS OfficeNo, --need to check          
  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.Email, '') ELSE ISNULL(P.Email, '') END AS Email,          
  M.JoinedDate,          
  ISNULL(MC.Code + ' - ', '') + ISNULL(MC.Description, '') AS MembershipCategory,          
  ISNULL(MS.Code + ' - ', '') + ISNULL(MS.Description, '') AS MembershipStatus,          
  ISNULL(MR.Relationship, '') AS Relationship,          
  M.ExpiryDate,
  ISNULL(A.FileVirtualPath, '') AS FileVirtualPath
          
  FROM   Member M          
          
  LEFT OUTER JOIN Member_Person P           
  ON P.PersonID = M.PersonID          
          
  LEFT OUTER JOIN Member_Relation MR           
  ON    MR.ProspectID = M.ProspectID          
          
  LEFT OUTER JOIN Member AS MM           
  ON    MM.ProspectID = MR.PrincipleProspectID          
          
  LEFT OUTER JOIN Member_Company C           
  ON    C.CompanyID = M.CompanyID          
          
  LEFT OUTER JOIN MembershipCategory MC           
  ON    MC.Code = M.MembershipCategory           
          
  LEFT OUTER JOIN MembershipType MT           
  ON    MT.Code = M.MembershipType          
          
  LEFT OUTER JOIN MembershipStatus MS           
  ON    MS.Code = M.MembershipStatus         
    
  LEFT OUTER JOIN Title T           
  ON    T.Code = P.Title 
  
  LEFT OUTER JOIN Member_Attachment A          
  ON    A.ProspectID = M.ProspectID 
  AND	A.AttachedType = 'Photo'
          
  WHERE   M.MembershipStatus IS NOT NULL          
  AND    M.MemberID IS NOT NULL          
  AND    ((TRIM(@MembershipStatus) = 'All') OR (M.MembershipStatus IN (SELECT TRIM(value) FROM STRING_SPLIT(@MembershipStatus, ','))))          
            
  --ORDER BY  CASE WHEN MR.ProspectID IS NULL THEN M.MemberID ELSE MM.MemberID END      
  ORDER BY  M.MemberID      
          
     END TRY          
          
     BEGIN CATCH          
          SELECT            
            ERROR_NUMBER() AS ErrorNumber ,          
   ERROR_SEVERITY() AS ErrorSeverity ,          
   ERROR_STATE() AS ErrorState  ,          
   ERROR_PROCEDURE() AS ErrorProcedure ,          
   ERROR_LINE() AS ErrorLine  ,          
   ERROR_MESSAGE() AS ErrorMessage;            
     END CATCH            
  END
GO
/****** Object:  StoredProcedure [dbo].[GetMemberList]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
  --exec [GetMemberList]
  
 CREATE PROCEDURE [dbo].[GetMemberList]                  
 AS          
   BEGIN            
          
     BEGIN TRY                    
            
		  SELECT     
		  --top 5      
		  --M.MembershipStatus,          
		  --M.ProspectID,M.MemberID,MR.ProspectID,MR.PrincipleProspectID,MM.ProspectID,MM.MemberID,          
		  ISNULL(T.Description, '') AS Title,
		  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.CompanyName, '') ELSE ISNULL(P.SurName, '') + ' ' + ISNULL(P.Name, '') END AS Name,          
		  CASE WHEN MR.ProspectID IS NULL THEN M.MemberID ELSE MM.MemberID END AS MemberID,           
		  M.MemberID AS NomineeID,          
		  ISNULL(NRIC, '') AS NRIC,          
		  P.DateOfBirth,          
		  ISNULL(P.Gender, '') AS Gender,          
		  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.Address, '') ELSE ISNULL(P.HomeAddress, '') END AS ResidentAddress,          
		  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.PostalCode, '') ELSE ISNULL(P.HomePostalCode, '') END AS ResidentPostalCode,          
		  CASE WHEN M.PersonID IS NULL THEN '' ELSE ISNULL(P.OfficeAddress, '') END AS BusinessAddress,          
		  CASE WHEN M.PersonID IS NULL THEN '' ELSE ISNULL(P.OfficePostalCode, '') END AS BusinessPostalCode, 
		  '' AS City, --need to check    
		  '' AS Country, --need to check                
		  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.MobileNo, '') ELSE ISNULL(P.MobileNo, '') END AS HpNo,
		  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.PhoneNo, '')  ELSE ISNULL(P.PhoneNo, '') END AS HpNo,
		  '' AS OfficeNo, --need to check          
		  CASE WHEN M.PersonID IS NULL THEN ISNULL(C.Email, '') ELSE ISNULL(P.Email, '') END AS Email,          
		  M.JoinedDate,          
		  ISNULL(MC.Code + ' - ', '') + ISNULL(MC.Description, '') AS Category,          
		  ISNULL(MS.Code + ' - ', '') + ISNULL(MS.Description, '') AS Status,          
		  ISNULL(MR.Relationship, '') AS Relation,          
		  M.ExpiryDate AS DateExpiry
          
		  FROM   Member M          
          
		  LEFT OUTER JOIN Member_Person P           
		  ON P.PersonID = M.PersonID          
          
		  LEFT OUTER JOIN Member_Relation MR           
		  ON    MR.ProspectID = M.ProspectID          
          
		  LEFT OUTER JOIN Member AS MM           
		  ON    MM.ProspectID = MR.PrincipleProspectID          
          
		  LEFT OUTER JOIN Member_Company C           
		  ON    C.CompanyID = M.CompanyID          
          
		  LEFT OUTER JOIN MembershipCategory MC           
		  ON    MC.Code = M.MembershipCategory           
          
		  LEFT OUTER JOIN MembershipType MT           
		  ON    MT.Code = M.MembershipType          
          
		  LEFT OUTER JOIN MembershipStatus MS           
		  ON    MS.Code = M.MembershipStatus         
    
		  LEFT OUTER JOIN Title T           
		  ON    T.Code = P.Title 
          
		  WHERE   M.MembershipStatus IS NOT NULL          
		  AND    M.MemberID IS NOT NULL          
                
		  ORDER BY  M.MemberID      
          
     END TRY          
          
     BEGIN CATCH          
          SELECT            
			   ERROR_NUMBER() AS ErrorNumber ,          
			   ERROR_SEVERITY() AS ErrorSeverity ,          
			   ERROR_STATE() AS ErrorState  ,          
			   ERROR_PROCEDURE() AS ErrorProcedure ,          
			   ERROR_LINE() AS ErrorLine  ,          
			   ERROR_MESSAGE() AS ErrorMessage;            
     END CATCH            
  END
GO
/****** Object:  StoredProcedure [dbo].[GetMemberRefundReport]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMemberRefundReport]
    @ProcessDateFrom AS date,
	@ProcessDateTo AS date,
	@RefundDateFrom AS date,
	@RefundDateTo AS date,
	@PaymentCode AS VARCHAR(255),
	@UserID AS VARCHAR(50),
	@BatchID AS VARCHAR(50),
	@MembershipType AS VARCHAR(255),
	@MembershipStatus AS VARCHAR(100),
	@month AS VARCHAR(50),
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = 2000000
SELECT COUNT(*) OVER () as 'Count', rd.RefundDetailID as 'TrxNo', am.MemberID, am.MemberName, r.Description, r.Reference, r.RefundDate as 'ChequeDate', '123' as BankCode, rd.RefundAmount, rd.CreatedBy as 'UserID', r.RefundDate, r.UpdatedAt, r.PaymentCode, r.BatchID, am.MembershipType, am.MembershipStatus, MONTH(r.refundDate) as month
FROM [AR_RefundDetail] as rd
INNER JOIN AR_Refund as r on rd.RefundID = r.RefundID
INNER JOIN AllMembers as am on rd.ProspectID = am.ProspectID
WHERE rd.SystemUse = 'Y' AND
(@PaymentCode IS NULL OR (@PaymentCode like '%;'+cast(PaymentCode as varchar(255))+';%')) AND
(@MembershipType IS NULL OR (@MembershipType like '%;'+cast(MembershipType as varchar(255))+';%')) AND
(BatchID LIKE ISNULL(@BatchID,'')+'%') AND
(r.CreatedBy LIKE ISNULL(@UserID,'')+'%') AND
(MONTH(RefundDate) LIKE ISNULL(@month,'')+'%') AND
(
	(@RefundDateFrom IS NULL OR (CONVERT(char(10), r.RefundDate,126) >= @RefundDateFrom) AND
	(@RefundDateTo IS NULL OR CONVERT(char(10), r.RefundDate,126) <= @RefundDateTo))
) AND
(
	(@ProcessDateFrom IS NULL OR (CONVERT(char(10), r.UpdatedAt,126) >= @ProcessDateFrom) AND 
	(@ProcessDateTo IS NULL OR CONVERT(char(10), r.UpdatedAt,126) <= @ProcessDateTo))
)
ORDER BY RefundDetailID ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetMembershipDataBase]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GetMembershipDataBase]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

  select MembershipCategory.code,count(Member.MembershipCategory) as count ,sum(member.MonthlySubFee)as billing ,(count(Member.MembershipCategory) * sum(member.MonthlySubFee)) as total from MembershipCategory
left join Member on Member.MembershipCategory  = MembershipCategory.Code
left join Member_Outstanding on Member.ProspectID = Member_Outstanding.ProspectID 
left join Member_Relation on Member.ProspectID = Member_Relation.PrincipleProspectID
where Member_Outstanding.PaymentStatus != 'Paid'
group by MembershipCategory.Code
END
GO
/****** Object:  StoredProcedure [dbo].[GetNomDifferenceReconciliationData]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GetNomDifferenceReconciliationData]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    select MembershipCategory.code as Category, member.memberid as MemberId, member.monthlysubfee as BilledAmount
from MembershipCategory
left join Member on Member.MembershipCategory  = MembershipCategory.Code
left join Member_Relation on Member.ProspectID = Member_Relation.ProspectID

where  member.memberid not in (

select member.memberid 
 from Member
 join Member_Outstanding on Member.ProspectID = Member_Outstanding.ProspectID and Member_Outstanding.PaymentStatus != 'Active'
 join Member_Relation on Member.ProspectID = Member_Relation.ProspectID
 )
END
GO
/****** Object:  StoredProcedure [dbo].[GetNomMembershipDataBase]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GetNomMembershipDataBase]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    select MembershipCategory.code,count(Member.ProspectID) as count ,sum(member.MonthlySubFee)as billing ,(count(Member.MembershipCategory) * sum(member.MonthlySubFee)) as total from MembershipCategory
left join Member on Member.MembershipCategory  = MembershipCategory.Code
left join Member_Outstanding on Member.ProspectID = Member_Outstanding.ProspectID and Member_Outstanding.PaymentStatus != 'Paid'
left join Member_Relation on Member.ProspectID = Member_Relation.ProspectID
where Member_Outstanding.PaymentStatus != 'Paid'
group by MembershipCategory.Code
END
GO
/****** Object:  StoredProcedure [dbo].[GetNomSubFeeBillData]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GetNomSubFeeBillData]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

   
     select MembershipCategory.code,count(Member.MembershipCategory) as count ,sum(member.MonthlySubFee)as billing ,(count(Member.MembershipCategory) * sum(member.MonthlySubFee)) as total from MembershipCategory
left join Member on Member.MembershipCategory  = MembershipCategory.Code
left join Member_Relation on Member.ProspectID = Member_Relation.ProspectID
group by MembershipCategory.Code
END
GO
/****** Object:  StoredProcedure [dbo].[GetPrincipleReconcilation]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetPrincipleReconcilation]
AS
BEGIN     

select * from (select MembershipCategory.Code as SCode, Member.MemberID, Member.MonthlySubFee from MembershipCategory
left join Member on MembershipCategory.Code = Member.MembershipCategory
left join (select * from AllMembers
where SubMemberList is not null) as pricipals on Member.ProspectID = pricipals.ProspectID
) as subBilling 
left join (select MembershipCategory.Code as MCode, Member.MemberID, Member_Outstanding.OutstandingAmount from MembershipCategory
left join Member on MembershipCategory.Code = Member.MembershipCategory
left join Member_Outstanding on Member.ProspectID = Member_Outstanding.ProspectID
left join (select * from AllMembers
where SubMemberList is not null) as pricipals on Member.ProspectID = pricipals.ProspectID
) as MembershipBilling
on subBilling.SCode = MembershipBilling.MCode
and subBilling.MemberID = MembershipBilling.MemberID
and subBilling.MonthlySubFee =MembershipBilling.OutstandingAmount
where SCode is not null 
and subBilling.MemberID is not null
and MonthlySubFee is not null
and MCode is null
and MembershipBilling.MemberID is null
and OutstandingAmount is null

END

GO
/****** Object:  StoredProcedure [dbo].[GetReminderChecklistReport]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[GetReminderChecklistReport]
    @ReminderDateFrom AS date,
	@ReminderDateTo AS date,
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = 20000000;

DECLARE @crCurr AS date
SET @crCurr = DATEADD(month, -1, CAST( GETDATE() AS Date )) 

DECLARE @cr30Date AS date
SET @cr30Date = DATEADD(month, -2, CAST( GETDATE() AS Date )) 

DECLARE @cr60Date AS date
SET @cr60Date = DATEADD(month, -3, CAST( GETDATE() AS Date )) 

DECLARE @cr90Date AS date
SET @cr90Date = DATEADD(month, -4, CAST( GETDATE() AS Date )) 

DECLARE @cr120Date AS date
SET @cr120Date = DATEADD(month, -5, CAST( GETDATE() AS Date )) 

DECLARE @cr150Date AS date
SET @cr150Date = DATEADD(month, -6, CAST( GETDATE() AS Date )) 

DECLARE @cr180Date AS date
SET @cr180Date = DATEADD(month, -7, CAST( GETDATE() AS Date )) 

select COUNT(*) OVER () as 'Count', *,(CrCurr+Cr30+Cr60+Cr90+Cr120+Cr150+Cr180) as 'Total', (Cr30+Cr60+Cr90+Cr120+Cr150+Cr180) as 'TotalCurrentBalance' from (
select rd.ReminderDetailId, r.ReminderDate, AccountStatus, am.ProspectID, am.MemberID, am.MemberName, am.Email,
'' as 'MailTo1', '' as 'MailTo2', '' as 'MailTo3', '' as 'MailTo4', '' as MailToDist,
am.Address as 'ResAddr1', '' as 'ResAddr2', '' as 'ResAddr3', '' as 'ResAddr4', am.PostalCode as ResPostal,
'' as Occupation, am.Address as 'BusAddr1', '' as 'BusAddr2', '' as 'BusAddr3', '' as 'BusAddr4', am.PostalCode as BusPostal,
am.CreditLimit,
ISNULL((select
sum(ISNULL(OutstandingAmount - PaidAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -1, CAST( GETDATE() AS Date )) ) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -1, CAST( GETDATE() AS Date )) ) AND ProspectID = am.ProspectID), 0) as 'CrCurr',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -2, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -2, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr30', 
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -3, CAST( GETDATE() AS Date )) ) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -3, CAST( GETDATE() AS Date )) ) AND ProspectID = am.ProspectID ), 0) as 'Cr60', 
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -4, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -4, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr90',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -5, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -5, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr120',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -6, CAST( GETDATE() AS Date ))) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -6, CAST( GETDATE() AS Date ))) AND ProspectID = am.ProspectID ), 0) as 'Cr150',
ISNULL((select
sum(ISNULL(OutstandingAmount, 0 )) as 'Amount'
from Member_Outstanding 
where (Status is null or Status != 'I') and MONTH(OutstandingDate) = MONTH(DATEADD(month, -7, CAST( GETDATE() AS Date )) ) AND YEAR(OutstandingDate) = YEAR(DATEADD(month, -7, CAST( GETDATE() AS Date )) ) AND ProspectID = am.ProspectID) , 0) as 'Cr180', 
'' as 'LastPayDate',
am.PhoneNo as TEL, '' as PG, '' as HP, '' as O_TEL,  '' as Term,  am.EffectiveDate as 'TermStart', am.ExpiryDate as 'TermEnd', am.MembershipStatus as Status
from AR_ReminderDetail as rd
left join AR_Reminder as r on rd.ReminderId = r.ReminderId
left join AllMembers as am on rd.ProspectID = am.ProspectID
left join Member_Outstanding as mo on rd.OutstandingID = mo.OutstandingID
where rd.SystemUse = 'Y'
and (@ReminderDateFrom IS NULL OR (CONVERT(char(10), r.ReminderDate, 126) >= @ReminderDateFrom and CONVERT(char(10), r.ReminderDate,126) <= @ReminderDateTo))
) as tbl
ORDER BY tbl.ReminderDetailId ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetReminderUser]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetReminderUser]
    @ReminderDate AS date,

    @ReminderType varchar,

    @Position varchar

AS
BEGIN
SET NOCOUNT ON
select Name,Email,PhoneNo,Position,DateFrom,DateTo,ReminderType

from AR_ReminderUser as a

--where (CONVERT(char(10), a.DateFrom,126) <= @ReminderDate and CONVERT(char(10), a.DateTo,126) >= @ReminderDate)

where (CONVERT(char(10), a.DateFrom,126) >= @ReminderDate and CONVERT(char(10), a.DateTo,126) <= @ReminderDate)

--and ReminderType = @ReminderType and Position = @Position;

END
GO
/****** Object:  StoredProcedure [dbo].[GetResourceCarLabel]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
       
 --exec [GetResourceCarLabel]      
      
 CREATE PROCEDURE [dbo].[GetResourceCarLabel]       
 AS      
 BEGIN        
 BEGIN TRY      
    
  BEGIN /** drop temp table**/      
  IF OBJECT_ID(N'tempdb..##tmpCarLabelResource_Pivot') IS NOT NULL          
  BEGIN          
   DROP TABLE ##tmpCarLabelResource_Pivot          
  END          
          
  IF OBJECT_ID(N'tempdb..##tmpCarLabelResource') IS NOT NULL          
  BEGIN          
   DROP TABLE ##tmpCarLabelResource     
  END          
          
  IF OBJECT_ID(N'tempdb..##tmpCarLabelIUResource_Pivot') IS NOT NULL          
  BEGIN          
   DROP TABLE ##tmpCarLabelIUResource_Pivot          
  END          
          
  IF OBJECT_ID(N'tempdb..##tmpCarLabelIUResource') IS NOT NULL          
  BEGIN          
   DROP TABLE ##tmpCarLabelIUResource          
  END    
      
  IF OBJECT_ID(N'tempdb..##tmpResource') IS NOT NULL          
  BEGIN          
   DROP TABLE ##tmpResource          
  END        
 END /** drop temp table**/    
    
      
 BEGIN /** tmpCarLabel **/           
  DECLARE @DynamicQueryCarLabelResource AS NVARCHAR(MAX)          
  DECLARE @ColumnCarLabelResource AS NVARCHAR(MAX)          
          
  SELECT * INTO ##tmpCarLabelResource_Pivot          
  FROM           
   (SELECT ResourceID,CarParkCategory, CarLabel, 'CarLabel' + CAST(ROW_NUMBER() OVER (PARTITION BY ResourceID,CarParkCategory ORDER BY ResourceID,CarParkCategory) AS VARCHAR(45)) AS ColumnSequenceCarLabelResource FROM NSRCCResource_CarLabel WHERE Status =
  
 'A' ) ResourceCarLabel          
    
  SELECT @ColumnCarLabelResource= COALESCE(@ColumnCarLabelResource+ ', ','') + QUOTENAME(ColumnSequenceCarLabelResource)          
  FROM           
  (          
    SELECT ColumnSequenceCarLabelResource from ##tmpCarLabelResource_Pivot          
    WHERE ResourceID =           
    (SELECT TOP 1 ResourceID FROM ##tmpCarLabelResource_Pivot           
    GROUP BY ResourceID, CarParkCategory          
    ORDER BY COUNT(ColumnSequenceCarLabelResource) DESC)       
    AND CarParkCategory =           
    (SELECT TOP 1 CarParkCategory FROM ##tmpCarLabelResource_Pivot           
    GROUP BY ResourceID, CarParkCategory          
    ORDER BY COUNT(ColumnSequenceCarLabelResource) DESC)       
  ) tableCarLabelResource_Pivot       
    
  SET @DynamicQueryCarLabelResource =           
   N'SELECT ResourceID,CarParkCategory, ' +@ColumnCarLabelResource+ ' INTO ##tmpCarLabelResource FROM ' +          
   '(SELECT ResourceID,CarParkCategory, ' +@ColumnCarLabelResource+ 'FROM ##tmpCarLabelResource_Pivot          
   PIVOT          
     (          
   MAX(CarLabel)          
   FOR ColumnSequenceCarLabelResource IN (' +@ColumnCarLabelResource+ ')          
     ) PIV) tableCarLabelResource';        
    
  EXEC(@DynamicQueryCarLabelResource);          
  --SELECT * FROM ##tmpCarLabelResource;      
 END /** tmpCarLabel **/       
     
          
 BEGIN /** tmpCarLabelIU **/           
  DECLARE @DynamicQueryCarLabelIUResource AS NVARCHAR(MAX);    
  DECLARE @DynamicQueryCarLabelIUResourceJoin AS NVARCHAR(MAX);     
  DECLARE @ColumnCarLabelIUResource AS NVARCHAR(MAX);         
          
  SELECT * INTO ##tmpCarLabelIUResource_Pivot          
  FROM           
   (SELECT ResourceID,CarParkCategory, CarLabelIU, 'CarLabelIU' + CAST(ROW_NUMBER() OVER (PARTITION BY ResourceID,CarParkCategory ORDER BY ResourceID,CarParkCategory) AS VARCHAR(45)) AS ColumnSequenceCarLabelIUResource FROM NSRCCResource_CarLabel 
   WHERE Status = 'A' ) ResourceCarLabelIU        
    
  SELECT @ColumnCarLabelIUResource= COALESCE(@ColumnCarLabelIUResource+ ', ','') + QUOTENAME(ColumnSequenceCarLabelIUResource)          
  FROM           
   (          
    SELECT ColumnSequenceCarLabelIUResource from ##tmpCarLabelIUResource_Pivot          
    WHERE ResourceID =           
    (SELECT TOP 1 ResourceID FROM ##tmpCarLabelIUResource_Pivot           
    GROUP BY ResourceID, CarParkCategory          
    ORDER BY COUNT(ColumnSequenceCarLabelIUResource) DESC)       
    AND CarParkCategory =           
    (SELECT TOP 1 CarParkCategory FROM ##tmpCarLabelIUResource_Pivot           
    GROUP BY ResourceID, CarParkCategory          
    ORDER BY COUNT(ColumnSequenceCarLabelIUResource) DESC)       
   ) tableCarLabelIUResource_Pivot       
    
  SET @DynamicQueryCarLabelIUResource =           
     N'SELECT ResourceID,CarParkCategory, ' +@ColumnCarLabelIUResource+ ' INTO ##tmpCarLabelIUResource FROM ' +          
     '(SELECT ResourceID,CarParkCategory, ' +@ColumnCarLabelIUResource+ 'FROM ##tmpCarLabelIUResource_Pivot          
     PIVOT          
     (          
   MAX(CarLabelIU)          
   FOR ColumnSequenceCarLabelIUResource IN (' +@ColumnCarLabelIUResource+ ')          
     ) PIV) tableCarLabelIUResource';         
    
  EXEC(@DynamicQueryCarLabelIUResource);          
  --SELECT * FROM ##tmpCarLabelIUResource;      
 END /** tmpCarLabel **/     
     
    
 BEGIN /** join two carlabel temp table **/    
  SET @ColumnCarLabelIUResource = REPLACE(@ColumnCarLabelIUResource,'[', ' CLIUR.[');    
  SET @DynamicQueryCarLabelIUResourceJoin =     
    N'SELECT * INTO ##tmpResource ' +    
    'FROM ' +    
    '(SELECT CLR.*, ' +@ColumnCarLabelIUResource +     
    'FROM  ##tmpCarLabelResource AS CLR     
    INNER JOIN ##tmpCarLabelIUResource AS CLIUR     
    ON   CLIUR.ResourceID = CLR.ResourceID     
    AND   CLIUR.CarParkCategory = CLR.CarParkCategory) tmpclr ';    
    
  EXEC(@DynamicQueryCarLabelIUResourceJoin);      
  --SELECT * FROM ##tmpResource;    
 END /** join two carlabel temp table **/    
    
    
 BEGIN /*Resource Car Info*/          
   SELECT     
         ISNULL(R.IDNo, '')  AS MemberID,    
         ISNULL(R.IDNo, '')  AS NomineeID,                          
         CLR.*,        
         ISNULL(R.Name, '')  AS Name,    
         ISNULL(T.Description, '') AS Title,       
         ISNULL(R.SurName, '')  AS SurName,          
         --'' AS Salutation,          
         ISNULL(R.Gender, '') AS Sex,         
		 CASE ISNULL(R.Category, '') 
			WHEN 'STA' THEN 'STA - Staff'
			WHEN 'VEN' THEN 'VEN - Vendor'
			WHEN 'VIP' THEN 'VIP - VIP'
			WHEN 'OTH' THEN 'OTH - Others' 
		 END AS Category,
         --ISNULL(C.Code, '') + ' ' + ISNULL(C.Description, '') AS CarParkCategoryDesc,
		 ISNULL(C.Description, '') AS CarParkCategoryDesc, 
		 ISNULL(S.Code + ' - ', '') + ISNULL(S.Description, '') AS Status 
          
   FROM   NSRCCResource AS R         
         
     --LEFT OUTER JOIN MembershipStatus MS               
     --ON    MS.Code = M.MembershipStatus      
         
     LEFT OUTER JOIN Title T              
     ON    T.Code = R.Title      
         
     LEFT OUTER JOIN ##tmpResource AS CLR    
   ON    CLR.ResourceID = R.ID    
    
     LEFT OUTER JOIN CarParkCategory C             
     ON    C.Code = CLR.CarParkCategory  
	 
	 LEFT OUTER JOIN Status S      
     ON    S.Code = R.Status
          
     WHERE   R.Status IS NOT NULL                   
     AND    R.Status = 'A'            
           
     ORDER BY   R.ID          
  END /*Resource Car Info*/      
     
     END TRY      
      
     BEGIN CATCH      
          SELECT        
            ERROR_NUMBER() AS ErrorNumber ,      
   ERROR_SEVERITY() AS ErrorSeverity ,      
   ERROR_STATE() AS ErrorState  ,      
   ERROR_PROCEDURE() AS ErrorProcedure ,      
   ERROR_LINE() AS ErrorLine  ,      
   ERROR_MESSAGE() AS ErrorMessage;        
     END CATCH        
  END
GO
/****** Object:  StoredProcedure [dbo].[GetSubFeeBillingData]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GetSubFeeBillingData]
   
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

     select MembershipCategory.code,count(Member.MembershipCategory) as count ,sum(member.MonthlySubFee)as billing ,(count(Member.MembershipCategory) * sum(member.MonthlySubFee)) as total from MembershipCategory
left join Member on Member.MembershipCategory  = MembershipCategory.Code
left join Member_Relation on Member.ProspectID = Member_Relation.PrincipleProspectID
group by MembershipCategory.Code
END
GO
/****** Object:  StoredProcedure [dbo].[GetUnsentInterestList]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[GetUnsentInterestList]
	@ReminderDate AS VARCHAR(100),
	@AgingType AS VARCHAR(1),
	@RowsToSkip INT,
	@FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM [Member_Outstanding]);

;With ReminderTbl AS(
select COUNT(*) OVER () as Count, IIF(Amount * 0.01 * LateInterestRate < InterestMinAmount, InterestMinAmount, Amount * 0.01 * LateInterestRate) as 'InterestAmount', * from 
(select
(SELECT AR_Aging.Description from AR_Aging where DATEDIFF(DAY ,mo.PaymentDueDate, GETDATE()) BETWEEN DaysFrom AND DaysTo)  as AgingDescription,
	(SELECT AR_Aging.Code from AR_Aging where DATEDIFF(DAY ,mo.PaymentDueDate, GETDATE()) BETWEEN DaysFrom AND DaysTo) As Aging,
	  DATEDIFF(DAY ,mo.PaymentDueDate, GETDATE()) as 'days',  mo.OutstandingAmount + ISNULL(mo.Interest,0) - ISNULL(mo.PaidAmount,0) as 'Amount',
	  am.MemberID,
	  am.MemberName,
	  am.CreditLimit,
	  am.MembershipStatus,
	  (select LateInterestRate from MMSSystemSetup where SystemUse = 'Y')  as LateInterestRate,
	  (select InterestMinAmount from MMSSystemSetup where SystemUse = 'Y') as InterestMinAmount,
	  [PaymentDueDate],
	  [OutstandingID],
	  mo.ProspectID,
	  mo.OutstandingDate,
      [OutstandingAmount],
	  mo.InvoiceNo,
	  mo.Interest,
      [PaidAmount],
      [PaymentStatus]
  FROM (select * from [dbo].[Member_Outstanding] where status is null or status != 'I') as mo 
  inner join AllMembers as am on mo.ProspectID = am.ProspectID
  where PaymentStatus is null and DATEDIFF(DAY ,mo.PaymentDueDate, GETDATE()) >= 60 
  AND (@ReminderDate IS NULL OR (CAST( mo.PaymentDueDate as DATE) <= @ReminderDate))
) as tbl WHERE (tbl.Aging LIKE ISNULL(@AgingType,'')+'%')
)



select ReminderTbl.* from ReminderTbl
left join AR_ReminderDetail on ReminderTbl.OutstandingID = AR_ReminderDetail.OutstandingID AND ReminderTbl.Aging = AR_ReminderDetail.AgingCode
WHERE ReminderTbl.Amount > 0 AND AR_ReminderDetail.ReminderDetailId is null AND Interest is null
ORDER BY ReminderTbl.OutstandingID ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[GetUnsentRecurrentBillList]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUnsentRecurrentBillList]
    @TransactionDate AS date
AS
BEGIN

IF ( @TransactionDate IS NULL ) SET @TransactionDate = CAST( GETDATE() AS Date );

select mr.RecuBillID, mr.ProspectID, am.MemberName, am.MemberID,r.Month, Frequency, 
(select PayDueDay from MMSSystemSetup where SystemUse = 'Y') as PaymentDue, 
mr.ChargeCode, (RecurrentAmount * r.Month) as 'TaxableAmount', 0 as 'Tax', '' as 'AdvBilling',  ChargeCode.Description as 'ChargeCodeDescription', mr.LastPartialPayment ,PaymentMethod, StartYearMonth, EndYearMonth, ((RecurrentAmount * r.Month)-ISNULL(ma.ReduceAmount,0)) as 'Amount', NoTimesForBill, NoTimesBilled,
ma.ReduceAmount, ma.AbsentFrom, ma.AbsentTo, 
	CASE 
		WHEN ReduceAmount > 0
			THEN CONCAT('ReduceAmount - ', ma.ReduceAmount ,' ( ', CAST(ma.AbsentFrom AS date), ' - ', CAST(ma.AbsentTo as date), ' )')
		ELSE ''
	END
 as AbsentDescription, ((RecurrentAmount * r.Month)) as 'RecAmount'
from Member_RecurrentBill as mr
left join AllMembers as am on mr.ProspectID = am.ProspectID 
left join AR_Recurring as r on mr.Frequency = r.Code 
left join ChargeCode on mr.ChargeCode = ChargeCode.Code
left join (
	select TransactionDetailId, RecuBillID, TransactionDate from AR_TransactionDetail
	where @TransactionDate >= AR_TransactionDetail.StartBillDate AND @TransactionDate < NextSubBillDate
) as td on mr.RecuBillID = td.RecuBillID 
left join (
	select Member_Application.ProspectID, ISNULL(Member_Absent.ReduceAmount, 0) as 'ReduceAmount', Member_Absent.AbsentFrom, Member_Absent.AbsentTo, Member_Absent.Description as 'AbsentDescription' from Member_Absent 
	left join Member_Application on Member_Absent.ApplicationNo = Member_Application.ApplicationNo
	where @TransactionDate >= AbsentFrom AND @TransactionDate < AbsentTo
) as ma on mr.ProspectID = ma.ProspectID
WHERE @TransactionDate BETWEEN  mr.StartYearMonth and mr.EndYearMonth 
AND td.TransactionDetailId is null
END

GO
/****** Object:  StoredProcedure [dbo].[GetUnsentReminderList]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 

 

CREATE PROCEDURE [dbo].[GetUnsentReminderList]
    @ReminderDate AS VARCHAR(100),
    @ReminderFormat AS VARCHAR(1), 
    @AgingType AS VARCHAR(1),
    @RowsToSkip INT,
    @FetchRows INT
AS
BEGIN
SET NOCOUNT ON
IF(@FetchRows IS NULL) SET @FetchRows = (SELECT COUNT(*) FROM [Member_Outstanding]);

 

;With ReminderTbl AS(
    select 
    reminder.*, AR_Aging.Description as 'AgingDescription' from (
    select
    CASE 
         WHEN Aging = 1 AND OutstandingAmount > 150 THEN '2'
         WHEN Aging = 1 AND OutstandingAmount <= 150 THEN '1'
         WHEN Aging = 2 AND OutstandingAmount > 200 THEN '3'
         WHEN Aging = 2 AND OutstandingAmount <= 200 THEN '2'
         WHEN Aging = 3 AND OutstandingAmount > 200 THEN '4'
         WHEN Aging = 3 AND OutstandingAmount <= 200 THEN '3'
         WHEN Aging = 4 AND OutstandingAmount > 250 THEN '5'
         WHEN Aging = 4 AND OutstandingAmount <= 250 THEN '4'
         WHEN Aging = 5 THEN '5'
         WHEN Aging = 4 AND (PaidAmount is null or PaidAmount = 0) THEN '5'
         ELSE '3'  
      END as 'AgingCode',
* from (SELECT 
      --(SELECT AR_Aging.Description from AR_Aging where DATEDIFF(DAY ,mo.PaymentDueDate, GETDATE()) BETWEEN DaysFrom AND DaysTo)  as AgingDescription,
      (SELECT AR_Aging.Code from AR_Aging where DATEDIFF(DAY ,mo.PaymentDueDate, GETDATE()) BETWEEN DaysFrom AND DaysTo) As Aging,
      DATEDIFF(DAY ,mo.PaymentDueDate, GETDATE()) as 'days',  (mo.OutstandingAmount+ISNULL(mo.Interest, 0)) - ISNULL(mo.PaidAmount,0) as 'Amount',
      am.MemberID,
      am.MemberName,
      am.CreditLimit,
      am.SpendingCredit,
      am.PostalCode,
      am.Address,
      am.PhoneNo,
      am.MembershipStatus,
      [PaymentDueDate],
      mo.InvoiceNo,
      [OutstandingID],mo.ProspectID,
      mo.OutstandingDate,
      [OutstandingAmount],
      [PaidAmount],
      [PaymentStatus]
  FROM [dbo].[Member_Outstanding] as mo 
  inner join AllMembers as am on mo.ProspectID = am.ProspectID
  where PaymentStatus is null and DATEDIFF(DAY ,mo.PaymentDueDate, GETDATE()) >= 60 
  AND (@ReminderDate IS NULL OR (CAST( mo.PaymentDueDate as DATE) <= @ReminderDate))) as r
) as reminder
left join AR_ReminderDetail as rd on reminder.OutstandingID = rd.OutstandingID AND reminder.Aging = rd.AgingCode 
left join AR_Aging on AR_Aging.Code = reminder.AgingCode
WHERE reminder.Amount > 0 AND rd.AgingCode is null AND (reminder.AgingCode LIKE ISNULL(@AgingType,'')+'%')
)

 

select 
ROW_NUMBER() OVER(Order by OutstandingID) AS row_num,
COUNT(*) OVER () as Count, 
* from (

 

    select 
    '3'  as ReminderFormat,
    'Expired Members' as ReminderFormatDescription,
    * from (
    select 
    isnull((select sum(isnull(Amount,0)) from ReminderTbl where ProspectID = tbl.ProspectID AND OutstandingID < tbl.OutstandingID),0) as 'TotalSpendingCredit',
    * from (
    select * from (
        select
        * from ReminderTbl
    ) as t
    ) as tbl
    )as subtbl where MembershipStatus = 'E'

 

    UNION ALL

 

    select 
    '2'  as ReminderFormat,
    'Exceed Credit Limit' as ReminderFormatDescription,
    * from (
    select 
    isnull((select sum(isnull(Amount,0)) from ReminderTbl where ProspectID = tbl.ProspectID AND OutstandingID < tbl.OutstandingID),0) as 'TotalSpendingCredit',
    * from (
    select * from (
        select
        * from ReminderTbl
    ) as t
    ) as tbl
    )as subtbl where SpendingCredit < TotalSpendingCredit

 

    UNION ALL

 

    select 
    '1' as ReminderFormat,
    'Outstanding Balance'  as ReminderFormatDescription,
    * from (
    select 
    isnull((select sum(isnull(Amount,0)) from ReminderTbl where ProspectID = tbl.ProspectID AND OutstandingID < tbl.OutstandingID),0) as 'TotalSpendingCredit',
    * from (
    select * from (
        select
        * from ReminderTbl
    ) as t
    ) as tbl
    )as subtbl
) as list
WHERE (list.ReminderFormat LIKE ISNULL(@ReminderFormat,'')+'%')
ORDER BY list.OutstandingID ASC   
OFFSET ISNULL(@RowsToSkip,0) ROWS   
FETCH NEXT @FetchRows ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[getUserByAD_UserID]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[getUserByAD_UserID]
    @AD_UserID AS varchar(100)
AS
BEGIN
SET NOCOUNT ON
	select UserID,'Admin' as UserName, AdminLocation.ID as 'LocationID', LocationName, LocationCode,
	(select PostalCode from AR_Location) as 'PostalCode',
	(select Country from AR_Location) as 'Country',
	(select Tel from AR_Office) as 'Tel',
	(select Fax from AR_Office) as 'Fax'
	from AdminUserLocationPermission
	left join AdminLocation on AdminUserLocationPermission.LocationID = AdminLocation.ID
	where AdminUserLocationPermission.UserID = @AD_UserID 
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserLocations]    Script Date: 3/22/2024 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetUserLocations]
AS
BEGIN     

select *, '' as UserID  from AdminLocation
where AdminLocation.SystemUse = 'Y'
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Main Module, 2 = Sub Module' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminModule', @level2type=N'COLUMN',@level2name=N'ModuleLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Giro Reference (or) Reference Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_MemberAccountDetail', @level2type=N'COLUMN',@level2name=N'Reference'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Payment Received from Member/Cancel Payment - Finance' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_Transaction', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bill Upfront Process - Finance' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_Transaction', @level2type=N'COLUMN',@level2name=N'NextBillDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bill Upfront Process - Finance' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_Transaction', @level2type=N'COLUMN',@level2name=N'SubscriptionType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bill Upfront Process - Finance' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_Transaction', @level2type=N'COLUMN',@level2name=N'SubscriptionMonths'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Payment Received from Member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_TransactionDetail', @level2type=N'COLUMN',@level2name=N'PaymentCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Payment Received from Member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_TransactionDetail', @level2type=N'COLUMN',@level2name=N'ChequeDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Payment Received from Member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_TransactionDetail', @level2type=N'COLUMN',@level2name=N'BankCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Adjustment - Accounts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_TransactionDetail', @level2type=N'COLUMN',@level2name=N'Section'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Adjustment - Accounts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_TransactionDetail', @level2type=N'COLUMN',@level2name=N'RndAdjustment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Payment Received from Member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_TransactionDetail', @level2type=N'COLUMN',@level2name=N'IsBankIn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Statement Month' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AR_TransactionDetail', @level2type=N'COLUMN',@level2name=N'FinancialMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mem Registration, Online Payment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TermsandCondition', @level2type=N'COLUMN',@level2name=N'FileType'
GO
USE [master]
GO
ALTER DATABASE [UpdatedDB] SET  READ_WRITE 
GO
