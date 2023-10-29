/*************************************************************
******************* ON-DELETE-CASCADE  **********************
*************************************************************

CHILD TABLODA ON DELETE CASCADE KOMUTU YAZILMAZSA

1-) Child tablo silinmeden Parent tablo silinmeye calisildiginda 
        PgAdmin Eror verir. Yani Child tablo silinmeden Parent 
        tablo silinemez
		
2-) Child tablodaki veri silinmeden Parent tablodaki veri silinmeye 
        calisildiginda Pg Admin Eror verir. yani Child tablodaki 
        veri silinmeden Parent tablodaki veri silinemez
CHILD TABLODA ON DELETE CASCADE KOMUTU YAZILIRSA

1-) Child tablo silinmeden Parent tablo silinebilir.
    PgAdmin Eror vermez
	
2-) Child tablodaki veri silinmeden Parent tablodaki veri silinmeye 
        calisildiginda PgAdmin Eror vermez  Parent tablodaki veriyi 
        siler.Fakat bu durumda Child tablodaki veride silinir.
*/


CREATE TABLE parent2
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO parent2 VALUES (101, 'Sony', 'Kim Lee');
INSERT INTO parent2 VALUES (102, 'Asus', 'George Clooney');
INSERT INTO parent2 VALUES (103, 'Monster', 'Johnny Deep');
INSERT INTO parent2 VALUES (104, 'Apple', 'Mick Jackson') ;

CREATE TABLE child2
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk FOREIGN KEY (ted_vergino) REFERENCES parent2(vergi_no)
ON DELETE CASCADE   
);

INSERT INTO child2 VALUES(101, 1001,'PC', 'Habip Sanli');
INSERT INTO child2 VALUES(102, 1002,'Kamera', 'Zehra 0z');
INSERT INTO child2 VALUES(102, 1003,'Saat', 'Mesut Kaya');
INSERT INTO child2 VALUES(102, 1004,'PC', 'Vehbi Koc');
INSERT INTO child2 VALUES(103, 1005,'Kamera', 'Cemal Sala');
INSERT INTO child2 VALUES(104, 1006,'Saat', 'Behlil Dana');
INSERT INTO child2 VALUES(104, 1007,'Kamera', 'Eymen Ozden');

-- SORU-1 : parent2 tablosundaki tum verileri siliniz
delete from parent2;

select * from parent2;

select * from child2;

-- SORU-2 : Parent2 tablosunu silinz

drop table parent2;--Önce child i sil sonra parenti sil diyor

drop table parent2 cascade;--Bunun childi var hala silmek istiyormusun diye soruyor eminsen cascade yaz diyor

drop table child2;-- Artık parent i olmadığı için kolaylıkla siler

--------------------------------------------------------------------------------------------------

CREATE TABLE toptancilar
(
vergi_no int PRIMARY KEY,
sirket_ismi VARCHAR(40),
irtibat_ismi VARCHAR(30)
);

INSERT INTO toptancilar VALUES (201, 'IBM', 'Kadir Şen'); 
INSERT INTO toptancilar VALUES (202, 'Huawei', 'Çetin Hoş');
INSERT INTO toptancilar VALUES (203,'Erikson', 'Mehmet Gör'); 
INSERT INTO toptancilar VALUES (204, 'Apple', 'Adem Coş');

CREATE TABLE malzemeler  --> child
(
ted_vergino int,
malzeme_id int,
malzeme_isim VARCHAR(20),
musteri_isim VARCHAR(25),
CONSTRAINT FK FOREIGN KEY (ted_vergino) REFERENCES toptancilar (vergi_no) on delete cascade
);


INSERT INTO malzemeler VALUES (201, 1001, 'Laptop', 'Asli Can'); 
INSERT INTO malzemeler VALUES (202, 1002, 'Telefon', 'Fatih Ak'); 
INSERT INTO malzemeler VALUES (202, 1003, 'TV', 'Ramiz Özmen');
INSERT INTO malzemeler VALUES (202, 1004, 'Laptop', 'Veli Tan');


--SORU-4: Malzemeler tablosundaki musteri_isim'i Asli Can olan kaydin malzeme_isim'ini, 
--toptancılar tablosunda irtibat_ismi 'Adem Coş' olan kaydin sirket_ismi ile güncelleyiniz.

update from  malzemeler set musteri_isim where malzeme_isim='Asli Can' and -- Senin ilk başta denediğin


UPDATE malzemeler
SET malzeme_isim = (SELECT sirket_ismi FROM toptancilar WHERE irtibat_ismi = 'Adem Coş')
WHERE musteri_isim = 'Asli Can';

select * from malzemeler;

--SORU-5: malzeme_ismi Laptop olan kaydin musteri_isim'ini, sirket_ismi Apple'olan toptancinin irtibat_isim'i ile güncelleyiniz.

UPDATE malzemeler
SET musteri_isim = (SELECT irtibat_ismi FROM toptancilar WHERE sirket_ismi = 'Apple')
WHERE malzeme_isim = 'Laptop';
  
select * from malzemeler;

----------------------------------------------------------------

