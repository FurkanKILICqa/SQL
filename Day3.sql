------------------ DAY'3 DT-NT -------------------
------------------   tekrar ------------------

CREATE TABLE calisanlar(
id char(5) PRIMARY KEY,--bu sütun başka bir tablo ile kullanılacak ken çalışacak
isim varchar(50) UNIQUE,
maas int NOT NULL,
ise_baslama date
);--parennt yada referanced

CREATE TABLE adresler(
adres_id char(5),--null ve tekrarlı (dabliquate) verileri foreign key kabul eder
sokak varchar(30),
cadde varchar(30),
sehir varchar(20),
FOREIGN KEY(adres_id) REFERENCES calisanlar(id) 
);--child

--Her iki isim de birbirinin aynı olmaılı bağlarken 

INSERT INTO calisanlar VALUES('10002', 'Donatello' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10003', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10004', 'Donatello', 5000, '2018-04-14'); --isim unique olmalı
INSERT INTO calisanlar VALUES('10005', 'Michelangelo', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Leonardo', null, '2019-04-12');--maaş null olamaz
INSERT INTO calisanlar VALUES('10007', 'Raphael', '', '2018-04-14');--integer emtpy olamaz, tırnak içinde yazılamaz
INSERT INTO calisanlar VALUES('', 'April', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'Ms.April', 2000, '2018-04-14');--isim üstte empty yani iki defa empyt olamaz
INSERT INTO calisanlar VALUES('10002', 'Splinter' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES( null, 'Fred' ,12000, '2018-04-14');--primary key null kabul etmez
INSERT INTO calisanlar VALUES('10008', 'Barnie' ,10000, '2018-04-14');
INSERT INTO calisanlar VALUES('10009', 'Wilma' ,11000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Betty' ,12000, '2018-04-14');

INSERT INTO adresler VALUES('10003','Ninja Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Kaya Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Taş Sok', '30.Cad.','Konya');

INSERT INTO adresler VALUES('10012','Taş Sok', '30.Cad.','Konya');--freign key primary den referans alır
--primaryde oldağığı için kabul etmez -- çalışanlarda 10012 yok


INSERT INTO adresler VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');

select * from calisanlar;
select * from adresler;

--14-Where Condition(Koşulu) 

--çalışanlar tablosundan ismi donatello olanların tüm bilgilerini listeleyelim

select * from calisanlar where isim='Donatello'--Birtane getidi çünkü isim stünu unique dir

--çalışanlar tablosundan maası 5000 den fazla olanların tüm bilgilerini listeleyelim


select * from calisanlar where maas>5000;


--çalışanlar tablosundan maası 5000 den fazla olanların isim ve maas larını tüm bilgilerini listeleyelim

select isim,maas from calisanlar where maas>5000;


--adresler tablosundan sehiri 'Konya' ve 
--adres_id si 10002 olan tüm verileri getir
--or ve and komutlarını istediğimiz kadar kullanabiliriz

-- !!!!!  char ve varchar data tipleri her zaman tek tırnak ile birlikte yazılır !!!!!

select * from adresler where adres_id='10002' and sehir='Konya';

--sehiri 'Konya' veya 'Bursa' olan adress lerin cadde ve sehir bilgilerini getirelim

select * from adresler where sehir='Bursa' or sehir='Konya';

--15-Delete From ... Where ... Bu komutmuz koşulu sağlayan kayıtları siler-- DML-- Data Manipulation Language ailesinden dir

CREATE TABLE ogrenciler1
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);
INSERT INTO ogrenciler1 VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO ogrenciler1 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler1 VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO ogrenciler1 VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO ogrenciler1 VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO ogrenciler1 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler1 VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler1 VALUES(129, 'Mehmet Bak', 'Alihan', 89);

select * from ogrenciler1;


--id=123 olan kaydı silelim


delete from ogrenciler1 Where id=123;-- 1 Tane silindi

--ismi kemal olan kaydı silelim
delete from ogrenciler1 where isim='Kemal Tan'
--ismi Ahmet Ran veya Veli Han kayıtları silelim
delete from ogrenciler1 where isim='Ahmet Ran' or isim='Veli Han';

--16-a- Tablodaki tüm kayıtları silme: DELETE FROM .. :koşul belitmezsek tablodaki tüm kayıtlar silinir,tablo boş durur
select * from students

--students tablosundaki tüm kayıtları silelim


delete from students;--Tablo hala durur sadece içindekileri siler

--16-b-Tablodaki tüm kayıtları silme:TRUNCATE TABLE ..

select * from doctors

--doctors tablosundaki tüm kayıtları silelim. 

truncate table doctors--tablodakilerin hepsini siler tablo durur koşul belirtemeyiz sadece tüm kayıtları silmek için kullanırız

--17-Parent child ilişkisi olan tablolarda silme işlemi (aşamalısilme işlemidir)

select * from calisanlar;--Parent

select * from adresler;--child

--calisanlar tablosundaki tüm kayıtları silelelim

delete from calisanlar;--bazı kayıtlar adresler tablosunda referans alındığı için silmez.
delete from calisanlar where id '10002';--bazı kayıtlar adresler tablosunda referans alındığı için silmez.

delete from adresler where adres_id = '10002';--refaerans alınan bilgi silindi ilişki koparıldı
delete from calisanlar where id= '10002';--artık referans alına bir kayıt olmadığı için yani bir ilişki olmadığı siler


delete from adresler;--Tüm ilişki koparıldı
delete from calisanlar;--Artık hiçbir kayıt ref almıyor


--18-On Delete Cascade (Kademe) : Kademeli silme işlemini otomatik siler


CREATE TABLE talebeler
(
id int primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
--parent

CREATE TABLE notlar( 
talebe_id int,
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id) on delete cascade --bir bütün dür
);--Child


INSERT INTO talebeler VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO talebeler VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO talebeler VALUES(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);
INSERT INTO notlar VALUES ('127', 'Matematik',90);
INSERT INTO notlar VALUES (null, 'tarih',90);

select * from talebeler;
select * from notlar;


--notlar tablosundan talebe_id:123 plan kaydı silelim
--childlerden istediğimizi silebeliriz çünkü refens yok

delete from notlar where talebe_id=123;

--talebeler tablosundan id:126 olan kaydı silelim.
--parenttan referanslı kayıt silmek için aşamalı(cascade)
--silme yapmalıydık
--on delete cascade öz önce notlar tablosundan ref. siler
--sonra parenttan ref. kaldırılan kaydı siler.


delete from talebeler where id=126;--Başarılı

delete from talebeler;--talebelerin hepsini sildi, notlar tablosundan referans alınmayan haric hepsini sildi 
--notlar tablosundan da sadece ref. olan kayıtları siler


--19-Tabloyu silme :Tablyu SCHEMA dan kaldırma 
--sairler tablosunu silelim

drop table sairler;--DDL--Data Definition Language, tablo silme
drop table talebeler;--İlişki hala tanımlı olduğu için bu şekilde silmez

drop table talebeler cascade;--notlar tablosundaki ry key kısıtlamasını sildi

-- talebeler 1 tablosunu silelim

drop table if exists talebeler1;--Hatayı almamk için eğer varsa sil yoksa yata verme dedih if exests ile sadece uyarı verir

--20-In Condition Komutu: Liste içinde ise true


CREATE TABLE musteriler  (
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler;

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.

select *
from musteriler
where urun_isim = 'Orange' or urun_isim='Apple' or urun_isim='Apricot';

--2.Yol

Select * 
from musteriler 
where urun_isim in ('Orange', 'Apple', 'Apricot')

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' ve 'Apricot' olmayan verileri listeleyiniz.


Select * 
from musteriler 
where urun_isim not in ('Orange', 'Apple', 'Apricot')

--21- Between... And... Komutları

--Müşteriler tablosunda urun_id 20 ile 40(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz

select * 
from musteriler 
where urun_id>=20 and  urun_id<=40;

--2.Yol

select * from musteriler
where urun_id 
between 20 and 40; --20 ve 40 dahildir

--Müşteriler tablosunda urun_id 20 den küçük veya 30(dahil değil) dan büyük olan urunlerin tum bilgilerini listeleyiniz

select * 
from musteriler 
where urun_id<20 or urun_id>30;

--2.Yol

select * 
from musteriler 
where urun_id not between 20 and 30;


--22-Agregate (Toplamsal) Fonksiyon (Javadaki Methotlar gibi)

CREATE TABLE calisanlar3 (
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM markalar;
SELECT * FROM calisanlar3;

--çalışanlar3 tablosunda max maaşı görüntüleyiniz

select maas from calisanlar3;

--çalışanlar3 tablosunda toplam maaşı görüntüleyiniz
select max(maas) from calisanlar3;--en büyük değeri döndürdü 

--çalışanlar3 tablosunda toplam maaşı görüntüleyiniz

select min(maas) from calisanlar3;--en küçük değeri döndür

--çalışanlar3 tablosunda toplam maaşı görüntüleyiniz
select sum(maas) from calisanlar3;--bütün maaşları topladı

--çalışanlar3 tablosunda toplam maaşı görüntüleyiniz
select avg(maas) from calisanlar3;--ortalaması nı hesapladı

--çalışanlar3 tablosunda toplam maaşı görüntüleyiniz
select ROUND(avg(maas),2) from calisanlar3;--küsüratı sildi yuvarlayarak söyledi

--çalışanlar3 tablosunda toplam maaşı görüntüleyiniz

select count(*) from calisanlar3;--kaç tane maaş veriliyor onu hesapladı 7 
select count(maas) from calisanlar3;


--çalışanlar3 tablosunda toplam maaşı 2500 olanların sayısını görüntüleyin
SELECT COUNT(maas) FROM calisanlar3 WHERE maas=2500






