Use master
Drop database if exists sms
Create database sms
Use sms
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Email VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    LoginType VARCHAR(1) NOT NULL
);

CREATE TABLE Section (
	sectionID INT IDENTITY(1,1) PRIMARY KEY,
    degree_program varchar(2) not null,
    semester_no int not null,
    section char(1) not null,
    num_students int not null,
	batch int not null
);


create table Students (
	roll_number VARCHAR(4) not null primary key,
	first_name varchar(64),
	last_name varchar(64),
	cnic varchar(13) not null check (LEN(cnic)=13), 
	dob date not null, 
	gender char(1)not null CHECK (gender IN ('M', 'F', 'O')), 
	sectionID INT not null ,
	cgpa DECIMAL(4,2),
	user_num INT NOT NULL, 
	FOREIGN KEY (user_num) REFERENCES Users(UserID),
	FOREIGN KEY (sectionID) REFERENCES Section(sectionID)
);


-- RelationShip between Students and Section
CREATE TABLE StudentSections (
    idx INT IDENTITY(1,1) PRIMARY KEY,
    roll_number VARCHAR(4) NOT NULL,
    section_id INT NOT NULL,
    CONSTRAINT fk_roll_number FOREIGN KEY (roll_number) REFERENCES Students (roll_number),
    CONSTRAINT fk_section_id FOREIGN KEY (section_id) REFERENCES Section(sectionID)
);

CREATE TABLE Contact_Information (
	roll_number VARCHAR(4) not null primary key, 
    Address VARCHAR(255) not null ,
    Home_Phone VARCHAR(20) not null ,
	mobile_no varchar(11) not null check (len(mobile_no)=11),
	personal_email varchar(64) not null ,
    Postal_Code VARCHAR(6) not null check (LEN(postal_code) = 6),
	city varchar(50) not null check (city not like '%[^A-Za-z]%'),
	country varchar(50) not null check (country not like '%[^A-Za-z]%'),
	FOREIGN KEY (roll_number) REFERENCES Students(roll_number)
);

CREATE TABLE Course (
    CourseCode VARCHAR(10) NOT NULL PRIMARY KEY,
    CourseName VARCHAR(50) NOT NULL,
    CreditHours INT NOT NULL CHECK (CreditHours > 0),
    CourseCoordinator VARCHAR(50) NOT NULL,
);

-- Recursive Relationship of Course 
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
    ObtainedMarks FLOAT NOT NULL,
    MarksOf VARCHAR(1),
	FOREIGN KEY (StudentID) REFERENCES Students(roll_number),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseCode),
    CHECK (ObtainedMarks >= 0 AND ObtainedMarks <= TotalMarks)
);

CREATE TABLE Evaluations (
    EvaluationID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID VARCHAR(10),
    AssignmentWeightage FLOAT,
    QuizWeightage FLOAT,
    FinalExamWeightage FLOAT,
    Sessional1Weightage FLOAT,
    Sessional2Weightage FLOAT,
	ProjectWeightage FLOAT,
	CPWeightage FLOAT,
    CONSTRAINT CHK_Evaluations_Weightage CHECK (ProjectWeightage + CPWeightage + AssignmentWeightage + QuizWeightage + FinalExamWeightage + Sessional1Weightage + Sessional2Weightage = 100),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseCode)
);

select AssignmentWeightage, QuizWeightage,FinalExamWeightage ,Sessional1Weightage, Sessional2Weightage, ProjectWeightage,CPWeightage from Evaluations where CourseID='CS101'



CREATE TABLE Jobs (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    JobName VARCHAR(50) NOT NULL
);

CREATE TABLE AcademicOfficers (
    OfficerID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    JobID INT,
    CNIC VARCHAR(15) UNIQUE,
    user_num INT, 
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
	FOREIGN KEY (user_num) REFERENCES Users(UserID)
);

CREATE TABLE Faculty (
    FacultyID INT IDENTITY(1,1) PRIMARY KEY,
    FacultyName VARCHAR(50) NOT NULL,
    CNIC VARCHAR(15) NOT NULL,
    user_num INT, 
	FOREIGN KEY (user_num) REFERENCES Users (UserID)
);

