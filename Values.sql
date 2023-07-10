delete from AppointmentBooking;
delete from CurrentEmployment;
delete from Medic;
delete from Employer;
delete from Clinic;
delete from Patient;

insert into Employer (PC, Name, Surname, BirthDate, AccountId)
values 	("1", "MName", "MSurname", date("2023-07-10"), null),
		("2", "MName", "MSurname", date("2023-07-10"), null);

insert into Medic (EmployerPC, SpecializationId)
values 	("1", null),
		("2", null);

insert into Clinic (Id, Street, City, Country, PostCode)
values (1, "CStreet", "CCity", "CCountry", 1);

insert into Patient (PC, Name, Surname, BirthDate, Street, City, Country, PostCode, AccountId)
values ("1", "PName", "PSurname", date("2023-07-09"), "PStreet", "PCity", "PCountry", 2, null);

insert into AppointmentBooking(DateTime, ClinicId, MedicEmployerPC, PatientPC)
values (date("2023-07-10"), 1, "1", "1");

insert into CurrentEmployment(EmployerPC, ClinicId, StartDate, Salary)
values 	("1", "1", date("2021-07-10"), 15),
		("2", "1", date("2021-07-10"), 15);
		