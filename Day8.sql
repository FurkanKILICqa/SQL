-------------Day 8'--------------

select * from developers where name like 'A%n'--Ayşenur Han değerinde en sonunda boşluk olduğu için bu sonucu göremedik

select * from developers

--39-String Fonksiyon

select name,length(name) as isim_uzunlugu--Name sutunundaki isimleri ve isimlerin uzunluklarını yazdırdık
from developers

update developers set name=trim(name) --Name sütunundaki bütün değerleri sildik trim methodu ile


--developers tablosunda name değerlerinde 'Ayşenur' kelimesini 'Ayşe' ile değiştiririnz.

update developers set name=replace(name,'Ayşenur','Ayşe')--Name Ayşenura eşit olan tüm kelimeleri Ayşe kelimesi ile değiştirdik


select upper(name), lower(prog_lang)--Name stunundaki tüm değerler Büyükharfe prog_lang deki tüm değerler küçükharfe dönüştürüldü
from developers


select * from calisanlar3;


--calisanlar3 tablosunda isyeri='Vakko' olan kayıtlarda 
--'Şubesi' ifadesini siliniz.


update calisanlar3 set sehir=replace(sehir,'Subesi',' ')--Şubesi kelimesini sildik 

update calisanlar3 set sehir=substring(sehir,1,length(sehir)-7)--Baştan son 7 karaktere kadar sil
where isyeri='Vakko'




--words tablosunda tüm kelimeleri(word) ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.

select initcap(word) from words;--İsimlerin ilk harlerini büyük yazdık



--words tablosunda tüm kelimeleri ve tüm kelimelerin(word) ilk 2 harfini görüntüleyiniz.

select word,substring(word,1,2)--Word stunundaki isimlerin ilk iki harfi ni yazdık
from words


--words tablosunda tüm kelimeleri ve tüm kelimelerin(word) 2. indeksten itibaren kalanını görüntüleyiniz.

SELECT word,SUBSTRING(word,2) FROM words;


--40-FETCH NEXT n ROW ONLY:sadece sıradaki ilk n satırı getirir
--                  LIMIT n:sadece sıradaki ilk n satırı getirir
--                  OFFSET n: n satırı atlayıp sonrakileri getirir



--developers tablosundan ekleme sırasına göre ilk 3 kaydı getiriniz.

SELECT * 
FROM developers
FETCH NEXT 3 ROW ONLY;

SELECT * 
FROM developers
LIMIT 3;


--developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.

SELECT * 
FROM developers
offset 2 row --Burada row zorunludeğil
FETCH NEXT 3 ROW ONLY;--İlk iki satırı atla ve sonraki üç satırı getir

SELECT * 
FROM developers
offset 2 
LIMIT 3;--Bununla üstteki arasında hiç bir fark yok 

--developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.

select * from developers 
order by salary asc--Küçükten büyüğe sıraladık
limit 3;--Maaşı en düşük ilk 3 veiryi getirdik

--developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.

select * from developers 
order by salary desc
offset 1 -- İlk Kaydı atla
limit 1--En yüksek ikinci maası bulduk 

--41-Alter Table: Tabloyu güncellemek için kullanırız:DDL

/*
add column ==> yeni sutun ekler
drop column ==> mevcut olan sutunu siler
rename column.. to.. ==> sutunun ismini degistirir      
rename.. to.. ==> tablonun ismini degistirir*/



--calisanlar3 tablosuna yas (int) seklinde yeni sutun ekleyiniz.

select * from employees;



alter table calisanlar3
add column yas int-- Data tipi ile yazmalıyız, yaş stunu ekledik


--calisanlar3 tablosuna remote (boolean) seklinde yeni sutun ekleyiniz.
--varsayılan olarak remote değeri TRUE olsun

alter table calisanlar3 
add column remote boolean default true--Remote isminde boolean data tipinde defoult true defoult tan sora vermek istediğimiz değeri girebiliriz


