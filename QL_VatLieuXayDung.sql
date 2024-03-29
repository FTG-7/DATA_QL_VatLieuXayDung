﻿
CREATE TABLE NHACUNGCAP(
    MANCC varchar(15) PRIMARY KEY,
    TENNCC NVARCHAR(50) ,
	DIACHI NVARCHAR(50) ,
	SDT VARCHAR(15),
    --SISO NVARCHAR(15) ???
);

CREATE TABLE LOAIHANG(
    MALOAI varchar(15) PRIMARY KEY,
    TENLOAI NVARCHAR(50) ,
	MOTA NVARCHAR(255) ,/*MÔ TẢ LOẠI HÀNG*/
    FLAG INT /*GẮN CỜ THỂ HIỆN TRẠNG THÁI "CÒN KINH DOANH" LOẠI HÀNG NÀY*/
);

CREATE TABLE HANGHOA(
    MAHH varchar(15) PRIMARY KEY,
    MALOAI VARCHAR(15) ,
	TENHH NVARCHAR(50) ,
    DONVI_TINH NVARCHAR(50),
	XUATXU NVARCHAR(50),
	CONSTRAINT FK_HANGHOA_LOAIHANG FOREIGN KEY (MALOAI) REFERENCES LOAIHANG(MALOAI)
);
CREATE TABLE NHANVIEN(
    MANV varchar(15) PRIMARY KEY,
    TENNV NVARCHAR(50) ,
	GIOITINH NVARCHAR(50) ,
    NGAYSINH DATETIME,
	DIACHI NVARCHAR(50),
	SDT NVARCHAR(50),
);

CREATE TABLE KHO(
    IDKHO INT PRIMARY KEY,
    MAHH VARCHAR(15) ,
    SOLUONG INT,
	CONSTRAINT FK_KHO_HANGHOA FOREIGN KEY (MAHH) REFERENCES HANGHOA(MAHH)
);

CREATE TABLE NGUOIDUNG(
    USERNAME varchar(15) PRIMARY KEY,
    MATKHAU NVARCHAR(50) ,
	LOAI INT ,
    ACTIVE INT
);
CREATE TABLE TBLNGUOIDUNG_NHANVIEN(
    ID_I INT PRIMARY KEY,
    USERNAME VARCHAR(15) ,
	 MANV varchar(15)
	CONSTRAINT FK_NGUOIDUNG_NV_USER FOREIGN KEY (USERNAME) REFERENCES NGUOIDUNG(USERNAME),
	CONSTRAINT FK_NGUOIDUNG_NV_MANV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
);
CREATE TABLE HOADON_NHAP(
    SO_HD_NHAP varchar(15) PRIMARY KEY,
    MANCC VARCHAR(15) ,
	MANV VARCHAR(15) ,
    NGAYLAP_NHAP DATETIME,
	CONSTRAINT FK_HDN_MANCC FOREIGN KEY (MANCC) REFERENCES NHACUNGCAP(MANCC),
	CONSTRAINT FK_HDN_MANV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
	
);
CREATE TABLE CHITIET_HD_NHAP(
	IDNHAP VARCHAR(10) NOT NULL,
    MAHH VARCHAR(15) ,
	SO_HD_NHAP VARCHAR(15) ,
    SOLUONG_NHAP INT,
	DONGIA_NHAP INT,
	CONSTRAINT PK_IDNHAP PRIMARY KEY (IDNHAP),
	CONSTRAINT FK_CTN_MAHH FOREIGN KEY (MAHH) REFERENCES HANGHOA(MAHH),
	CONSTRAINT FK_CTN_SOHDN FOREIGN KEY (SO_HD_NHAP) REFERENCES HOADON_NHAP (SO_HD_NHAP),
	CONSTRAINT CHK_CHITIETHCTN CHECK(SOLUONG_NHAP>0 AND DONGIA_NHAP>0)
);
CREATE TABLE KHACHHANG(
    MAKH varchar(15) PRIMARY KEY,
    TENKH NVARCHAR(50) ,
	DIACHI NVARCHAR(50) ,
    SDT NVARCHAR(50)
);
CREATE TABLE HOADON_XUAT(
    SO_HD_XUAT varchar(15) PRIMARY KEY,
    MAKH varchar(15) ,
	MANV VARCHAR(15) ,
    NGAYLAP_XUAT DATE,
	CONSTRAINT FK_HDX_MAKH FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
	CONSTRAINT FK_HDX_MANV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
);
CREATE TABLE CHITIET_HD_XUAT(
    IDXUAT VARCHAR(10) NOT NULL,
    IDKHO INT ,
	SO_HD_XUAT VARCHAR(15),
    SOLUONG_XUAT INT,
	DONGIA_XUAT INT,
	CONSTRAINT PK_IDXUAT PRIMARY KEY (IDXUAT),
	CONSTRAINT FK_CTX_MAHH FOREIGN KEY (IDKHO) REFERENCES KHO (IDKHO),
	CONSTRAINT FK_CTX_SOHDX FOREIGN KEY (SO_HD_XUAT) REFERENCES HOADON_XUAT (SO_HD_XUAT),
	CONSTRAINT CHK_CHITIETHCTX CHECK(SOLUONG_XUAT>0 AND DONGIA_XUAT>0) 
);

