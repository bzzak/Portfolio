-- Test zawarto�ci tabel --
SELECT * FROM biura
SELECT * FROM klienci
SELECT * FROM nieruchomosci
SELECT * FROM personel
SELECT * FROM wizyty
SELECT * FROM wlasciciele
SELECT * FROM wynajecia

-- Test funkcji datediff(datepart, startdate, enddate)
SELECT DATEDIFF(MONTH, '2021-01-01', '2021-12-31')


--1-- Wy�wietl imiona oraz nazwiska wszystkich klient�w, kt�rzy nie podali numeru telefonu w porz�dku malej�cym wed�ug d�ugo�ci nazwiska.
SELECT klienci.imie, klienci.nazwisko 
FROM klienci
WHERE klienci.telefon IS NULL
ORDER BY DATALENGTH(klienci.nazwisko) DESC

--2-- Wy�wietl imiona oraz nazwiska wszystkich klient�w, kt�rzy wynaj�li wcze�niej ogl�dan� nieruchomo��.
SELECT DISTINCT k.imie, k.nazwisko
FROM klienci k, wizyty w, wynajecia wyn, nieruchomosci n
WHERE w.klientnr = k.klientnr
AND w.nieruchomoscnr = n.nieruchomoscnr
AND wyn.klientnr = k.klientnr
AND wyn.nieruchomoscnr = n.nieruchomoscnr

--3-- Wy�wietl imiona oraz nazwiska wszystkich klient�w, kt�rzy wynaj�li nieruchomo��, kt�rej czynsz by� wy�szy ni� zadeklarowana przez nich maksymalna kwota [max_czynsz].
SELECT k.imie, k.nazwisko 
FROM klienci k, wynajecia w
WHERE k.klientnr = w.klientnr
AND w.czynsz > k.max_czynsz

--4-- Dla ka�dego klienta wy�wietl jego imi�, nazwisko oraz liczb� nieruchomo�ci, kt�re ogl�da� przed wynaj�ciem pierwszej z nich. Uwzgl�dnij tylko tych klient�w, kt�rzy ogl�dali wi�cej ni� jedn� nieruchomo��.

-- Co� nie tak --
SELECT imie, nazwisko, COUNT(wizyty.nieruchomoscnr) AS 'Liczba obejrzanych nieruchomo�ci przed wynaj�ciem pierwszej z nich'
FROM klienci
JOIN wizyty
ON wizyty.klientnr = klienci.klientnr
JOIN nieruchomosci
ON wizyty.nieruchomoscnr = nieruchomosci.nieruchomoscnr
JOIN wynajecia
ON wynajecia.klientnr = klienci.klientnr AND wynajecia.nieruchomoscnr = nieruchomosci.nieruchomoscnr
WHERE wizyty.data_wizyty < (SELECT MIN(od_kiedy) FROM wynajecia WHERE wynajecia.klientnr = klienci.klientnr)
GROUP BY klienci.klientnr, imie, nazwisko
HAVING COUNT(wizyty.nieruchomoscnr) > 1


--5-- Dla ka�dego klienta wy�wietl jego imi�, nazwisko oraz numery wszystkich nieruchomo�ci, kt�rych czynsz jest ni�szy ni� zadeklarowana przez niego maksymalna kwota.
SELECT DISTINCT k.imie, k.nazwisko, STRING_AGG(n.nieruchomoscnr, ', ') AS 'Ni�szy czynsz ni� zadeklarowana maksymalna kwota'
FROM klienci k, nieruchomosci n
WHERE n.czynsz < k.max_czynsz
GROUP BY k.klientnr, k.imie, k.nazwisko

--6-- Wy�wietl imi� oraz nazwisko w�a�ciciela, kt�ry posiada najwi�cej nieruchomo�ci. Uwzgl�dnij, �e rezultat�w mo�e by� wiele.
SELECT TOP 1 WITH TIES w.imie, w.nazwisko
FROM wlasciciele w
LEFT JOIN nieruchomosci n
ON w.wlascicielnr = n.wlascicielnr
GROUP BY w.wlascicielnr, w.imie, w.nazwisko
ORDER BY COUNT(n.nieruchomoscnr) DESC

