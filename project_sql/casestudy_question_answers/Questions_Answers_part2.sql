
-- -- write a query to return the email,first_name,last_name and genre of all rock music.
-- order them by alphabetically by email in ASC

with table_a as (select 
	first_name,
	last_name, 
	email,
	customer.customer_id,
	invoice.invoice_id from customer left join invoice 
	on customer.customer_id=invoice.customer_id),

table_b as(select 
	table_a.first_name,
	table_a.last_name,
	table_a.email,
	table_a.invoice_id,
	invoice_line.track_id from table_a left join invoice_line
	on table_a.invoice_id=invoice_line.invoice_id),

table_c as (select table_b.first_name,
table_b.last_name,
table_b.email,
table_b.track_id,
track.genre_id from table_b left join track
on table_b.track_id=track.track_id),

table_d as(select table_c.first_name,
table_c.last_name,
table_c.email,
table_c.genre_id,
genre.name from table_c left join genre 
on table_c.genre_id=genre.genre_id
where genre.name='Rock')

select distinct table_d.first_name,table_d.last_name,table_d.email
from table_d
order by table_d.email ASC

-- write a query that returns that returns artist name and total track count of the top 10 rock bands

with table_a as (select 
	artist.artist_id,
	artist.name,
	album.album_id 
	from artist left join album 
	on artist.artist_id=album.artist_id),

table_b as (select table_a.name,track.genre_id from table_a left join track 
on table_a.album_id=track.album_id),

table_c as(select table_b.name,table_b.genre_id,genre.name as g_name from table_b left join genre
on table_b.genre_id=genre.genre_id
where genre.name='Rock')

select table_c.name,count(table_c.g_name) from table_c 
group by table_c.name
order by count(table_c.g_name) DESC
limit 10

-- write a query to return all the song name whose song length is greater than avg of song length

select track.name,track.milliseconds from track 
where milliseconds>(select avg(milliseconds) from track)
order by track.milliseconds DESC