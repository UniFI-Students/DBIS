# DBIS
Database and informational systems.

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

Il Sistema Sanitario Nazionale (S.S.N) chiede di implementare un sito per gestire le cliniche.

[Account]
Il sito deve prevedere la possibilità di accesso di dottori, amministratori e pazienti trammite i loro account.
Per avere l'acesso al sito bisogna inserire l' ID e password.

[Patient]
I pazienti hanno nome, cognome,  età , città di residenza , e codice fiscale. /* Funzionamento */ Questi dati possono essere cambiati da qualsiasi amministratore.
Un paziente può controllare sul sito gli orari dei medici, divisi per specializazioni, e può scegliere in quale clinica andare.
Il paziente puo essere registrato nel sistema senza creare l'account per esso. /* Funzionamento */ Questo serve per i casi specifici se il paziente sta in gravi condizioni e non era presenta nel sistema prima.

[Worker]
Medici e amministratori sono lavoratori di qualche clinica\e.
I lavoratori hanno il codice fiscale, nome, cognome, età.
Ogni medico può lavorare in più cliniche mentre il personale amministrativo è dipendente di un specifica clinica.

[Medico]
Ogni medico ha il suo orario disponibile per le prenotazioni per la specifica clinica. Tal orario puo essere cambiato solo da amministratori di quella clinica.
Ogni medico è caratterizato da una specializazone.   

[Administrator]
Amministratore è definito dal livello di amministrazione.
Ci sono due livelli di amministrazione. Uno serve per avere la possibilità di modificare tutti i dati del sistema(anche cancelare altri amministratori) e
l'altro solo per modicificare, cancellare, o spostare le prenotazioni, su richiesta sia dei medici o dei pazienti, e i dati dei pazienti.
//Se l'amministratore 'A' viene cancellato da un altro amministratore 'B', allora amministratore 'B' diventra risponsabile delle modifice dell'amministratore 'A' //così ho definito una procedura

[Clinic]
Le cliniche sono caratterizate da: un luogo, un orario , oltre che da  vari reparti.
La clinica paga uno stpendio ad ogni lavoratore.
Nella clinica si può tenere traccia dei dipendenti presenti e quelli passati, dei quali si sa anche la data di licenziamento.

[Department] 
Ogni reparto ha un medico primario e i medici che lavorono li.
Un medico non può appartenere a 2 reparti.

[Result]
i risultati devono riportare: il paziente, la data, il medico e la clinca 

[List of interrogations on those entities]

1)Per calcolare il numero di dipendenti, conviene sommare il numero di admin e medici oppure tenere un attributo apposito?
2) per calcolare il numero di primari, basta vedere il numero di reparto
3) le cliniche hanno lo stesso orario?
4) quanti sono i pazienti che hanno una clinica nella propria residenza
5) conviene tenere un attributo per il costo totale degli stipendi, o derivarlo dalla somma di tutti i dipendenti
6) il paziente è già stato inserito nel sistema?