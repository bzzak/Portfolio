use model
go

if db_id('narciarze') is not null
	drop database narciarze
go

create database narciarze
go

use narciarze
go

create table kraje (
	id_kraju int identity(1,1) primary key,
	kraj char(3) not null unique
)
go

create table skocznie (
	id_skoczni int identity(1,1) primary key,
	miasto varchar(36),
	id_kraju int not null,
	nazwa varchar(36),
	k int,
	sedz int,
	constraint fkskoczniekraje foreign key (id_kraju) references kraje(id_kraju)
)
go

create table trenerzy (
	id_trenera int identity(1,1) primary key,
	id_kraju integer not null,
	imie_t varchar(36),
	nazwisko_t varchar(36),
	data_ur_t smalldatetime,
	constraint fktrenerzykraje foreign key (id_kraju) references kraje(id_kraju)
)
go

create table zawodnicy (
	id_skoczka int identity(1,1) primary key,
	imie varchar(36),
	nazwisko varchar(36),
	id_kraju int not null,
	data_ur smalldatetime,
	wzrost int,
	waga int,
	constraint fkzawodnicykraje foreign key (id_kraju) references kraje(id_kraju)
)
go

create table zawody (
	id_zawodow int identity(1,1) primary key,
	id_skoczni int not null,
	data smalldatetime,
	constraint fkzawodyskocznie foreign key (id_skoczni) references skocznie(id_skoczni)
)
go

create table uczestnictwa_w_zawodach (
	id_zawodow int,
	id_skoczka int,
	constraint pkuczestnictwa primary key (id_zawodow, id_skoczka),
	constraint fkuczestnictwazawody foreign key (id_zawodow) references zawody(id_zawodow),
	constraint fkuczestnictwazawodnicy foreign key (id_skoczka) references zawodnicy(id_skoczka)
)
go

insert into kraje values ('AUT')
insert into kraje values ('FIN')
insert into kraje values ('GER')
insert into kraje values ('JPN')
insert into kraje values ('NOR')
insert into kraje values ('POL')
insert into kraje values ('USA')
go

insert into skocznie values ('Zakopane', 6, 'Wielka Krokiew', 120, 134)
insert into skocznie values ('Garmisch-Partenkirchen', 3, 'Wielka Skocznia Olimpijska', 115, 125)
insert into skocznie values ('Oberstdorf', 3, 'Skocznia Heiniego Klopfera', 185, 211)
insert into skocznie values ('Oberstdorf', 3, 'Grosse Schattenberg', 120, 134)
insert into skocznie values ('Willingen', 3, 'Grosse Muhlenkopfschanze', 130, 145)
insert into skocznie values ('Kuopio', 2, 'Puijo', 120, 131)
insert into skocznie values ('Lahti', 2, 'Salpausselka', 116, 128)
insert into skocznie values ('Trondheim', 5, 'Granasen', 120, 132)
go

insert into trenerzy values (1, 'Alexander', 'Pointner', null)
insert into trenerzy values (2, 'Tommi', 'Nikunen', null)
insert into trenerzy values (5, 'Mika', 'Kojonkoski', '1963-04-19')
insert into trenerzy values (6, null, 'Kuttin', '1971-01-05')
insert into trenerzy values (3, 'Wolfang', 'Steiert', '1963-04-19')
insert into trenerzy values (4, 'Hirokazu', 'Yagi', null)
go

insert into zawodnicy values ('Marcin', 'BACHLEDA', 6, '1982-09-04', 166, 56)
insert into zawodnicy values ('Robert', 'MATEJA', 6, '1976-05-31', 180, 63)
insert into zawodnicy values ('Alexander', 'HERR', 3, '1978-10-04', 173, 65)
insert into zawodnicy values ('Stephan', 'HOCKE', 3, '1983-10-20', 178, 59)
insert into zawodnicy values ('Martin', 'SCHMITT', 3, '1978-01-29', 181, 64)
insert into zawodnicy values ('Michael', 'UHRMANN', 3, '1978-09-09', 184, 64)
insert into zawodnicy values ('Georg', 'SPAETH', 3, '1981-02-24', 187, 68)
insert into zawodnicy values ('Matti', 'HAUTAMAEKI', 2, '1981-07-14', 174, 57)
insert into zawodnicy values ('Tami', 'KIURU', 2, '1976-09-13', 183, 59)
insert into zawodnicy values ('Janne', 'AHONEN', 2, '1977-05-11', 184, 67)
insert into zawodnicy values ('Martin', 'HOELLWARTH', 1, '1974-04-13', 182, 67)
insert into zawodnicy values ('Thomas', 'MORGENSTERN', 1, '1986-10-30', 174, 57)
insert into zawodnicy values ('Tommy', 'INGEBRIGTSEN', 5, '1977-08-08', 179, 56)
insert into zawodnicy values ('Bjoern-Einar', 'ROMOEREN', 5, '1981-04-01', 182, 63)
insert into zawodnicy values ('Roar', 'LJOEKELSOEY', 5, '1976-05-31', 175, 62)
insert into zawodnicy values ('Alan', 'ALBORN', 7, '1980-12-13', 177, 57)
insert into zawodnicy values ('Adam', 'MAŁYSZ', 6, '1977-12-03', 169, 60)
go

