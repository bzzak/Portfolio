-- Kolokwium PBD pierwszy termin, grupa 1 ,13 stycznia 2022, 14:00 --
-- Baza filmy --
select * from actors
select * from directors
select * from genres
select * from movies
select * from movies_actors
select * from movies_directors
select * from movies_genres
select * from reviewers
select * from reviews
-- 1 -- 
-- Wy�wietl oceny wystawione przez recenzent�w o imieniu William. -- 
-- Wyniki posortuj wed�ug oceny w porz�dku malej�cym. --
select stars
from reviews
join reviewers
on reviewers.reviewer_id = reviews.reviewer_id
where reviewers.name like 'William%'
order by stars desc
-- 2 -- 
-- Wy�wietl imiona i nazwiska aktor�w, kt�rzy zagrali w filmach maj�cych premier� w pi�tek albo w sobot�. --
-- Zastosuj aliasy "imi�" i "nazwisko". --
select first_name as 'imi�', last_name as 'nazwisko'
from actors
join movies_actors
on movies_actors.actor_id = actors.actor_id
join movies
on movies.movie_id = movies_actors.movie_id
where datepart(weekday,movies.release_date) in(6,7)
-- 3 -- 
-- Wy�wietl imiona i nazwiska re�yser�w, kt�rzy nie wyre�yserowali �adnego filmu. --
select first_name, last_name
from directors
where not exists (
select director_id
from movies_directors
where directors.director_id = movies_directors.director_id
)
-- albo tak --
select directors.first_name, directors.last_name
from directors
left join movies_directors
on movies_directors.director_id = directors.director_id
group by directors.director_id, directors.first_name, directors.last_name
having count(movies_directors.director_id) = 0
-- 4 --
-- Dla ka�dego re�ysera wy�wietl jego imi� i nazwisko oraz dat� premiery jego najnowszego filmu. --
-- Uwzgl�dnij tylko tych re�yser�w, dla kt�rych warto�� ta jest p�niejsza ni� 31 grudnia 2005 roku. --
select directors.first_name, directors.last_name, max(movies.release_date) as 'Premiera najnowszego filmu'
from directors
join movies_directors
on movies_directors.director_id = directors.director_id
join movies
on movies.movie_id = movies_directors.movie_id
group by directors.director_id, directors.first_name, directors.last_name, movies.release_date
having movies.release_date > '2005-12-31'
-- 5 --
-- Wy�wietl nazwy gatunk�w, kt�re dotycz� najwi�kszej liczby film�w. --
select genres.name
from genres
left join movies_genres
on movies_genres.genre_id = genres.genre_id
group by genres.genre_id, genres.name
having count(movies_genres.genre_id) >= all (select count(*) from movies_genres group by movies_genres.genre_id)
-- 6 --
-- Dla ka�dego recenzenta wy�wietl jego imi� i nazwisko oraz tytu�y film�w, kt�rym wystawi� najgorsz� ocen�. --
select rvrs.name, string_agg(m.title, ', ')
from reviewers rvrs
join reviews rvs
on rvs.reviewer_id = rvrs.reviewer_id
join movies m
on m.movie_id = rvs.movie_id
where rvs.stars <= all (select reviews.stars from reviews where reviews.reviewer_id = rvs.reviewer_id)
group by rvrs.reviewer_id, rvrs.name
-- Nam go�ciu zabroni� u�ywa� string_agg bo niby dopiero niedawno zosta�o wprowadzone, ale spr�buj tak: --
select rvrs.name, m.title
from reviewers rvrs
join reviews rvs
on rvs.reviewer_id = rvrs.reviewer_id
join movies m
on m.movie_id = rvs.movie_id
where rvs.stars <= all (select reviews.stars from reviews where reviews.reviewer_id = rvs.reviewer_id)
group by rvrs.reviewer_id, rvrs.name, m.title
