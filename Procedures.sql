#Cancel appointment booking for specific dateTime, clinic, medic and patient
drop procedure if exists CancelAppoinmentBooking;
DELIMITER $$
create procedure CancelAppoinmentBooking(in AppDateTime datetime,
                                         in AppClinicId int, 
                                         in AppMedicPC char(16),
										 in AppPatientPC char(16))
begin
	if (select count(*) 
		from AppointmentBooking Ab
		where	Ab.ClinicId = AppClinicId and 
				Ab.MedicEmployerPC = AppMedicPC
		) = 0
	then 	select 'Appoinment booking not found';
	else 	update AppointmentBooking Ab
			set Ab.PatientPC = null
			where 	Ab.ClinicId = AppClinicId and 
					Ab.MedicEmployerPC = AppMedicPC and
					Ab.PatientPC = AppPatientPC;
end if;
end $$
DELIMITER ;

#List paid salaries for each clinic
# Example of possible output:
#	|	ClinicRelativeData	|	PaidSalary	|
#	|						|		25		|	
#	|						|		15		|
drop procedure if exists ListClinicWithTheSumOfPaidSalaries;
DELIMITER $$
create procedure ListClinicWithTheSumOfPaidSalaries()
begin
    select C.Id as ClinicId, C.Street as ClinicStreet, C.City as ClinicCity, C.Country as ClinicCountry, C.PostCode as ClinicPostCode, sum(CE.Salary) as PaidSalary from CurrentEmployment CE
    join Clinic C on C.Id = CE.ClinicId
    group by C.Id;
end $$
DELIMITER ;

#List work schedule of the clinic
# Gets in input ClinicId, NextDaysInterval, CurrentDate and 
# returns work schedule for this clinic with daily work schedule 
# and specific date in the NextDaysInterval days after the CurrentDate.
# Example of possible output:
#	|	ClinicRelativeData	|	Type	|	StartTime	|	EndTime		|	DayOfTheWeek	|		Date	|
#	|						|	Week	|	9:00:00		|	17:00:00	|		MON			|		NULL	|
#	|						|	Week	|	9:00:00		|	17:00:00	|		TUE			|		NULL	|
#	|						|	Week	|	9:00:00		|	17:00:00	|		WED			|		NULL	|
#	|						|	Week	|	9:00:00		|	17:00:00	|		THU			|		NULL	|
#	|						|	Week	|	9:00:00		|	17:00:00	|		FRI			|		NULL	|
#	|						|	Week	|	9:00:00		|	17:00:00	|		SAT			|		NULL	|
#	|						|	Week	|	9:00:00		|	17:00:00	|		SUN			|		NULL	|
#	|						|	Date	|	9:00:00		|	10:00:00	|		NULL		|	2023-12-31	|
drop procedure if exists ListWorkScheduleOfTheClinic;
DELIMITER $$
create procedure ListWorkScheduleOfTheClinic(ClinicId int, NextDaysInterval int, CurrentDate date)
begin
    select C.Id as ClinicId, C.Street as ClinicStreet, C.City as ClinicCity, C.Country as ClinicCountry, C.PostCode as ClinicPostCode, WS.Type, WS.StartTime, WS.EndTime, WS.DayOfTheWeek, WS.Date  
	from WorkSchedule WS
		join ClinicSchedule CS on (CS.WorkScheduleId = WS.Id)
		join Clinic C on (C.Id = CS.ClinicId)
		having 	(WS.Type = "Week") or 
				(WS.Type = "Date" and (WS.Date between CurrentDate and date_add(CurrentDate, interval NextDaysInterval day)));
	
end $$
DELIMITER ;


#Calculate paid salary by specific clinic.
drop function if exists GetClinicSumOfThePaidSalaries;
DELIMITER $$
create function GetClinicSumOfThePaidSalaries(ClinicId int)
returns int
reads sql data
begin
	declare clinicSalary int;
    select sum(Ce.Salary) from CurrentEmployment Ce where Ce.ClinicId = ClinicId into clinicSalary;
    return clinicSalary;
end $$
DELIMITER ;


