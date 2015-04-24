create table [dbo].[county_code] (
	CountyId varchar(10) not null,
	CountyName varchar(64),
	constraint [PK_county_code] primary key clustered ( [CountyId] )
)

insert into county_code values ('GALV', 'Galveston')
insert into county_code values ('BRAZ', 'Brazoria')
insert into county_code values ('HARR', 'Harris')
insert into county_code values ('OTHER', 'Other')

create table [dbo].[state_code] (
	StateId varchar(2) not null,
	StateName varchar(32),
	constraint [PK_state_id] primary key clustered ([StateId])
)

insert into state_code values ('TX', 'Texas')

create table [dbo].[program_code] (
	ProgramId int identity(1,1) not null,
	ProgramRu int,
	ProgramName nvarchar(64),
	constraint [PK_program_id] primary key clustered ( [ProgramId] ASC ),
	--constraint [FK_program_ru] foreign key (ProgramRu) references Sysfile.RU(RU)
)

insert into program_code values (3600, 'Wellness & Recovery')


create table [dbo].[call_record] (
	CallId int identity(1,1) not null,
	ProgramId int,
	CallDate datetime,
	CallerName varchar(64),
	PatientName varchar(64),
	CmhcId varchar(10),
	PhoneNumber varchar(10),
	County varchar(10),
	Street varchar(64),
	State varchar(2),
	Zip varchar(9),
	ReferredTo varchar(64),
	ReferredFrom varchar(64),
	Request nvarchar(max),
	constraint [PK_call_record] primary key clustered ( [CallId] ASC ),
	constraint [FK_county_code] foreign key (County) references county_code(CountyId)
)

insert into call_record values (3600, '5/8/2015', 'test caller', 'test patient', null, '1234567890', 'GALV', '123 Main', 'TX', '77550', 'Some Referral To', 'Some Referral From', 'Some Reaseon')

