DROP DATABASE IF EXISTS Thực_Tập;
CREATE DATABASE Thực_Tập;
USE Thực_Tập;

DROP TABLE IF EXISTS GiangVien;
CREATE TABLE GiangVien (
	magv TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    hoten VARCHAR(50) NOT NULL,
    luong INT UNSIGNED NOT NULL 
    );
    
DROP TABLE IF EXISTS SinhVien;
CREATE TABLE SinhVien (
	masv TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    hoten VARCHAR(50) NOT NULL,
    namsinh INT UNSIGNED  NOT NULL,
    quequan VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS DeTai;
CREATE TABLE DeTai(
	madt TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    tendt VARCHAR(50) NOT NULL,
    kinhphi INT UNSIGNED,
    NoiThucTap VARCHAR(50) NOT NULL
    );

DROP TABLE IF EXISTS HuongDan;
CREATE TABLE HuongDan(
	id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
    masv TINYINT UNSIGNED NOT NULL, 
    madt TINYINT UNSIGNED NOT NULL, 
    magv TINYINT UNSIGNED NOT NULL, 
    ketqua TINYINT UNSIGNED NOT NULL,
    CONSTRAINT pk_masv FOREIGN KEY (masv) REFERENCES SinhVien (masv) ON DELETE CASCADE ON UPDATE CASCADE,   
    CONSTRAINT pk_madt FOREIGN KEY (madt) REFERENCES DeTai (madt) ON DELETE CASCADE ON UPDATE CASCADE,  
    CONSTRAINT pk_magv FOREIGN KEY (magv) REFERENCES GiangVien (magv) ON DELETE CASCADE ON UPDATE CASCADE
    );

########

# QUEST 1 # INSERT DỮ LIỆU  
INSERT INTO GiangVien ( hoten, 			luong )
VALUES 				('NGUYỄN LƯƠNG TÂY' , '300'),
					('TRẦN ĐÔ LA', 		'1000' ),
                    ('THANH ĐÔ MỸ', 	'600' ),
                    ('LƯƠNG TIỀN VIỆT', '1300' ),
                    ('LAN KHÔNG LƯƠNG', '200' );


INSERT INTO detai(tendt, 				kinhphi, 	NoiThucTap)
VALUES			('CÔNG NGHỆ SINH HỌC' , 	'100' , 	'HÀ NỘI'),
				('CÔNG NGHỆ VŨ TRỤ' , 		'200' , 	'BẮC KINH'),
                ('CÔNG NGHỆ NÔNG NGHIỆP' , 300 , 	'TÂY NGUYÊN'),
                ('KINH TẾ CHIA SẺ' ,		'350' , 'HỒ CHÍ MINH'),
                ('CÔNG NGHỆ HẠT NHÂN' , 	'9999' , 'BÌNH NHƯỠNG');
 
INSERT INTO sinhvien( hoten, 			namsinh, quequan)
VALUES			('TRẦN LONG ÓC' , 		'1992' , 'HÀ TÂY'),
				('NGUYỄN KHÔNG ĐỒNG' , '1990' , 'THÁI BÌNH'),
                ('LÊ XONG XÓC' , 		'1989' , 'BÌNH NHƯỠNG'),
                ('LÊ KIỆM LỜI' , 		'1993' , 'HÀ NỘI'),
                ('TRẦN NĂM NGÓN' , 		'2001' , 'TIỀN GIANG');
                
INSERT INTO huongdan( masv, madt, 	magv, 	ketqua )
	VALUES 		('1' , 		'2' , 	'3' , 	'7'),
				('2' , 		'1' , 	'5' , 	'8'),
				('3' , 		'3' , 	'4' , 	'7'),
				('4' , 		'4' , 	'1' ,	 '9'),
				('4' , 		'3' , 	'2' , 	'10'),
				('2' , 		'2' , 	'3' ,	 '5');

# QUEST 2 # 
# A, Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
SELECT hoten FROM sinhvien
LEFT EXCLUDING JOIN huongdan USING (masv)
GROUP BY hoten ;

# B, ) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’
SELECT sv.masv , sv.hoten FROM sinhvien sv
JOIN huongdan hd USING (masv)
WHERE hd.madt = 4;

# QUEST 3 # Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm: 
# mã số, họ tên và tên đề tài
# (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")

CREATE OR REPLACE VIEW SinhVienInfo AS
	SELECT SV.masv, SV.hoten , DT.tendt ,
		CASE
			WHEN DT.tendt IS NULL THEN 'CHƯA CÓ'
			ELSE DT.tendt
		END AS 'TÊN ĐỀ TÀI'
    FROM sinhvien SV     
    LEFT JOIN huongdan HD USING (masv)
    LEFT JOIN detai DT USING (madt);

# CÁCH 2 # JOIN 3 BẢNG union VỚI 1 BẢNG KO CÓ

CREATE OR REPLACE VIEW SinhVienInfo AS
	SELECT SV.masv, SV.hoten, DT.tendt AS 'TÊN ĐỀ TÀI'
	FROM sinhvien SV
	JOIN huongdan HD USING (masv)   
	JOIN detai DT USING (madt) 
	UNION 
	SELECT SV.masv, SV.hoten, 'CHƯA CÓ' FROM sinhvien SV 
								WHERE masv NOT IN (SELECT masv
												FROM huongdan);

SELECT hoten , masv FROM SinhVienInfo 
WHERE `TÊN ĐỀ TÀI` = 'CHƯA CÓ';

# QUEST 4 # Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900 
# thì hiện ra thông báo "năm sinh phải > 1900"

DROP TRIGGER IF EXISTS trigger_insert_student_info;
DELIMITER $$
CREATE TRIGGER trigger_insert_student_info
BEFORE INSERT ON sinhvien
FOR EACH ROW
BEGIN
    IF NEW.namsinh <= 1900 THEN
    SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'năm sinh phải > 1900';
    END IF;
END $$
DELIMITER ;    

INSERT INTO sinhvien ( hoten, namsinh, quequan)
VALUES 				('TRẦN STUPID' , '1899' , 'BÌNH THẠNH');

# QUEST 5 # Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ tất cả thông 
# tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi

DROP TRIGGER IF EXISTS xóa_1acc_xóa_info_TABLEhuongdan;
DELIMITER $$
CREATE TRIGGER xóa_1acc_xóa_info_TABLEhuongdan
BEFORE DELETE ON sinhvien
FOR EACH ROW
BEGIN
	DELETE FROM huongdan WHERE masv IN (OLD.masv);
END $$
DELIMITER ;

# TEST #
DELETE FROM sinhvien WHERE masv = 3;