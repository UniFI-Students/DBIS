#Creating Database

DROP DATABASE IF EXISTS ClinicsDB;
CREATE DATABASE ClinicsDB;
USE ClinicsDB;


#Creating Tables

#Entities:

create table if not exists Account(
	Id int primary key,
	Login char(10) not null,
	Password int not null,
	Type enum('Patient','Employer') not null
) engine=innoDB;

create table if not exists Clinic(
	ID int primary key,
	Street char (15) not null,
	City char(10) not null,
	Country char(10) not null,
	PostCode int not null
) engine=innoDB;

create table if not exists Specialization(
	ID int primary key,
	Name char(10) not null
) engine=innoDB;

create table if not exists Patient(
	PC char(16) primary key,
	Name char(10) not null,
	Surname char(10) not null,
	BirthDate date not null,     
	Street char (15) not null,
	City char(10) not null,
	Country char(10) not null,
	PostCode int not null,
	AccountId int,
	foreign key (AccountId) references Account(ID)
) engine=innoDB;

create table if not exists Employer(
	PC char(16) primary key,
	Name char(10) not null,
	Surname char(10) not null,
	BirthDate date not null,
	AccountId int,
	foreign key (AccountId) references Account(ID)
) engine=innoDB;

create table if not exists Medic(
	EmployerPC char(16) primary key,
	SpecializationID int not null,
	foreign key (EmployerPC) references Employer(PC),
	foreign key (SpecializationID) references Specialization(ID)
) engine=innoDB;

create table if not exists Administrator(
	EmployerPC char(16) primary key,
	AdministratorType int not null,
	foreign key (EmployerPC) references Employer(PC)
) engine=innoDB;

create table if not exists CurrentEmployment(
	EmployerPC char(16) not null,
	ClinicID int not null,
	StartDate date not null,
	Salary int,
	primary key (EmployerPC, StartDate, ClinicID),
	foreign key (EmployerPC) references Employer(PC),
	foreign key (ClinicID) references Clinic(ID)
) engine=innoDB;

create table if not exists PastEmployment(
	EmployerPC char(16) not null,
	ClinicID int not null,
	StartDate date not null,
	DismissalDate date,
	primary key (EmployerPC,StartDate,ClinicID),
	foreign key (EmployerPC) references Employer(PC),
	foreign key (ClinicID) references Clinic(ID)
) engine=innoDB;

create table if not exists Department(
	ClinicID int not null,
	SpecializationID int not null,
	PrimaryMedicEmployerPC char(16) not null,
	primary key (ClinicID,SpecializationID),
	foreign key (ClinicID) references Clinic(ID),
	foreign key (SpecializationID) references Specialization(ID),
	foreign key (PrimaryMedicEmployerPC) references Medic(EmployerPC)
) engine=innoDB;

create table WorkSchedule(
	ID int primary key,
	StartTime time not null,
	EndTime time not null,
	Date date,
	DayOfTheWeek enum('MON','TUE','WED','THU','FRI','SAT','SUN'),
	Type enum('Daily work schedule','Week daily work schedule') not null
) engine=innoDB;

create table if not exists Result(
	Date date not null,
	ClinicID int not null,
	MedicEmployerPC char(16) not null,
	PatientPC char(16) not null,
	Document varchar(256) not null,
	primary key (Date, ClinicID, MedicEmployerPC, PatientPC),
	foreign key (ClinicID) references Clinic(ID),
	foreign key (MedicEmployerPC) references Medic(EmployerPC),
	foreign key (PatientPC) references Patient(PC)
) engine=innoDB;

create table if not exists AppointmentBooking(
	DateTime datetime not null,
	ClinicID int not null,
	MedicEmployerPC char(16) not null,
	PatientPC char(16),
	primary key (DateTime,ClinicID,MedicEmployerPC),
	foreign key (ClinicID) references Clinic(ID),
	foreign key (MedicEmployerPC) references Medic(EmployerPC),
	foreign key (PatientPC) references Patient(PC)
) engine=innoDB;

#Relationships:

create table if not exists EmployerSchedule(
	CurrEmployerPC char(16) not null,
	CurrEmployerStartDate date not null,
	CurrEmployerClinicID int not null,
	WorkScheduleID int not null,
	primary key (CurrEmployerPC, CurrEmployerStartDate, CurrEmployerClinicID, WorkScheduleID),
	foreign key (CurrEmployerPC, CurrEmployerStartDate, CurrEmployerClinicID) references CurrentEmployment(EmployerPC, StartDate, ClinicID),
	foreign key (WorkScheduleID) references WorkSchedule(ID)
) engine=innoDB;

create table if not exists ClinicSchedule(
	ClinicID int not null,
	WorkScheduleID int not null,
	primary key (ClinicID,WorkScheduleID),
	foreign key (ClinicID) references Clinic(ID),
	foreign key (WorkScheduleID) references WorkSchedule(ID)
) engine=innoDB;

create table if not exists DepartmentCurrentEmployment(
	CEEmployerPC char(16) not null,
	CEStartDate date not null,
	ClinicID int not null,
	DepSpecializationID int not null,
	primary key (CEEmployerPC,CEStartDate,ClinicID,DepSpecializationID),
	foreign key (CEEmployerPC, CEStartDate, ClinicID) references CurrentEmployment(EmployerPC, StartDate, ClinicID),
	foreign key (ClinicID, DepSpecializationID) references Department(ClinicID, SpecializationID)
) engine=innoDB;