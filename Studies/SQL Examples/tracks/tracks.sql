use [model]
go

if db_id('tracks') is not null
	drop database [tracks]
go

create database [tracks]
go

use [tracks]
go

create table [artists] (
	[artist_id] int primary key,
	[name] varchar(50) not null
)
go

create table [customers] (
	[customer_id] int primary key,
	[first_name] varchar(50) not null,
	[last_name] varchar(50) not null,
	[city] varchar(50) not null,
	[country] varchar(50) not null,
	[email] varchar(50) not null
)
go

create table [genres] (
	[genre_id] int primary key,
	[name] varchar(50) not null
)
go

create table [playlists] (
	[playlist_id] int primary key,
	[name] varchar(50) not null
)
go

create table [albums] (
	[album_id] int primary key,
	[title] varchar(100) not null,
	[artist_id] int not null foreign key references [artists]([artist_id])
)
go

create table [orders] (
	[order_id] int primary key,
	[customer_id] int not null foreign key references [customers]([customer_id]),
    [order_date] date not null
)
go

create table [tracks] (
	[track_id] int primary key,
	[title] varchar(100) not null,
	[album_id] int not null foreign key references [albums]([album_id]),
	[genre_id] int not null foreign key references [genres]([genre_id]),
	[milliseconds] int not null,
	[bytes] int not null,
	[price] decimal(3, 2) not null
)
go

create table [orders_tracks] (
	[order_id] int not null foreign key references [orders]([order_id]),
	[track_id] int not null foreign key references [tracks]([track_id]),
	[price] decimal(3, 2) not null
)
go

create table [playlists_tracks] (
	[playlist_id] int not null foreign key references [playlists]([playlist_id]),
	[track_id] int not null foreign key references [tracks]([track_id])
)
go

insert into [artists] values
	(1, 'Amy Winehouse'),
	(2, 'Black Eyed Peas'),
	(3, 'Eric Clapton'),
	(4, 'Green Day'),
	(5, 'Iron Maiden'),
	(6, 'Jamiroquai'),
	(7, 'Lenny Kravitz'),
	(8, 'Luciano Pavarotti'),
	(9, 'Metallica'),
	(10, 'Miles Davis'),
	(11, 'Nirvana'),
	(12, 'System of a Down'),
	(13, 'The Rolling Stones'),
	(14, 'U2'),
	(15, 'Van Halen')
go

insert into [customers] values
	(1, 'Otto', 'Köhler', 'Stuttgart', 'Germany', 'okohler@yahoo.de'),
	(2, 'Kara', 'Nielsen', 'Copenhagen', 'Denmark', 'kara.nielsen@gmail.com'),
	(3, 'Roberto', 'Almeida', 'Rio de Janeiro', 'Brazil', 'roberto.almeida@hotmail.com'),
	(4, 'Victor', 'Stevens', 'Madison', 'USA', 'vstevens@yahoo.com'),
	(5, 'Aaron', 'Mitchell', 'Winnipeg', 'Canada', 'aaron.mitchell@yahoo.ca'),
	(6, 'Hannah', 'Schneider', 'Berlin', 'Germany', 'hannah.schneider@yahoo.de'),
	(7, 'Camille', 'Bernard', 'Paris', 'France', 'camille.bernard@yahoo.fr'),
	(8, 'Dominique', 'Dubois', 'Paris', 'France', 'dominique.dubois@gmail.com'),
	(9, 'Stanis³aw', 'Wójcik', 'Warsaw', 'Poland', 'stanis³aw.wojcik@wp.pl'),
	(10, 'Emma', 'Jones', 'London', 'United Kingdom', 'emma.jones@hotmail.com')
go

insert into [genres] values
	(1, 'alternative'),
	(2, 'blues'),
	(3, 'classical'),
	(4, 'heavy metal'),
	(5, 'hip hop'),
	(6, 'jazz'),
	(7, 'metal'),
	(8, 'R&B'),
	(9, 'reggae'),
	(10, 'rock')
go

insert into [playlists] values
	(1, 'All kind of metal'),
	(2, 'Best of Metallica'),
	(3, 'Greatest hits vol. 1'),
	(4, 'Greatest hits vol. 2'),
	(5, 'R&B classics')
go

