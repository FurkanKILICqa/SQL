--------------DAY'7---------------------
--JOINS--BİRLEŞTİRME
--JOIN:ilişkili tablolarda ortak bir sütun baz alınarak(tipik olarak PK ve FK)
--bir veya daha fazla tablodaki sütunların birleştirilmesini sağlar.


CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'IBM');
INSERT INTO sirketler VALUES(101, 'GOOGLE');
INSERT INTO sirketler VALUES(102, 'MICROSOFT');
INSERT INTO sirketler VALUES(103, 'APPLE');

CREATE TABLE siparis (
siparis_id int,
sirket_id int,
siparis_tarihi date
);
INSERT INTO siparis VALUES(11, 101, '2023-02-17');  
INSERT INTO siparis VALUES(22, 102, ' 2023-02-18');  
INSERT INTO siparis VALUES(33, 103, ' 2023-01-19');  
INSERT INTO siparis VALUES(44, 104, ' 2023-01-20');  
INSERT INTO siparis VALUES(55, 105, ' 2022-12-21');



--33-INNER JOIN:baz aldığımız sütundaki sadece ortak değerleri gösterir.

--iki tablodaki şirket id'si aynı olanların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.

SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler
INNER JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id


--LEFT ve RIGHT JOIN i tablo sırasını değiştirerek birbirinin yerine kullanılabilir.







--34-LEFT JOIN:Sol tablodaki(ilk tablodaki) tüm verileri getirir.
   --RIGHT JOIN:Sağ tablodaki(ikinci tablodaki) tüm verileri getirir.
   
   
--şirketler tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz. 


   
SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler
left JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id
   
   
--siparis tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.    
--ilk kaydedilen tablo left olur

SELECT siparis.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler RIGHT JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id    
   

--35-FULL JOIN:iki tablodaki baz alınan sütundaki tüm kayıtları getirir.










--36-SELF JOIN : tablonun kendi içindeki bir sütunu baz alarak INNER JOIN yapılmasını sağlar. 











CREATE TABLE personeller  (
id int,
isim varchar(20),  
title varchar(60), 
yonetici_id int
);
INSERT INTO personeller VALUES(1, 'Ali Can', 'SDET',     2);
INSERT INTO personeller VALUES(2, 'Veli Cem', 'QA',      3);
INSERT INTO personeller VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personeller VALUES(4, 'Fatma Can', 'CEO',    null);

SELECT * FROM personeller;

--herbir personelin ismi ile birlikte yöneticisinin ismini de veren bir sorgu oluşturunuz.

SELECT p.id,p.isim AS personel,m.id,m.isim AS yonetici
FROM personeller p
INNER JOIN personeller m
ON p.yonetici_id=m.id











--37-LIKE Cond.:WHERE komutu ile kullanılır, 
--Sorgular belirli bir karakter dizisini(desen-pattern) kullanarak filtreleme yapmamızı sağlar
--ILIKE:LIKE gibi ancak CASE INSENSITIVE dir.


CREATE TABLE words
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);
INSERT INTO words VALUES (1011, 'ahata', 3);

SELECT * FROM words;

select * from developers where name like start with 'E'


--Wildcard(Joker=%) %


select * 
from developers
where name like 'A%'-- 'E' ile başlayan karakteri bulduk birden çok karakter de bulabiliriz


select * 
from developers
where name ilike 'a%'--küçük büyük isim şartı olmadan yazdırdık

--a harfi ile biten şehirde çalışan dev isimlerini ve şehirlerini yazdiran QUERY yazin

select name,city
from developers
where city ilike '%a'--ismi ve şehri a ile biten isim ve şehirleri bulduk



select name,salary
from developers
where name ilike 't%n'--t ile başlayıp n ile biten ismi ve maaşı sıraladık isim sadece tn olsa bile kabul ederdi


--Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin


select name,salary
from developers
where name ilike '%an%'--isminin sonu an ile bitenleri getirdi

--Ismi içinde e ve a olan devlerin tüm bilgilerini yazdiran QUERY yazin

select name,salary
from developers
where name ilike '%a%' and name like '%e%' 

--2.Yol

select name,salary
from developers
where name ilike '%a%e%' or name ilike '%a%e%'


--al?--ilk iki harfi hatırladık üçüncü harfi hatırlayamadık



--Isminin ikinci harfi ü olan devlerin tum bilgilerini yazdiran QUERY yazin

select *
from developers
where name like '_ü%' 


--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin


select *
from developers
where prog_lang like '__v_' --karakter sayısı 4 tane olan java yı getirdik


select *
from developers
where prog_lang like '____'--karakter sayısı 4 tane olan programlama dilini getirdik

--Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan devlerin tum bilgilerini yazdiran QUERY yazin.ÖDEVVV
--HINT:sadece JavaScript olacak
--Isminin 2. harfi e,4. harfi y olan devlerin tum bilgilerini yazdiran QUERY yazin. ÖDEVV
--ismi boşluk içeren devlerin tum bilgilerini yazdiran QUERY yazin:ÖDEVVVV

--38-REGEXP_LIKE(~):belirli bir karakter desenini içeren dataları regex kullanarak
--filtrelememizi sağlar.


--words tablosu ile çalışalım.
--h harfinden sonra a veya i harfini sonra ise t harfini 
--içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.


select *
from words
where word ~ 'h[ai]t'--hat,hit içeriyor olmalı [] parantez içerisindekilerin var olup olmadığından emin değiliz ve sadece bir harfi temsil eder ya a ya i var ama emin değiliz


select *
from words
where word ~* 'h[ai]t'-- * işareti ni koyarsak caseinsensitive olur küçük büyük harf duyarlılığı kalkar yani 
--küçük/büyük harf hassasiyeti olmasın:~*


select *
from words
where word ~* 'h[a-k]t'--a ile k harfleri arasındakiler den en az biri


-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin

select *
from words
where word ~* '[mi]'

--a ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select *
from words
where word ~* '^a'--sadece a ile başlayan kelimeleri gerdik

--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select *
from words
where word ~* '^[as]'--başlangıcı a ama içerisinde a veya s oalbilir


--m biten kelimelerin tum bilgilerini yazdiran QUERY yazin
select *
from words
where word ~* 'm$'-- m harfinden sonra harf gelmiyor



--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin


select *
from words
where word ~* '^y.*f$'


--2.Yol
SELECT *
FROM words
WHERE word ~* '^y(.*)f$'


select *
from words
where word ~* '^y.f$'--y ile başlayan f ile biten


--NOT LIKE:verilen karakter desenine benzemeyenleri filtreler
-- !~     :verilen karakter desenine benzemeyenleri filtreler

-- ilk harfi h veya H olmayan kelimelerin tum bilgilerini yazdiran QUERY yaziniz.

select * 
from words
where word not ilike 'h%'



select * 
from words
where word !~* '^h'


--2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin.ÖDEV




