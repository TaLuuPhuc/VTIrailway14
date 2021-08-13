	-- Exercise 1: JOIN --
-- QUEST 1 - Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
USE testingsystem;
SELECT AccountID , Email , UserName , FullName
FROM department JOIN `account` USING (DepartmentID) #QUERY ngắn#
GROUP BY DepartmentName;

SELECT ac.AccountID ,  ac.Email , ac.UserName , ac.FullName
FROM `department` AS de
INNER JOIN `account` AS ac
ON de.DepartmentID = ac.DepartmentID
GROUP BY DepartmentName;

-- QUEST 2 - Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
USE testingsystem;
SELECT AccountID
FROM `account`
WHERE CreateDate > '2021-06-25 00:00:00';

-- QUEST 3 - Viết lệnh để lấy ra tất cả các developer
# KO RÕ RÀNG 

-- QUEST 4 -  Viết lệnh để lấy ra danh sách các phòng ban có >=0 nhân viên
USE testingsystem;
SELECT DepartmentName , COUNT(ac.DepartmentID) Số_Nhân_Viên
FROM department de
INNER JOIN `account` ac
ON de.DepartmentID = ac.DepartmentID
GROUP BY DepartmentName
HAVING COUNT(ac.DepartmentID) >=1 ;

-- LẤY DANH SÁCH THỂ LOẠI PHIM >50 PHIM

USE sakila;
SELECT `name` AS THỂ_LOẠI , COUNT(fi.category_id) AS SỐ_PHIM
FROM film_category AS fi
INNER JOIN category AS ca
ON ca.category_id = fi.category_id
GROUP BY `name`
HAVING SỐ_PHIM >= 50;

-- QUEST 5 - Viết lệnh để lấy ra dạng câu hỏi được sử dụng trong đề thi nhiều nhất
USE testingsystem;
SELECT TypeName Dạng_Câu_Hỏi , COUNT(que.TypeID) SỐ_BÀI
FROM question que
INNER JOIN typequestion typ USING (TypeID)
GROUP BY TypeName
HAVING MAX(SỐ_BÀI)
LIMIT 1;

SELECT * FROM typequestion;

-- QUEST 6 - Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
USE testingsystem; 
SELECT TypeName DẠNG_CÂU_HỎI , COUNT(que.TypeID) SỐ_LẦN_DÙNG
FROM typequestion typ
JOIN question que USING (TypeID)
GROUP BY TypeName;

SELECT CQ.CategoryName , COUNT(Q.CategoryID) FROM categoryquestion CQ
LEFT JOIN question Q ON CQ.CategoryID = Q.CategoryID
GROUP BY CQ.CategoryName;

-- QUEST 7 -  Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
USE testingsystem;
SELECT CategoryName AS CÂU_HỎI_MÔN , COUNT(ex.CategoryID) AS SỐ_ĐỀ_THI_CÓ
FROM categoryquestion AS ca
JOIN exam AS ex
ON ex.CategoryID = ca.CategoryID
GROUP BY CategoryName;

-- QUEST 8 - Lấy ra Question có nhiều câu trả lời nhất
USE testingsystem;
SELECT q.Content , COUNT(a.QuestionID) SL_Quest
FROM question AS q
JOIN answer AS a USING(QuestionID)
GROUP BY q.Content
ORDER BY SL_Quest DESC
LIMIT 1 ;

-- QUEST 9 - Thống kê số lượng account trong mỗi group
USE testingsystem;
SELECT GroupName , COUNT(gr.CreatorID) , CONCAT(gr.CreatorID)
FROM `group` AS gr
JOIN  groupaccount AS grac
ON grac.GroupID = gr.GroupID
GROUP BY GroupName;

-- QUEST 10 - Tìm chức vụ có ít người nhất
USE testingsystem;
SELECT PositionName , COUNT(po.PositionID) AS SỐ_ACCOUNT
FROM position AS po
JOIN `account` AS ac USING (PositionID)
GROUP BY PositionName
HAVING COUNT(SỐ_ACCOUNT)
ORDER BY SỐ_ACCOUNT ASC
LIMIT 1;