--7-- Dla ka�dego w�a�ciciela wy�wietl jego imi�, nazwisko oraz numery wszystkich nieruchomo�ci, kt�re posiada.
SELECT w.imie, w.nazwisko, STRING_AGG(n.nieruchomoscnr, ', ') AS 'Nieruchomo�ci, kt�re posiada'
FROM wlasciciele w
LEFT JOIN nieruchomosci n
ON w.wlascicielnr = n.wlascicielnr
GROUP BY w.wlascicielnr, w.imie, w.nazwisko

--8-- Dla ka�dego biura wy�wietl liczb� zatrudnionych w nim kobiet oraz m�czyzn. Uwzgl�dnij wszystkie biura. Zastosuj aliasy K oraz M.
SELECT b.biuronr,
(SELECT COUNT(*) FROM personel p WHERE p.plec = 'K' AND p.biuronr = b.biuronr) AS 'K',
(SELECT COUNT(*) FROM personel p WHERE p.plec = 'M' AND p.biuronr = b.biuronr) AS 'M'
FROM biura b
GROUP BY b.biuronr

--9-- Dla ka�dego miasta wy�wietl liczb� zatrudnionych w nim kobiet oraz m�czyzn. Uwzgl�dnij wszystkie miasta. Zastosuj aliasy K oraz M.
SELECT bm.miasto, SUM(bm.K) AS 'K', SUM(bm.M) AS 'M'
FROM (
	  SELECT b.miasto,
	  (SELECT COUNT(*) FROM personel p WHERE p.plec = 'K' AND p.biuronr = b.biuronr ) AS 'K',
	  (SELECT COUNT(*) FROM personel p WHERE p.plec = 'M' AND p.biuronr = b.biuronr) AS 'M'
	  FROM biura b
	  GROUP BY b.miasto, b.biuronr
	  ) bm
GROUP BY bm.miasto

--10-- Dla ka�dego stanowiska wy�wietl liczb� zatrudnionych na nim kobiet oraz m�czyzn. Uwzgl�dnij wszystkie stanowiska. Zastosuj aliasy K oraz M.
SELECT p1.stanowisko ,
(SELECT COUNT(*) FROM personel p2 WHERE p2.plec = 'K' AND p1.stanowisko = p2.stanowisko) AS 'K',
(SELECT COUNT(*) FROM personel p2 WHERE p2.plec = 'M'AND p1.stanowisko = p2.stanowisko) AS 'M'
FROM personel p1
GROUP BY p1.stanowisko

--11-- Wy�wietl numery wszystkich biur, kt�re nie oferuj� �adnych nieruchomo�ci.
SELECT b.biuronr
FROM biura b
WHERE b.biuronr not in (SELECT biuronr FROM nieruchomosci)

--12-- Wy�wietl nazwy wszystkich miast, z kt�rych pochodz� klienci, a w kt�rych swojej siedziby nie ma �adne biuro.
SELECT SUBSTRING(adres, 8, LEN(adres) - 7) as miasto
FROM klienci
WHERE SUBSTRING(adres, 8, LEN(adres) - 7) != all (select miasto from biura group by miasto)

--13-- Dla ka�dego biura wy�wietl jego numer oraz ��czny zysk obliczony jako 30% pobranego czynszu. Zastosuj alias zysk.
SELECT b.biuronr, ISNULL(SUM(0.3*w.czynsz*(DATEDIFF(MONTH, w.od_kiedy, w.do_kiedy)+1)), 0) AS 'Zysk'
FROM biura b
LEFT JOIN nieruchomosci n
ON  b.biuronr = n.biuronr
LEFT JOIN wynajecia w
ON n.nieruchomoscnr = w.nieruchomoscnr
GROUP BY b.biuronr

--14-- Dla ka�dej nieruchomo�ci wy�wietl jej numer, liczb� wizyt oraz liczb� wynajm�w. Zastosuj aliasy wizyty oraz wynajmy.
SELECT n.nieruchomoscnr,
(SELECT COUNT(*) FROM wizyty w WHERE n.nieruchomoscnr = w.nieruchomoscnr) AS 'wizyty',
(SELECT COUNT(*) FROM wynajecia wyn WHERE n.nieruchomoscnr = wyn.nieruchomoscnr) AS 'wynajmy'
FROM nieruchomosci n;

