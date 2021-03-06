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
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID					TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	GroupName				VARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID				TINYINT UNSIGNED,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
	GroupID					TINYINT UNSIGNED NOT NULL,
	AccountID				TINYINT UNSIGNED NOT NULL,
    JoinDate				DATETIME DEFAULT NOW(),
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
    CreateDate				DATETIME DEFAULT NOW(),
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
    CreateDate				DATETIME DEFAULT NOW(),
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
                        
INSERT INTO `Account` (Email, 			UserName, 			FullName, 		DepartmentID, 	PositionID, 	CreateDate)
VALUES				('Email1@gmail.com', 'UserName1', 	'FullName1',				'4', 		'1', 	'2021-06-21'),
					('Email2@gmail.com', 'UserName2', 	'FullName2',	 			'3', 		'3', 	'2021-06-23'),
					('Email3@gmail.com', 'UserName3', 	'FullName3', 				'1', 		'4', 	'2021-06-25'),
					('Email4@gmail.com', 'UserName4', 	'FullName4',	 			'2',		'4', 	'2021-06-25'),
					('QuangThuan@gmail.com','QuangThuan', 'QuangThuanTran',  		'7' , 		'3', 	'2021-06-29'),
                    ('PhanDinh@gmail.com', 'PhanDinh' , 'PhanDinhGiot' , 			'9' , 		'4', 	'2021-07-08'),
                    ('TranDinh@gmail.com', 'TranDinh' , 'TranDinhCua' , 			'10' ,		'2' , 	'2021-07-22'),
                    ('VoHuy@gmail.com', 	'DinhHuy' , 'NguyenDinhHuy' , 			'11' , 		'3' , 	'2021-07-21'),
                    ('KhanhSky@gmail.com', 'Kh??nhky' , 	'VoKhanhSky' , 				'8' , 		'1' , 	'2021-07-01'),
                    ('TayMonKhanh@gmail.com', 'KhanhTay', 'ThienTayKhanh' , 		'6' , 		'2' , 	'2021-07-30');
                        
 INSERT INTO `Group` (GroupName, 			CreatorID, 		CreateDate)
 VALUES				('TestingSystem',		 '2',			'2021-03-05'),
					('Development',			 '1',			'2021-03-07'),
					('VTISale01',			 '2',			'2021-03-09'),
					('VTISale02', 			'3',			'2021-03-10'),
					('VTISale03',			 '4',			'2021-03-28');

INSERT INTO GroupAccount (GroupID, 	AccountID,	 JoinDate)
VALUES					 ('1',		 '1',		 '2021-03-05'),
						('1',		 '2', 		'2021-03-07'),
                        ('3', 		'3', 		'2021-03-09'),
                        ('3',		 '4',		 '2021-03-10'),
                        ('5', 		'3',		'2021-03-28');

INSERT INTO TypeQuestion (TypeName)
VALUES					('Essay'),
						('MultipleChoice');
                        
 INSERT INTO CategoryQuestion (CategoryName)
 VALUES						('Java'),
							('SQL'),
							('Postman'),
							('Ruby');

INSERT INTO Question (Content, 			CategoryID, 	TypeID, 	CreatorID, 	CreateDate)
VALUES				('C??u h???i v??? Java', 	'1',		 '1' , 		'2' ,		'2020-04-05'),
					('H???i v??? Ruby',			 '2' , 		'1',		'4',		'2020-04-06'),
					('H???i v??? Postman',		 '4', 		'1',		 '3',		'2020-04-06'),
					('H???i v??? SQL',			 '3',		 '2',		 '4',		'2020-04-07');


INSERT INTO Answer (Content,		 QuestionID, IOsCorrect)
VALUES				('Tr??? l???i 01', 		'1', 		'0'),
					('Tr??? l???i 02', 		'2', 		'1'),
					('Tr??? l???i 03', 		'3', 		'0'),
					('Tr??? l???i 04', 		'4', 		'1'),
                    ('Tr??? l???i 05', 		'4', 		'1'),
                    ('Tr??? l???i 06', 		'3', 		'0'),
					('Tr??? l???i 07', 		'4', 		'1');
					
