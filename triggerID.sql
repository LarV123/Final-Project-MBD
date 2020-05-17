create or replace function REVERSESTR (
    INPUT in  varchar2 
) return varchar2
is
    rev varchar2(50) := '';
begin
    FOR i in reverse 1..length(input) LOOP
        rev := rev||substr(input, i, 1);
    END LOOP;
    return rev;
end REVERSESTR;
/

create sequence KATEGORI_BARANG_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_KATEGORI_BARANG
before insert on KATEGORI_BARANG
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',KATEGORI_BARANG_ID_SEQ.NEXTVAL);
	IF :new.ID_KATEGORI_BARANG is null then
	    :new.ID_KATEGORI_BARANG := CONCAT('KB',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/

create sequence JENIS_PEMBAYARAN_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_JENIS_PEMBAYARAN
before insert on JENIS_PEMBAYARAN
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',JENIS_PEMBAYARAN_ID_SEQ.NEXTVAL);
	IF :new.ID_JENIS_PEMBAYARAN is null then
	    :new.ID_JENIS_PEMBAYARAN := CONCAT('JPB',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/

create sequence PROVINSI_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_PROVINSI
before insert on PROVINSI
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',PROVINSI_ID_SEQ.NEXTVAL);
	IF :new.ID_PROVINSI is null then
	    :new.ID_PROVINSI := CONCAT('PV',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/

create sequence JENIS_EKSPEDISI_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_JENIS_EKSPEDISI
before insert on JENIS_EKSPEDISI
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',EKSPEDISI_ID_SEQ.NEXTVAL);
	IF :new.ID_EKSPEDISI is null then
	    :new.ID_EKSPEDISI := CONCAT('JE',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/

create sequence JENIS_PELANGGAN_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_JENIS_PELANGGAN
before insert on JENIS_PELANGGAN
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',JENIS_PELANGGAN_ID_SEQ.NEXTVAL);
	IF :new.ID_JENIS_PELANGGAN is null then
	    :new.ID_JENIS_PELANGGAN := CONCAT('JP',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/

create sequence KOTA_KABUPATEN_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_KOTA_KABUPATEN
before insert on KOTA_KABUPATEN
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',KOTA_KABUPATEN_ID_SEQ.NEXTVAL);
	IF :new.ID_KABUPATEN is null then
	    :new.ID_KABUPATEN := CONCAT('K',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/

create sequence PENGIRIMAN_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_PENGIRIMAN
before insert on PENGIRIMAN
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',PENGIRIMAN_ID_SEQ.NEXTVAL);
	IF :new.ID_PENGIRIMAN is null then
	    :new.ID_PENGIRIMAN := CONCAT('PG',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/

create sequence PELANGGAN_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_PELANGGAN
before insert on PELANGGAN
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',PELANGGAN_ID_SEQ.NEXTVAL);
	IF :new.ID_PELANGGAN is null then
	    :new.ID_PELANGGAN := CONCAT('PL',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/

create sequence PEMBAYARAN_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_PEMBAYARAN
before insert on PEMBAYARAN
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',PEMBAYARAN_ID_SEQ.NEXTVAL);
	IF :new.ID_PEMBAYARAN is null then
	    :new.ID_PEMBAYARAN := CONCAT('PB',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/

create sequence BARANG_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_BARANG
before insert on BARANG
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',BARANG_ID_SEQ.NEXTVAL);
	IF :new.ID_BARANG is null then
	    :new.ID_BARANG := CONCAT('B',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/

create sequence PESANAN_ID_SEQ
start with 1
increment by 1
cache 20
nominvalue 
nomaxvalue 
nocycle
noorder;
/

create or replace trigger BI_ID_PESANAN
before insert on PESANAN
for each row
DECLARE
    ID_NUMBER varchar2(8);
begin
    ID_NUMBER := CONCAT('0000',PESANAN_ID_SEQ.NEXTVAL);
	IF :new.ID_PESANAN is null then
	    :new.ID_PESANAN := CONCAT('P',REVERSESTR(SUBSTR(REVERSESTR(ID_NUMBER),1,4)));
	END IF;
end;
/