--------------DAY'6---------------------
--29-GROUP BY clause:

CREATE TABLE manav
(
isim varchar(50),
urun_adi varchar(50),
urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);  
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);  
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);


SELECT * FROM manav;


--manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarı görüntüleyiniz

select isim 
from manav 
group by isim 


select isim,sum(urun_miktar)--her bir ismin almış olduğu ürün miktarını topladık
from manav 
group by isim 


--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.


select isim,sum(urun_miktar) as toplam_kg
from manav 
group by isim 
order by toplam_kg desc--en çok ürün alandan en az ürün alana doğru sıraladık


--Her bir ismin aldığı her bir ürünün toplam miktarını isme göre sıralı görüntüleyiniz.

select isim,sum(urun_miktar) as toplam_kg
from manav 
group by isim 
order by toplam_kg desc



select isim,urun_adi, sum(urun_miktar) as toplam_kg
from manav
group by isim,urun_adi
order by isim--ilk olarak isme göre grupladık daha sonra ürün id ye göre grupladık sonra isme göre sıraladık


select isim,urun_adi, sum(urun_miktar) as toplam_kg--agregate fonsion birden fazla değer ile çalışıp tek bir sonuc çıkarır (Sum)
from manav
group by isim,urun_adi
order by isim


--not:Group byile gruplama yapıldığında select ten sonra sadece grouplanan stun kullanılabilir yada bir stun aggregate fonksiyon ile sonucu kullanılabilir.

select isim,urun_miktar,sum(urun_miktar)
from manav
group by isim 



--ürün ismine göre her bir ürünü alan toplam kişi sayısı gösteriniz.

SELECT urun_adi,COUNT(distinct isim) as kisi_sayisi
FROM manav
GROUP BY urun_adi;--ürünler kaç defa alınmış onu hesapladık 


--Isme göre alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz


select isim,sum(DISTINCT urun_adi) as urun_sayisi,count(distinct urun_adi)
from manav group by isim

--Isme göre alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz

SELECT isim,SUM(urun_miktar) toplam_kg,COUNT(DISTINCT urun_adi) urun_cesidi
FROM manav
GROUP BY isim


SELECT isim, COUNT(DISTINCT urun_adi) urun_sayisi
FROM manav
GROUP BY isim


--Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sıralayınız.

SELECT urun_miktar, COUNT(DISTINCT isim) musteri_sayisi
FROM manav
GROUP BY urun_miktar
ORDER BY musteri_sayisi ASC















--30-HAVING clause:Group by ile group lama yaptıktan sonra filtrelemek istersek having clouts kullanırız

DROP TABLE personel;