--15-- Dla ka�dej nieruchomo�ci wy�wietl jej numer oraz wyra�on� w procentach podwy�k� czynszu pomi�dzy jego pierwotn� a obecn� warto�ci�.

-- Juz dobrze -- B��d polega� na dzieleniu ca�kowitym zamiast rzeczywistym

SELECT n.nieruchomoscnr,  ROUND( ( n.czynsz / CAST( (SELECT TOP 1 ww.czynsz From wynajecia ww WHERE n.nieruchomoscnr = ww.nieruchomoscnr ORDER BY ww.od_kiedy) AS float) * 100 ) - 100 , 2)  AS 'Podwy�ka(%)'
FROM nieruchomosci n
LEFT JOIN wynajecia w
ON n.nieruchomoscnr = w.nieruchomoscnr
GROUP BY n.nieruchomoscnr, n.czynsz

-- Albo tak
SELECT n.nieruchomoscnr, ROUND(((n.czynsz - w.czynsz) * 100 / CAST(w.czynsz AS float)), 2) AS 'Podwy�ka(%)'
FROM nieruchomosci n
JOIN wynajecia w
ON n.nieruchomoscnr = w.nieruchomoscnr
WHERE w.od_kiedy = (SELECT MIN(od_kiedy) FROM wynajecia WHERE n.nieruchomoscnr = wynajecia.nieruchomoscnr)

--16-- Dla ka�dej nieruchomo�ci wy�wietl jej numer oraz ��czn� kwot� pobranego czynszu.
SELECT n.nieruchomoscnr, ISNULL(SUM(w.czynsz * (DATEDIFF(MONTH, w.od_kiedy, w.do_kiedy)+1)), 0) as pobrany_czynsz
FROM nieruchomosci n
LEFT JOIN wynajecia w
ON n.nieruchomoscnr = w.nieruchomoscnr
GROUP BY n.nieruchomoscnr

--17-- Wy�wietl numer najcz�ciej ogl�danej nieruchomo�ci. Uwzgl�dnij, �e rezultat�w mo�e by� kilka.
SELECT TOP 1 WITH TIES w.nieruchomoscnr AS 'Najcz�ciej ogl�dana nieruchomo��'
FROM wizyty w
GROUP BY w.nieruchomoscnr
ORDER BY  COUNT(w.nieruchomoscnr) DESC

--Albo tak
SELECT nieruchomoscnr AS 'Najcz�ciej ogl�dana nieruchomo��'
FROM wizyty
GROUP BY nieruchomoscnr
HAVING COUNT(nieruchomoscnr) >= all (SELECT COUNT(*) FROM wizyty GROUP BY nieruchomoscnr )

--18-- Wy�wietl numer nieruchomo�ci, kt�ra by�a wynaj�ta przez najwi�ksz� liczb� dni. Uwzgl�dnij, �e rezultat�w mo�e by� kilka.
SELECT TOP 1 WITH TIES n.nieruchomoscnr AS 'Najd�u�ej wynajmowana nieruchomo��'
FROM nieruchomosci n
LEFT JOIN wynajecia w
ON n.nieruchomoscnr = w.nieruchomoscnr
GROUP BY n.nieruchomoscnr
ORDER BY SUM((DATEDIFF(DAY, w.od_kiedy, w.do_kiedy))+1) DESC

--19-- Dla ka�dego wynajmu wy�wietl numer umowy oraz wyra�ony w dniach czas jego trwania.
SELECT w.umowanr AS 'Numer umowy', ((DATEDIFF(DAY, w.od_kiedy, w.do_kiedy))+1) AS 'D�ugo�� wynajmu w dniach'
FROM wynajecia w

--20-- Dla ka�dej formy p�atno�ci wy�wietl jej nazw� oraz liczb� um�w, zgodnie z kt�rymi czynsz jest op�acany z jej wykorzystaniem.
SELECT w.forma_platnosci, COUNT(*) AS 'Liczba um�w op�acanych t� form� p�atno�ci'
FROM wynajecia w
GROUP BY w.forma_platnosci
