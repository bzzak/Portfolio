--1--
SELECT imie, nazwisko, CONVERT(int, DATEDIFF(day, zawodnicy.data_ur, GETDATE())/365) AS wiek
FROM zawodnicy
ORDER BY wiek desc, nazwisko

--2--
SELECT imie, nazwisko, MIN(CONVERT(int, DATEDIFF(year, data_ur, zawody.DATA))) as 'wiek'
FROM zawodnicy, zawody, uczestnictwa_w_zawodach as ucz
WHERE zawody.id_zawodow = ucz.id_zawodow
AND ucz.id_skoczka = zawodnicy.id_skoczka
GROUP BY imie, nazwisko

--3--
SELECT z1.imie, z1.nazwisko, z2.imie, z2.nazwisko
FROM zawodnicy z1
CROSS JOIN zawodnicy z2
WHERE LEFT(z1.imie, 1) = LEFT(z2.imie, 1) 
AND LEFT(z1.nazwisko, 1) = LEFT(z2.nazwisko, 1)
AND z1.id_skoczka < z2.id_skoczka

--4--
SELECT imie, nazwisko
FROM zawodnicy z
WHERE NOT EXISTS
	(
	SELECT id_skoczka
	FROM uczestnictwa_w_zawodach uwz
	WHERE z.id_skoczka = uwz.id_skoczka
	)

--8--
SELECT nazwa, ABS(sedz - k)
FROM skocznie

--9--
SELECT nazwa
FROM skocznie s
WHERE EXISTS
	(
	SELECT id_skoczni
	FROM zawody z
	WHERE s.id_skoczni = z.id_skoczni
	AND sedz=(SELECT MAX(sedz) FROM skocznie)
	)

--10--
SELECT kraj, count(id_skoczka) as 'l_zaw'
FROM kraje LEFT JOIN zawodnicy on kraje.id_kraju = zawodnicy.id_kraju
GROUP BY kraj

--11--
select kraje.kraj from kraje
except
select kraje.kraj from kraje
join zawodnicy on kraje.id_kraju = zawodnicy.id_kraju
group by kraje.kraj
having
count(zawodnicy.id_kraju) != 0

--12--
select kraje.kraj from kraje
except
select kraje.kraj from kraje
join skocznie on kraje.id_kraju = skocznie.id_kraju
group by kraje.kraj
having
count(skocznie.id_kraju) != 0

--13--
select kraje.kraj from kraje
join skocznie on kraje.id_kraju = skocznie.id_kraju
join zawody on zawody.id_skoczni = skocznie.id_skoczni
group by kraje.kraj
having 
count(skocznie.id_kraju) > 0

