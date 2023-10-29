create table ogrenciler(
id int primary key,
isim varchar(50),
adres varchar(50),
sinav_not int 
);

--tablodaki verilerden biri mutlaka unique olmalı

--2. Yol--

create table ogrenciler(
id int,
isim varchar(50),
adres varchar(50),
sinav_not int
constraint std_pk primary key (id)
);


--2 Primary Key olursa ne olur--

create table ogrenciler(
id int primary key,
isim varchar(50),
adres varchar(50),
sinav_not int,
constraint std_pk primary key (id,name)
);


--Neden composite PK ya ihtiyacımız var ??

--1.Güvenlik sebebi ile 

--2023544151744 gibi composit düşünelim
--2023 --> ögrencinin kayit olduğu tarih
--064--> bolüm kodu
--120 kayit sırası

-- Sinav notunun 0-100 arasi olma kontrolu :

create table ogrenciler(
id int primary key,
isim varchar(50),
adres varchar(100),
sinav_not int check(sinav_not>0 and sinav_not<100)
);

--Tablo veri ekleme 

insert into ogrenciler values(1,'Kadir Furkan','Fatih Ca. No:8 Çorum/Turkey',99);

INSERT INTO ogrenciler (id,isim,adres,sinav_not) values 
		(2,'Zeki Bey','Izmir', 90),
		(3,'Cemal Dogan','Trabzon',65),
		(4,'Mirac','Bursa',45),
		(5,'Yavuz Bal','Antalya',55);
		
		
INSERT INTO ogrenciler (id,isim,sinav_not) values
		(6,'Bilal Degirmen',95),
		(7,'Fahri Ersoz',92);




-- SORU1: ogrenciler tablosundaki id ve isim bilgileri ile tum recordlari getirelim :
select id,isim from ogrenciler;



-- SORU2: Sinav notu 80'den buyuk olan ogrencilerin tum bilgilerini listele
select * from ogrenciler where sinav_not>80


--Soru3: Adresi Ankara olan ogrenciler tum bilgilerini listele
select * from ogrenciler where adres='Ankara';

--Soru4: Sinav notu 80 ve adresi istanbul olan ogrenci ismini listele
select isim from ogrenciler where sinav_not=80 and adres='İstanbul';

--Bolum5: Sinav notu 55 veya 100 olan ogrencilerin tüm bilgilerini listele
select * from ogrenciler where sinav_not=55 or sinav_not=100

--Daha matıklı yolu
select * from ogrenciler where sinav_not in(55,100)

-- Sinav notu 65 veya 85 olan ogrencilerin tüm bilgilerini listele
select * from ogrenciler where sinav_not between 65 and 85;


-- SORU7: id'si 3 ve 5 arasinda olmayan ogrencilerin isim ve sinav notu listele
select isim,sinav_not from ogrenciler where id not between 3 and 5;


-- SORU8: En yuksek sinav puani nedir
select max(sinav_not) from ogrenciler;


-- SORU9: İzmir'de yaşayan ve sınav notu 50'den yuksek olan öğrencilerin listesi:
select * from ogrenciler where adres='İzmir' and sinav_not>50;



-- SORU10: Öğrenci sayısı ve ortalama sınav notu:
--id Ögrencilerin tamamını temsil eder

SELECT AVG(sinav_not),COUNT(id) FROM ogrenciler;--Normal ortalama (küsüratı ile) için

SELECT round(AVG(sinav_not)),COUNT(id) FROM ogrenciler;--Küsüratsız ortalama için


SELECT AVG(sinav_not),COUNT(*) FROM ogrenciler;
SELECT COUNT(*), ROUND(AVG(sinav_notu),1) FROM ogrenciler;


-- SORU11: sinav_notu 52 olan satiri siliniz
delete from ogrenciler where sinav_not=52;--Sınav notu 52 olanları sildik



select * from ogrenciler;




-- SORU12: ismi Derya Soylu veya Yavuz Bal olan satirlari siliniz
DELETE FROM ogrenciler WHERE isim='Derya Soylu' OR isim='Cemal Dogan';
DELETE FROM ogrenciler WHERE isim IN('Derya Soylu','Cemal Dogan');


--Soru13 : Ogrenciler tablosunun iceriğini siliniz
--Ogrenciler tablosundaki bütün veriler silinir

delete from ogrenciler;--silindikten sonra geri getirilebilir
--truncate delete from a göre daha yavaş çalışır çünkü kontrol ederek siler

truncate table ogrenciler;--where key word unu kullanamayız veriler asla geri getirilemez referansı ile birlikte siler çünkü 
--truncate daha hızlı çalışır çünkü hiç kontrol etmeden siiler 


--Soru14 : Ogrenci Tablosu siliniz
drop from ogrenciler;