CREATE TABLE CourseInstructor (
	FacultyID INT PRIMARY KEY, 
    is_coordinator INT,
    Subject_Teaching VARCHAR(50) NOT NULL,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

CREATE TABLE LabInstructor (
	FacultyID INT PRIMARY KEY, 
    Subject_Teaching VARCHAR(50) NOT NULL,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

-- Relationship Between Sections and Faculty
CREATE TABLE SectionsTeaching (
    SectionID INT PRIMARY KEY,
    SectionName VARCHAR(50),
    CourseID VARCHAR(10),
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Faculty(FacultyID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseCode)
);

-- Relationship Between Students and Course 
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID VARCHAR(4) NOT NULL,
    CourseID VARCHAR(10) NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(roll_number),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseCode)
);



--Users insertion
INSERT INTO Users (Email, Password, LoginType)
VALUES
('john@example.com', 'johndoe123', 'E'),
('jane@example.com', 'janedoe123', 'E'),
('jimmy@example.com', 'jimmyjohns123', 'E'),
('sara@example.com', 'sarasampson123', 'E'),
('tim@example.com', 'timtaylor123', 'E'),
('amanda@example.com', 'amandabaker123', 'E'),
('admin1@example.com', 'admin123', 'A'),
('admin2@example.com', 'admin456', 'A'),
('teacher1@example.com', 'teacher123', 'T'),
('teacher2@example.com', 'teacher456', 'T');

--Section insertion
INSERT INTO Section (degree_program, semester_no, section, num_students, batch)
VALUES
('CS', 1, 'A', 30, 2023),
('CS', 1, 'B', 25, 2023),
('CS', 1, 'C', 28, 2023),
('CS', 2, 'A', 32, 2022),
('CS', 2, 'B', 27, 2022),
('CS', 2, 'C', 29, 2022),
('IT', 1, 'A', 20, 2023),
('IT', 1, 'B', 18, 2023),
('IT', 2, 'A', 22, 2022),
('IT', 2, 'B', 19, 2022);

--Students insertion
INSERT INTO Students (roll_number, first_name, last_name, cnic, dob, gender, sectionID, cgpa, user_num)
VALUES
('S001', 'John', 'Doe', '1234567890123', '1998-02-15', 'M', 1, 3.5, 1),
('S002', 'Jane', 'Doe', '1234567890124', '1999-05-21', 'F', 1, 3.8, 2),
('S003', 'Bob', 'Smith', '1234567890125', '1997-12-01', 'M', 1, 3.2, 3),
('S004', 'Alice', 'Johnson', '1234567890126', '1998-09-10', 'F', 1, 3.6, 4),
('S005', 'Mike', 'Brown', '1234567890127', '1999-03-25', 'M', 1, 3.4, 5),
('S006', 'Emily', 'Davis', '1234567890128', '1997-06-12', 'F', 1, 3.9, 6),
('S007', 'David', 'Wilson', '1234567890129', '1998-11-08', 'M', 1, 3.3, 7),
('S008', 'Sarah', 'Martin', '1234567890130', '1999-01-30', 'F', 1, 3.7, 8),
('S009', 'Alex', 'Taylor', '1234567890131', '1997-10-05', 'M', 1, 3.1, 9),
('S010', 'Olivia', 'Miller', '1234567890132', '1998-07-19', 'F', 1, 3.5, 10);

--StudentSections insertions
INSERT INTO StudentSections (roll_number, section_id)
VALUES
('S001', 1),
('S002', 1),
('S003', 1),
('S004', 2),
('S005', 2),
('S006', 2),
('S007', 3),
('S008', 3),
('S009', 3),
('S010', 4);

--Contact_Information insertions
INSERT INTO Contact_Information (roll_number, Address, Home_Phone, mobile_no, personal_email, Postal_Code, city, country)
VALUES
('S001', '123 Main St', '555-1234', '03211234567', 'john.doe@email.com', '123456', 'Lahore', 'Pakistan'),
('S002', '456 Second Ave', '555-5678', '03331234567', 'jane.doe@email.com', '234567', 'Karachi', 'Pakistan'),
('S003', '789 Third St', '555-9012', '03451234567', 'jim.smith@email.com', '345678', 'Islamabad', 'Pakistan'),
('S004', '987 Fourth Ave', '555-3456', '03121234567', 'jenny.smith@email.com', '456789', 'Lahore', 'Pakistan'),
('S005', '654 Fifth St', '555-7890', '03131234567', 'johnny.appleseed@email.com', '567890', 'Karachi', 'Pakistan'),
('S006', '321 Sixth Ave', '555-2345', '03111234567', 'jane.smith@email.com', '678901', 'Islamabad', 'Pakistan'),
('S007', '159 Seventh St', '555-6789', '03151234567', 'jimmy.johns@email.com', '789012', 'Lahore', 'Pakistan'),
('S008', '753 Eighth Ave', '555-1234', '03221234567', 'jenny.jones@email.com', '890123', 'Karachi', 'Pakistan'),
('S009', '246 Ninth St', '555-5678', '03321234567', 'jimmy.neutron@email.com', '901234', 'Islamabad', 'Pakistan'),
('S010', '852 Tenth Ave', '555-9012', '03441234567', 'jenny.apple@gmail.com', '012345', 'Lahore', 'Pakistan');

