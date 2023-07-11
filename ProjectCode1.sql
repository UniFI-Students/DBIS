########################## 	 DATABASE CREATION    ##########################

drop database if exists ClinicsDB;
create database ClinicsDB;
use ClinicsDB;

###########################   TABLES CREATION   ########################### 


################################ ENTITIES ################################

create table if not exists Account(
	Id int primary key,
	Login char(32) not null,
	Password int not null,
	Type enum('Patient','Employer') not null
) engine=innoDB;

create table if not exists Clinic(
	Id int primary key,
	Street char (64) not null,
	City char(64) not null,
	Country char(64) not null,
	PostCode int not null
) engine=innoDB;

create table if not exists Specialization(
	Id int primary key,
	Name char(32) not null
) engine=innoDB;

create table if not exists Patient(
	PC char(16) primary key,
	Name char(16) not null,
	Surname char(16) not null,
	BirthDate date not null,     
	Street char (64) not null,
	City char(64) not null,
	Country char(64) not null,
	PostCode int not null,
	AccountId int,
	foreign key (AccountId) references Account(Id)
) engine=innoDB;

create table if not exists Employer(
	PC char(16) primary key,
	Name char(10) not null,
	Surname char(10) not null,
	BirthDate date not null,
	AccountId int,
	foreign key (AccountId) references Account(Id)
) engine=innoDB;

create table if not exists Medic(
	EmployerPC char(16) primary key,
	SpecializationId int,
	foreign key (EmployerPC) references Employer(PC),
	foreign key (SpecializationId) references Specialization(Id)
) engine=innoDB;

create table if not exists Administrator(
	EmployerPC char(16) primary key,
	AdministratorType int not null,
	foreign key (EmployerPC) references Employer(PC)
) engine=innoDB;

create table if not exists CurrentEmployment(
	EmployerPC char(16) not null,
	ClinicId int not null,
	StartDate date not null,
	Salary int,
	primary key (EmployerPC, StartDate, ClinicId),
	foreign key (EmployerPC) references Employer(PC),
	foreign key (ClinicId) references Clinic(Id)
) engine=innoDB;

create table if not exists PastEmployment(
	EmployerPC char(16) not null,
	ClinicId int not null,
	StartDate date not null,
	DismissalDate date,
	primary key (EmployerPC, StartDate, ClinicId),
	foreign key (EmployerPC) references Employer(PC),
	foreign key (ClinicId) references Clinic(Id)
) engine=innoDB;

create table if not exists Department(
	ClinicId int not null,
	SpecializationId int not null,
	PrimaryMedicEmployerPC char(16) not null,
	primary key (ClinicId, SpecializationId),
	foreign key (ClinicId) references Clinic(Id),
	foreign key (SpecializationID) references Specialization(Id),
	foreign key (PrimaryMedicEmployerPC) references Medic(EmployerPC)
) engine=innoDB;

create table WorkSchedule(
	Id int primary key,
	StartTime time not null,
	EndTime time not null,
	Date date,
	DayOfTheWeek enum('MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'),
	Type enum('Week', 'Date') not null
) engine=innoDB;

create table if not exists Result(
	Date date not null,
	ClinicId int not null,
	MedicEmployerPC char(16) not null,
	PatientPC char(16) not null,
	Document varchar(256) not null,
	primary key (Date, ClinicId, MedicEmployerPC, PatientPC),
	foreign key (ClinicId) references Clinic(Id),
	foreign key (MedicEmployerPC) references Medic(EmployerPC),
	foreign key (PatientPC) references Patient(PC)
) engine=innoDB;

create table if not exists AppointmentBooking(
	DateTime datetime not null,
	ClinicId int not null,
	MedicEmployerPC char(16) not null,
	PatientPC char(16),
	primary key (DateTime, ClinicId, MedicEmployerPC),
	foreign key (ClinicId) references Clinic(Id),
	foreign key (MedicEmployerPC) references Medic(EmployerPC),
	foreign key (PatientPC) references Patient(PC)
) engine=innoDB;

############################ RELATIONSHIP ############################

create table if not exists EmployerSchedule(
	CurrEmployerPC char(16) not null,
	CurrEmployerStartDate date not null,
	CurrEmployerClinicId int not null,
	WorkScheduleId int not null,
	primary key (CurrEmployerPC, CurrEmployerStartDate, CurrEmployerClinicId, WorkScheduleId),
	foreign key (CurrEmployerPC, CurrEmployerStartDate, CurrEmployerClinicId) references CurrentEmployment(EmployerPC, StartDate, ClinicId),
	foreign key (WorkScheduleId) references WorkSchedule(Id)
) engine=innoDB;