INSERT INTO Exam (`Code`, 		Title, 			CategoryID, 	Duration, 	CreatorID, 	CreateDate)
VALUES				('VTIQ004', '????? thi Java', 		'1', 			'60', 		'3' ,	'2020-04-08'),
					('VTIQ005', '????? thi Ruby', 		'2', 			120, 		'4' ,	'2020-04-10'),
					('VTIQ006', '????? thi Postman', 	'3', 			'60', 		'1',	'2020-04-05'),
					('VTIQ007', '????? thi SQL',	 	'2', 			'60', 		'4' ,	'2020-04-05');

INSERT INTO ExamQuestion (ExamID, QuestionID)
VALUES					(1, 		3),
						(3, 		4),
                        (2, 		1),
                        (4, 		2);
                        
                        
                        
-- ASSIGNMENT 3 --

-- QUEST 2 - L???y ra t???t c??? ph??ng ban
SELECT DepartmentName FROM testingsystem.department;

-- QUEST 3 - L???y ra ID c???a ph??ng Sale
SELECT DepartmentID FROM testingsystem.department
WHERE DepartmentName = 'banhang';

-- QUEST 4 - L???y th??ng tin account c?? full name d??i nh???t
SELECT * FROM testingsystem.account;
USE testingsystem;
SELECT * FROM account
WHERE length(FullName) = (SELECT MAX(length(FullName)) FROM account)
ORDER BY FullName DESC;

-- QUEST 5 - L???y th??ng tin account c?? full name d??i nh???t v?? ??? ph??ng ban c?? ID=4
WITH cte_PositionID4 AS
(SELECT * FROM `account` WHERE PositionID = 4)

SELECT * FROM cte_PositionID4
WHERE LENGTH(FullName) = (SELECT MAX(LENGTH(FullName)) FROM cte_PositionID4);

-- QUEST 6 - L???y ra t??n group ???? tham gia tr?????c ng??y 20/12/2019
SELECT GroupName
FROM `group`
WHERE CreateDate > '2021-03-10 00:00:00';

-- QUEST 7 -  L???y ra ID c???a question c?? >= 4 c??u tr??? l???i
SELECT * FROM testingsystem.answer;
SELECT AnswerID FROM answer
WHERE QuestionID >= 4;

-- QUEST 8 - : L???y ra c??c m?? ????? thi c?? th???i gian thi >= 60 ph??t v?? ???????c t???o tr?????c ng??y 20/12/2019
SELECT * FROM testingsystem.exam;
SELECT `Code` FROM exam
WHERE Duration >= 120 AND CreateDate >= '2020-04-05 00:00:00';

-- QUEST 9 - L???y ra 3 group ???????c t???o g???n ????y nh???t
SELECT * FROM testingsystem.group;
SELECT * FROM `group`
ORDER BY CreateDate DESC
LIMIT 3;

-- QUEST 10 -  ?????m s??? nh??n vi??n thu???c department c?? id = 2
SELECT COUNT(AccountID) SoNhanVien 
FROM `account`
WHERE PositionID = 2;

-- QUEST 11 - L???y ra nh??n vi??n c?? t??n b???t ?????u b???ng ch??? "D" v?? k???t th??c b???ng ch??? "o"
SELECT * FROM account
WHERE FullName LIKE ('t%h');

-- QUEST 12 - X??a t???t c??? c??c exam ???????c t???o tr?????c ng??y 20/12/2019
DELETE FROM exam
WHERE CreateDate <= '2020-04-08 00:00:00';

-- QUEST 13 -  X??a t???t c??? c??c question c?? n???i dung b???t ?????u b???ng t??? "c??u h???i"
DELETE FROM question
WHERE Content LIKE 'C??u h???i%';

-- QUEST 14 - Update th??ng tin c???a account c?? id = 5 th??nh t??n "Nguy???n B?? L???c" v?? email th??nh loc.nguyenba@vti.com.vn
UPDATE `account`
SET 		FullName = 'Nguy???n B?? L???c',
			Email	= 'loc.nguyenba@vti.com.vn'
WHERE AccountID =5; 

-- QUEST 15 - update account c?? id = 5 s??? thu???c group c?? id = 4
UPDATE 		groupaccount
SET			AccountID = 2 
WHERE 		GroupID = 4;                      
                        
                        