insert into [albums] values
	(1, 'American Idiot', 4),
	(2, 'Back to Black', 1),
	(3, 'Black Album', 9),
	(4, 'Brave New World', 5),
	(5, 'Emergency on Planet Earth', 6),
	(6, 'Greatest Hits', 7),
	(7, 'How to Dismantle an Atomic Bomb', 14),
	(8, 'Live After Death', 5),
	(9, 'Load', 9),
	(10, 'Master of Puppets', 9),
	(11, 'Mezmerize', 12),
	(12, 'Nevermind', 11),
	(13, 'No Security', 13),
	(14, 'Pavarotti''s Opera Made Easy', 8),
	(15, 'Piece of Mind', 5),
	(16, 'The Essential Miles Davis [Disc 1]', 10),
	(17, 'The Essential Miles Davis [Disc 2]', 10),
	(18, 'Unplugged', 3),
	(19, 'Van Halen', 15),
	(20, 'Voodoo Lounge', 13)
go

insert into [orders] values
	(1, 2, '2020-01-03'),
	(2, 7, '2020-01-25'),
	(3, 3, '2020-05-02'),
	(4, 6, '2020-05-05'),
	(5, 8, '2020-07-07'),
	(6, 6, '2020-08-02'),
	(7, 5, '2020-09-03'),
	(8, 1, '2020-09-30'),
	(9, 5, '2020-11-09'),
	(10, 7, '2020-11-13'),
	(11, 4, '2020-12-22'),
	(12, 1, '2021-03-05'),
	(13, 6, '2021-03-17'),
	(14, 1, '2021-03-26'),
	(15, 2, '2021-03-28')
go

