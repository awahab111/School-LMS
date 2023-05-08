--create database sms
--use sms
create table Students (
	roll_number VARCHAR(4) not null primary key,
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
	roll_number VARCHAR(4) not null primary key, 
    Address VARCHAR(255) not null ,
    Home_Phone VARCHAR(20) not null ,
	mobile_no varchar(11) not null check (len(mobile_no)=11),
	email varchar(64) not null ,
    Postal_Code VARCHAR(6) not null check (LEN(postal_code) = 6),
	city varchar(50) not null check (city not like '%[^A-Za-z]%'),
	country varchar(50) not null check (country not like '%[^A-Za-z]%'),
	FOREIGN KEY (roll_number) REFERENCES Students(roll_number)
);

CREATE TABLE Course (
    CourseCode VARCHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    CourseName VARCHAR(50) NOT NULL,
    CreditHours INT NOT NULL CHECK (CreditHours > 0),
    CourseCoordinator VARCHAR(50) NOT NULL,
);

CREATE TABLE PrereqCourse (
    PrereqID INT IDENTITY(1,1) PRIMARY KEY,
    CourseCode VARCHAR(10) not null,
    PrereqCourseCode VARCHAR(10),
    FOREIGN KEY (CourseCode) REFERENCES Course(CourseCode),
    FOREIGN KEY (PrereqCourseCode) REFERENCES Course(CourseCode)
);

CREATE TABLE Attendance (
    AttendanceID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID VARCHAR(4),
    CourseID VARCHAR(10),
    LectureNo INT,
    AttendanceDate DATE,
    Duration INT,
    Presence BIT,
    FOREIGN KEY (StudentID) REFERENCES Students(roll_number),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseCode)
);

CREATE TABLE Marks (
    MarksID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID VARCHAR(4),
    CourseID VARCHAR(10),
    TotalMarks FLOAT,
    ObtainedMarks FLOAT NOT NULL CHECK (ObtainedMarks >= 0 AND ObtainedMarks <= TotalMarks),
    MarksOf VARCHAR(1),
	FOREIGN KEY (StudentID) REFERENCES Students(roll_number),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseCode)
);

CREATE TABLE Evaluations (
    EvaluationID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID VARCHAR(10),
    AssignmentWeightage FLOAT,
    QuizWeightage FLOAT,
    FinalExamWeightage FLOAT,
    Sessional1Weightage FLOAT,
    Sessional2Weightage FLOAT,
    CONSTRAINT CHK_Evaluations_Weightage CHECK (AssignmentWeightage + QuizWeightage + FinalExamWeightage + Sessional1Weightage + Sessional2Weightage = 100),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseCode)
);





drop table Students

select * from Students	