-- QUEST 11 - Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
USE testingsystem;
SELECT de.DepartmentName , PositionName , COUNT(ac.PositionID)
FROM `account` AS ac 
JOIN department AS de ON de.DepartmentID = ac.DepartmentID
JOIN position AS po ON po.PositionID = ac.PositionID
GROUP BY de.DepartmentName, po.PositionID;

-- QUEST 12 -  Lấy thông tin chi tiết của câu hỏi bao gồm:
-- thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
USE testingsystem;
SELECT TypeName, que.Content, que.CreatorID , an.content, an.IOsCorrect
FROM typequestion AS ty
JOIN question AS que ON que.TypeID = ty.TypeID
JOIN answer AS an ON an.QuestionID = que.QuestionID;

-- QUEST 13 - Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
USE testingsystem;
SELECT TypeName , COUNT(que.TypeID)
FROM typequestion AS ty
JOIN question AS que ON que.TypeID = ty.TypeID
GROUP BY TypeName;

-- QUEST 14 - Lấy ra group không có account nào
USE testingsystem;
SELECT *
FROM `group` AS gr
LEFT JOIN groupaccount AS ga USING (GroupID)
# ON ga.GroupID = gr.GroupID
WHERE ga.AccountID is NULL;

-- QUEST 16 - Lấy ra question không có answer nào
USE testingsystem;
SELECT * 
FROM question AS que
LEFT JOIN answer AS an
ON an.QuestionID = que.QuestionID
WHERE an.QuestionID IS NOT NULL;

-- QUEST 17 
-- a) Lấy các account thuộc nhóm thứ 1
USE testingsystem;
SELECT FullName, Email , UserName
FROM `account` AS ac
JOIN groupaccount AS ga
ON ga.AccountID = ac.AccountID
WHERE GroupID = 1; 

-- b) Lấy các account thuộc nhóm thứ 2
USE testingsystem;
SELECT FullName, Email , UserName
FROM `account` AS ac
JOIN groupaccount AS ga
ON ga.AccountID = ac.AccountID
WHERE GroupID = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
USE testingsystem;
SELECT FullName, Email , UserName FROM `account` AS ac
JOIN groupaccount AS ga ON ga.AccountID = ac.AccountID
WHERE GroupID = 1
UNION
SELECT FullName, Email , UserName FROM `account` AS ac
JOIN groupaccount AS ga ON ga.AccountID = ac.AccountID
WHERE GroupID = 2;

-- QUEST 18 
-- a) Lấy các group có lớn hơn 5 thành viên
USE testingsystem;
SELECT GroupName AS NHÓM , COUNT(AccountID) AS SỐ_NHVIEN FROM `group` AS gr
JOIN groupaccount AS ga
ON gr.GroupID = ga.GroupID
GROUP BY GroupName
HAVING COUNT(AccountID) >5;

-- b) Lấy các group có nhỏ hơn 7 thành viên
USE testingsystem;
SELECT GroupName AS NHÓM , COUNT(AccountID) AS SỐ_NHVIEN FROM `group` AS gr
JOIN groupaccount AS ga
ON gr.GroupID = ga.GroupID
GROUP BY GroupName
HAVING COUNT(AccountID) <7;

-- c) Ghép 2 kết quả từ câu a) và câu b)
USE testingsystem;
SELECT GroupName AS NHÓM , COUNT(AccountID) AS SỐ_NHVIEN FROM `group` AS gr
JOIN groupaccount AS ga
ON gr.GroupID = ga.GroupID
GROUP BY GroupName
HAVING COUNT(AccountID) >5
UNION ALL -- LẤY CẢ KẾT QUẢ TRÙNG
SELECT GroupName AS NHÓM , COUNT(AccountID) AS SỐ_NHVIEN FROM `group` AS gr
JOIN groupaccount AS ga
ON gr.GroupID = ga.GroupID
GROUP BY GroupName
HAVING COUNT(AccountID) <7;