-- Test zawartoœci tabel --
SELECT * FROM biura
SELECT * FROM klienci
SELECT * FROM nieruchomosci
SELECT * FROM personel
SELECT * FROM wizyty
SELECT * FROM wlasciciele
SELECT * FROM wynajecia

-- Test funkcji datediff(datepart, startdate, enddate)
SELECT DATEDIFF(MONTH, '2021-01-01', '2021-12-31')


--1-- Wyœwietl imiona oraz nazwiska wszystkich klientów, którzy nie podali numeru telefonu w porz¹dku malej¹cym wed³ug d³ugoœci nazwiska.
SELECT klienci.imie, klienci.nazwisko 
FROM klienci
WHERE klienci.telefon IS NULL
ORDER BY DATALENGTH(klienci.nazwisko) DESC

--2-- Wyœwietl imiona oraz nazwiska wszystkich klientów, którzy wynajêli wczeœniej ogl¹dan¹ nieruchomoœæ.
SELECT DISTINCT k.imie, k.nazwisko
FROM klienci k, wizyty w, wynajecia wyn, nieruchomosci n
WHERE w.klientnr = k.klientnr
AND w.nieruchomoscnr = n.nieruchomoscnr
AND wyn.klientnr = k.klientnr
AND wyn.nieruchomoscnr = n.nieruchomoscnr

--3-- Wyœwietl imiona oraz nazwiska wszystkich klientów, którzy wynajêli nieruchomoœæ, której czynsz by³ wy¿szy ni¿ zadeklarowana przez nich maksymalna kwota [max_czynsz].
SELECT k.imie, k.nazwisko 
FROM klienci k, wynajecia w
WHERE k.klientnr = w.klientnr
AND w.czynsz > k.max_czynsz

--4-- Dla ka¿dego klienta wyœwietl jego imiê, nazwisko oraz liczbê nieruchomoœci, które ogl¹da³ przed wynajêciem pierwszej z nich. Uwzglêdnij tylko tych klientów, którzy ogl¹dali wiêcej ni¿ jedn¹ nieruchomoœæ.

-- Coœ nie tak --
SELECT imie, nazwisko, COUNT(wizyty.nieruchomoscnr) AS 'Liczba obejrzanych nieruchomoœci przed wynajêciem pierwszej z nich'
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


--5-- Dla ka¿dego klienta wyœwietl jego imiê, nazwisko oraz numery wszystkich nieruchomoœci, których czynsz jest ni¿szy ni¿ zadeklarowana przez niego maksymalna kwota.
SELECT DISTINCT k.imie, k.nazwisko, STRING_AGG(n.nieruchomoscnr, ', ') AS 'Ni¿szy czynsz ni¿ zadeklarowana maksymalna kwota'
FROM klienci k, nieruchomosci n
WHERE n.czynsz < k.max_czynsz
GROUP BY k.klientnr, k.imie, k.nazwisko

--6-- Wyœwietl imiê oraz nazwisko w³aœciciela, który posiada najwiêcej nieruchomoœci. Uwzglêdnij, ¿e rezultatów mo¿e byæ wiele.
SELECT TOP 1 WITH TIES w.imie, w.nazwisko
FROM wlasciciele w
LEFT JOIN nieruchomosci n
ON w.wlascicielnr = n.wlascicielnr
GROUP BY w.wlascicielnr, w.imie, w.nazwisko
ORDER BY COUNT(n.nieruchomoscnr) DESC

--7-- Dla ka¿dego w³aœciciela wyœwietl jego imiê, nazwisko oraz numery wszystkich nieruchomoœci, które posiada.
SELECT w.imie, w.nazwisko, STRING_AGG(n.nieruchomoscnr, ', ') AS 'Nieruchomoœci, które posiada'
FROM wlasciciele w
LEFT JOIN nieruchomosci n
ON w.wlascicielnr = n.wlascicielnr
GROUP BY w.wlascicielnr, w.imie, w.nazwisko

