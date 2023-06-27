# DBIS
Database and informational systems.

Richiesta del progetto

Il Sistema Sanitario Nazionale(S.S.N) ci ha chiesto di creare un database per un sito per 
gestire le prenotazioni delle visite.
Il sistema deve supportare l'accesso autorizato per distinguere tra medici, pazienti e amministratori.
Il paziente p-----
Il medico curante può disporre un orario  prenotazione della sua visita, specificando la clinica.

NEW PRE-VERSION

Il Sistema Sanitario Nazionale(S.S.N) ha chiesto la creazione di un sito per gestire le prenotazioni di visite da parte dei pazienti.
Un paziente può controllare sul sito gli orari dei medici, divisi per specializazioni, e può scegliere in quale clinica andare.
I pazienti devono inserire nel sistema , nome, cognome,  età , città di residenza , e codice fiscale.
Ogni medico è caratterizato da una specializazone,un codice identificativo, nome, cognome, età, codice fiscale.                // e un modo per identificare se è primario o no
Ogni medico può andare in più cliniche mentre il personale amministrativo è dipendente di un specifica clinica.
Le cliniche sono caratterizate da, un luogo, un numero di dipendenti e un orario , oltre che da  vari reparti, con un primario a gestione di ognuno di esso
Il sito è gestito da amministratori i quali posso modicificare, cancellare, o spostare le prenotazioni, su richiesta sia dei medici o dei pazienti.
Sia i medici che i dipendenti , se vogliono accedere come pazienti, devono creare un nuovo account.
I dati delle prenotazioni vengono salvati, e l’orario smette di essere disponibile per altre prenotazioni.
Ogni fine settimana la tabella delle prenotazioni viene resettata per essere disponibli per la settimana successiva.



REWRITED REQUEST VERSION

Il Sistema Sanitario Nazionale (S.S.N) chiede di implementare un sito per gestire le prenotazioni di visite da parte dei pazienti.

Il sito deve prevedere la possibilità di accesso di dottori, amministratori e pazienti trammite i suoi account.
Per avere l'acesso sul sito bisogna inserire il login e password.

I pazienti hanno nome, cognome,  età , città di residenza , e codice fiscale. Questi dati possono essere cambiati da qualsiasi amministratore.
Un paziente può controllare sul sito gli orari dei medici, divisi per specializazioni, e può scegliere in quale clinica andare.
Il paziente puo essere registrato nel sistema senza creare l'account per esso. Questo server per i casi specifici se il paziente sta in gravi condizioni e non era presenta in sistema prima.

Medici e amministratori sono lavoratori di qualche clinica\e.
I lavoratori hanno il codice fiscale, nome, cognome, età e il stipendio per la clinica dove lavora.
Ogni medico può lavorare in più cliniche mentre il personale amministrativo è dipendente di un specifica clinica.

Ogni medico ha il suo orario disponibile per le prenotazioni per la specifica clinica. Tal orario puo essere cambiato solo da amministratori della questa clinica.
Ogni medico è caratterizato da una specializazone.   

Amministratore e definito dal livello di amministrazione.
Ci sono due livelli di amministrazione. Uno serve per avere tutti le possibilità di modificare i dati del sistema(anche cancelare altri amministratori) e
l'altro per modicificare, cancellare, o spostare le prenotazioni, su richiesta sia dei medici o dei pazienti.
Se l'amministratore 'A' viene cancellato da un altro amministratore 'B', allora amministratore 'B' diventra risponsabile delle modifice dell'amministratore 'A' //così ho definito una procedura

Le cliniche sono caratterizate da, un luogo, un numero di dipendenti e un orario , oltre che da  vari reparti, con un medico primario a gestione di ognuno di esso

