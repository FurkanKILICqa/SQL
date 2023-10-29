--------------DAY'4-------------------
--23-ALIASES:Etiket/Rumuz:Tabloya veya aütunlara sorgularımızı geçici isim verebiliriz.

CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');


select * from workers;

select calisan_id as id from workers; --görüntülenen raporda calışan _id 
select calisan_id id from workers;--as kullanmadan da olur ikiside kabul edilir

select calisan_id as id, calisan_isim as isim from workers;


select calisan_id || ' - ' || calisan_isim as id_isim from workers;
--burada || bu birleştirme işlemi yapar her ikisini ayntı tabloda yazar
--as kullanarak id_isim adında isim verdik 


select * from workers as w;
--tabloya geçici isim verdik tabloyu ismini kısaltmak için kullanılır sürekli usun isim çalıştırmamk için daha kullanışlı olsun diye

--------------------------------------------

--24-SUBQUERY--NESTED QUERY
--24-a-SUBQUERY: WHERE ile kullanımı

select * from calisanlar3;

select * from markalar;


--1.Yol
select marka_isim from markalar where marka_id=100;--Vakko

select * from calisanlar3 where isyeri='Vakko';

--2.yol
select * 
from calisanlar3
where isyeri=	(select marka_isim 
				 from markalar
				 where marka_id=100);--Bu saorguya alt sorgu (Subquary) denir. Bir komut ile birden fazla komut çalıştırma
					--marka id leri genellikle unique olur


--Interwiew Question : calisanlar3 tablosunda max maaşı alan çalışanın tüm fieldlerini listeleyiniz

select max(maas) from calisanlar3;

select *
from calisanlar3 
where maas=(select max(maas) from calisanlar3);--matruska gibi sıralıyoruz--abreguate tek fonsiyon döndürür her zaman

--Interwiew Question : calisanlar3 tablosunda 2. en yüksek maaşı alan çalışanın tüm fieldlerini listeleyiniz.Ödev

--Çöz

SELECT MAX(maas)
FROM calisanlar3
WHERE maas<(SELECT MAX(maas) FROM calisanlar3)


--calisanlar3 tablosunda ikinci en yüksek maaşı alan çalışanı gösteriniz.
SELECT *
FROM calisanlar3
WHERE maas=(SELECT MAX(maas)
            FROM calisanlar3
            WHERE maas<(SELECT MAX(maas)
						FROM calisanlar3))





--calisanlar3 tablosunda max veya min maaşı alan çalışanların
-- tüm fieldlarını gösteriniz.

--1.Yol
select *
from calisanlar3 
where maas=(select max(maas) from calisanlar3) or maas=(select min(maas) from calisanlar3);


--2.Yol
select *
from calisanlar3 
where maas in ((select max(maas) from calisanlar3),(select min(maas) from calisanlar3));



-- Ankara'da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
SELECT marka_id,calisan_sayisi
FROM markalar
WHERE marka_isim IN ('Pierre Cardin','Adidas','Vakko');--Bu değerler değişebilir daha dinamiği değeri getiren sütunlardır

--subquery ile dinamik çözüm 

SELECT marka_id,calisan_sayisi
FROM markalar
WHERE marka_isim IN (SELECT isyeri FROM calisanlar3 WHERE sehir='Ankara');

--marka_id'si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
--chect sadece tablo oluşturulurken kullanılır

select isim,maas,sehir 
from calisanlar3
where isyeri in (select marka_isim from markalar where marka_id>101);--birden fazla değer döneceği için '=' olmaz 'in kullanırız'


-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.

select isim,maas,isyeri--marka isimleri isyeri stununda yazıyor 
from calisanlar3
where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);


--24-b-SUBQUERY: SELECT komutundan sonra kullanımı

-- Her markanin id'sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
SELECT marka_id,marka_isim,
							(SELECT COUNT(distinct sehir) --distinct farklı değerleri gösterir
		 					FROM calisanlar3
							WHERE isyeri=marka_isim) AS sehir_sayisi--Tekbaşına çalıştıramadığımız bilgilere colorated subquary denir
FROM markalar;


CREATE VIEW sehir_sayisi AS--data analist ler tarafından kullanılır genelde
SELECT marka_id,marka_isim,(SELECT COUNT(DISTINCT(sehir)) 
							FROM calisanlar3 
							WHERE isyeri=marka_isim) AS sehir_sayisi
FROM markalar;


-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum maaşini listeleyen bir Sorgu yaziniz.
select marka_isim,calisan_sayisi,(SELECT MAX(maas) FROM calisanlar3 where isyeri=marka_isim) as max_maas,
								 (SELECT min(maas) FROM calisanlar3 where isyeri=marka_isim) as min_maas
from markalar;						--select ten sonra tek değer döndürmeli




---------------------------------------------



--25-EXISTS Cond.
--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur.
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır.

