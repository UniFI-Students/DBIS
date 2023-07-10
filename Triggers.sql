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