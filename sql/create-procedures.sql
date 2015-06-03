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
if OBJECT_ID('sp_matchcall') is not null
	drop procedure sp_matchcall
if OBJECT_ID('sp_updateNewHistoryCall') is not null
	drop procedure sp_updateNewHistoryCall
if OBJECT_ID('sp_getmatches') is not null
	drop procedure sp_getmatches
if OBJECT_ID('sp_makematch') is not null
	drop procedure sp_makematch
if OBJECT_ID('sp_removematch') is not null
	drop procedure sp_removematch	
if OBJECT_ID('sp_matchcmhc') is not null
	drop procedure sp_matchcmhc
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
	@program as int,
	@status as int = 0
) as
begin
	select callId
		, convert(nvarchar(10), CallDate, 101)
		--, calldate
		, callername
	from call_record
	where (@program is null or programId = @program)
	  and status = @status
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
		HistoryPreviousId,
		HistoryNextId,
		ProgramId,
		PatientName ,
		CmhcId ,
		PhoneNumber ,
		County ,
		City, 
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
	@HistoryPreviousId int = null,
	@HistoryNextId int = null,
	@ProgramId int,
	@CallDate datetime,
	@CallerName varchar(64) = null,
	@PatientName varchar(64) = null,
	@CmhcId varchar(10) = null,
	@PhoneNumber varchar(10) = null,
	@County varchar(10) = null,
	@City varchar(64) = null,
	@Street varchar(64) = null,
	@State varchar(2) = null,
	@Zip varchar(9) = null,
	@ReferredTo varchar(64) = null,
	@ReferredFrom varchar(64) = null,
	@Request nvarchar(max)  = null,
	@UserId int
) as
begin
	insert into call_record (
		Status,
		HistoryPreviousId,
		HistoryNextId,
		ProgramId,
		CallDate ,
		CallerName ,
		PatientName ,
		CmhcId ,
		PhoneNumber ,
		County ,
		City ,
		Street ,
		State ,
		Zip ,
		ReferredTo ,
		ReferredFrom ,
		Request ,
		CreateDate,
		CreateUser
	) values (
		0,
		@HistoryPreviousId,
		@HistoryNextId,
		@ProgramId,
		@CallDate ,
		@CallerName ,
		@PatientName ,
		@CmhcId ,
		@PhoneNumber ,
		@County ,
		@City, 
		@Street ,
		@State ,
		@Zip ,
		@ReferredTo ,
		@ReferredFrom ,
		@Request ,
		GETDATE() ,
		@UserId
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

go
create procedure sp_updateNewHistoryCall (
	@callid int,
	@newid int
) as
begin
	update call_record
	set HistoryNextId = @newid
	where callid = @callid
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
	@City varchar(64) = null,
	@Street varchar(64) = null,
	@State varchar(2) = null,
	@Zip varchar(9) = null,
	@ReferredTo varchar(64) = null,
	@ReferredFrom varchar(64) = null,
	@Request nvarchar(max) = null,
	@UserId varchar(10)
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
		null,
		@programId,
		@CallDate,
		@CallerName,
		@PatientName,
		@CmhcId,
		@PhoneNumber,
		@County,
		@City,
		@Street,
		@State,
		@Zip,
		@ReferredTo,
		@ReferredFrom,
		@Request,
		@UserId
	
	--@new_id = scope_identity()
	
	exec sp_updatecallstatus @callid, 1
	
	--declare @new_id
	select top 1 @new_id = new_id from #res
	
	exec sp_updateNewHistoryCall @callid, @new_id
	
	select @new_id
	--select new_id from #res
end

go
create procedure sp_voidcall (
	@callid int
) as
begin
	exec sp_updatecallstatus @callid, 2
end

--exec sp_matchcall 'anderson cooper'
go
create procedure sp_matchcall (
	@caller varchar(64),
	@patient varchar(64)= null,
	@phone varchar(10) = null,
	@excludeid int = null,
	@crossprogram int = NULL
) as
begin

	select 	
		CallId, 
		convert(nvarchar(10), CallDate, 101),
		CallerName ,
		Status,
		HistoryPreviousId,
		HistoryNextId,
		ProgramId,
		PatientName ,
		CmhcId ,
		PhoneNumber ,
		County ,
		City, 
		Street ,
		State ,
		Zip ,
		ReferredTo ,
		ReferredFrom ,
		Request ,
		CreateDate
	from [dbo].[call_record] as cr
	where (
		(difference(cr.CallerName, @caller) > 3 and 
			difference((select top 1 data from split(cr.CallerName, ' ') where Id = '2'), 
			           (select top 1 data from split(@caller,' ') where Id = '2')) > 3)
		or (DIFFERENCE(cr.PatientName, @patient) > 3 and 
			difference((select top 1 data from split(cr.PatientName, ' ') where Id = '2'), 
			           (select top 1 data from split(@patient,' ') where Id = '2')) > 3)
		or cr.PhoneNumber = @phone
	)
	and (@crossprogram is null or @crossprogram = cr.ProgramId)
	and Status = 0
	and (@excludeid is null or @excludeid != CallId)
	order by difference(cr.CallerName, @caller) desc
end

go
create procedure sp_matchcmhc (
	@patient varchar(64)= null
) as
begin
	select 	
		cr.clientid, 
		FirstName + ' ' + LastName Name,
		convert(nvarchar(10), DOB, 101) as DOB,
		ad.Address,
		ad.CountyDesc,
		ad.CityDesc,
		ad.State,
		ad.Zip,
		ad.PhoneHome
	from Client.client_record as cr
	left join viewCurrentAddress ad
	  on ad.ClientID = cr.clientid
	where 
		difference(cr.FirstName, @patient) > 3 and 
		difference(cr.LastName, (select top 1 data from split(@patient,' ') where Id = '2')) > 3
end

go
create procedure sp_getmatches (
	@callid int
) as 
begin
	select case 
		when call1 = @callid then call2
		when call2 = @callid then call1
	end as matchid
	from call_matches
	where call1 = @callid or call2 = @callid
end

go
create procedure sp_makematch (
	@call1 int,
	@call2 int
) as
begin
	insert into call_matches
	values (
		@call1,
		@call2
	)
end

go
create procedure sp_removematch (
	@call1 int,
	@call2 int
) as 
begin
	delete from call_matches
	where call1 = @call1
	  and call2 = @call2
end

