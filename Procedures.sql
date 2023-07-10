#Cancel appointment booking 
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
				Ab.MedicEmployerPC = AppMedicPC and
				Ab.PatientPC = AppPatientPC
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

#List paid salaries by specific clinic in its departments.
drop function if exists ListClinicSumOfThePaidSalariesForDeparments;
DELIMITER $$
create procedure ListClinicSumOfThePaidSalariesForDeparments(ClinicId int)
begin
	# Gets in input ClinicId and returns for all deparments salary paid in them
    # Example of possible output:
    #	|	DeparmentSpecialization	|	Salary	|
    #	|		SpecializationA		|	150000	|
    #	|		SpecializationB		| 	  2000	|
    #	|		SpecializationC		|	     0	|
    # All department specialization listed above must be deparments of the clinic with ClinicId
    
end $$
DELIMITER ;

#List work schedule of the clinic
drop function if exists ListWorkScheduleOfTheClinic;
DELIMITER $$
create procedure ListWorkScheduleOfTheClinic(ClinicId int, NextDaysInterval int)
begin
	# Gets in input ClinicId, NextDaysInterval and 
    # returns work schedule for this clinic with daily work schedule and specific date in the NextDaysInterval days.
    # Example of possible output:
    #	|	Type	|	StartTime	|	EndTime	|	DayOfTheWeek	|		Date	|
    #	|	Week	|	9:00		|	17:00	|		MON			|		NULL	|
    #	|	Week	|	9:00		|	17:00	|		TUE			|		NULL	|
    #	|	Week	|	9:00		|	17:00	|		WED			|		NULL	|
    #	|	Week	|	9:00		|	17:00	|		THU			|		NULL	|
    #	|	Week	|	9:00		|	17:00	|		FRI			|		NULL	|
    #	|	Week	|	9:00		|	17:00	|		SAT			|		NULL	|
    #	|	Week	|	9:00		|	17:00	|		SUN			|		NULL	|
    #	|	Date	|	9:00		|	10:00	|		NULL		|	2023-12-31	|
    
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


