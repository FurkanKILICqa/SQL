--Yorum satırı

--------------------DAY'1 DT-------------------------

--1-create database
CREATE DATABASE kadir_furkan;--SQL komutlarında küçük/büyük harf duyarlılığı yoktur.
CREATE DATABASE frkn;


--2-database silme 

DROP DATABASE frkn;

--Bu databaseler dll dir.

--3-tablo oluşturma --data defination language DDL

create table students(
id CHAR(4),
name varchar(20),
grade real,
register_date DATE
);

--4-mevcut olan bir tablodan yeni tablo oluşturma
create table grades as select name,grade from students;

--5-tabloya data ekleme-- Data manipulation language DML
insert into students values('1001','Sherlock Holmes',99.5,'2074-10-04');
insert into students values( '1002','Jack Sparrow',88.8,now());

--6-tablodaki tüm dataları görüntüleme

select * from students;--DQL

--7-tablonun bazı sütunlarına data ekleme --(data eklemediğimiz sütunlara null eklenir)
--ondalıklı değerleri girmek için "." kullanırız "," kulalanırsak yeni değer algılar

insert into students(name,grade) values( 'Harry Potter',99.9 );

--8-tablodaki tüm kayıtların sadece belirli sütunlar görüntüleme

select name,grade from students

--practice
--tabloyu sil
--4. query i tekrar çalıştıralım

select * from grades;
--------------------------------------------

create table tedarikciler(
id char(4),
name varchar(10),
adress varchar(50),
ulasim_tarihi date
);

create table tedarikci_info as select name,ulasim_tarihi from tedarikciler;

select * from tedarikci_info;

insert into tedarikciler values('1001','Monitor','Fatih_Cad.',now());

select * from tedarikciler;

create table ogretmenler (
kimli_no_id char(15),
name varchar(30),
brans varchar(25),
cinsiyet char(6)
);

insert into ogretmenler values('234431223','Ayse Güler','Matematik','kadin');
insert into ogretmenler values('234431224','Ali Güler','Fizik','Erkek')

select * from ogretmenler;

create table ogretmenler_ekleme as select kimli_no_id,name from ogretmenler;


insert into ogretmenler(kimli_no_id,name) values('567597624','Veli_Güler');