create table arac ( 
id int,
marka varchar (30),
model varchar(30), 
fiyat int,
kilometre int, 
vites varchar(20)
);
insert into arac values (100, 'Citroen', 'C3', 500000, 5000, 'Otomatik' );
insert into arac values (101, 'Mercedes', 'C180', 900000, 10000, 'Otomatik' );
insert into arac values (102, 'Honda', 'Civic', 400000, 15000, 'Manuel' );
insert into arac values (103, 'Wolkswagen', 'Golf', 350000, 20000, 'Manuel' );  
insert into arac values (104, 'Ford', 'Mustang', 750000, 5000, 'Otomatik' );
insert into arac values (105, 'Porsche', 'Panamera', 850000, 5000, 'Otomatik' );
insert into arac values (106, 'Bugatti', 'Veyron', 950008, 5000, 'Otomatik' );


--SORU-6: arac tablosundaki en yüksek fiyat'ı listele

select max(fiyat) as en_yüksek_fiyat from arac 


--Soru-7:arac tablosundaki araçları toplam fiyatını bulunuz

select sum(fiyat) as toplam from arac;

--Soru-8: arac tablosundaki fiyat ortalamalarını bulunuz

select avg(fiyat) as ortalama from arac;--Buda küsüratlı hali


select round(avg(fiyat)) as ortalama from arac;--round ile küsütratsız olanları yazdırdık 


select round(avg(fiyat),2) as ortalama from arac;--Son iki küsüratı genelleikle bizim için yeterli 

--Soru-9: arac tablosunda kaç tane araç olduğunu bulunuz

select count(*) from arac;--İkisi de olur ama en garanti olan budur 

select count(id) from arac;--İkisi de olur ama bu bazı durumlarda bizi yanıltabilir  


-----------------------------------------------



CREATE TABLE meslekler
(
id int PRIMARY KEY, 
isim VARCHAR(50), 
soyisin VARCHAR(50), 
meslek CHAR(9), 
maas int
);
INSERT INTO meslekler VALUES (1, 'Ali', 'Can', 'Doktor', '20000' ); 
INSERT INTO meslekler VALUES (2, 'Veli', 'Cem', 'Mühendis', '18000'); 
INSERT INTO meslekler VALUES (3, 'Mine', 'Bulut', 'Avukat', '17008'); 
INSERT INTO meslekler VALUES (4, 'Mahmut', 'Bulut', 'Ögretmen', '15000'); 
INSERT INTO meslekler VALUES (5, 'Mine', 'Yasa', 'Teknisyen', '13008'); 
INSERT INTO meslekler VALUES (6, 'Veli', 'Yilmaz', 'Hemşire', '12000'); 
INSERT INTO meslekler VALUES (7, 'Ali', 'Can', 'Marangoz', '10000' ); 
INSERT INTO meslekler VALUES (8, 'Veli', 'Cem', 'Tekniker', '14000');



--Soru-10: meslekler tablosunu isime göre sıralayınız

select * 
from meslekler 
order by isim;--İsme göre sıraladık a-z


--Soru-11: meslekler tablosunda maaşı büyükten küçüğe doğru sıralayınız

select * 
from meslekler 
order by maas desc;--Maaşı büyükten küçüğe doğru sıralayınız

--Not: Eğer desc yazmassak küçükten büyüğe sıralar !!!!

--Soru-12: meslekler tablosunda ismi Ali olanları maaşı büyükten küçüğe doğru sıralayınız

select maas from meslekler
where isim='Ali'
order by maas desc;--İsmi ali olan kişilerin maaşını büyükten küçüğe sıraladık


--Soru-13: meslekler tablosunda id değeri 5 ten büyük olan ilk iki veriyi listeleyiniz

select * from meslekler
where id>5
limit 2;-- Id değeri 5 ten büyük olan ilk 2 veriyi listeledik

--Soru-14: meslekler tablosunda maaşı en yüksek 3 kişinin bilgilerini getiriniz

select * from meslekler
order by maas desc
limit 3;--Maaşı en yüksek 3 kişinin maaşını listeledik



-------------------------------Join------------------------------------

--Birkaç tablodan veri istiyorsak bu join dir 
--Herhagi bir öğrencinin aldığı dersleri getrir dersek inner joinden alırız 'join inner' yazarız



create table filmler (
film_id int,
film_name varchar(30), 
category varchar(30) 
);

insert into filmler values (1, 'Eyvah Eyvah', 'Komedi');
insert into filmler values (2, 'Kurtlar Vadisi', 'Aksiyon');
insert into filmler values (3, 'Eltilerin Savasi', 'Komedi');
insert into filmler values (4, 'Aile Arasinda', 'Komedi');
insert into filmler values (5, 'GORA', 'Bilim Kurgu'); 
insert into filmler values (6, 'Organize Isler', 'Komedi');
insert into filmler values (7, 'Babam ve Oglum', 'Dram');

create table aktorler (
id int,
actor_name varchar(30),
film_id int
);

insert into aktorler values (1, 'Ata Demirer', 1); 
insert into aktorler values (2, 'Necati Sasmaz', 2);
insert into aktorler values (3, 'Gupse Ozay', 3);
insert into aktorler values (4, 'Engin Gunaydin', 4);
insert into aktorler values (5, 'Cem Yilmaz', 5);


--Soru-15 Tüm film_name leri, kategorilerini ve filmlerde oynayan aktor_name leri listeleyin
--Daha çok hangi tablodan veri alacaksak fromdan sonda onu yazarız

select * from filmler as a left join aktorler as b on a.film_id=b.film_id


select * from aktorler as b left join filmler as a on b.film_id=a.film_id


--Soru-16: tüm actor_name leri ve oynadigi film name leri listeleyiniz
















