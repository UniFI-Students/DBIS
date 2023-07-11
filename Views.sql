##################### VISITS #############################


drop view if exists ItalianClinic;
create view ItalianClinic as
	select * from Clinic C
		where C.Country="Italia";
        
################## END VISITS END ##################