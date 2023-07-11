################  insterting values into tables  #################


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

insert into Administrator value
('QXPDGC79T24H825O', 1),
('TMNGMF49C66D010V', 2),
('RZNMGK33P56C484V', 3),
('WHBCWS98R59A108X', 1),
('THXHMD53A30I981C', 3);

insert into AppointmentBooking values
('7.10.23 9:00', 2333, 'RPEZFP37R21A013O', 'PXPPJC36L03D727A'), 
('7.11.23 11:00', 2321, 'LFLQYL81M25L059Z', 'DZVZRP50E31I263L'),
('8.11.23 15:00', 5456, 'VZFSWM59L01B869R', 'YSBDDK77E08A573L'),
('8.12.23 18:00', 7665, 'HJRGPF33H24A848Y', 'MSFMLD67T18I145T'),
('8.12.23 12:00', 7678, 'PFMKQH87D51D856Z', 'FQDJQC86H08E892V');

insert into Clinic values
(2333, 'Highgrove Corner', 'Firenze', 'Italia', 50100),
(2321, 'Heighton Close', 'Parigi', 'Francia', 12444),
(5456, 'Hogarth Fold', 'Mosca', 'Russia', 23334),
(7665, 'Runton Road', 'Pechino', 'Cina', 54427),
(7678, 'Wentcliffe Road', 'Tokyo', 'Giappone', 76653),
(3445, 'Windley Road', 'Milano', 'Italia', 20100);

insert into ClinicSchedule values

(2333, 1),
(2321, 2),
(5456, 3),
(7665, 4),
(7678, 5),
(3445, 6);

insert into CurrentEmployment values

('THXHMD53A30I981C', 2333, 2010-11-10, 1500),
('RPEZFP37R21A013O', 5456, 2020-10-07, 1200),
('LFLQYL81M25L059Z', 7678, 1982-09-15, 2000),
('VZFSWM59L01B869R', 7665, 2021-03-09, 3000),
('HJRGPF33H24A848Y', 2333, 2007-05-08, 1500),
('PFMKQH87D51D856Z', 5456, 2005-06-03, 2500),
('QXPDGC79T24H825O', 7678, 2012-08-12, 1800);

insert into Department values 
(5456, 234, 'RPEZFP37R21A013O'),
(7665, 879, 'VZFSWM59L01B869R'),
(2333, 123, 'HJRGPF33H24A848Y');

insert into DepartmentCurrentEmployment values

('THXHMD53A30I981C', 2010-11-10 ,2333, 123),
('RPEZFP37R21A013O', 2020-10-07, 5456, 234),
('VZFSWM59L01B869R', 2021-03-09, 7665, 879),
('HJRGPF33H24A848Y', 2007-05-08, 2333, 123),
('PFMKQH87D51D856Z', 2005-06-03, 5456, 234);

insert into Employer values 

('RPEZFP37R21A013O', 'giuseppe', 'roberti',1981-03-11, 332),
('LFLQYL81M25L059Z', 'alessia', 'mesa', 1978-04-09, 656),
('VZFSWM59L01B869R', 'roberta', 'tissoni', 1991-02-09, 678),
('HJRGPF33H24A848Y', 'maria', 'wu', 2002-08-23, 876),
('PFMKQH87D51D856Z', 'giulia', 'ster', 1996-12-02, 544),
('QXPDGC79T24H825O', 'maria', 'itto', 1995-11-07, 555),
('TMNGMF49C66D010V', 'marta', 'reli', 1982-12-06, 783),
('RZNMGK33P56C484V', 'giulio', 'barella', 1934-01-05, 676),
('WHBCWS98R59A108X', 'roberto', 'koss', 1963-10-06, 878),
('THXHMD53A30I981C', 'maya', 'bailey', 2003-05-12, 122),
('CLRQHB75P26I054T', 'sage', 'morgan', 2001-12-07, 458);

insert into EmployerSchedule values

('THXHMD53A30I981C', 2010-11-10, 2333, 1),
('RPEZFP37R21A013O', 2020-10-07, 5456, 2),
('LFLQYL81M25L059Z', 1982-09-15, 7678, 3),
('VZFSWM59L01B869R', 2021-03-09, 7665, 4),
('HJRGPF33H24A848Y', 2007-05-08, 2333, 5),
('PFMKQH87D51D856Z', 2005-06-03, 5456, 6),
('QXPDGC79T24H825O', 2012-08-12, 7678, 7);

insert into Medic values
('RPEZFP37R21A013O', 234),
('LFLQYL81M25L059Z', 324),
('VZFSWM59L01B869R', 879),
('HJRGPF33H24A848Y', 123),
('PFMKQH87D51D856Z', 234),
('CLRQHB75P26I054T', 879);

insert into PastEmployment values 

('TMNGMF49C66D010V', 5456, 1999-12-10, 2005-11-07),
('RZNMGK33P56C484V', 7665, 2001-01-06, 2015-02-25),
('WHBCWS98R59A108X', 7678, 1982-07-08, 2001-06-03),
('THXHMD53A30I981C', 2333, 1971-05-22, 1984-02-15),
('THXHMD53A30I981C', 2333, 1989-11-06, 1995-04-12);

insert into Patient value

('PXPPJC36L03D727A', 'mario', 'Rabelli', 1973-10-15, 'rossi', 'Berlino', 'Germania', 32145, 123),
('DZVZRP50E31I263L', 'alberto', 'Erri', 1965-07-12, 'washington', 'New york', 'USA', 23112, 132),
('YSBDDK77E08A573L', 'sara', 'lusi', 2000-03-22, 'colle', 'Minsk', 'Bielorussia', 23445, 453),
('MSFMLD67T18I145T', 'elisa', 'mesa', 1999-08-03, '52nd', 'Firenze', 'Italia', 50100, 233),
('FQDJQC86H08E892V', 'marco', 'caloto', 1923-05-12, 'rei', 'Roma', 'Slovenia', 42233, 435);

insert into result values

(2023-07-25, 2333, 'RPEZFP37R21A013O', 'PXPPJC36L03D727A', 'guarito'),
(2023-07-25, 2321, 'LFLQYL81M25L059Z', 'DZVZRP50E31I263L', 'coma'),
(2023-07-27, 5456, 'VZFSWM59L01B869R', 'YSBDDK77E08A573L', 'sta recuperando'),
(2023-07-28, 7665, 'HJRGPF33H24A848Y', 'MSFMLD67T18I145T', 'guarito'),
(2023-07-30, 7678, 'PFMKQH87D51D856Z', 'FQDJQC86H08E892V', 'guarito'); # ultima sezione era vuota

insert into specialization values

(123, 'chirurgia'),
(324, 'Pronto intervento'),
(234, 'dermatologia'),
(657, 'psichiatria'),
(546, 'ematologia'),
(879, 'neurologia');

insert into WorkSchedule values

(1, '08:00', '22:00', 2023-07-24, null , 1),
(2, '08:00', '22:00', 2023-07-25, null , 1),
(3, '08:00', '22:00', null , 3, 2),
(4, '08:00', '22:00', null, 4, 2),
(5, '08:00', '22:00', 2023-07-28, null, 1),
(6, '09:00', '23:00', null, 6, 2),
(7, '09:00', '23:00', 2023-07-30, null, 1); # se non metto null mi da errore


################ End insterting values into tables End  #################