INSERT INTO NHACUNGCAP (MANCC, TENNCC, DIACHI, SDT) 
VALUES
    ('NCC001', N'Công ty A', N'123 Đường A, Quận 1', '0123456789'),
    ('NCC002', N'Công ty B', N'456 Đường B, Quận 2', '0987654321'),
    ('NCC003', N'Công ty C', N'789 Đường C, Quận 3', '0123456780'),
    ('NCC004', N'Công ty D', N'101 Đường D, Quận 4', '0987654322'),
    ('NCC005', N'Công ty E', N'202 Đường E, Quận 5', '0123456781');

SELECT* FROM NHACUNGCAP

INSERT INTO LOAIHANG (MALOAI, TENLOAI, MOTA, FLAG)
VALUES
    ('LH001', N'Điện tử', N'Loại hàng điện tử', 1),
    ('LH002', N'Thời trang', N'Loại hàng thời trang', 1),
    ('LH003', N'Điện gia dụng', N'Loại hàng điện gia dụng', 1),
    ('LH004', N'Thực phẩm', N'Loại hàng thực phẩm', 1),
    ('LH005', N'Sách văn phòng', N'Loại hàng sách văn phòng', 1),
    ('LH006', N'Quần áo', N'Loại hàng quần áo', 1),
    ('LH007', N'Dụng cụ thể thao', N'Loại hàng dụng cụ thể thao', 1);

INSERT INTO HANGHOA (MAHH, MALOAI, TENHH, DONVI_TINH, XUATXU)
VALUES
    ('HH001', 'LH001', N'Laptop Dell', N'Cái', N'USA'),
    ('HH002', 'LH001', N'Máy tính bảng Samsung', N'Cái', N'Korea'),
    ('HH003', 'LH003', N'Tivi Sony', N'Cái', N'Japan'),
    ('HH004', 'LH004', N'Rau cải xanh', N'Kg', N'Vietnam'),
    ('HH005', 'LH005', N'Bút bi đen', N'Cái', N'China');

INSERT INTO NHANVIEN (MANV, TENNV, GIOITINH, NGAYSINH, DIACHI, SDT)
VALUES
    ('NV001', N'Nguyễn Văn A', N'Nam', '1990-01-15', N'123 Đường X, Quận Y', '0123456789'),
    ('NV002', N'Nguyễn Thị B', N'Nữ', '1995-05-20', N'456 Đường Z, Quận W', '0987654321'),
    ('NV003', N'Trần Văn X', N'Nam', '1992-03-20', N'567 Đường X, Quận 8', '0123456783'),
    ('NV004', N'Nguyễn Thị Y', N'Nữ', '1997-07-25', N'678 Đường Y, Quận 9', '0987654324'),
    ('NV005', N'Lê Văn Z', N'Nam', '1991-12-10', N'789 Đường Z, Quận 10', '0123456784');

INSERT INTO KHO (IDKHO, MAHH, SOLUONG)
VALUES
    (1, 'HH001', 100),
    (2, 'HH002', 50),
    (3, 'HH003', 30),
    (4, 'HH004', 100),
    (5, 'HH005', 200);

