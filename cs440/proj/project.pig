-- make sure to change ish-history location


register file:/home/hadoop/lib/pig/piggybank.jar;
DEFINE EXTRACT org.apache.pig.piggybank.evaluation.string.EXTRACT;

-- run with: pig -f project.pig -param INPUT='s3://cs440-climate/gsod/1965/747750-13846-1965.op' -param 'OUTPUT=s3://cs440-jrile/data'
ISH = LOAD 's3://cs440-climate/ish-history.txt' as (row:chararray);

RAW_ISH_BASE = FOREACH ISH GENERATE 
	FLATTEN(
		(tuple(int, int, chararray, chararray, chararray))
		EXTRACT(row, '^(\\d{6}) (\\d{5}) (.{30})(\\S{2}) \\S{2} (\\S{2}).*')
	) as (
	usaf_id:	int,
	wban_id:	int,
	sname:	chararray,
	ctry:	chararray,
	state:	chararray );
	-- this will only get stations with something in the state field.

CLEAN_RAW_ISH_BASE = FILTER RAW_ISH_BASE BY usaf_id > 0;

ISH_BASE = FOREACH CLEAN_RAW_ISH_BASE GENERATE
	TRIM(CONCAT((chararray)usaf_id, (chararray)wban_id)) as w_identifier,
	state;

RAW_LOGS = LOAD 's3://cs440-climate/gsod/' as (line:chararray);

LOGS = FOREACH RAW_LOGS GENERATE
	FLATTEN(
		(tuple(int, int, int, int, int, float))
		EXTRACT(line, '(\\d{6}) (\\d{5})  (\\d{4})(\\d{2})(\\d{2})\\s+(\\d+\\.\\d).*' )
	) as (
	stn:		int,
	wban:		int,
	year:		int,
	month:		int,
	day:		int,
	temp:		float );

CLEAN_LOGS_0 = FILTER LOGS BY stn > 0;
CLEAN_LOGS = FILTER CLEAN_LOGS_0 BY temp != 9999.9F;	

LOGS_BASE = FOREACH CLEAN_LOGS GENERATE
	TRIM(CONCAT((chararray)stn, (chararray)wban)) as identifier,
	year,
	month,
	day,
	temp;
	
LOGS_GROUPED = GROUP LOGS_BASE BY (identifier, year, month);
LOGS_GROUPED2 = foreach LOGS_GROUPED generate group, flatten(AVG(LOGS_BASE.temp)) as avg_temp;

LOGS_GROUPED3 = foreach LOGS_GROUPED2 generate flatten(group), avg_temp;


JOINED = join LOGS_GROUPED3 by group::identifier, ISH_BASE by w_identifier;
JOINED_CLEAN = FOREACH JOINED GENERATE
	ISH_BASE::w_identifier as j_identifier,
	ISH_BASE::state as j_state,
	LOGS_GROUPED3::group::year as j_year,
	LOGS_GROUPED3::group::month as j_month,
	LOGS_GROUPED3::avg_temp as j_avg_temp;

GROUP_BY_STATE_YEAR_AND_MONTH = GROUP JOINED_CLEAN BY 
	(j_state, j_year, j_month);

STATE_AVG = foreach GROUP_BY_STATE_YEAR_AND_MONTH generate
	group, flatten(AVG(JOINED_CLEAN.j_avg_temp)) as state_avg_temp;

STORE STATE_AVG INTO 's3://cs440-jrile/results/';

