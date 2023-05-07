--create database sms
--use sms
create table Students (
roll_number int not null primary key,
first_name varchar(64),
last_name varchar(64),
cnic varchar(13) not null check (LEN(cnic)=13), 
dob date not null, 
gender char(1)not null CHECK (gender IN ('Male', 'Female', 'Other')), 
section VARCHAR(5) not null,
degree VARCHAR(10) not null,
semester_no int not null,
batch VARCHAR(10) not null,
cgpa DECIMAL(4,2),
FOREIGN KEY (section) REFERENCES Section(section),
FOREIGN KEY (degree) REFERENCES Section(degree_program),
FOREIGN KEY (semester_no) REFERENCES Section(semester_no),
FOREIGN KEY (batch) REFERENCES Section(batch)
);

CREATE TABLE Section (
    degree_program varchar(2) not null,
    semester_no int not null,
    section char(1) not null,
    num_students int not null,
	batch int not null,
    primary key (degree_program, semester_no, section)
);

CREATE TABLE Contact_Information (
    Address VARCHAR(255) not null ,
    Home_Phone VARCHAR(20) not null ,
	mobile_no varchar(11) not null check (len(mobile_no)=11),
	email varchar(64) not null ,
    Postal_Code VARCHAR(10) not null ,
    City VARCHAR(100) not null ,
    Country VARCHAR(100) not null 
);



drop table Students

select * from Students	