INSERT INTO KHACHHANG (MAKH, TENKH, DIACHI, SDT)
VALUES
    ('KH001', N'Nguyễn Khách Hàng 1', N'789 Đường C, Quận 1', '0123456789'),
    ('KH002', N'Trần Khách Hàng 2', N'101 Đường D, Quận 2', '0987654321'),
    ('KH003', N'Lê Khách Hàng 3', N'202 Đường E, Quận 3', '0123456780'),
    ('KH004', N'Phạm Khách Hàng 4', N'303 Đường F, Quận 4', '0987654322'),
    ('KH005', N'Huỳnh Khách Hàng 5', N'404 Đường G, Quận 5', '0123456781');
	
INSERT INTO HOADON_NHAP (SO_HD_NHAP, MANCC, MANV, NGAYLAP_NHAP)
VALUES
    ('HDN001', 'NCC001', 'NV001', '2023-09-14 10:00:00'),
    ('HDN002', 'NCC002', 'NV002', '2023-09-14 11:30:00'),
    ('HDN003', 'NCC003', 'NV003', '2023-09-15 09:45:00'),
    ('HDN004', 'NCC004', 'NV004', '2023-09-15 14:20:00'),
    ('HDN005', 'NCC005', 'NV005', '2023-09-16 08:00:00');

INSERT INTO CHITIET_HD_NHAP (IDNHAP,MAHH, SO_HD_NHAP, SOLUONG_NHAP, DONGIA_NHAP)
VALUES
    ('IDN001','HH001', 'HDN001', 10, 800),
    ('IDN002','HH002', 'HDN001', 20, 400),
    ('IDN003','HH003', 'HDN002', 5, 1200),
    ('IDN004','HH004', 'HDN002', 15, 300),
    ('IDN005','HH005', 'HDN003', 30, 10);

--ALTER TABLE CHITIET_HD_NHAP DROP CONSTRAINT PK__CHITIET___3214EC275F3EBC60;
--ALTER TABLE CHITIET_HD_NHAP
--ALTER COLUMN IDNHAP VARCHAR(10) NOT NULL;

--ALTER TABLE CHITIET_HD_NHAP
--ADD CONSTRAINT PK_IDNHAP PRIMARY KEY (IDNHAP);

SELECT* FROM CHITIET_HD_NHAP
INSERT INTO NGUOIDUNG (USERNAME, MATKHAU, LOAI, ACTIVE)
VALUES
    ('user1', 'password1', 1, 1),
    ('user2', 'password2', 2, 1),
    ('user3', 'password3', 1, 1),
    ('user4', 'password4', 2, 1),
    ('user5', 'password5', 1, 1);

INSERT INTO TBLNGUOIDUNG_NHANVIEN (ID_I, USERNAME, MANV)
VALUES
    (1, 'user1', 'NV001'),
    (2, 'user2', 'NV002'),
    (3, 'user3', 'NV003'),
    (4, 'user4', 'NV004'),
    (5, 'user5', 'NV005');

INSERT INTO HOADON_XUAT (SO_HD_XUAT, MAKH, MANV, NGAYLAP_XUAT)
VALUES
    ('HDX001', 'KH001', 'NV001', '2023-09-14'),
    ('HDX002', 'KH002', 'NV002', '2023-09-14'),
    ('HDX003', 'KH003', 'NV003', '2023-09-15'),
    ('HDX004', 'KH004', 'NV004', '2023-09-15'),
    ('HDX005', 'KH005', 'NV005', '2023-09-16');

INSERT INTO CHITIET_HD_XUAT (IDXUAT,IDKHO, SO_HD_XUAT, SOLUONG_XUAT, DONGIA_XUAT)
VALUES
    ('IDX001',1, 'HDX001', 5, 1000),
    ('IDX002',2, 'HDX001', 10, 500),
    ('IDX003',3, 'HDX002', 8, 800),
    ('IDX004',4, 'HDX002', 12, 300),
    ('IDX005',5, 'HDX003', 15, 10);