--Course insertions
INSERT INTO Course (CourseCode, CourseName, CreditHours, CourseCoordinator) 
VALUES 
    ('CS101', 'Introduction to Computer Science', 3, 'Dr. Ali'),
    ('CS201', 'Data Structures and Algorithms', 4, 'Dr. Khan'),
    ('CS301', 'Database Systems', 3, 'Dr. Ali'),
    ('CS401', 'Artificial Intelligence', 4, 'Dr. Ahmed'),
    ('CS501', 'Advanced Algorithms', 3, 'Dr. Khan'),
    ('CS601', 'Computer Networks', 3, 'Dr. Ali'),
    ('CS701', 'Distributed Systems', 4, 'Dr. Ahmed'),
    ('CS801', 'Machine Learning', 4, 'Dr. Khan'),
    ('CS901', 'Big Data Analytics', 3, 'Dr. Ahmed'),
    ('CS1001', 'Software Engineering', 4, 'Dr. Ali');

--PrereqCourse insertions
INSERT INTO PrereqCourse (CourseCode, PrereqCourseCode)
VALUES 
    ('CS201', 'CS101'),
    ('CS301', 'CS101'),
    ('CS401', 'CS201'),
    ('CS501', 'CS201'),
    ('CS601', 'CS301'),
    ('CS701', 'CS401'),
    ('CS701', 'CS601'),
    ('CS801', 'CS401'),
    ('CS901', 'CS601'),
    ('CS1001', 'CS301');

--Attendance insertions
INSERT INTO Attendance (StudentID, CourseID, LectureNo, AttendanceDate, Duration, Presence)
VALUES 
('1234', 'CS101', 2, '2023-05-01', 60, 1);
('1234', 'CS201', 1, '2023-05-01', 60, 1),
('1234', 'CS301', 1, '2023-05-01', 60, 0),
('1234', 'CS401', 1, '2023-05-01', 60, 1),
('1234', 'CS501', 1, '2023-05-01', 60, 1);
('S006', 'CS601', 1, '2023-05-02', 60, 1),
('S007', 'CS701', 1, '2023-05-02', 60, 0),
('S008', 'CS801', 1, '2023-05-02', 60, 1),
('S009', 'CS901', 1, '2023-05-02', 60, 1),
('S010', 'CS1001', 1, '2023-05-02', 60, 0);

--Marks insertions
INSERT INTO Marks (StudentID, CourseID, TotalMarks, ObtainedMarks, MarksOf)
VALUES
('S001', 'CS101', 100.0, 85.0, 'A'),
('S002', 'CS101', 100.0, 75.0, 'A'),
('S003', 'CS101', 100.0, 90.0, 'A'),
('S004', 'CS101', 100.0, 80.0, 'A'),
('S005', 'CS201', 100.0, 95.0, 'A'),
('S006', 'CS201', 100.0, 85.0, 'A'),
('S007', 'CS201', 100.0, 92.0, 'A'),
('S008', 'CS201', 100.0, 88.0, 'A'),
('S009', 'CS301', 100.0, 87.0, 'A'),
('S010', 'CS301', 100.0, 77.0, 'A');

--Evaluations insertions
INSERT INTO Evaluations (CourseID, AssignmentWeightage, QuizWeightage, FinalExamWeightage, Sessional1Weightage, Sessional2Weightage, ProjectWeightage, CPWeightage)
VALUES
('CS101', 10, 15, 40, 10, 10, 10, 5),
('CS201', 10, 10, 40, 10, 10, 10, 10),
('CS301', 20, 10, 30, 10, 10, 10, 10),
('CS401', 10, 15, 30, 15, 10, 10, 10),
('CS501', 20, 10, 30, 20, 10, 5, 5),
('CS601', 20, 10, 30, 20, 10, 5, 5),
('CS701', 10, 15, 30, 20, 10, 5, 10),
('CS801', 10, 20, 30, 20, 10, 5, 5),
('CS901', 20, 10, 20, 20, 10, 10, 10),
('CS1001', 20, 10, 20, 20, 10, 10, 10);

