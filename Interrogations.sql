######################################## Interrogations #############################################

#Find clinics where specific medic he worked before and works now
select 	E.PC as EmployerPC, 
		E.Name as EmployerName, 
        E.Surname as EmployerSurname, 
        E.BirthDate as EmployerBirthDate, 
		C.Id as ClinicId, 
        C.Street as ClinicStreet, 
        C.Country as ClinicCountry, 
        C.PostCode as ClinicPostCode 
from 	(select distinct CE.EmployerPC, CE.ClinicId 
			from CurrentEmployment CE
				join PastEmployment PE on CE.ClinicId = PE.ClinicId
				where PE.EmployerPC = CE.EmployerPC
		) T
join Employer E on E.PC = T.EmployerPC
join Clinic C on C.Id = T.ClinicId;

#Find list of department with their primary medics by specific clinic
select 	D.ClinicId, 
		SDepartment.Name as DepartmentSpecialization, 
        M.EmployerPC as PrimaryMedicEmployerPC, 
        SMedic.Name as PrimaryMedicSpecialization 
from Department D
join Medic M on M.EmployerPC = D.PrimaryMedicEmployerPC
join Specialization SMedic on M.SpecializationId = SMedic.Id
join Specialization SDepartment on D.SpecializationId = SDepartment.Id
where D.ClinicId = 2333;


#################################### End Interrogations End #########################################

############################## Procedure call and function usage ####################################

call ClinicsDB.CancelAppoinmentBooking(date("2023-07-10"), "1", "1", "1");

call ClinicsDB.ListClinicWithTheSumOfPaidSalaries();
#Alternative for previous procedure call by using function call and select statement
select *, ClinicsDB.GetClinicSumOfThePaidSalaries(C.Id) from Clinic C;

call ClinicsDB.ListWorkScheduleOfTheClinic("1", 30, date("2023-07-10"));

select ClinicsDB.GetClinicSumOfThePaidSalaries("1");

########################## End Procedure call and function usage  End ###############################


######################################## Triggers usage #############################################

# Inserting incorrect department primary medic 
# who does not work in the same clinic of that deparment throws error
insert into Department(ClinicId, SpecializationId, PrimaryMedicEmployerPC)
values (2333, 234, "VZFSWM59L01B869R");


# Updating incorrect department primary medic 
# who does not work in the same clinic of that deparment does not change primary medic.
update Department D
set PrimaryMedicEmployerPC = "VZFSWM59L01B869R"
where D.ClinicId = 2333 and D.SpecializationId = 123

#################################### End Triggers usage End #########################################