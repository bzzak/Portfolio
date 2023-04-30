-- Kolos poprawa
select * from albums
select * from genres
-- 1 --
select orders.order_id
from orders
join customers
on customers.customer_id = orders.customer_id
where len(customers.first_name) = len(customers.last_name)
order by customers.first_name asc

-- 2 --

select distinct customers.country as 'kraj'
from customers
join orders
on orders.customer_id = customers.customer_id
where datename(month,orders.order_date) in('January','March')


-- 3 --

select artists.name, albums.title
from artists
left join albums
on albums.artist_id = artists.artist_id


-- 4 -- 

select albums.title, avg(tracks.milliseconds)
from albums
join tracks
on tracks.album_id = albums.album_id
group by albums.album_id, albums.title
having avg(tracks.milliseconds) < 250000


-- 5 --

select genres.name, count(*)
from genres
join tracks
on tracks.genre_id = genres.genre_id
group by genres.genre_id, genres.name
having count(*) <= all(
                                     select count(*)
									 from genres g
									 join tracks t
									 on t.genre_id = g.genre_id
									 where t.genre_id = g.genre_id
									 group by g.genre_id
                                    )

-- 6 --

select playlists.name, tracks.title
from playlists
join playlists_tracks
on playlists_tracks.playlist_id = playlists.playlist_id
join tracks
on tracks.track_id = playlists_tracks.track_id
where tracks.milliseconds >= all(select t.milliseconds
                                  from tracks t
								  where t.track_id = tracks.track_id
								 )
group by playlists.playlist_id, playlists.name, tracks.title
