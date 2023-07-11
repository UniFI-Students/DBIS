use ClinicsDB;

delete from DepartmentCurrentEmployment;
delete from Result;
delete from ClinicSchedule;
delete from EmployerSchedule;
delete from WorkSchedule;
delete from CurrentEmployment;
delete from PastEmployment;
delete from AppointmentBooking;
delete from Department;
delete from Medic;
delete from Administrator;
delete from Employer;
delete from Clinic;
delete from Patient;
delete from Specialization;
delete from Account;

############### TABLE POPULATION #########################
load data local infile "F:\\DBIS\\Tables CSV\\Account.csv" into table Account
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\Specialization.csv" into table Specialization
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\Employer.csv" into table Employer
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\Medic.csv" into table Medic
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\Administrator.csv" into table Administrator
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\Clinic.csv" into table Clinic
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\Patient.csv" into table Patient
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\CurrentEmployment.csv" into table CurrentEmployment
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\PastEmployment.csv" into table PastEmployment
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\AppointmentBooking.csv" into table AppointmentBooking
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\Department.csv" into table Department
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\DepartmentCurrentEmployment.csv" into table DepartmentCurrentEmployment
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\WorkSchedule.csv" into table WorkSchedule
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines
(Id, StartTime, EndTime, @Date, @DayOfTheWeek, Type)
set Date = nullif(@Date,''),
	DayOfTheWeek = nullif(@DayOfTheWeek,'');

load data local infile "F:\\DBIS\\Tables CSV\\ClinicSchedule.csv" into table ClinicSchedule
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

load data local infile "F:\\DBIS\\Tables CSV\\EmployerSchedule.csv" into table EmployerSchedule
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

############### END TABLE POPULATION END #########################