create table if not exists ClinicSchedule(
	ClinicId int not null,
	WorkScheduleId int not null,
	primary key (ClinicId, WorkScheduleId),
	foreign key (ClinicId) references Clinic(Id),
	foreign key (WorkScheduleId) references WorkSchedule(Id)
) engine=innoDB;

create table if not exists DepartmentCurrentEmployment(
	CEEmployerPC char(16) not null,
	CEStartDate date not null,
	ClinicId int not null,
	DepSpecializationId int not null,
	primary key (CEEmployerPC, CEStartDate, ClinicId, DepSpecializationID),
	foreign key (CEEmployerPC, CEStartDate, ClinicId) references CurrentEmployment(EmployerPC, StartDate, ClinicId),
	foreign key (ClinicId, DepSpecializationId) references Department(ClinicID, SpecializationId)
) engine=innoDB;

######################### END TABLE CREATION END #########################


###########################  TABLE POPULATION  ###########################


insert into Account value

(123, 'mario', 321, 1),
(132, 'alberto', 231, 1),
(453, 'sara ',354, 1),
(233, 'elisa', 332, 1),
(435, 'marco', 534, 1),
(332, 'giuseppe', 233, 2),
(656, 'alessia', 656, 2),
(678, 'roberta', 876, 2),
(876, 'maria', 678, 2),
(544, 'giulia', 445, 2),
(555, 'maria', 235, 2),
(783, 'marta', 887, 2),
(676, 'giulio', 121, 2),
(878, 'roberto', 789, 2),
(122, 'maya', 445, 2),
(458, 'sage', 448, 2);

insert into Clinic values
(2333, 'Highgrove Corner', 'Firenze', 'Italia', 50100),
(2321, 'Heighton Close', 'Parigi', 'Francia', 12444),
(5456, 'Hogarth Fold', 'Mosca', 'Russia', 23334),
(7665, 'Runton Road', 'Pechino', 'Cina', 54427),
(7678, 'Wentcliffe Road', 'Tokyo', 'Giappone', 76653),
(3445, 'Windley Road', 'Milano', 'Italia', 20100);

insert into specialization values

(123, 'chirurgia'),
(324, 'Pronto intervento'),
(234, 'dermatologia'),
(657, 'psichiatria'),
(546, 'ematologia'),
(879, 'neurologia');

insert into Patient value

('PXPPJC36L03D727A', 'mario', 'Rabelli', "1973-10-15", 'rossi', 'Berlino', 'Germania', 32145, 123),
('DZVZRP50E31I263L', 'alberto', 'Erri', "1965-07-12", 'washington', 'New york', 'USA', 23112, 132),
('YSBDDK77E08A573L', 'sara', 'lusi'," 2000-03-22", 'colle', 'Minsk', 'Bielorussia', 23445, 453),
('MSFMLD67T18I145T', 'elisa', 'mesa', "1999-08-03", '52nd', 'Firenze', 'Italia', 50100, 233),
('FQDJQC86H08E892V', 'marco', 'caloto', "1923-05-12", 'rei', 'Roma', 'Slovenia', 42233, 435);

insert into Employer values 

('RPEZFP37R21A013O', 'giuseppe', 'roberti',"1981-03-11", 332),
('LFLQYL81M25L059Z', 'alessia', 'mesa', "1978-04-09", 656),
('VZFSWM59L01B869R', 'roberta', 'tissoni', "1991-02-09", 678),
('HJRGPF33H24A848Y', 'maria', 'wu', "2002-08-23", 876),
('PFMKQH87D51D856Z', 'giulia', 'ster', "1996-12-02", 544),
('QXPDGC79T24H825O', 'maria', 'itto', "1995-11-07", 555),
('TMNGMF49C66D010V', 'marta', 'reli', "1982-12-06", 783),
('RZNMGK33P56C484V', 'giulio', 'barella', "1934-01-05", 676),
('WHBCWS98R59A108X', 'roberto', 'koss', "1963-10-06", 878),
('THXHMD53A30I981C', 'maya', 'bailey', "2003-05-12", 122),
('CLRQHB75P26I054T', 'sage', 'morgan', "2001-12-07", 458);

insert into Medic values
('RPEZFP37R21A013O', 234),
('LFLQYL81M25L059Z', 324),
('VZFSWM59L01B869R', 879),
('HJRGPF33H24A848Y', 123),
('PFMKQH87D51D856Z', 234),
('CLRQHB75P26I054T', 879);

insert into Administrator value
('QXPDGC79T24H825O', 1),
('TMNGMF49C66D010V', 2),
('RZNMGK33P56C484V', 3),
('WHBCWS98R59A108X', 1),
('THXHMD53A30I981C', 3);

insert into CurrentEmployment values

