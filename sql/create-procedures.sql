--exec sp_counties
if object_id('sp_counties') is not null
	drop procedure sp_counties
if object_id('sp_states') is not null
	drop procedure sp_states
if object_id('sp_programs') is not null
	drop procedure sp_programs
if object_id('sp_calls') is not null
	drop procedure sp_calls
if object_id('sp_addcall') is not null
	drop procedure sp_addcall
if object_id('sp_updatecallstatus') is not null
	drop procedure sp_updatecallstatus
if object_id('sp_updatecall') is not null
	drop procedure sp_updatecall
if object_id('sp_voidcall') is not null
	drop procedure sp_voidcall
if object_id('sp_getcall') is not null
	drop procedure sp_getcall
	
go
create procedure sp_counties as
begin
	select CountyId
		, CountyName
	from county_code
end

--exec sp_states 
go
create procedure sp_states as
begin
	select StateId
		, StateName
	from state_code
end

--exec sp_programs
go
create procedure sp_programs as
begin
	select programId
		, programRu
		, programName
	from program_code
end

--exec sp_calls 3600
go
create procedure sp_calls (
	@program as int
) as
begin
	select callId
		, convert(nvarchar(10), CallDate, 101)
		--, calldate
		, callername
	from call_record
	where @program is null or programId = @program
	  and status = 0
end

go
--exec sp_getcall 0
create procedure sp_getcall (
	@call as int
) as
--as 
begin
	select
		CallId, 
		convert(nvarchar(10), CallDate, 101),
		CallerName ,
		Status,
		HistoryId,
		ProgramId,
		PatientName ,
		CmhcId ,
		PhoneNumber ,
		County ,
		Street ,
		State ,
		Zip ,
		ReferredTo ,
		ReferredFrom ,
		Request
	from call_record
	where CallId = @call
end

go
create procedure sp_addcall (
	@HistoryId int = null,
	@ProgramId int,
	@CallDate datetime,
	@CallerName varchar(64) = null,
	@PatientName varchar(64) = null,
	@CmhcId varchar(10) = null,
	@PhoneNumber varchar(10) = null,
	@County varchar(10) = null,
	@Street varchar(64) = null,
	@State varchar(2) = null,
	@Zip varchar(9) = null,
	@ReferredTo varchar(64) = null,
	@ReferredFrom varchar(64) = null,
	@Request nvarchar(max)  = null--,
	--@new_id int output
) as
begin
	insert into call_record (
		Status,
		HistoryId,
		ProgramId,
		CallDate ,
		CallerName ,
		PatientName ,
		CmhcId ,
		PhoneNumber ,
		County ,
		Street ,
		State ,
		Zip ,
		ReferredTo ,
		ReferredFrom ,
		Request
	) values (
		0,
		@HistoryId,
		@ProgramId,
		@CallDate ,
		@CallerName ,
		@PatientName ,
		@CmhcId ,
		@PhoneNumber ,
		@County ,
		@Street ,
		@State ,
		@Zip ,
		@ReferredTo ,
		@ReferredFrom ,
		@Request
	);
	--select @new_id = scope_identity()
	select scope_identity() as [new_id]
end
/*
exec sp_addcall null, 3600, '5/8/2015', 'test caller', 'test patient', null, '1234567890', 'GALV', '123 Main', 'TX', '77550', 'Some Referral To', 'Some Referral From', 'Some Reaseon'
*/


go
create procedure sp_updatecallstatus (
	@callid int,
	@status int
) as 
begin 
	update call_record 
	set Status = @status
	where CallId = @callid
end


--exec sp_updatecall 2, 3600, '5/13/2015', 'edit new name', 'edit new patient'
go
create procedure sp_updatecall (
	@callId int,
	--@HistoryId int,
	@ProgramId int,
	@CallDate datetime,
	@CallerName varchar(64),
	@PatientName varchar(64),
	@CmhcId varchar(10) = null,
	@PhoneNumber varchar(10) = null,
	@County varchar(10) = null,
	@Street varchar(64) = null,
	@State varchar(2) = null,
	@Zip varchar(9) = null,
	@ReferredTo varchar(64) = null,
	@ReferredFrom varchar(64) = null,
	@Request nvarchar(max) = null
) as
begin
	declare @this_id int
	declare @new_id int
	
	create table #res (
		new_id int
	)
	
	insert into #res
	exec sp_addcall 
		--@HistoryId,
		@callId,
		@programId,
		@CallDate,
		@CallerName,
		@PatientName,
		@CmhcId,
		@PhoneNumber,
		@County,
		@Street,
		@State,
		@Zip,
		@ReferredTo,
		@ReferredFrom,
		@Request
	
	--@new_id = scope_identity()
	
	exec sp_updatecallstatus @callid, 1
	
	select new_id from #res
end

go
create procedure sp_voidcall (
	@callid int
) as
begin
	exec sp_updatecallstatus @callid, 2
end