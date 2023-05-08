--create database sms
--use sms
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
	batch int not null,
);

create table Students (
	roll_number VARCHAR(4) not null primary key,
	first_name varchar(64),
	last_name varchar(64),
	cnic varchar(13) not null check (LEN(cnic)=13), 
	dob date not null, 
	gender char(1)not null CHECK (gender IN ('Male', 'Female', 'Other')), 
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
	ProjectWeightage FLOAT,
	CPWeightage FLOAT,
    CONSTRAINT CHK_Evaluations_Weightage CHECK (ProjectWeightage + CPWeightage + AssignmentWeightage + QuizWeightage + FinalExamWeightage + Sessional1Weightage + Sessional2Weightage = 100),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseCode)
);

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



