DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DepartmentID 			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    DepartmentName			VARCHAR(30) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position` (
	PositionID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    PositionName			ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE  `Account` (
	AccountID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Email					VARCHAR(50) NOT NULL UNIQUE KEY,
    UserName				VARCHAR(50) NOT NULL UNIQUE KEY,
    FullName				VARCHAR(50) NOT NULL,
    DepartmentID			TINYINT UNSIGNED NOT NULL,
    PositionID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME,
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID					TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	GroupName				VARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID				TINYINT UNSIGNED,
    CreateDate				DATETIME,
    FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
	GroupID					TINYINT UNSIGNED NOT NULL,
	AccountID				TINYINT UNSIGNED NOT NULL,
    JoinDate				DATETIME,
    FOREIGN KEY (GroupID) REFERENCES `Group` (GroupID),
    FOREIGN KEY (AccountID) REFERENCES  `Account` (AccountID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
	TypeID					TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    TypeName				VARCHAR(50) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion (
	CategoryID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    CategoryName			ENUM ('Java', '.NET', 'SQL', 'Postman', 'Ruby')
);

DROP TABLE IF EXISTS Question;
CREATE TABLE  Question (
	QuestionID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content					VARCHAR(100) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    TypeID					TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID),
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion (TypeID),
    FOREIGN KEY ( CreatorID) REFERENCES `Account` (AccountID)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
	AnswerID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content					VARCHAR(100) NOT NULL,
    QuestionID				TINYINT UNSIGNED NOT NULL,
    IOsCorrect				VARCHAR(50),
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
    );
    
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
	ExamID					TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code`					VARCHAR(20) NOT NULL,
    Title					VARCHAR(50) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    Duration				TINYINT UNSIGNED NOT NULL,
	CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
    );
    
DROP TABLE IF EXISTS ExamQuestion;     
CREATE TABLE ExamQuestion (
	ExamID					TINYINT UNSIGNED NOT NULL,
    QuestionID				TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (ExamID) REFERENCES Exam (ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);

INSERT INTO department(DepartmentName)
VALUES				  ('BanHang'),
					  ('Marketing'),
                      ('GiamDoc'),
                      ('ThuKy'),
                      ('VanHanhKho'),
                      ('KeToan'),
                      ('BaoVe'),
                      ('GiamSat'),
                      ('KyThuat'),
                      ('XayLap'),
                      ('ThamDinhGia');
					
INSERT INTO `Position`(PositionName)
VALUES					('Dev'),
						('Test'),
                        ('Scrum Master'),
                        ('PM');
                        
INSERT INTO `Account` (Email, UserName, FullName, DepartmentID, PositionID, CreateDate)
VALUES					('Email1@gmai.com', 'UserName1', 'FullName1', '4', '1', '2021-06-21'),
						('Email2@gmai.com', 'UserName2', 'FullName2', '4', '3', '2021-06-23'),
                        ('Email3@gmai.com', 'UserName3', 'FullName3', '1', '4', '2021-06-25'),
                        ('Email4@gmai.com', 'UserName4', 'FullName4', '2', '4', '2021-06-25');
                        
 INSERT INTO `Group` (GroupName, CreatorID, CreateDate)
 VALUES					('TestingSystem', '2','2021-03-05'),
						('Development', '1','2021-03-07'),
						('VTISale01', '2','2021-03-09'),
						('VTISale02', '3','2021-03-10'),
						('VTISale03', '4','2021-03-28');

INSERT INTO GroupAccount (GroupID, AccountID, JoinDate)
VALUES					 ('1', '1', '2021-03-05'),
						('1', '2', '2021-03-07'),
                        ('3', '3', '2021-03-09'),
                        ('3', '4', '2021-03-10'),
                        ('5', '3','2021-03-28');

INSERT INTO TypeQuestion (TypeName)
VALUES					('Essay'),
						('MultipleChoice');
                        
 INSERT INTO CategoryQuestion (CategoryName)
 VALUES					('Java'),
						('SQL'),
						('Postman'),
						('Ruby');

INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES					('Câu hỏi về Java', '1', '1' , '2' ,'2020-04-05'),
						('Hỏi về Ruby', '2' , '1', '4','2020-04-06'),
                        ('Hỏi về Postman', '4', '1', '3','2020-04-06'),
                        ('Hỏi về SQL', '3', '2', '4','2020-04-07');


INSERT INTO Answer (Content, QuestionID, IOsCorrect)
VALUES					('Trả lời 01', '1', '0'),
						('Trả lời 02', '2', '1'),
						('Trả lời 03', '3', '0'),
						('Trả lời 04', '4', '1');
                        
INSERT INTO Exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES					('VTIQ004', 'Đề thi Java', '1', '60', '3' ,'2020-04-08'),
						('VTIQ005', 'Đề thi Ruby', '2', 120, '4' ,'2020-04-10'),
						('VTIQ006', 'Đề thi Postman', '3', '60', '1','2020-04-05'),
						('VTIQ007', 'Đề thi SQL', '2', '60', '4' ,'2020-04-05');

INSERT INTO ExamQuestion (ExamID, QuestionID)
VALUES					(1, 3),
						(3, 4),
                        (2, 1),
                        (4, 2);
                        
