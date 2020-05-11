drop sequence SEQ_ID_KATEGORI_BARANG;

create sequence SEQ_ID_KATEGORI_BARANG
    minvalue 1
    maxvalue 99999
    start with 1
    increment by 1
    cache 20;

create or replace trigger TRG_INS_KATEGORI_BARANG
before insert on KATEGORI_BARANG
begin
    if (:new.ID_KATEGORI_BARANG is null)
    then
        :new.ID_KATEGORI_BARANG := 'KB' || SEQ_ID_KATEGORI_BARANG.nextval;
    end if;
end;/

insert KATEGORI_BARANG values (NULL, 'Alat Kedokteran Umum');
insert KATEGORI_BARANG values (NULL, 'X-Ray Viewer');
insert KATEGORI_BARANG values (NULL, 'Alkes Disposable');
insert KATEGORI_BARANG values (NULL, 'Alat Bantu Bergerak');
insert KATEGORI_BARANG values (NULL, 'Alat Bantu Dengar');
insert KATEGORI_BARANG values (NULL, 'Defibrillator');
insert KATEGORI_BARANG values (NULL, 'Rapid Test');
insert KATEGORI_BARANG values (NULL, 'Alat P3K');
insert KATEGORI_BARANG values (NULL, 'Model Kerangka Manusia');
insert KATEGORI_BARANG values (NULL, 'Termometer');