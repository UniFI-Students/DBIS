#Creating Database

drop database if exists ClinicsDB;
create database ClinicsDB;
use ClinicsDB;


#Creating Tables

#Entities:

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

#Relationships:

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