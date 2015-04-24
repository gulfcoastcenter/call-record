--exec sp_counties
if object_id('sp_counties') is not null
	drop procedure sp_counties

create procedure sp_counties as
select CountyId
	, CountyName
from county_code

--exec sp_states 
if object_id('sp_states') is not null
	drop procedure sp_states

create procedure sp_states as
select StateId
	, StateName
from state_code

--exec sp_programs
if object_id('sp_programs') is not null
	drop procedure sp_programs
create procedure sp_programs as
select programId
	, programRu
	, programName
from program_code

--exec sp_calls 3600
if object_id('sp_calls') is not null
	drop procedure sp_calls
create procedure sp_calls (
	@program as int
) as
select callId
	, calldate
	, callername
from call_record
where @program is null or programId = @program