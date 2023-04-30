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
-- Wyœwietl oceny wystawione przez recenzentów o imieniu William. -- 
-- Wyniki posortuj wed³ug oceny w porz¹dku malej¹cym. --
select stars
from reviews
join reviewers
on reviewers.reviewer_id = reviews.reviewer_id
where reviewers.name like 'William%'
order by stars desc
-- 2 -- 
-- Wyœwietl imiona i nazwiska aktorów, którzy zagrali w filmach maj¹cych premierê w pi¹tek albo w sobotê. --
-- Zastosuj aliasy "imiê" i "nazwisko". --
select first_name as 'imiê', last_name as 'nazwisko'
from actors
join movies_actors
on movies_actors.actor_id = actors.actor_id
join movies
on movies.movie_id = movies_actors.movie_id
where datepart(weekday,movies.release_date) in(6,7)
-- 3 -- 
-- Wyœwietl imiona i nazwiska re¿yserów, którzy nie wyre¿yserowali ¿adnego filmu. --
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
-- Dla ka¿dego re¿ysera wyœwietl jego imiê i nazwisko oraz datê premiery jego najnowszego filmu. --
-- Uwzglêdnij tylko tych re¿yserów, dla których wartoœæ ta jest póŸniejsza ni¿ 31 grudnia 2005 roku. --
select directors.first_name, directors.last_name, max(movies.release_date) as 'Premiera najnowszego filmu'
from directors
join movies_directors
on movies_directors.director_id = directors.director_id
join movies
on movies.movie_id = movies_directors.movie_id
group by directors.director_id, directors.first_name, directors.last_name, movies.release_date
having movies.release_date > '2005-12-31'
-- 5 --
-- Wyœwietl nazwy gatunków, które dotycz¹ najwiêkszej liczby filmów. --
select genres.name
from genres
left join movies_genres
on movies_genres.genre_id = genres.genre_id
group by genres.genre_id, genres.name
having count(movies_genres.genre_id) >= all (select count(*) from movies_genres group by movies_genres.genre_id)
-- 6 --
-- Dla ka¿dego recenzenta wyœwietl jego imiê i nazwisko oraz tytu³y filmów, którym wystawi³ najgorsz¹ ocenê. --
select rvrs.name, string_agg(m.title, ', ')
from reviewers rvrs
join reviews rvs
on rvs.reviewer_id = rvrs.reviewer_id
join movies m
on m.movie_id = rvs.movie_id
where rvs.stars <= all (select reviews.stars from reviews where reviews.reviewer_id = rvs.reviewer_id)
group by rvrs.reviewer_id, rvrs.name
-- Nam goœciu zabroni³ u¿ywaæ string_agg bo niby dopiero niedawno zosta³o wprowadzone, ale spróbuj tak: --
select rvrs.name, m.title
from reviewers rvrs
join reviews rvs
on rvs.reviewer_id = rvrs.reviewer_id
join movies m
on m.movie_id = rvs.movie_id
where rvs.stars <= all (select reviews.stars from reviews where reviews.reviewer_id = rvs.reviewer_id)
group by rvrs.reviewer_id, rvrs.name, m.title
