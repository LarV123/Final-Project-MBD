drop sequence SEQ_ID_BARANG;

create sequence SEQ_ID_BARANG
    minvalue 1
    maxvalue 999999
    start with 1
    increment by 1
    cache 20;

create or replace trigger TRG_INS_BARANG
before insert on BARANG
for each row
begin
    if (:new.ID_BARANG is null)
    then
        select 'B' || SEQ_ID_BARANG.nextval into :new.ID_BARANG from dual;
    end if;
end;
/

delete from BARANG;

insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Kedokteran Umum'), 'Stetoskop', 180000, 227500, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Kedokteran Umum'), 'Headlamp', 2500000, 3025000, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Kedokteran Umum'), 'Examination Lamp', 17000000, 20000000, 30, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Kedokteran Umum'), 'Low Pressure Suction Apparatus', 2500000, 3100000, 30, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Kedokteran Umum'), 'Palu Reflect T', 30000, 40000, 5, 0);

insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('X-Ray Viewer'), 'X Ray Film Viewer Single', 4000000, 6000000, 10, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('X-Ray Viewer'), 'X Ray Film Viewer Double', 8000000, 12000000, 13, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('X-Ray Viewer'), 'X Ray Film Viewer 3 Panel', 15000000, 20000000, 15, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('X-Ray Viewer'), 'X Ray Film Viewer 4 Panel', 17500000, 25000000, 19, 0);

insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), '2 Way Folley Catheter Nomor 10', 20000, 40000, 5, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), '2 Way Folley Catheter Nomor 12', 20000, 40000, 5, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), '2 Way Folley Catheter Nomor 14', 20000, 40000, 5, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), '2 Way Folley Catheter Nomor 16', 20000, 40000, 5, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), 'Alat Jarum Infus 18G', 3000, 4000, 3, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), 'Alat Jarum Infus 20G', 3000, 4000, 3, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), 'Alat Jarum Infus 22G', 3000, 4000, 3, 0);

insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Tongkat Ketiak', 200000, 350000, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Tongkat Siku', 300000, 450000, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Tongkat Kaki 4', 150000, 300000, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Tongkat Tuna Netra', 150000, 350000, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Kursi Roda', 900000, 1200000, 12, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Kursi Roda Travelling', 1800000, 2100000, 14, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Kursi Roda 3 in 1', 2500000, 3000000, 14, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Alat Bantu Dengar HA 20', 375000, 475000, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Alat Bantu Dengar HA 50', 800000, 1000000, 7, 0);

insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Defibrillator'), 'Defibrillator', 80000000, 100000000, 30, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Defibrillator'), 'Defibrillator Portable', 30000000, 40000000, 30, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Defibrillator'), 'Defibrillator Instramed', 200000000, 250000000, 30, 0);

insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Alat Tes Malaria', 600000, 850000, 6, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Drug Test 6 Parameter', 70000, 100000, 6, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Drug Test 5 Parameter', 60000, 80000, 6, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Drug Test Morfin', 10000, 20000, 6, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Alat Cek Kehamilan', 6000, 10000, 6, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Rapid Test MET', 10000, 20000, 6, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Rapid Test AMP', 10000, 20000, 6, 0);

insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Air Splint', 250000, 500000, 10, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Arm Sling', 35000, 50000, 5, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Spalk Kaki', 150000, 250000, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Spalk Tangan', 150000, 250000, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Cervical Collar', 350000, 400000, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Emergency Bag', 900000, 1000000, 7, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Perban', 20000, 50000, 4, 0);
insert into BARANG values (null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Emergency Blanket', 120000, 200000, 7, 0);