use model
go

if db_id('biuro') is not null
	drop database biuro
go

create database biuro
go

use biuro
go

create table biura (
	biuronr varchar(4) primary key,
	ulica varchar(25) not null,
	miasto varchar(25) not null,
	kod varchar(6) not null
)
go

create table klienci (
	klientnr varchar(4) primary key,
	imie varchar(25) not null,
	nazwisko varchar(25) not null,
	adres varchar(45) not null,
	telefon varchar(15),
	preferencje varchar(25),
	max_czynsz smallint
)
go

create table wlasciciele (
	wlascicielnr varchar(4) primary key,
	imie varchar(25) not null,
	nazwisko varchar(25) not null,
	adres varchar(45) not null,
	telefon varchar(15) not null
)
go

create table personel (
	personelnr varchar(4) primary key,
	imie varchar(25) not null,
	nazwisko varchar(25) not null,
	stanowisko varchar(25) not null,
	plec char(1) not null,
	dataur smalldatetime not null,
	pensja smallint not null,
	biuronr varchar(4) not null,
	constraint chpersonelplec check (plec = 'K' or plec = 'M'),
	constraint fkpersonelbiura foreign key (biuronr) references biura(biuronr)
)
go

create table nieruchomosci (
	nieruchomoscnr varchar(4) primary key,
	ulica varchar(25) not null,
	miasto varchar(25) not null,
	kod varchar(6) not null,
	typ varchar(25) not null,
	pokoje tinyint not null,
	czynsz smallint not null,
	wlascicielnr varchar(4) not null,
	personelnr varchar(4) not null,
	biuronr varchar(4) not null,
	constraint fknieruchomosciwlasciciele foreign key (wlascicielnr) references wlasciciele(wlascicielnr),
	constraint fknieruchomoscipersonel foreign key (personelnr) references personel(personelnr),
	constraint fknieruchomoscibiura foreign key (biuronr) references biura(biuronr)
)
go

create table wizyty (
	klientnr varchar(4),
	nieruchomoscnr varchar(4),
	data_wizyty smalldatetime not null,
	uwagi varchar(255),
	constraint pkwizyty primary key (klientnr, nieruchomoscnr),
	constraint fkwizytyklienci foreign key (klientnr) references klienci(klientnr),
	constraint fkwizytynieruchomosci foreign key (nieruchomoscnr) references nieruchomosci(nieruchomoscnr)
)
go

create table wynajecia (
	umowanr varchar(4) primary key,
	nieruchomoscnr varchar(4) not null,
	klientnr varchar(4) not null,
	czynsz smallint not null,
	forma_platnosci varchar(25) not null,
	kaucja smallint not null,
	zaplacona tinyint,
	od_kiedy smalldatetime not null,
	do_kiedy smalldatetime not null,
	constraint fkwynajecianieruchomosci foreign key (nieruchomoscnr) references nieruchomosci(nieruchomoscnr),
	constraint fkwynajeciaklienci foreign key (klientnr) references klienci(klientnr)
)
go

insert into biura values ('B001', 'Piękna 46', 'Białystok', '15-900')
insert into biura values ('B002', 'Cicha 56', 'Łomża', '18-400')
insert into biura values ('B003', 'Mała 63', 'Białystok', '15-900')
insert into biura values ('B004', 'Miodowa 32', 'Grajewo', '19-300')
insert into biura values ('B005', 'Dobra 22', 'Łomża', '18-400')
insert into biura values ('B006', 'Słoneczna 55', 'Białystok', '15-900')
insert into biura values ('B007', 'Akacjowa 16', 'Augustów', '16-300')
go

insert into klienci values ('CO16', 'Alicja', 'Stefańska', '15-900 Białystok', '0-85-333 2222', 'mieszkanie', 400)
insert into klienci values ('CO17', 'Katarzyna', 'Winiarska', '15-900 Białystok', null, 'mieszkanie', 420)
insert into klienci values ('CO18', 'Anna', 'Nowak', '15-900 Białystok', null, 'dom', 850)
insert into klienci values ('CR51', 'Michał', 'Rafalski', '16-080 Tykocin', '0-86-123 4567', 'dom', 750)
insert into klienci values ('CR52', 'Ludwik', 'Wierzba', '19-200 Grajewo', null, 'mieszkanie', 375)
insert into klienci values ('CR53', 'Janusz', 'Kalinowski', '18-400 Łomża', '0-86-444 5555', 'mieszkanie', 425)
insert into klienci values ('CR54', 'Maria', 'Tomaszewska', '16-300 Augustów', '0-87-111 6666', 'mieszkanie', 600)
go

