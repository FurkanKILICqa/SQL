------------------Day'2 NT-------------------
------------------tekrar---------------------
create table sairler(
id int,
name varchar(50),
email varchar(50)
);

insert into sairler values(1001,'Can Yücel','sair@mail.com');
insert into sairler values(1001,'Necip Fazıl','sair@mail.com');
insert into sairler values(1002,'','sair@mail.com');

insert into sairler(name) values('Nazım Hikmet');

select * from sairler;

--9-Tabloya Unique Constranti Ekleme----
create table it_persons(
id serial,--id noyu otomatik olarak sırayla ile arttırır
name varchar(50),
email varchar(50) unique,--Tekrarsızları yazdırır
salary real,
prog_lag varchar(20)
);

insert into it_persons(name,email,salary,prog_lag)
values('Kadir Furkan','QA@mail.com',8000,'QA');

insert into it_persons(name,email,salary,prog_lag)
values('Kadir Furkan','QA@mail.com',8000,'QA');--email unique olmak zorunda burada 1. ile aynı

insert into it_persons(name,email,salary,prog_lag)
values('Kadir Furkan','DEV@mail.com',15000,'Java');


select * from it_persons;

create table doctors(
id serial,
name varchar(50) not null,
email varchar(50) unique not null,
salary real--küsütarlı sayı girecceksek buraya real yazarız
);


insert into doctors(name,email,salary) values('Fatma Hoca','dr@mail.com',8000);

insert into doctors(email,salary) values('dr@mail.com',8000);--bilerek hatalı girdik

insert into doctors(name,email,salary) values('Dr.Who','who@mail.com',70000);

insert into doctors(name,email,salary) values('','notnull@mail.com',8000);--not null komutu
--boş değer ('') kabul eder.

select * from doctors;

--11-- taploya PK contrinti ekleme----
--Her tabloda sadece bir tane primary key kullanılabilir
CREATE TABLE students2(
id int primary key,--not null, unique, başka bir tabloyla ilişkilendirmek için kullanılacak
name varchar(50),
grade real,
register_date date	
);

select * from students2;

--11-- taploya PK contrinti ekleme 2. yöntem----

CREATE TABLE students3(
id int,
name varchar(50),
grade real,
register_date date,
constraint std_pk primary key(id)--kendimiz constraintimize isim verebiliyoruz bu yöntem de
--tek bir stun pk içermiyorsa birden fazla stünları bir araya getirerek bu sistem ile yaparız
--composit yapmak için kullanılır
);

select * from students3;



CREATE TABLE students4(
id int,
name varchar(50),
grade real,
register_date date,
constraint composite_pk primary key(id,name)
);

--12--Tabloya FK constrainit ekleme----

CREATE TABLE address3(
address_id int,
street VARCHAR(50),
city VARCHAR(50),
student_id int,--FK, null kabul eder,duplicate kabul eder
CONSTRAINT add_fk FOREIGN KEY(student_id) REFERENCES students3(id)
);

select * from address3;


--13-tabloya CHECK constrainti ekleme

create table personel(
id int,
name varchar(50),
salary real check(salary>8000),
age int check(0<age and age<50) --Negatif olamlı	
);

insert into personel values(11,'Kadir Furkan',12000,27);


select * from personel;