('THXHMD53A30I981C', 2333, "2010-11-10", 1500),
('RPEZFP37R21A013O', 5456, "2020-10-07", 1200),
('LFLQYL81M25L059Z', 7678, "1982-09-15", 2000),
('VZFSWM59L01B869R', 7665, "2021-03-09", 3000),
('HJRGPF33H24A848Y', 2333, "2007-05-08", 1500),
('PFMKQH87D51D856Z', 5456, "2005-06-03", 2500),
('QXPDGC79T24H825O', 7678, "2012-08-12", 1800);

insert into PastEmployment values 

('TMNGMF49C66D010V', 5456, "2001-01-06", "2015-02-25"),
('WHBCWS98R59A108X', 7678, "1982-07-08", "2001-06-03"),
('THXHMD53A30I981C', 2333, "1971-05-22", "1984-02-15"),
('THXHMD53A30I981C', 2333, "1989-11-06", "1995-04-12");

insert into Department values 
(5456, 234, 'RPEZFP37R21A013O'),
(7665, 879, 'VZFSWM59L01B869R'),
(2333, 123, 'HJRGPF33H24A848Y');

insert into WorkSchedule values

(1, '08:00', '22:00', "2023-07-24", null , 1),
(2, '08:00', '22:00', "2023-07-25", null , 1),
(3, '08:00', '22:00', null , 3, 2),
(4, '08:00', '22:00', null, 4, 2),
(5, '08:00', '22:00', "2023-07-28", null, 1),
(6, '09:00', '23:00', null, 6, 2),
(7, '09:00', '23:00', "2023-07-30", null, 1); 

insert into result values

("2023-07-25", 2333, 'RPEZFP37R21A013O', 'PXPPJC36L03D727A', 'guarito'),
("2023-07-25", 2321, 'LFLQYL81M25L059Z', 'DZVZRP50E31I263L', 'coma'),
("2023-07-27", 5456, 'VZFSWM59L01B869R', 'YSBDDK77E08A573L', 'sta recuperando'),
("2023-07-28", 7665, 'HJRGPF33H24A848Y', 'MSFMLD67T18I145T', 'guarito'),
("2023-07-30", 7678, 'PFMKQH87D51D856Z', 'FQDJQC86H08E892V', 'guarito'); 


insert into AppointmentBooking values
("7.10.23 9:00", 2333, 'HJRGPF33H24A848Y', 'PXPPJC36L03D727A'), 
("7.11.23 11:00", 2321, 'PFMKQH87D51D856Z', 'YSBDDK77E08A573L'),
("8.11.23 15:00", 5456, 'VZFSWM59L01B869R', 'MSFMLD67T18I145T'),
("8.12.23 18:00", 7665, 'LFLQYL81M25L059Z', 'FQDJQC86H08E892V');

insert into EmployerSchedule values

('THXHMD53A30I981C', "2010-11-10", 2333, 1),
('RPEZFP37R21A013O', "2020-10-07", 5456, 2),
('LFLQYL81M25L059Z', "1982-09-15", 7678, 3),
('VZFSWM59L01B869R', "2021-03-09", 7665, 4),
('HJRGPF33H24A848Y', "2007-05-08", 2333, 5),
('PFMKQH87D51D856Z', "2005-06-03", 5456, 6),
('QXPDGC79T24H825O', "2012-08-12", 7678, 7);


insert into ClinicSchedule values

(2333, 1),
(2321, 2),
(5456, 3),
(7665, 4),
(7678, 5),
(3445, 6);

insert into DepartmentCurrentEmployment values

('THXHMD53A30I981C', "2010-11-10" ,2333, 123),
('RPEZFP37R21A013O', "2020-10-07", 5456, 234),
('VZFSWM59L01B869R', "2021-03-09", 7665, 879),
('HJRGPF33H24A848Y', "2007-05-08", 2333, 123),
('PFMKQH87D51D856Z', "2005-06-03", 5456, 234);




#################### TABLES POPULATION  ####################


########################## VISITS ##########################


drop view if exists ItalianClinic;
create view ItalianClinic as
	select * from Clinic C
		where C.Country="Italia";
        
###################### END VISITS END ###################### 

#####################  INTERROGATION #######################

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


############################## END INTERROGATION END #######################################

############################    TRIGGERS DEFINITION   ######################################

#Triggers when inserting an a work schedule with type.
#Sets Date to null if type is Week, otherwise will set DayOfTheWeek to null.
drop trigger if exists AdjustValuesForWorkScheduleOnInsertTrigger;
DELIMITER $$
create trigger AdjustValuesForWorkScheduleOnInsertTrigger
before insert on WorkSchedule
for each row
begin
	case new.Type
		when "Week" then set new.Date = null;
        when "Date" then set new.DayOfTheWeek = null;
	end case;