insert into wlasciciele values ('CO15', 'Paweł', 'Kowalewski', '19-200 Grajewo, Jarzębinowa 2', '0-87-444 5555')
insert into wlasciciele values ('CO40', 'Tatiana', 'Marcinkowska', '15-900 Białystok, Wodna 63', '0-85-111 5555')
insert into wlasciciele values ('CO46', 'Jan', 'Kowalski', '16-300 Augustów, Fabryczna 2', '0-87-555 4444')
insert into wlasciciele values ('CO87', 'Karol', 'Frankowski', '15-900 Białystok, Agrestowa 6', '0-85-222 6666')
insert into wlasciciele values ('CO93', 'Tomasz', 'Szymański', '15-900 Białystok, Parkowa 12', '0-85-333 4444')
go

insert into personel values ('SA8', 'Katarzyna', 'Morawska', 'kierownik', 'K', '1971-05-06', 1700, 'B007')
insert into personel values ('SA9', 'Maria', 'Hojna', 'asystent', 'K', '1970-2-19', 900, 'B007')
insert into personel values ('SB20', 'Sabina', 'Bober', 'dyrektor', 'K', '1940-6-3', 2400, 'B003')
insert into personel values ('SB21', 'Daniel', 'Frankowski', 'kierownik', 'M', '1958-3-24', 1800, 'B003')
insert into personel values ('SB22', 'Małgorzata', 'Kowalska', 'asystent', 'K', '1972-3-15', 1000, 'B003')
insert into personel values ('SB23', 'Anna', 'Biała', 'asystent', 'K', '1960-11-10', 1200, 'B003')
insert into personel values ('SB30', 'Katarzyna', 'Michalska', 'dyrektor', 'K', '1960-11-17', 2500, 'B006')
insert into personel values ('SB31', 'Dawid', 'Piotrowski', 'asystent', 'M', '1975-3-22', 1100, 'B006')
insert into personel values ('SB32', 'Małgorzata', 'Plichta', 'asystent', 'K', '1971-10-3', 1200, 'B006')
insert into personel values ('SG20', 'Karolina', 'Mucha', 'dyrektor', 'K', '1953-3-3', 2200, 'B004')
insert into personel values ('SG21', 'Piotr', 'Cybulski', 'asystent', 'M', '1974-12-6', 1300, 'B004')
insert into personel values ('SL20', 'Paweł', 'Nowak', 'kierownik', 'M', '1962-2-2', 1500, 'B002')
insert into personel values ('SL21', 'Paweł', 'Kowalski', 'asystent', 'M', '1969-5-5', 1000, 'B002')
insert into personel values ('SL22', 'Monika', 'Munk', 'asystent', 'K', '1977-7-26', 1100, 'B002')
insert into personel values ('SL30', 'Jan', 'Wiśniewski', 'dyrektor', 'M', '1945-10-1', 3000, 'B005')
insert into personel values ('SL31', 'Julia', 'Lisicka', 'asystent', 'K', '1965-7-13', 900, 'B005')
insert into personel values ('SL32', 'Michał', 'Brzęczyk', 'asystent', 'M', '1959-3-15', 1000, 'B005')
go

insert into nieruchomosci values ('A14', 'Handlowa 16', 'Augustów', '16-300', 'dom', 6, 715, 'CO46', 'SA9', 'B007')
insert into nieruchomosci values ('B16', 'Nowa 5', 'Białystok', '15-900', 'mieszkanie', 4, 495, 'CO93', 'SB21', 'B003')
insert into nieruchomosci values ('B17', 'Mała 2', 'Białystok', '15-900', 'mieszkanie', 3, 412, 'CO93', 'SB23', 'B003')
insert into nieruchomosci values ('B18', 'Leśna 6', 'Białystok', '15-900', 'mieszkanie', 3, 385, 'CO40', 'SB23', 'B003')
insert into nieruchomosci values ('B21', 'Dobra 18', 'Białystok', '15-900', 'dom', 5, 660, 'CO87', 'SB22', 'B003')
insert into nieruchomosci values ('G01', 'Długa 33', 'Grajewo', '19-200', 'dom', 7, 830, 'CO15', 'SG21', 'B004')
insert into nieruchomosci values ('L94', 'Akacjowa 6', 'Łomża', '18-400', 'mieszkanie', 4, 440, 'CO87', 'SL31', 'B005')
go