--8-- Dla ka¿dego biura wyœwietl liczbê zatrudnionych w nim kobiet oraz mê¿czyzn. Uwzglêdnij wszystkie biura. Zastosuj aliasy K oraz M.
SELECT b.biuronr,
(SELECT COUNT(*) FROM personel p WHERE p.plec = 'K' AND p.biuronr = b.biuronr) AS 'K',
(SELECT COUNT(*) FROM personel p WHERE p.plec = 'M' AND p.biuronr = b.biuronr) AS 'M'
FROM biura b
GROUP BY b.biuronr

--9-- Dla ka¿dego miasta wyœwietl liczbê zatrudnionych w nim kobiet oraz mê¿czyzn. Uwzglêdnij wszystkie miasta. Zastosuj aliasy K oraz M.
SELECT bm.miasto, SUM(bm.K) AS 'K', SUM(bm.M) AS 'M'
FROM (
	  SELECT b.miasto,
	  (SELECT COUNT(*) FROM personel p WHERE p.plec = 'K' AND p.biuronr = b.biuronr ) AS 'K',
	  (SELECT COUNT(*) FROM personel p WHERE p.plec = 'M' AND p.biuronr = b.biuronr) AS 'M'
	  FROM biura b
	  GROUP BY b.miasto, b.biuronr
	  ) bm
GROUP BY bm.miasto

--10-- Dla ka¿dego stanowiska wyœwietl liczbê zatrudnionych na nim kobiet oraz mê¿czyzn. Uwzglêdnij wszystkie stanowiska. Zastosuj aliasy K oraz M.
SELECT p1.stanowisko ,
(SELECT COUNT(*) FROM personel p2 WHERE p2.plec = 'K' AND p1.stanowisko = p2.stanowisko) AS 'K',
(SELECT COUNT(*) FROM personel p2 WHERE p2.plec = 'M'AND p1.stanowisko = p2.stanowisko) AS 'M'
FROM personel p1
GROUP BY p1.stanowisko

--11-- Wyœwietl numery wszystkich biur, które nie oferuj¹ ¿adnych nieruchomoœci.
SELECT b.biuronr
FROM biura b
WHERE b.biuronr not in (SELECT biuronr FROM nieruchomosci)

--12-- Wyœwietl nazwy wszystkich miast, z których pochodz¹ klienci, a w których swojej siedziby nie ma ¿adne biuro.
SELECT SUBSTRING(adres, 8, LEN(adres) - 7) as miasto
FROM klienci
WHERE SUBSTRING(adres, 8, LEN(adres) - 7) != all (select miasto from biura group by miasto)

--13-- Dla ka¿dego biura wyœwietl jego numer oraz ³¹czny zysk obliczony jako 30% pobranego czynszu. Zastosuj alias zysk.
SELECT b.biuronr, ISNULL(SUM(0.3*w.czynsz*(DATEDIFF(MONTH, w.od_kiedy, w.do_kiedy)+1)), 0) AS 'Zysk'
FROM biura b
LEFT JOIN nieruchomosci n
ON  b.biuronr = n.biuronr
LEFT JOIN wynajecia w
ON n.nieruchomoscnr = w.nieruchomoscnr
GROUP BY b.biuronr

--14-- Dla ka¿dej nieruchomoœci wyœwietl jej numer, liczbê wizyt oraz liczbê wynajmów. Zastosuj aliasy wizyty oraz wynajmy.
SELECT n.nieruchomoscnr,
(SELECT COUNT(*) FROM wizyty w WHERE n.nieruchomoscnr = w.nieruchomoscnr) AS 'wizyty',
(SELECT COUNT(*) FROM wynajecia wyn WHERE n.nieruchomoscnr = wyn.nieruchomoscnr) AS 'wynajmy'
FROM nieruchomosci n;

--15-- Dla ka¿dej nieruchomoœci wyœwietl jej numer oraz wyra¿on¹ w procentach podwy¿kê czynszu pomiêdzy jego pierwotn¹ a obecn¹ wartoœci¹.

