if OBJECT_ID('call_matches') is not null
	drop table call_matches
if OBJECT_ID('call_record') is not null
	drop table call_record
if OBJECT_ID('record_status') is not null
	drop table record_status
if OBJECT_ID('county_code') is not null
	drop table county_code
if OBJECT_ID('state_code') is not null
	drop table state_code
if OBJECT_ID('program_code') is not null
	drop table program_code

go

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

create table [dbo].[record_status] (
	StatusId int identity (0,1) not null,
	StatusName varchar(32) not null,
	constraint [PK_status_Id] Primary Key clustered ([StatusId] ASC )
)

insert into record_status values ('Active')
insert into record_status values ('Modified')
insert into record_status values ('Void')

create table [dbo].[call_record] (
	CallId int identity(1,1) not null,
	Status int,
	HistoryPreviousId int,
	HistoryNextId int,
	ProgramId int,
	CallDate datetime,
	CallerName varchar(64),
	PatientName varchar(64),
	CmhcId varchar(10),
	PhoneNumber varchar(10),
	County varchar(10),
	City varchar(64),
	Street varchar(64),
	State varchar(2),
	Zip varchar(9),
	ReferredTo varchar(64),
	ReferredFrom varchar(64),
	Request nvarchar(max),
	CreateDate datetime,
	CreateUser varchar(10),
	constraint [PK_call_record] primary key clustered ( [CallId] ASC ),
	constraint [FK_county_code] foreign key (County) references county_code(CountyId),
	constraint [FK_status_code] foreign key (Status) references record_status(StatusId),
	constraint [FK_HistoryPrevious_Id] foreign key (HistoryPreviousId) references call_record(CallId),
	constraint [FK_HistroyNext_Id] foreign key (HistoryNextId) references call_record(CallId)
)

insert into call_record values (0, NULL, NULL, 3600, '5/8/2015', 'test caller', 'test patient', null, '1234567890', 'GALV', 'Galveston', '123 Main', 'TX', '77550', 'Some Referral To', 'Some Referral From', 'Some Reaseon', GETDATE())

create table call_matches (
	call1 int,
	call2 int,
	constraint [FK_call1_id] foreign key (call1) references call_record(callid),
    constraint [FK_call2_id] foreign key (call2) references call_record(callid)
)