insert into [tracks] values
	(1, 'American Idiot', 1, 1, 174419, 5705793, 0.99),
	(2, 'Holiday', 1, 1, 232724, 7599602, 0.99),
	(3, 'Boulevard of Broken Dreams', 1, 1, 260858, 8485122, 0.99),
	(4, 'Extraordinary Girl', 1, 1, 214021, 6975177, 0.99),
	(5, 'Wake Me Up When September Ends', 1, 1, 285753, 9325597, 0.99),
	(6, 'Rehab', 2, 8, 213240, 3416878, 0.99),
	(7, 'You Know I''m No Good', 2, 8, 256946, 4133694, 0.99),
	(8, 'Back to Black', 2, 8, 240320, 3852953, 0.99),
	(9, 'Tears Dry on Their Own', 2, 8, 185293, 2996598, 0.99),
	(10, 'Wake Up Alone', 2, 8, 221413, 3576773, 0.99),
	(11, 'Enter Sandman', 3, 7, 332251, 10852002, 0.99),
	(12, 'The Unforgiven', 3, 7, 387082, 12646886, 0.99),
	(13, 'Nothing Else Matters', 3, 7, 388832, 12606241, 0.99),
	(14, 'The Struggle Within', 3, 7, 234240, 7654052, 0.99),
	(15, 'Brave New World', 4, 10, 378984, 15161472, 0.99),
	(16, 'Blood Brothers', 4, 10, 434442, 17379456, 0.99),
	(17, 'The Fallen Angel', 4, 10, 240718, 9629824, 0.99),
	(18, 'The Nomad', 4, 10, 546115, 21846144, 0.99),
	(19, 'Music of the Wind', 5, 10, 383033, 12870239, 0.99),
	(20, 'Blow Your Mind', 5, 10, 512339, 17089176, 0.99),
	(21, 'Are You Gonna Go My Way', 6, 10, 211591, 6905135, 0.49),
	(22, 'Fly Away', 6, 10, 221962, 7322085, 0.49),
	(23, 'American Woman', 6, 10, 261773, 8538023, 0.49),
	(24, 'Believe', 6, 10, 295131, 9661978, 0.49),
	(25, 'I Belong to You', 6, 10, 257123, 8477980, 0.49),
	(26, 'Again', 6, 10, 228989, 7490476, 0.49),
	(27, 'Stars', 6, 10, 248137, 8194906, 0.49),
	(28, 'Angel', 6, 10, 240561, 7880256, 0.49),
	(29, 'Can''t Get You Off My Mind', 6, 10, 273815, 8937150, 0.49),
	(30, 'Let Love Rule', 6, 10, 342648, 11298085, 0.49),
	(31, 'Vertigo', 7, 10, 194612, 6329502, 0.99),
	(32, 'Miracle Drug', 7, 10, 239124, 7760916, 0.99),
	(33, 'City of Blinding Lights', 7, 10, 347951, 11432026, 0.99),
	(34, 'One Step Closer', 7, 10, 231680, 7512912, 0.99),
	(35, 'Aces High', 8, 4, 276375, 6635187, 0.99),
	(36, 'Revelations', 8, 7, 371826, 8926021, 0.99),
	(37, 'Flight of Icarus', 8, 7, 229982, 5521744, 0.99),
	(38, 'The Number of the Beast', 8, 7, 275121, 6605094, 0.99),
	(39, 'Running Free', 8, 7, 204617, 4912986, 0.99),
	(40, 'Phantom of the Opera', 8, 4, 441155, 10589917, 0.99),
	(41, 'King Nothing', 9, 7, 328097, 10681477, 0.99),
	(42, 'Hero of the Day', 9, 7, 261982, 8540298, 0.99),
	(43, 'Bleeding Me', 9, 7, 497998, 16249420, 0.99),
	(44, 'Cure', 9, 7, 294347, 9648615, 0.99),
	(45, 'Mama Said', 9, 7, 319764, 10508310, 0.99),
	(46, 'Thorn Within', 9, 7, 351738, 11486686, 0.99),
	(47, 'Ronnie', 9, 7, 317204, 10390947, 0.99),
	(48, 'Battery', 10, 7, 312424, 10229577, 0.99),
	(49, 'Master of Puppets', 10, 7, 515239, 16893720, 0.99),
	(50, 'Disposable Heroes', 10, 7, 496718, 16135560, 0.99),
	(51, 'Orion', 10, 7, 500062, 16378477, 0.99),
	(52, 'B.Y.O.B.', 11, 7, 255555, 8407935, 0.49),
	(53, 'Cigaro', 11, 7, 131787, 4321705, 0.49),
	(54, 'Radio/Video', 11, 7, 249312, 8224917, 0.49),
	(55, 'Question!', 11, 7, 200698, 6616398, 0.49),
	(56, 'Sad Statue', 11, 7, 205897, 6733449, 0.49),
	(57, 'Lost in Hollywood', 11, 7, 320783, 10535158, 0.49),
	(58, 'Smells Like Teen Spirit', 12, 10, 301296, 9823847, 0.99),
	(59, 'Breed', 12, 10, 183928, 5984812, 0.99),
	(60, 'Lithium', 12, 10, 256992, 8404745, 0.99),
	(61, 'Drain You', 12, 10, 223973, 7273440, 0.99),
	(62, 'Stay Away', 12, 10, 212636, 6956404, 0.99),
	(63, 'You Got Me Rocking', 13, 10, 205766, 6734385, 0.99),
	(64, 'Flip the Switch', 13, 10, 252421, 8336591, 0.99),
	(65, 'Memory Motel', 13, 10, 365844, 11982431, 0.99),
	(66, 'Corinna', 13, 10, 257488, 8449471, 0.99),
	(67, 'Respectable', 13, 10, 215693, 7099669, 0.99),
	(68, 'The Last Time', 13, 10, 287294, 9498758, 0.99),
	(69, 'Out of Control', 13, 10, 479242, 15749289, 0.99),
	(70, 'Nessun dorma!', 14, 3, 176911, 2920890, 1.99),
	(71, 'Quest for Fire', 15, 7, 221309, 3543040, 0.99),
	(72, 'Bye Bye Blackbird', 16, 6, 476003, 15549224, 1.99),
	(73, 'Someday My Prince Will Come', 16, 6, 544078, 17890773, 1.99),
	(74, 'My Funny Valentine (Live)', 17, 6, 907520, 29416781, 1.99),
	(75, 'Nefertiti', 17, 6, 473495, 15478450, 1.99),
	(76, 'Little Church', 17, 6, 196101, 6273225, 1.99),
	(77, 'Black Satin', 17, 6, 316682, 10529483, 1.99),
	(78, 'Time After Time', 17, 6, 220734, 7292197, 1.99),
	(79, 'Portia', 17, 6, 378775, 12520126, 1.99),
	(80, 'Before You Accuse Me', 18, 2, 224339, 7456807, 0.99),
	(81, 'Hey Hey', 18, 2, 196466, 6543487, 0.99),
	(82, 'Tears in Heaven', 18, 2, 274729, 9032835, 0.99),
	(83, 'Lonely Stranger', 18, 2, 328724, 10894406, 0.99),
	(84, 'Layla', 18, 2, 285387, 9490542, 0.99),
	(85, 'Running on Faith', 18, 2, 378984, 12536275, 0.99),
	(86, 'Walkin'' Blues', 18, 2, 226429, 7435192, 0.99),
	(87, 'Alberta', 18, 2, 222406, 7412975, 0.99),
	(88, 'Malted Milk', 18, 2, 216528, 7096781, 0.99),
	(89, 'Old Love', 18, 2, 472920, 15780747, 0.99),
	(90, 'Eruption', 19, 10, 102556, 3286026, 0.99),
	(91, 'Atomic Punk', 19, 10, 182073, 5908861, 0.99),
	(92, 'Little Dreamer', 19, 10, 203258, 6648122, 0.99),
	(93, 'Ice Cream Man', 19, 10, 200306, 6573145, 0.99),
	(94, 'You Got Me Rocking', 20, 10, 215928, 7162159, 0.99),
	(95, 'The Worst', 20, 10, 144613, 4750094, 0.99),
	(96, 'New Faces', 20, 10, 172146, 5689122, 0.99),
	(97, 'Out of Tears', 20, 10, 327418, 10677236, 0.99),
	(98, 'I Go Wild', 20, 10, 264019, 8630833, 0.99),
	(99, 'Brand New Car', 20, 10, 256052, 8459344, 0.99),
	(100, 'Blinded by Rainbows', 20, 10, 273946, 8971343, 0.99)
