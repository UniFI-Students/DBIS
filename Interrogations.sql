######################################## Interrogations #############################################




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