SELECT* FROM NHACUNGCAP
SELECT* FROM KHACHHANG
SELECT* FROM TBLNGUOIDUNG_NHANVIEN
SELECT* FROM NGUOIDUNG
SELECT* FROM NHANVIEN
SELECT* FROM HANGHOA
SELECT* FROM HOADON_NHAP
SELECT* FROM HOADON_XUAT
SELECT* FROM CHITIET_HD_NHAP
SELECT* FROM CHITIET_HD_XUAT
SELECT* FROM LOAIHANG
SELECT* FROM KHO
select * from KHO,HANGHOA,LOAIHANG
-------------------------------------------------------------------------
SELECT SUM(SOLUONG) FROM KHO
DECLARE @LANTANG INT
SET @LANTANG =0
WHILE(SELECT SUM(SOLUONG) FROM KHO)<1000
BEGIN
	UPDATE KHO
	SET SOLUONG = SOLUONG +50
	WHERE SOLUONG <100

	SET @LANTANG = @LANTANG +1
	IF NOT EXISTS (SELECT * FROM KHO WHERE SOLUONG <60) -- THÊM 50 VÀO SỐ LƯỢNG HH NÀO DƯỚI 60
		BREAK
END

DECLARE @THONGBAO NVARCHAR(100)
SET @THONGBAO = N'ĐÃ TĂNG: ' + CAST(@LANTANG AS NVARCHAR(10)) + N' LẦN'
go
SELECT * FROM 
-------------------------procedure-----------------------------------------------------------------
--Thêm Vật Liệu:
CREATE PROCEDURE ThemVatLieu (
    @MAHH varchar(15) ,
    @MALOAI VARCHAR(15) ,
	@TENHH NVARCHAR(50) ,
    @DONVI_TINH NVARCHAR(50),
	@XUATXU NVARCHAR(50)
)
AS
BEGIN
  --  INSERT INTO VatLieu (TenVatLieu, SoLuong, Gia)
  --  VALUES (@TenVatLieu, @SoLuong, @Gia);
	INSERT INTO HANGHOA (MAHH, MALOAI, TENHH, DONVI_TINH, XUATXU)
	VALUES(@MAHH, @MALOAI, @TENHH,   @DONVI_TINH, @XUATXU)
    
END

EXEC ThemVatLieu
    @MAHH = 'MMM',
    @MALOAI = 'LH001',
    @TENHH = N'Tên hàng hóa mới',
    @DONVI_TINH = N'Đơn vị tính mới',
    @XUATXU = N'Xuất xứ mới';

--Cập Nhật Số Lượng Vật Liệu:
CREATE PROCEDURE CapNhatSoLuongVatLieu
AS
BEGIN
    UPDATE KHO
    SET KHO.SOLUONG = (SELECT COUNT(HANGHOA.MAHH) FROM HANGHOA WHERE HANGHOA.MAHH = KHO.MAHH)
END
-- Gọi Stored Procedure
EXEC CapNhatSoLuongVatLieu;

--Xóa Vật Liệu:
CREATE PROCEDURE XoaVatLieu (
     @MAHH varchar(15)
)
AS
BEGIN
    DELETE FROM HANGHOA
    WHERE MAHH = @MAHH;
END
-- Gọi Stored Procedure và truyền tham số
EXEC XoaVatLieu @MAHH = 'MMM';

--Danh Sách Các Giao Dịch Gần Đây:

CREATE PROCEDURE LayTatCaHoaDonTrongNgay
AS
BEGIN
    SELECT * 
    FROM HOADON_XUAT
    WHERE CONVERT(DATE, NGAYLAP_XUAT) = CONVERT(DATE, GETDATE())
    ORDER BY NGAYLAP_XUAT DESC;
END
INSERT INTO HOADON_XUAT (SO_HD_XUAT, MAKH, MANV, NGAYLAP_XUAT)
VALUES
    ('HDX011', 'KH001', 'NV001', '2023-04-12')
EXEC LayTatCaHoaDonTrongNgay;

SELECT* FROM HOADON_XUAT

INSERT INTO HOADON_XUAT (SO_HD_XUAT, MAKH, MANV, NGAYLAP_XUAT)
VALUES
    ('HDX009', 'KH001', 'NV001', '2023-11-22')

--Tổng Số Lượng Vật Liệu Trong Kho:
CREATE PROCEDURE TongSoLuongVatLieuTrongKho (
    @MAHH varchar(15)
)
AS
BEGIN
    SELECT SUM(SoLuong) AS TongSoLuong
    FROM KHO
    WHERE MAHH = @MAHH;
END

EXEC TongSoLuongVatLieuTrongKho @MAHH = 'HH001';
-------------------------FUNCTION-----------------------------------------------------------------