CREATE TABLE mart
(     
urun_id int,      
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(     
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;


---Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

SELECT urun_isim,musteri_isim
FROM nisan n
WHERE EXISTS (SELECT urun_isim FROM mart m WHERE m.urun_isim=n.urun_isim)

--Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

select urun_isim,musteri_isim
from mart as m
where not exists(select urun_isim from nisan as n where n.urun_isim=m.urun_isim);





------------DAY'5-------------
--crate:Insert



--26-UPDATE komutu

select * from calisanlar3;
select * from markalar;


update calisanlar3 set isyeri='Trendyol' where id=123456789;--tabloya veri ekledik


update calisanlar3 set isim='Veli Yıldırım',sehir='Bursa' where id=567890123;--id ye göre veli yıldırımın şehrini güncelledik
--eğer id ler aynı ise aynı olan hepsi değişir

UPDATE markalar 
SET marka_id=marka_id*2 
WHERE marka_id>=102;--102 ye eşit veya büyükse


-- markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.

UPDATE markalar
SET calisan_sayisi=calisan_sayisi+marka_id;--satır satır toplar

--calisanlar3 tablosundan Ali Seker'in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.

UPDATE calisanlar3
SET isyeri = (SELECT isyeri FROM calisanlar3 WHERE isim='Veli Yıldırım') 
WHERE isim='Ali Seker';

--calisanlar3 tablosunda maasi 1500 olanların isyerini, markalar tablosunda
--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz.

update calisanlar3 
set isyeri= (select marka_isim from markalar where calisan_sayisi>20000)
where maas>1500 ;

--calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.

update calisanlar3 
set sehir=sehir || ' Subesi' 
where isyeri='Vakko';-- || bu iki çizgi girleştirmeye yarar


update calisanlar3 
set isyeri=concat(sehir,'Subesi')
where isyeri 'Vakko';

--calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.

UPDATE calisanlar3
SET sehir=sehir || ' Şubesi'
WHERE isyeri='Vakko'

--alternatif
UPDATE calisanlar3
SET sehir=CONCAT(sehir,' Şubesi')
WHERE isyeri='Vakko'








--27-IS NULL condition  

CREATE TABLE people
(
ssn char(9),
name varchar(50),
address varchar(50)
);
INSERT INTO people VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO people VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO people VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO people (ssn, address) VALUES(456789012, 'Bursa');
INSERT INTO people (ssn, address) VALUES(567890123, 'Denizli');
INSERT INTO people (ssn, name) VALUES(567890123, 'Veli Han');


select * from people;

select * from people
where name is null;--neme null olanları getir

--people tablosundaki name sütununda NULL olan değerleri listleyiniz.

select * 
from people 
where name is not null;--name i null olmayanları getir

--people tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..

update people 
set address 
set name = 'Missing...' 
where name is null;--null name stunundaki null olan değerleri 

UPDATE people
SET name='MISSING...'
WHERE name IS NULL



--people tablosunda adres sütunu null olanların adres değerini 
--'MISSING...' olarak güncelleyiniz..

UPDATE people
SET address='MISSING...'
WHERE address IS NULL





--28-ORDER BY

--28-ORDER BY:kayıtları belirli bir fielda göre varsayılan olarak
--NATURAL(artan,ASCENDING) sıralı şekilde sıralar.












CREATE TABLE person
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa'); 
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara'); 


select * from person;


--person tablosundaki tüm kayıtları adrese göre (artan) sıralayarak listeleyiniz.

select * from person order by adres asc ;--artarak sıralar defoultta : asc


--person tablodaki tüm kayıtları soyisme göre (azalan) sıralayarak listeleyiniz
select * from person order by soyisim desc;--Descending:azalan


--person tablosundaki soyismi Bulut olanları isime göre (azalan) sıralayarak listeleyiniz.

SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY isim DESC;-- z-a sıraladı

--alternatif

SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY 2 DESC;--not recommended:tavsiye edilmez


--person tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyiniz

SELECT *
FROM person
ORDER BY isim ASC,soyisim DESC;-- ismi a-z soyismi z-a ya sıraladı  


--İsim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.


select isim,soyisim,length(soyisim) as karakter_sayisi
from person 
order by length(soyisim);--kısa soyisimlerden başladı uzun isimlere doğru sıraladı


--2.Yol
SELECT isim,soyisim,LENGTH(soyisim) AS karakter_sayisi
FROM person
ORDER BY karakter_sayisi


--Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
--soyisim değerinin toplam uzunluğuna göre sıralayınız.

SELECT isim||' '||soyisim AS issoy
FROM person
ORDER BY length(isim||soyisim)


SELECT isim||' '||soyisim as ad_soyad,LENGTH(isim||soyisim) as karakter_sayisi
FROM person
ORDER BY LENGTH(isim||soyisim)

--calisanlar3 tablosunda maaşı ortalama maaştan yüksek olan çalışanların
--isim,şehir ve maaşlarını maaşa göre artan sıralayarak listeleyiniz.

select * from calisanlar3;

SELECT isim,sehir,maas
FROM calisanlar3
WHERE maas>(SELECT AVG(maas) FROM calisanlar3)
ORDER BY maas ASC; 



select isim,sehir,maas
from calisanlar3
where maas>(select avg(maas) from calisanlar3) 
order by maas asc;--maaşı ortalama maaştan büyük olan mmaşları küçükten büyüğr sıraladık