go

insert into [orders_tracks] values
	(1, 50, 0.89),
	(2, 80, 0.89),
	(2, 17, 0.89),
	(2, 36, 0.89),
	(2, 32, 0.89),
	(2, 10, 0.89),
	(3, 82, 0.89),
	(3, 29, 0.89),
	(3, 9, 0.89),
	(3, 63, 0.89),
	(3, 31, 0.89),
	(3, 94, 0.89),
	(4, 30, 0.89),
	(4, 8, 0.89),
	(4, 18, 0.89),
	(5, 15, 0.89),
	(5, 86, 0.89),
	(5, 32, 0.89),
	(6, 55, 0.89),
	(6, 82, 0.89),
	(6, 20, 0.89),
	(6, 87, 0.89),
	(7, 8, 0.89),
	(8, 58, 0.89),
	(8, 83, 0.89),
	(8, 91, 0.89),
	(8, 50, 0.89),
	(8, 60, 0.89),
	(8, 59, 0.89),
	(8, 68, 0.89),
	(8, 85, 0.89),
	(9, 50, 0.89),
	(9, 58, 0.89),
	(9, 3, 0.89),
	(9, 25, 0.89),
	(9, 4, 0.89),
	(9, 47, 0.89),
	(10, 45, 0.89),
	(10, 72, 1.89),
	(10, 68, 0.89),
	(10, 46, 0.89),
	(10, 12, 0.89),
	(11, 16, 0.89),
	(11, 3, 0.89),
	(11, 64, 0.89),
	(11, 25, 0.89),
	(11, 87, 0.89),
	(11, 99, 0.89),
	(11, 12, 0.89),
	(11, 34, 0.89),
	(12, 13, 0.99),
	(12, 94, 0.99),
	(12, 38, 0.99),
	(12, 39, 0.99),
	(12, 23, 0.49),
	(12, 28, 0.49),
	(13, 23, 0.49),
	(13, 25, 0.49),
	(13, 17, 0.99),
	(13, 53, 0.49),
	(14, 12, 0.99),
	(14, 1, 0.99),
	(14, 77, 1.99),
	(14, 72, 1.99),
	(14, 84, 0.99),
	(14, 41, 0.99),
	(14, 73, 1.99),
	(15, 62, 0.99),
	(15, 83, 0.99),
	(15, 82, 0.99),
	(15, 67, 0.99),
	(15, 53, 0.49),
	(15, 96, 0.99),
	(15, 68, 0.99),
	(15, 75, 1.99)
go

insert into [playlists_tracks] values
	(1, 49),
	(1, 48),
	(1, 51),
	(1, 52),
	(1, 37),
	(1, 35),
	(1, 45),
	(1, 71),
	(1, 53),
	(1, 39),
	(1, 38),
	(1, 13),
	(1, 42),
	(1, 56),
	(1, 46),
	(2, 47),
	(2, 12),
	(2, 48),
	(2, 51),
	(2, 42),
	(2, 14),
	(2, 44),
	(2, 11),
	(2, 46),
	(2, 13),
	(2, 50),
	(2, 49),
	(2, 43),
	(2, 45),
	(2, 41),
	(3, 44),
	(3, 79),
	(3, 76),
	(3, 41),
	(3, 45),
	(3, 3),
	(3, 98),
	(3, 23),
	(3, 73),
	(3, 12),
	(4, 13),
	(4, 23),
	(4, 91),
	(4, 4),
	(4, 34),
	(4, 51),
	(4, 37),
	(4, 97),
	(4, 98),
	(4, 9),
	(5, 10),
	(5, 6),
	(5, 8),
	(5, 9),
	(5, 7)
go