--calisanlar3 tablosunda yas sutununu siliniz.

alter table calisanlar3
drop column yas --Yas sütunu nu sildik 



--calisanlar3 tablosundaki maas sutununun data tipini real olarak güncelleyiniz.

alter table calisanlar3
alter column maas type real; --Maas sütunun daki data tipini real olarak değiştirdik 

--calisanlar3 tablosundaki maas sutununun ismini gelir olarak güncelleyiniz.

alter table calisanlar3
rename column maas to gelir--Maas sütunundaki ismi gelir olarak değiştirdik 


--calisanlar3 tablosunun ismini employees olarak güncelleyiniz.

alter table calisanlar3
rename to employees --calisanlar3 tablosunu employees olarak değiştirdik 


--employees tablosunda id sütunun data tipini varchar olarak güncelleyiniz.

alter table employees
alter column id type varchar(20)



--employees tablosunda id sütunun data tipini int olarak güncelleyiniz.

alter table employees
alter column id type int using id :: int --id sütunu nun ismin ni int olarak değiştirdik ilk başta hata verdi sonra eminim değiştir dedik sonra kabul etti 

--employees tablosunda isim sütununa NOT NULL constrainti ekleyiniz.

alter table employees
alter column isim set not null --İsim sütunu Not null olsun dedik (Değersiz olamsın dedik)


--NOT:içinde kayıtlar bulunan bir tabloyu güncellerken bir sütuna 
--NOT NULL,PK,FK,UNIQUE vs constraintleri ekleyebilmek için önce
--bu sütunların değerleri ilgili const.  sağlıyor olmalı.
--Not null uniuqe(Tekrarsız) == primary key
--subquary ile sadece getirme (Select) işlemi yapılır ve join ile de aynı şekilde

alter table sirketler
add primary key (sirket_id);

select * from employees;

--sirketler tablosunda sirket_isim sütununa UNIQUE constrainti ekleyiniz.
ALTER TABLE sirketler
ADD UNIQUE(sirket_isim)--eğer tekrarlı 


--siparis tablosunda sirket_id sütununa FK constrainti ekleyiniz.
ALTER TABLE siparis
ADD FOREIGN KEY(sirket_id) REFERENCES sirketler(sirket_id)

DELETE FROM siparis WHERE sirket_id IN (104,105)--104,105 değerleri primary key de olmadığı için sildik

--siparis tablosundaki FK constrainti kaldırınız.
ALTER TABLE siparis
DROP CONSTRAINT siparis_sirket_id_fkey--Foreign constraintini kaldıkdık

--employees tablosunda isim sütununda NOT NULL constraintini kaldırınız.
ALTER TABLE employees
ALTER COLUMN isim DROP NOT NULL-- İsim sütunun daki not null ifadesini sildik (not null bir constraint değildir) 

--42-Transsaction: Database deki en küçük işlem birimi 		
--       BEGIN:transactionı başlatır
--       COMMIT:transactionı onaylar ve sonlandırır
--       SAVEPOINT: kayıt noktası oluşturur
--       ROLLBACK:değişikleri mevcut duruma geri döndürür,transactionı sonlandırır


CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);

INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);


SELECT * FROM hesaplar;


UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
--sistemde hata oluştu
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;
--veriler tutarsız

SELECT * FROM hesaplar;

-------------------------------------------------

BEGIN;
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

BEGIN;
INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);

SAVEPOINT x;

SELECT * FROM hesaplar;

--try{
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;

--sistemde hata oluştu, catch bloğundan devam

UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--bu işlem başarısız
--veriler tutarsız

COMMIT;
--}catch(hata){
ROLLBACK TO x;
--}

-----------------------------------pozitif senaryo
--try{
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;--başarılı

UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--başarılı

COMMIT;

--}catch(hata){
ROLLBACK TO x;
--}

SELECT * FROM hesaplar;






