--Jobs insertions
INSERT INTO Jobs (JobName)
VALUES
('Software Engineer'),
('Data Analyst'),
('Marketing Manager'),
('Sales Representative'),
('Accountant'),
('Human Resources Manager'),
('Operations Manager'),
('Graphic Designer'),
('Customer Service Representative'),
('Project Manager');

--AcademicOfficers insertions
INSERT INTO AcademicOfficers (Name, JobID, CNIC, user_num)
VALUES
    ('John Smith', 1, '1234567890123', 1),
    ('Jane Doe', 2, '2345678901234', 2),
    ('Bob Johnson', 1, '3456789012345', 3),
    ('Alice Lee', 3, '4567890123456', 4),
    ('Tom Williams', 2, '5678901234567', 5),
    ('Samantha Davis', 1, '6789012345678', 6),
    ('David Chen', 3, '7890123456789', 7),
    ('Emily Kim', 2, '8901234567890', 8),
    ('Michael Brown', 1, '9012345678901', 9),
    ('Olivia Lee', 3, '0123456789012', 10);

--Faculty insertions
INSERT INTO Faculty (FacultyName, CNIC, user_num)
VALUES
('John Doe', '1234567890123', 1),
('Jane Doe', '1234567890124', 2),
('Bob Smith', '1234567890125', 3),
('Alice Johnson', '1234567890126', 4),
('Tom Wilson', '1234567890127', 5),
('Mary Brown', '1234567890128', 6),
('David Lee', '1234567890129', 7),
('Sarah Kim', '1234567890130', 8),
('Emily Park', '1234567890131', 9),
('Michael Chen', '1234567890132', 10);

--CourseInstructor insertions
INSERT INTO CourseInstructor (FacultyID, is_coordinator, Subject_Teaching)
VALUES
(1, 1, 'Introduction to Programming'),
(2, 0, 'Database Management Systems'),
(3, 1, 'Object-Oriented Programming'),
(4, 0, 'Data Structures and Algorithms'),
(5, 0, 'Operating Systems'),
(6, 1, 'Software Engineering'),
(7, 0, 'Computer Networks'),
(8, 0, 'Web Development'),
(9, 1, 'Artificial Intelligence'),
(10, 0, 'Cybersecurity');

--LabInstructor insertions
INSERT INTO LabInstructor (FacultyID, Subject_Teaching)
VALUES
(1, 'Programming Lab'),
(2, 'Database Lab'),
(3, 'Network Lab'),
(4, 'Data Structures Lab'),
(5, 'Operating Systems Lab'),
(6, 'Software Engineering Lab'),
(7, 'Web Development Lab'),
(8, 'Artificial Intelligence Lab'),
(9, 'Computer Graphics Lab'),
(10, 'Cybersecurity Lab');

--SectionsTeaching insertions
INSERT INTO SectionsTeaching (SectionID, SectionName, CourseID, InstructorID)
VALUES
(1, 'Section A', 'CS101', 1),
(2, 'Section B', 'CS201', 2),
(3, 'Section A', 'CS301', 3),
(4, 'Section B', 'CS401', 4),
(5, 'Section A', 'CS501', 5),
(6, 'Section B', 'CS601', 6),
(7, 'Section A', 'CS701', 7),
(8, 'Section B', 'CS801', 8),
(9, 'Section A', 'CS901', 9),
(10, 'Section B', 'CS1001', 10);

--Enrollments insertions
INSERT INTO Enrollments (StudentID, CourseID)
VALUES
('1234', 'CS501');
('1234', 'CS301'),
('1234', 'CS401');
('1234', 'CS101'),
('S002', 'CS101'),
('S004', 'CS201'),
('S006', 'CS301'),
('S007', 'CS401'),
('S009', 'CS501'),
('S010', 'CS501');
use sms 
select CourseID, CourseName from Enrollments inner join students on Students.roll_number=Enrollments.StudentID inner join Course on Course.CourseCode=Enrollments.CourseID where Students.roll_number = (select roll_number from Students where user_num = 19)
select LectureNo, AttendanceDate, Duration,Presence from Attendance inner join Students on StudentID=roll_number where Students.roll_number = (select roll_number from Students where user_num = 19) AND CourseID = 'CS101'
select jobid from jobs where jobname = 'Software Engineer'
SELECT * FROM USers

