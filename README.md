# Request for implementation of DB

Il Sistema Sanitario InterNazionale (S.S.I) chiede di implementare un sito per gestire le cliniche.

## Account

Il sito deve prevedere la possibilità di accesso di dottori, amministratori e pazienti trammite i loro account.
Per avere l'acesso al sito bisogna inserire i suoi login e password.

## Patient

I pazienti hanno nome, cognome, età , città di residenza , e codice fiscale.
> Questi dati possono essere cambiati da qualsiasi amministratore.

Un paziente può controllare sul sito gli orari dei medici, divisi per specializazioni, e può scegliere in quale clinica
andare.
Il paziente puo essere registrato nel sistema senza creare l'account per esso.
> Questo serve per i casi specifici se il paziente sta in gravi condizioni e non era presenta nel sistema prima.

## Employer

In ogni clinica ci sono i lavoratori.
Qualchuno di essi sono medici oppure amministratori.
I lavoratori hanno il codice fiscale, nome, cognome, età.
Non tutti i lavoratori hanno bisogno di avere l`account per se.
Soltanto i medici e amministratori per avere accesso al sito devono avere i suoi account.
Ogni medico può lavorare in più cliniche mentre il personale amministrativo è dipendente di una specifica clinica.

## Medic

Ogni medico ha il suo orario disponibile per le prenotazioni per la specifica clinica. Tal orario puo essere cambiato
solo da amministratori di quella clinica.
Ogni medico è caratterizato da una specializazone.

## Administrator

Amministratore è definito dal livello di amministrazione.
Ci sono due livelli di amministrazione. Uno serve per avere la possibilità di modificare tutti i dati del sistema(anche
cancelare altri amministratori) e
l'altro solo per modicificare, cancellare, o spostare le prenotazioni, su richiesta sia dei medici o dei pazienti, e i
dati dei pazienti.

## Clinic

Le cliniche sono caratterizate da: un luogo, un orario , e dai reparti.
Nella clinica si può tenere traccia dei dipendenti presenti e quelli passati, dei quali si sa anche la data di
licenziamento.
La clinica paga uno stpendio ad ogni lavoratore corrente.

## Department

Ogni reparto ha un medico primario e i medici che lavorono li.
Ogni reparto è definito per la sua specializzazione, e solo medici con quella specializzazione possono lavorarci.
Un medico non può appartenere a 2 reparti diversi della stessa clinica.

## Result

i risultati devono riportare: il paziente, la data, il medico e la clinca, e un documento sul risultato

## Appointment Booking

Tutti gli pazienti aventi gli account possono fare le prenotazioni per le visite ai medici in qualche clinica
desiderata.
Il tempo di prenotazione e gestito sia dai medici che dai amministratori di clininca dove lavora tal medico.

## List of interrogations on those entities

1) Per calcolare il numero di dipendenti, conviene sommare il numero di admin e medici oppure tenere un attributo
   apposito?
2) Per calcolare il numero di primari, basta vedere il numero di reparto
3) Le cliniche hanno lo stesso orario?
4) Quanti sono i pazienti che hanno una clinica nella propria residenza
5) Conviene tenere un attributo per il costo totale degli stipendi, o derivarlo dalla somma di tutti i dipendenti
6) Il paziente è già stato inserito nel sistema?

## Entity Relationship graphical schemes

### Entity Relationship graphical scheme

![Alt text](Entity_Relationship_Scheme.png?raw=true "ER Scheme")

### Translated Entity Relationship graphical scheme

![Alt text](Translated_ER_Scheme.png?raw=true "Translated ER Scheme")

## Translated Entity Relationship scheme

### Entity tables

1. Patient(**PC**, Name, Surname, Age, Street, City, Country, PostCode, *AccountId**
2. Employer(**PC**, Name, Surname, Age, *AccountId**)
3. Medic(***EmployerPC***, Specialization)
4. Administrator(***EmployerPC***, AdministrationType)
5. Account(**Id**, Login, Password, Type)
6. CurrentEmployment(***EmployerPC***, **StartDate**, *ClinicId*, *DepSpecialization*, Salary)
7. PastEmployment(***EmployerPC***, **StartDate**, *ClinicId*, DismissalDate)
8. Clinic(**Id**, Street, City, Country, PostCode)
9. Department(***ClinicId***, **Specialization**, *PrimaryMedicEmployerPC*)
10. WorkSchedule(**Id**, StartTime, EndTime, Day*, DayOfTheWeek*)
11. Result(**Date**, ***ClinicId***, ***MedicEmployerPC***, ***PatientPC***, Document)
12. AppointmentBooking(**DateTime**, ***ClinicId***, ***MedicEmployerPC***, *PatientPC**)

### Relationship tables

1. EmployerSchedule(*CurrEmployerPC*, *CurrEmployerStartDate*, *WorkScheduleId*)
2. ClinicSchedule(*ClinicId*, *WorkScheduleId*)

### Reference keys

1. Patient.AccountId → Account.Id
2. Employer.AccountId → Account.Id
3. Medic.EmployerPC → Employer.PC
4. Administrator.EmployerPC → Employer.PC
5. CurrentEmployment.EmployerPC → Employer.PC
6. CurrentEmployment.ClinicId → Clinic.Id
7. CurrentEmployment.DepSpecialization → Department.Specialization
8. PastEmployment.EmployerPC → Employer.PC
9. PastEmployment.ClinicId → Clinic.Id
10. Department.ClinicId → Clinic.Id
11. Department.PrimaryMedicEmployerPC → Medic.EmployerPC
12. Result.ClinicId → Clinic.Id
13. Result.MedicEmployerPC → Medic.EmployerPC
14. Result.PatientPC → Patient.PC
15. AppointmentBooking.ClinicId → Clinic.Id
16. AppointmentBooking.MedicEmployerPC → Medic.EmployerPC
17. AppointmentBooking.PatientPC → Patient.PC