CREATE TABLE personel  (
id int,
isim varchar(50),
sehir varchar(50), 
maas int,  
sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(678901245, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel

--Her bir şirketin MIN maas bilgisini, bu bilgi eğer 4000 den fazla ise görüntüleyiniz.

select sirket,min(maas) as min_maas
from personel 
group by sirket
having min(maas)>4000 --eğer maas 4000 den fazla ise demek having methodu geçici isim kabul etmez

--eğr ilk başta filtreleme istiyorsa o zaman where kullanırız ilk başta gruplama istiyorsa having kullanırız 

--Maaşı 4000 den fazla olan çalışanlardan, her bir şirketin MIN maas bilgisini görüntüleyiniz.

select sirket,min(maas) as min_maas
from personel 
where maas>4000
group by sirket 

--NOT:gruplamadan sonra yapılan işlem sonucu ile ilgili bir koşul belirtmek için HAVING,
--gruplamadan önce kayıtları filtrelemek(koşul belirtmek) için WHERE kullanılır.

--Her bir ismin aldığı toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gösteren sorgu yaziniz.

select isim, sum(maas) as sum_maas
from personel 
group by isim
having sum(maas)>10000;

--Eğer bir şehirde çalışan personel(id) sayısı 1’den çoksa sehir ismini ve personel sayısını veren sorgu yazınız

select sehir,count(distinct id) as Personel_sayisi
from personel
group by sehir 
having count(distinct id)>1

--Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.ÖDEV




--31-UNION:İki farklı sorgunun sonucu birleştirerek tek bir sütunda görüntülemeyi sağlar 
--tekarlı olanları göstermez
--union all: Union gibi kullanılır tekrarlı olanları da gösterir

DROP TABLE developers;

CREATE TABLE developers(
id SERIAL PRIMARY KEY,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20),
city varchar(50),
age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Abdullah Berk','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mehmet Cenk','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Han ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Han','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Muhammed Demir','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fevzi Kaya','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Can','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Tansu Han','tansu@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Said Ran','said@mail.com',4500,'Html','Izmir',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mustafa Pak','mustafa@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Hakan Tek','hakan@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Deniz Çetin','deniz@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Betül Çetin','ummu@mail.com',4000,'C#','Bursa',29);


CREATE TABLE contact_info(
address_id int,
street varchar(30),
number int,	
city varchar(30),
FOREIGN KEY(address_id) REFERENCES developers(id)	
);

INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');


SELECT * FROM developers;
SELECT * FROM contact_info;

--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini birlikte tekrarsız gösteren sorguyu yaziniz

select name from developers where age>25
union--union tekrar eden verileri göstermez
select prog_lang from developers where age<30

--birlikte tekrarlı gösteren sorguyu yaziniz

select name from developers where age>25
union all--all komutu da tekrarlı olanları da yazdırır
select prog_lang from developers where age<30


--NOT:UNION/UNION ALL birleştirdiğimiz sorgular aynı sayıda sütunu göstermeli ve
--alt alta gelecek olan sütunun data tipi aynı olmalı


--Java kullananların maaşını ve prog. dilini ve 
--JavaScript kullananların yaşını ve prog. dilini
--tekrarsız gösteren sorguyu yaziniz

SELECT salary AS maas_yas,prog_lang FROM developers WHERE prog_lang='Java'
UNION
SELECT age AS maas_yas,prog_lang FROM developers WHERE prog_lang='JavaScript'


--id si 8 olan developerın çalıştığı şehir ve maaşını
--iletişim adresindeki şehir ve kapı nosunu görüntüleyiniz.


SELECT city, salary maas_kapino FROM developers WHERE id=8
UNION
SELECT city, number maas_kapino FROM contact_info WHERE address_id=8


--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--tümünü tekrarsız olarak listeleyiniz
--union ile iki farklı sorgunun sonucunu birleştiririz

select city from developers 
union 
select sehir from calisanlar3

--32- Intersect:iki farklı sorgunun sonuçlarından ortak olanları(Kesişimi)
--tekrarsız olarak gösterir


--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--aynı olanlarını tekrarsız olarak listeleyiniz


SELECT city FROM developers
INTERSECT
SELECT sehir FROM calisanlar3;--ortak olan değerleri listeledik


--developers tablosunda Java kullananların çalıştıkları şehirler ve
--calisanlar3 tablosunda maaşı 1000 den fazla olanların sehirlerinden 
--ortak olanlarını listeleyiniz.


SELECT city FROM developers where prog_lang='Java' 
INTERSECT
SELECT sehir FROM calisanlar3 where maas>1000;

--33-EXCEPT:bir sorgunun sonuçlarından diğer bir sorgunun sonuçlarından 
--farklı olanları gösterir.

--developers tablosundaki şehirleri
--calisanlar3 tablosunda sehirler hariç olarak listeleyiniz

SELECT city FROM developers
EXCEPT
SELECT sehir FROM calisanlar3


--calisanlar3 tablosundaki şehirleri
--developers tablosunda sehirler hariç olarak listeleyiniz



SELECT sehir FROM calisanlar3
EXCEPT
SELECT city FROM developers

----developers tablosundaki maaşı 4000 den büyük olanların idlerinden
--contact_info tablosunda olmayanları listeleyiniz.

select id from developers where salary>4000
except
select address_id from contact_info

--hemen mail ile iletişim bilgilerini görüntüleyiniz i 


 --ÖDEV:mart ve nisan tablolarındaki tüm ürünlerin isimlerini tekrarsız listeleyiniz.  
 --ÖDEV:mart ve nisan tablolarındaki ortak ürünlerin isimlerini listeleyiniz.
 --ÖDEV:mart ayında satılıp nisan ayında satılmayan ürünlerin isimlerini listeleyiniz. 
 

 

select distinct urun_isim from mart 
union
select distinct urun_isim from nisan 


select urun_isim from mart
intersect
select urun_isim from nisan

select ürün_id from mart