end $$
DELIMITER ;

#Triggers when updating an a work schedule with type.
#Sets Date to null if type is Week, otherwise will set DayOfTheWeek to null.
drop trigger if exists AdjustValuesForWorkScheduleOnUpdateTrigger;
DELIMITER $$
create trigger AdjustValuesForWorkScheduleOnUpdateTrigger
before update on WorkSchedule
for each row
begin
	case new.Type
		when "Week" then set new.Date = null;
        when "Date" then set new.DayOfTheWeek = null;
	end case;
end $$
DELIMITER ;

#Triggers when inserting an a department with primary medic who does not work in the clinic of this department.
#Throws sql error.
drop trigger if exists InsertingIncorrectPrimaryMedicInDepartmentTrigger;
DELIMITER $$
create trigger InsertingIncorrectPrimaryMedicInDepartmentTrigger
before insert on Department
for each row
begin
	if (select count(*) from CurrentEmployment CE 
			where 	CE.ClinicId = new.ClinicId and 
					CE.EmployerPC = new.PrimaryMedicEmployerPC) = 0
	then 	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Specified Primary medic does not work in a clinic of the specified department.departmentcurrentemployment';
    end if; 
end $$
DELIMITER ;

#Triggers when updating an a department with primary medic who does not work in the clinic of this department.
#Sets primary medic reference to a previous primary medic.
drop trigger if exists UpdatingToIncorrectPrimaryMedicInDepartmentTrigger;
DELIMITER $$
create trigger UpdatingToIncorrectPrimaryMedicInDepartmentTrigger
before update on Department
for each row
begin
	if (select count(*) from CurrentEmployment CE 
			where 	CE.ClinicId = new.ClinicId and 
					CE.EmployerPC = new.PrimaryMedicEmployerPC) = 0
	then set new.PrimaryMedicEmployerPC = old.PrimaryMedicEmployerPC;
    end if; 
end $$
DELIMITER ;

#Triggers when inserting an a result with medic who does not currently work in the specified clinic
#Throws sql error.
drop trigger if exists InsertingIncorrectMedicClinicInResultTrigger;
DELIMITER $$
create trigger InsertingIncorrectMedicClinicInResultTrigger
before insert on Result
for each row
begin
	if (select count(*) from CurrentEmployment CE 
			where 	CE.ClinicId = new.ClinicId and 
					CE.EmployerPC = new.MedicEmployerPC) = 0
	then 	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Specified Primary medic does not work in the specified clinic';
    end if; 
end $$
DELIMITER ;

#Triggers when inserting an a appoinment booking with medic who does not currently work in the specified clinic
#Throws sql error.
drop trigger if exists InsertingIncorrectMedicClinicInAppointmentBookingTrigger;
DELIMITER $$
create trigger InsertingIncorrectMedicClinicInAppointmentBookingTrigger
before insert on appointmentbooking
for each row
begin
	if (select count(*) from CurrentEmployment CE 
			where 	CE.ClinicId = new.ClinicId and 
					CE.EmployerPC = new.MedicEmployerPC) = 0
	then 	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Specified Primary medic does not work in the specified clinic';
    end if; 
end $$
DELIMITER ;

################################# END TRIGGER DEFINITION END ##################################


######################################## TRIGGER USAGE ########################################

# Inserting incorrect department primary medic 
# who does not work in the same clinic of that deparment throws error
insert into Department(ClinicId, SpecializationId, PrimaryMedicEmployerPC)
values (2333, 234, "VZFSWM59L01B869R");


# Updating incorrect department primary medic 
# who does not work in the same clinic of that deparment does not change primary medic.
update Department D
set PrimaryMedicEmployerPC = "VZFSWM59L01B869R"
where D.ClinicId = 2333 and D.SpecializationId = 123;

#################################### END TRIGGER USAGE END #####################################

########################################  PROCEDURESA ##########################################

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
###################################### 	END PROCEDURES END #######################################


#########################################    FUNCTIONS   #########################################
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

##################################   END FUNCTIONS END   ####################################

#############################   PROCEDURE AND FUNCTION CALL   ###############################

call ClinicsDB.CancelAppoinmentBooking(date("2023-07-10"), "1", "1", "1");

call ClinicsDB.ListClinicWithTheSumOfPaidSalaries();
#Alternative for previous procedure call by using function call and select statement
select *, ClinicsDB.GetClinicSumOfThePaidSalaries(C.Id) from Clinic C;

call ClinicsDB.ListWorkScheduleOfTheClinic("1", 30, date("2023-07-10"));

select ClinicsDB.GetClinicSumOfThePaidSalaries("1");

########################## END PROCEDURES AND FUNCTIONS USAGE END  ###############################