-- Juz dobrze -- B³¹d polega³ na dzieleniu ca³kowitym zamiast rzeczywistym

SELECT n.nieruchomoscnr,  ROUND( ( n.czynsz / CAST( (SELECT TOP 1 ww.czynsz From wynajecia ww WHERE n.nieruchomoscnr = ww.nieruchomoscnr ORDER BY ww.od_kiedy) AS float) * 100 ) - 100 , 2)  AS 'Podwy¿ka(%)'
FROM nieruchomosci n
LEFT JOIN wynajecia w
ON n.nieruchomoscnr = w.nieruchomoscnr
GROUP BY n.nieruchomoscnr, n.czynsz

-- Albo tak
SELECT n.nieruchomoscnr, ROUND(((n.czynsz - w.czynsz) * 100 / CAST(w.czynsz AS float)), 2) AS 'Podwy¿ka(%)'
FROM nieruchomosci n
JOIN wynajecia w
ON n.nieruchomoscnr = w.nieruchomoscnr
WHERE w.od_kiedy = (SELECT MIN(od_kiedy) FROM wynajecia WHERE n.nieruchomoscnr = wynajecia.nieruchomoscnr)

--16-- Dla ka¿dej nieruchomoœci wyœwietl jej numer oraz ³¹czn¹ kwotê pobranego czynszu.
SELECT n.nieruchomoscnr, ISNULL(SUM(w.czynsz * (DATEDIFF(MONTH, w.od_kiedy, w.do_kiedy)+1)), 0) as pobrany_czynsz
FROM nieruchomosci n
LEFT JOIN wynajecia w
ON n.nieruchomoscnr = w.nieruchomoscnr
GROUP BY n.nieruchomoscnr

--17-- Wyœwietl numer najczêœciej ogl¹danej nieruchomoœci. Uwzglêdnij, ¿e rezultatów mo¿e byæ kilka.
SELECT TOP 1 WITH TIES w.nieruchomoscnr AS 'Najczêœciej ogl¹dana nieruchomoœæ'
FROM wizyty w
GROUP BY w.nieruchomoscnr
ORDER BY  COUNT(w.nieruchomoscnr) DESC

--Albo tak
SELECT nieruchomoscnr AS 'Najczêœciej ogl¹dana nieruchomoœæ'
FROM wizyty
GROUP BY nieruchomoscnr
HAVING COUNT(nieruchomoscnr) >= all (SELECT COUNT(*) FROM wizyty GROUP BY nieruchomoscnr )

--18-- Wyœwietl numer nieruchomoœci, która by³a wynajêta przez najwiêksz¹ liczbê dni. Uwzglêdnij, ¿e rezultatów mo¿e byæ kilka.
SELECT TOP 1 WITH TIES n.nieruchomoscnr AS 'Najd³u¿ej wynajmowana nieruchomoœæ'
FROM nieruchomosci n
LEFT JOIN wynajecia w
ON n.nieruchomoscnr = w.nieruchomoscnr
GROUP BY n.nieruchomoscnr
ORDER BY SUM((DATEDIFF(DAY, w.od_kiedy, w.do_kiedy))+1) DESC

--19-- Dla ka¿dego wynajmu wyœwietl numer umowy oraz wyra¿ony w dniach czas jego trwania.
SELECT w.umowanr AS 'Numer umowy', ((DATEDIFF(DAY, w.od_kiedy, w.do_kiedy))+1) AS 'D³ugoœæ wynajmu w dniach'
FROM wynajecia w

--20-- Dla ka¿dej formy p³atnoœci wyœwietl jej nazwê oraz liczbê umów, zgodnie z którymi czynsz jest op³acany z jej wykorzystaniem.
SELECT w.forma_platnosci, COUNT(*) AS 'Liczba umów op³acanych t¹ form¹ p³atnoœci'
FROM wynajecia w
GROUP BY w.forma_platnosci
