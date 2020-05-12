drop sequence SEQ_ID_KATEGORI_BARANG;

create sequence SEQ_ID_KATEGORI_BARANG
    minvalue 1
    maxvalue 99999
    start with 1
    increment by 1
    cache 20;

create or replace trigger TRG_INS_KATEGORI_BARANG
before insert on KATEGORI_BARANG
for each row
begin
    if (:new.ID_KATEGORI_BARANG is null)
    then
        select 'KB' || SEQ_ID_KATEGORI_BARANG.nextval into :new.ID_KATEGORI_BARANG from dual;
    end if;
end;
/

create or replace function FUNC_KATEGORI_BARANG_TO_ID (nama in VARCHAR)
return VARCHAR
is
    KATEGORI_ID VARCHAR(7);
begin
    select kb.ID_KATEGORI_BARANG into KATEGORI_ID from KATEGORI_BARANG kb where kb.NAMA_KATEGORI_BARANG = nama;
    return KATEGORI_ID;
end;

delete from KATEGORI_BARANG;

insert into KATEGORI_BARANG values (NULL, 'Alat Kedokteran Umum');
insert into KATEGORI_BARANG values (NULL, 'X-Ray Viewer');
insert into KATEGORI_BARANG values (NULL, 'Alkes Disposable');
insert into KATEGORI_BARANG values (NULL, 'Alat Bantu');
insert into KATEGORI_BARANG values (NULL, 'Defibrillator');
insert into KATEGORI_BARANG values (NULL, 'Rapid Test');
insert into KATEGORI_BARANG values (NULL, 'Alat P3K');