--Tính Tổng Giá Trị Giao Dịch Cho Một Vật Liệu:
CREATE FUNCTION TongGiaTriGiaoDich (
    @MAHH varchar(15)
)
RETURNS MONEY
AS
BEGIN
    DECLARE @TongGiaTri MONEY;
    SELECT @TongGiaTri = SUM(DONGIA_XUAT * SOLUONG_XUAT)
    FROM CHITIET_HD_XUAT CTX,KHO K
    WHERE CTX.IDKHO = K.IDKHO AND K.MAHH = @MAHH;
    RETURN @TongGiaTri;
END
GO

-- Gọi hàm từ câu truy vấn SELECT
SELECT dbo.TongGiaTriGiaoDich('HH01') AS TongGiaTri;

--Tính Tổng Giá Trị Giao Dịch Cho Một KHACH HANG:
GO
SELECT * FROM  CHITIET_HD_XUAT CTX,HOADON_XUAT HDX WHERE CTX.SO_HD_XUAT= HDX.SO_HD_XUAT AND HDX.MAKH ='KH003'
CREATE FUNCTION TongGiaTriGiaoDichKHACHHANG (
    @MAKH varchar(15)
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @TongGiaTri FLOAT;
    SELECT @TongGiaTri = SUM(DONGIA_XUAT * SOLUONG_XUAT)
    FROM CHITIET_HD_XUAT CTX,HOADON_XUAT HDX
    WHERE CTX.SO_HD_XUAT = HDX.SO_HD_XUAT AND HDX.MAKH=@MAKH;
    RETURN @TongGiaTri;
END
SELECT dbo.TongGiaTriGiaoDichKHACHHANG('KH003') AS TongGiaTri;

--Kiểm Tra Số Lượng Tồn Kho:
CREATE FUNCTION KiemTraSoLuongTonKho (
     @MAHH varchar(15)
)
RETURNS INT
AS
BEGIN
    DECLARE @SoLuongTonKho INT;
    SELECT @SoLuongTonKho = SoLuong
    FROM KHO
    WHERE MAHH = @MAHH;

    RETURN @SoLuongTonKho;
END
GO

--Tính Tổng Lượng Vật Liệu Nhập Theo Tháng:
CREATE FUNCTION TinhTongLuongVatLieuNhapTheoThang(
    @Thang INT
)
RETURNS INT
AS
BEGIN
    DECLARE @TongLuongNhap INT;
    SELECT @TongLuongNhap = SUM(SOLUONG_NHAP)
    FROM CHITIET_HD_NHAP, HOADON_NHAP
    WHERE MONTH(NGAYLAP_NHAP) = @Thang AND CHITIET_HD_NHAP.SO_HD_NHAP = HOADON_NHAP.SO_HD_NHAP;
    RETURN @TongLuongNhap;
END;

-- Gọi hàm và lấy kết quả
DECLARE @Thang INT;
SET @Thang = 9; -- Thay đổi với tháng mong muốn

DECLARE @TongLuongNhap INT;
SET @TongLuongNhap = dbo.TinhTongLuongVatLieuNhapTheoThang(@Thang);
-- In hoặc sử dụng kết quả theo nhu cầu
PRINT N'Tổng lượng vật liệu nhập cho tháng ' + CAST(@Thang AS NVARCHAR) + ': ' + CAST(@TongLuongNhap AS NVARCHAR);

/*--------------------------------------------------------------------------------------*/
/*Trigger kiểm tra ràng buộc trước khi thêm một người dùng mới:
*/
CREATE TRIGGER Trg_Check_Insert_NGUOIDUNG
ON NGUOIDUNG
INSTEAD of INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM NGUOIDUNG WHERE USERNAME = (SELECT USERNAME FROM inserted))
    BEGIN
        PRINT (N'Tên người dùng đã tồn tại.');
        ROLLBACK TRANSACTION;
    END
    IF (SELECT LOAI FROM inserted) NOT IN (1, 2) -- Loại 1 cho nhân viên, Loại 2 cho admin
    BEGIN
        PRINT (N'Loại người dùng không hợp lệ.');
        ROLLBACK TRANSACTION;
    END
END;
SELECT*FROM NGUOIDUNG