insert into zawody values (1, '2007-01-23')
insert into zawody values (7, '2006-11-15')
insert into zawody values (3, '2006-12-26')
insert into zawody values (3, '2006-12-28')
insert into zawody values (6, '2006-12-29')
go

insert into uczestnictwa_w_zawodach values (1, 1)
insert into uczestnictwa_w_zawodach values (1, 2)
insert into uczestnictwa_w_zawodach values (1, 3)
insert into uczestnictwa_w_zawodach values (1, 5)
insert into uczestnictwa_w_zawodach values (1, 6)
insert into uczestnictwa_w_zawodach values (1, 7)
insert into uczestnictwa_w_zawodach values (1, 10)
insert into uczestnictwa_w_zawodach values (1, 11)
insert into uczestnictwa_w_zawodach values (1, 12)
insert into uczestnictwa_w_zawodach values (1, 13)
insert into uczestnictwa_w_zawodach values (1, 14)
insert into uczestnictwa_w_zawodach values (1, 15)
insert into uczestnictwa_w_zawodach values (1, 16)
insert into uczestnictwa_w_zawodach values (1, 17)
insert into uczestnictwa_w_zawodach values (2, 1)
insert into uczestnictwa_w_zawodach values (2, 2)
insert into uczestnictwa_w_zawodach values (2, 3)
insert into uczestnictwa_w_zawodach values (2, 5)
insert into uczestnictwa_w_zawodach values (2, 6)
insert into uczestnictwa_w_zawodach values (2, 8)
insert into uczestnictwa_w_zawodach values (2, 9)
insert into uczestnictwa_w_zawodach values (2, 10)
insert into uczestnictwa_w_zawodach values (2, 14)
insert into uczestnictwa_w_zawodach values (3, 2)
insert into uczestnictwa_w_zawodach values (3, 4)
insert into uczestnictwa_w_zawodach values (3, 5)
insert into uczestnictwa_w_zawodach values (3, 8)
insert into uczestnictwa_w_zawodach values (3, 11)
insert into uczestnictwa_w_zawodach values (3, 12)
insert into uczestnictwa_w_zawodach values (3, 13)
insert into uczestnictwa_w_zawodach values (3, 15)
insert into uczestnictwa_w_zawodach values (3, 16)
insert into uczestnictwa_w_zawodach values (3, 17)
insert into uczestnictwa_w_zawodach values (4, 2)
insert into uczestnictwa_w_zawodach values (4, 3)
insert into uczestnictwa_w_zawodach values (4, 5)
insert into uczestnictwa_w_zawodach values (4, 6)
insert into uczestnictwa_w_zawodach values (4, 7)
insert into uczestnictwa_w_zawodach values (4, 8)
insert into uczestnictwa_w_zawodach values (4, 9)
insert into uczestnictwa_w_zawodach values (4, 10)
insert into uczestnictwa_w_zawodach values (4, 12)
insert into uczestnictwa_w_zawodach values (4, 13)
insert into uczestnictwa_w_zawodach values (4, 14)
insert into uczestnictwa_w_zawodach values (5, 1)
insert into uczestnictwa_w_zawodach values (5, 4)
insert into uczestnictwa_w_zawodach values (5, 5)
insert into uczestnictwa_w_zawodach values (5, 6)
insert into uczestnictwa_w_zawodach values (5, 7)
insert into uczestnictwa_w_zawodach values (5, 11)
insert into uczestnictwa_w_zawodach values (5, 12)
insert into uczestnictwa_w_zawodach values (5, 13)
insert into uczestnictwa_w_zawodach values (5, 14)
insert into uczestnictwa_w_zawodach values (5, 16)
insert into uczestnictwa_w_zawodach values (5, 17)
go