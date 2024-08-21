﻿	CREATE DATABASE QuanLyTraSuaDB;
	USE QuanLyTraSuaDB;

	-- Bảng KHACH_HANG
	CREATE TABLE KHACH_HANG (
		MA_KHACH_HANG CHAR(5) PRIMARY KEY,
		HO_TEN NVARCHAR(100) NOT NULL,
		SO_DIEN_THOAI NVARCHAR(20) NOT NULL,
		EMAIL NVARCHAR(100),
		DIA_CHI NVARCHAR(255)
	);

	SELECT * FROM KHACH_HANG

	-- Bảng SAN_PHAM
	CREATE TABLE SAN_PHAM (
		MA_SAN_PHAM CHAR(5) PRIMARY KEY,
		TEN_SAN_PHAM NVARCHAR(100) NOT NULL,
		MO_TA NVARCHAR(255),
		GIA FLOAT NOT NULL
	);

	SELECT * FROM SAN_PHAM

	-- Bảng NHAN_VIEN
	CREATE TABLE NHAN_VIEN (
		MA_NHAN_VIEN CHAR(5) PRIMARY KEY,
		HO_TEN NVARCHAR(100) NOT NULL,
		SO_DIEN_THOAI NVARCHAR(20) NOT NULL,
		EMAIL NVARCHAR(100),
		CHUC_VU NVARCHAR(100) NOT NULL
	);

	SELECT * FROM NHAN_VIEN


	-- Bảng DON_HANG
	CREATE TABLE DON_HANG (
		MA_DON_HANG CHAR(5) PRIMARY KEY,
		MA_KHACH_HANG CHAR(5),
		MA_NHAN_VIEN CHAR(5),
		NGAY_DAT_HANG DATE NOT NULL DEFAULT GETDATE(),
		TONG_TIEN FLOAT NOT NULL,
		CONSTRAINT FK_DONHANG_KHACHHANG FOREIGN KEY (MA_KHACH_HANG) REFERENCES KHACH_HANG(MA_KHACH_HANG),
		CONSTRAINT FK_DONHANG_NHANVIEN FOREIGN KEY (MA_NHAN_VIEN) REFERENCES NHAN_VIEN(MA_NHAN_VIEN)
	);

	SELECT * FROM DON_HANG



	-- Bảng CHI_TIET_DON_HANG
	CREATE TABLE CHI_TIET_DON_HANG (
		MA_CHI_TIET_DON_HANG CHAR(5) PRIMARY KEY,
		MA_DON_HANG CHAR(5),
		MA_SAN_PHAM CHAR(5),
		MA_NHAN_VIEN CHAR(5),
		SO_LUONG INT NOT NULL,
		GIA FLOAT NOT NULL,
		CONSTRAINT FK_CHITIETDH_DONHANG FOREIGN KEY (MA_DON_HANG) REFERENCES DON_HANG(MA_DON_HANG),
		CONSTRAINT FK_CHITIETDH_SANPHAM FOREIGN KEY (MA_SAN_PHAM) REFERENCES SAN_PHAM(MA_SAN_PHAM)
	);

	SELECT * FROM CHI_TIET_DON_HANG

	-- Bảng NHA_CUNG_CAP
	CREATE TABLE NHA_CUNG_CAP (
		MA_NHA_CUNG_CAP CHAR(5) PRIMARY KEY,
		TEN_NHA_CUNG_CAP NVARCHAR(100) NOT NULL,
		SO_DIEN_THOAI NVARCHAR(20),
		EMAIL NVARCHAR(100),
		DIA_CHI NVARCHAR(255)
	);

	SELECT * FROM NHA_CUNG_CAP

	-- Bảng KHO
	CREATE TABLE KHO (
		MA_KHO CHAR(5) PRIMARY KEY,
		MA_SAN_PHAM CHAR(5),
		MA_NHA_CUNG_CAP CHAR(5),
		SO_LUONG INT NOT NULL,
		NGAY_CAP_NHAT DATE NOT NULL DEFAULT GETDATE(),
		CONSTRAINT FK_KHO_SANPHAM FOREIGN KEY (MA_SAN_PHAM) REFERENCES SAN_PHAM(MA_SAN_PHAM),
		CONSTRAINT FK_KHO_NHACUNGCAP FOREIGN KEY (MA_NHA_CUNG_CAP) REFERENCES NHA_CUNG_CAP(MA_NHA_CUNG_CAP)
	);

	SELECT * FROM KHO

	-- Ràng buộc UNIQUE cho Email của KHACH_HANG
	ALTER TABLE KHACH_HANG
	ADD CONSTRAINT UQ_KHACH_HANG_EMAIL UNIQUE (EMAIL);

	-- Ràng buộc UNIQUE cho Email của NHAN_VIEN
	ALTER TABLE NHAN_VIEN
	ADD CONSTRAINT UQ_NHAN_VIEN_EMAIL UNIQUE (EMAIL);

	-- Ràng buộc CHECK cho giá sản phẩm (GIA) phải lớn hơn 0
	ALTER TABLE SAN_PHAM
	ADD CONSTRAINT CK_SAN_PHAM_GIA CHECK (GIA > 0);

	-- Ràng buộc CHECK cho số lượng tồn kho (SO_LUONG) phải lớn hơn hoặc bằng 0
	ALTER TABLE KHO
	ADD CONSTRAINT CK_KHO_SO_LUONG CHECK (SO_LUONG >= 0);

	ALTER TABLE NHAN_VIEN
	ADD CONSTRAINT DF_NHAN_VIEN_CHUC_VU
	DEFAULT N'Nhân viên' FOR CHUC_VU;

	SELECT * FROM NHAN_VIEN