insert into wizyty values ('CR51', 'A14', '2001-05-24', 'za mały')
insert into wizyty values ('CR51', 'B16', '2001-04-28', null)
insert into wizyty values ('CR51', 'L94', '2001-05-26', null)
insert into wizyty values ('CR52', 'A14', '2001-05-14', 'brak jadalni')
insert into wizyty values ('CR53', 'L94', '2001-04-20', 'za daleko')
insert into wizyty values ('CO16', 'A14', '2001-03-03', null)
insert into wizyty values ('CO16', 'B18', '2001-03-03', null)
insert into wizyty values ('CO16', 'G01', '2001-03-03', null)
insert into wizyty values ('CO17', 'L94', '2001-03-03', null)
insert into wizyty values ('CO18', 'B16', '2001-03-03', null)
insert into wizyty values ('CO18', 'B17', '2001-03-03', null)
insert into wizyty values ('CO18', 'B18', '2001-03-03', null)
insert into wizyty values ('CO18', 'B21', '2001-03-03', null)
insert into wizyty values ('CO18', 'G01', '2001-03-03', null)
insert into wizyty values ('CO18', 'L94', '2001-03-03', null)
insert into wizyty values ('CR54', 'A14', '2001-03-01', null)
insert into wizyty values ('CR54', 'B17', '2001-03-01', null)
insert into wizyty values ('CR54', 'B21', '2001-03-01', null)
insert into wizyty values ('CR54', 'L94', '2001-03-01', null)
go

insert into wynajecia values ('1001', 'B16', 'CO16', 410, 'gotówka', 900, 1, '2003-10-01', '2004-03-31')
insert into wynajecia values ('1002', 'B21', 'CR51', 580, 'czek', 1200, 1, '2003-11-01', '2004-04-30')
insert into wynajecia values ('1003', 'B17', 'CO17', 350, 'gotówka', 800, 1, '2003-12-01', '2004-05-31')
insert into wynajecia values ('1004', 'B18', 'CR52', 300, 'karta', 700, 1, '2004-01-01', '2004-06-30')
insert into wynajecia values ('1005', 'A14', 'CR54', 650, 'karta', 1300, 1, '2004-02-01', '2004-07-31')
insert into wynajecia values ('1006', 'L94', 'CR53', 400, 'gotówka', 800, 1, '2004-03-01', '2004-08-31')
insert into wynajecia values ('1007', 'G01', 'CO18', 800, 'karta', 1600, 1, '2002-04-01', '2004-09-30')
insert into wynajecia values ('1011', 'B16', 'CO16', 450, 'gotówka', 900, 1, '2004-04-01', '2004-09-30')
insert into wynajecia values ('1012', 'B21', 'CR51', 600, 'gotówka', 1200, 1, '2004-05-01', '2005-04-30')
insert into wynajecia values ('1013', 'B17', 'CO17', 400, 'karta', 800, 1, '2004-06-01', '2004-11-30')
insert into wynajecia values ('1014', 'B18', 'CR52', 350, 'gotówka', 700, 1, '2004-07-01', '2005-06-30')
insert into wynajecia values ('1015', 'A14', 'CR54', 650, 'gotówka', 1300, 1, '2004-08-01', '2005-01-31')
insert into wynajecia values ('1016', 'L94', 'CR53', 400, 'gotówka', 800, 0, '2004-09-01', '2005-05-30')
insert into wynajecia values ('1017', 'G01', 'CO18', 820, 'gotówka', 1600, 0, '2004-10-01', '2005-07-30')
insert into wynajecia values ('1021', 'B16', 'CO16', 450, 'gotówka', 900, 1, '2004-10-01', '2005-09-30')
insert into wynajecia values ('1023', 'G01', 'CO18', 800, 'gotówka', 1600, 1, '2006-08-01', '2009-07-31')
go