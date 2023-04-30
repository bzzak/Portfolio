select * from actors
select * from directors
select * from genres
select * from movies
select * from movies_actors
select * from movies_directors
select * from movies_genres
select * from reviewers
select * from reviews


--1)WYŒWIETL ROLE AKTORÓW, KTÓRYCH D£UGOŒÆ IMIENIA I NAZWISKA JEST TAKA SAMA. WYNIKI POSORTUJ WED£UG P£CI ROSN¥CO.

select  movies_actors.role
from movies_actors
join actors
on actors.actor_id = movies_actors.actor_id
where len(actors.first_name) = len(actors.last_name)
order by actors.gender asc

--2)WYŒWIETL IMIONA I NAZWISKA RECENZENTÓW, KTÓRZY OCENIALI FILM POWSTA£Y W GRUDNIU LUB LIPCU.

select reviewers.name
from reviewers
join reviews
on reviews.reviewer_id = reviewers.reviewer_id
join movies
on movies.movie_id = reviews.movie_id
where datename(month,movies.release_date) in('December','July')

--3)WYŒWIETL IMIÊ I NAZWISKO AKTORÓW NIE WYSTÊPUJ¥CYCH W ¯ADNYUM FILMIE.

select actors.first_name, actors.last_name
from actors
where not exists(
select actor_id from movies_actors where actors.actor_id = movies_actors.actor_id
)

--4)WYŒWIETL GATUNKI FILMÓW WRAZ Z D£UGOŒCI¥ NAJKRÓTSZEGO FILMU (>120).

select gor.name, mor.minutes
from genres gor
join movies_genres mgor
on mgor.genre_id = gor.genre_id
join movies mor
on mor.movie_id = mgor.movie_id
where mor.minutes <=  all(select m.minutes 
                          from movies m 
						  join movies_genres mg 
						  on mg.movie_id = m.movie_id 
						  join genres g 
						  on g.genre_id = mg.genre_id 
						  where (g.genre_id = gor.genre_id) and m.minutes > 120
						  )
						  and mor.minutes > 120
group by gor.genre_id, gor.name, mor.minutes

--5)WYŒWIETL RE¯YSERÓW, KTÓRZY STWORZYLI NAJMNIEJ FILMÓW 

select d.director_id, d.first_name, d.last_name
from directors d
left join movies_directors mdor
on mdor.director_id = d.director_id
group by d.director_id, d.first_name, d.last_name
having count(mdor.director_id) <= all(select distinct count(*) from movies_directors md group by md.director_id)

--6)WYŒWIETL DLA KA¯DEGO AKTORA IMIONA I NAZWISKA WRAZ Z TYTU£AMI NAJD£U¯SZYCH FILMÓW, W KTÓRYCH WYSTÊPOWALI.