INSERT INTO NGUOIDUNG (USERNAME, MATKHAU, LOAI, ACTIVE)
VALUES
    ('user11', 'password12', 3, 1)
/*--------------------------------------------------------------------------------------*/
SELECT*FROM LOAIHANG,HANGHOA,KHO WHERE LOAIHANG.MALOAI=HANGHOA.MALOAI AND KHO.MAHH = HANGHOA.MAHH

/*Trigger kiểm tra ràng buộc trước khi thay đổi thông tin một nhân viên:
*/

CREATE TRIGGER Trg_Check_Update_NHANVIEN
ON NHANVIEN
FOR UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM HOADON_XUAT WHERE MANV = (SELECT MANV FROM updated) ) OR EXISTS (SELECT 1 FROM HOADON_NHAP WHERE MANV = updated.MANV)
    BEGIN
        PRINT (N'Không thể cập nhật thông tin nhân viên này vì đã có hóa đơn liên quan.');
        ROLLBACK TRANSACTION;
    END
END;

CREATE TRIGGER Trg_KT_Update_NHANVIEN
ON NHANVIEN
FOR UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM HOADON_XUAT 
        WHERE MANV IN (SELECT MANV FROM INSERTED)
    ) OR EXISTS (
        SELECT 1 
        FROM HOADON_NHAP 
        WHERE MANV IN (SELECT MANV FROM INSERTED)
    )
    BEGIN
        PRINT (N'Không thể cập nhật thông tin nhân viên này vì đã có hóa đơn liên quan.');
        ROLLBACK TRANSACTION;
    END
END;

SELECT*FROM NHANVIEN
INSERT INTO NHANVIEN (MANV, TENNV, GIOITINH, NGAYSINH, DIACHI, SDT)
VALUES
    ('NV00111', N'ABC', N'Nam', '1990-01-15', N'123 Đường X, Quận Y', '0123456789')
UPDATE NHANVIEN
SET TENNV = 'MM', -- Thay đổi thông tin cần cập nhật
    DiaChi = '123'
WHERE MaNV = 'NV00111';

/*----------------------------------------------------------------------------------------------------------------------------------*/
/*Trigger tự động tính tổng số tiền cho mỗi hóa đơn nhập sau khi thêm chi tiết hóa đơn nhập:
*/

/*----------------------------------------------------------------------------------------------------------------------------------*/

/*Trigger kiểm tra ràng buộc trước khi xóa một loại hàng:*/
CREATE TRIGGER Trg_Check_Delete_LoaiHang
ON LOAIHANG
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM HANGHOA WHERE MALOAI = (SELECT MALOAI FROM deleted) )
    BEGIN
        PRINT (N'Không thể xóa loại hàng này vì đã có hàng hóa liên quan.');

    END
    ELSE
    BEGIN
        DELETE FROM LOAIHANG WHERE MALOAI = (SELECT MALOAI FROM deleted);
    END
END;
DELETE FROM LOAIHANG WHERE MALOAI = 'LH001';
SELECT *FROM LOAIHANG
INSERT INTO LOAIHANG (MALOAI, TENLOAI, MOTA, FLAG)
VALUES
    ('LH00111', N'Điện tử', N'Loại hàng điện tử', 1)
/*Trigger tự động cập nhật trạng thái "CÒN KINH DOANH" của loại hàng sau khi thêm hoặc cập nhật hàng hóa:
*/
CREATE TRIGGER Trg_Update_Flag_LoaiHang
ON LOAIHANG
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE LOAIHANG
    SET LOAIHANG.FLAG = 
        CASE 
            WHEN EXISTS (SELECT 1 FROM HANGHOA WHERE HANGHOA.MALOAI = LOAIHANG.MALOAI) THEN 1
            ELSE 0
        END
END;


SELECT*FROM LOAIHANG,HANGHOA WHERE LOAIHANG.MALOAI = HANGHOA.MALOAI
INSERT INTO LOAIHANG (MALOAI, TENLOAI, MOTA, FLAG)
VALUES
    ('LH0010', N'Điện tử', N'Loại hàng điện tử', 1)
/*---------------------------------------------------------------------------------------------------------------*/
/*Trigger tự động cập nhật trạng thái "KO KINH DOANH" của loại hàng sau khi thêm hoặc cập nhật hàng hóa:
*/

