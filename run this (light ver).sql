create table BARANG ( 
   ID_BARANG            VARCHAR2(7)        not null, 
   ID_KATEGORI_BARANG   VARCHAR2(7), 
   NAMA_BARANG          VARCHAR2(1024), 
   HARGA_PRODUKSI       INTEGER, 
   HARGA_JUAL           INTEGER, 
   ESTIMASI_PRODUKSI    INTEGER, 
   STOCK                INTEGER, 
   constraint PK_BARANG primary key (ID_BARANG) 
);

create index KATEGORI_BARANG_FK on BARANG ( 
   ID_KATEGORI_BARANG ASC 
);

create table DETAIL_PEMESANAN ( 
   ID_BARANG            VARCHAR2(7), 
   ID_PESANAN           VARCHAR2(7), 
   KUANTITAS            INTEGER, 
   SUBTOTAL             INTEGER, 
   DISCOUNT_BARANG      INTEGER 
);

create index MEMILIKI_DETAIL_FK on DETAIL_PEMESANAN ( 
   ID_PESANAN ASC 
);

create index MEMESAN_BARANG_FK on DETAIL_PEMESANAN ( 
   ID_BARANG ASC 
);

create table JENIS_EKSPEDISI ( 
   ID_EKSPEDISI         VARCHAR2(7)        not null, 
   NAMA_EKSPEDISI       VARCHAR2(1024), 
   KONTAK_EKSPEDISI     VARCHAR2(1024), 
   constraint PK_JENIS_EKSPEDISI primary key (ID_EKSPEDISI) 
);

create table JENIS_PELANGGAN ( 
   ID_JENIS_PELANGGAN   VARCHAR2(7)        not null, 
   NAMA_JENIS_PELANGGAN VARCHAR2(1024), 
   PRIORITAS_PELANGGAN  INTEGER, 
   constraint PK_JENIS_PELANGGAN primary key (ID_JENIS_PELANGGAN) 
);

create table JENIS_PEMBAYARAN ( 
   ID_JENIS_PEMBAYARAN  VARCHAR2(7)        not null, 
   NAMA_JENIS_PEMBAYARAN VARCHAR2(1024), 
   constraint PK_JENIS_PEMBAYARAN primary key (ID_JENIS_PEMBAYARAN) 
);

create table KATEGORI_BARANG ( 
   ID_KATEGORI_BARANG   VARCHAR2(7)        not null, 
   NAMA_KATEGORI_BARANG VARCHAR2(1024), 
   constraint PK_KATEGORI_BARANG primary key (ID_KATEGORI_BARANG) 
);

create table KOTA_KABUPATEN ( 
   ID_PROVINSI          VARCHAR2(7), 
   ID_KABUPATEN         VARCHAR2(7)        not null, 
   NAMA_KABUPATEN       VARCHAR2(1024), 
   constraint PK_KOTA_KABUPATEN primary key (ID_KABUPATEN) 
);

create index MEMILIKI_KABUPATEN_FK on KOTA_KABUPATEN ( 
   ID_PROVINSI ASC 
);

create table PELANGGAN ( 
   ID_PELANGGAN         VARCHAR2(7)        not null, 
   ID_JENIS_PELANGGAN   VARCHAR2(7), 
   ID_KABUPATEN         VARCHAR2(7), 
   NAMA_PELANGGAN       VARCHAR2(1024), 
   TELEPON_PELANGGAN    VARCHAR2(1024), 
   ALAMAT_PELANGGAN     VARCHAR2(1024), 
   EMAIL_PELANGGAN      VARCHAR2(1024), 
   constraint PK_PELANGGAN primary key (ID_PELANGGAN) 
);

create index JENIS_PELANGGAN_FK on PELANGGAN ( 
   ID_JENIS_PELANGGAN ASC 
);

create index BERTEMPAT_KOTA_FK on PELANGGAN ( 
   ID_KABUPATEN ASC 
);

create table PEMBAYARAN ( 
   ID_PEMBAYARAN        VARCHAR2(7)        not null, 
   ID_JENIS_PEMBAYARAN  VARCHAR2(7), 
   ID_PESANAN           VARCHAR2(7), 
   TANGGAL_PEMBAYARAN   DATE, 
   JUMLAH_PEMBAYARAN    INTEGER, 
   KEPERLUAN_PEMBAYARAN VARCHAR2(1024), 
   constraint PK_PEMBAYARAN primary key (ID_PEMBAYARAN) 
);

create index JENIS_PEMBAYARAN_FK on PEMBAYARAN ( 
   ID_JENIS_PEMBAYARAN ASC 
);

create index DETAIL_PEMBAYARAN_FK on PEMBAYARAN ( 
   ID_PESANAN ASC 
);

create table PENGIRIMAN ( 
   ID_PENGIRIMAN        VARCHAR2(7)        not null, 
   ID_PESANAN           VARCHAR2(7), 
   ID_EKSPEDISI         VARCHAR2(7), 
   TANGGAL_MENGIRIM     TIMESTAMP, 
   KODE_RESI            VARCHAR2(12), 
   constraint PK_PENGIRIMAN primary key (ID_PENGIRIMAN) 
);

create index MENGIRIM_FK on PENGIRIMAN ( 
   ID_PESANAN ASC 
);

create index JENIS_EKSPEDISI_FK on PENGIRIMAN ( 
   ID_EKSPEDISI ASC 
);

create table PESANAN ( 
   ID_PESANAN           VARCHAR2(7)        not null, 
   ID_PELANGGAN         VARCHAR2(7), 
   TANGGAL_PESAN        TIMESTAMP, 
   STATUS_PESANAN       SMALLINT, 
   DISCOUNT_PESANAN     INTEGER, 
   TOTAL_HARGA          INTEGER, 
   JUMLAH_TERBAYARKAN   INTEGER, 
   constraint PK_PESANAN primary key (ID_PESANAN) 
);

create index MEMESAN_FK on PESANAN ( 
   ID_PELANGGAN ASC 
);

create table PROVINSI ( 
   ID_PROVINSI          VARCHAR2(7)        not null, 
   NAMA_PROVINSI        VARCHAR2(1024), 
   constraint PK_PROVINSI primary key (ID_PROVINSI) 
);

create table UPDATE_STOCK ( 
   ID_BARANG            VARCHAR2(7), 
   ID_UPDATE_STOCK      VARCHAR2(7), 
   TANGGAL_UPDATE       DATE, 
   TIPE_UPDATE          VARCHAR2(1024), 
   JUMLAH_UPDATE        INTEGER 
);

create index UPDATE_STOCK_FK on UPDATE_STOCK ( 
   ID_BARANG ASC 
);

alter table BARANG 
   add constraint FK_BARANG_KATEGORI__KATEGORI foreign key (ID_KATEGORI_BARANG) 
      references KATEGORI_BARANG (ID_KATEGORI_BARANG);

alter table DETAIL_PEMESANAN 
   add constraint FK_DETAIL_P_MEMESAN_B_BARANG foreign key (ID_BARANG) 
      references BARANG (ID_BARANG);

alter table DETAIL_PEMESANAN 
   add constraint FK_DETAIL_P_MEMILIKI__PESANAN foreign key (ID_PESANAN) 
      references PESANAN (ID_PESANAN);

alter table KOTA_KABUPATEN 
   add constraint FK_KOTA_KAB_MEMILIKI__PROVINSI foreign key (ID_PROVINSI) 
      references PROVINSI (ID_PROVINSI);

alter table PELANGGAN 
   add constraint FK_PELANGGA_BERTEMPAT_KOTA_KAB foreign key (ID_KABUPATEN) 
      references KOTA_KABUPATEN (ID_KABUPATEN);

alter table PELANGGAN 
   add constraint FK_PELANGGA_JENIS_PEL_JENIS_PE foreign key (ID_JENIS_PELANGGAN) 
      references JENIS_PELANGGAN (ID_JENIS_PELANGGAN);

alter table PEMBAYARAN 
   add constraint FK_PEMBAYAR_DETAIL_PE_PESANAN foreign key (ID_PESANAN) 
      references PESANAN (ID_PESANAN);

alter table PEMBAYARAN 
   add constraint FK_PEMBAYAR_JENIS_PEM_JENIS_PE foreign key (ID_JENIS_PEMBAYARAN) 
      references JENIS_PEMBAYARAN (ID_JENIS_PEMBAYARAN);

alter table PENGIRIMAN 
   add constraint FK_PENGIRIM_JENIS_EKS_JENIS_EK foreign key (ID_EKSPEDISI) 
      references JENIS_EKSPEDISI (ID_EKSPEDISI);

alter table PENGIRIMAN 
   add constraint FK_PENGIRIM_MENGIRIM_PESANAN foreign key (ID_PESANAN) 
      references PESANAN (ID_PESANAN);

alter table PESANAN 
   add constraint FK_PESANAN_MEMESAN_PELANGGA foreign key (ID_PELANGGAN) 
      references PELANGGAN (ID_PELANGGAN);

alter table UPDATE_STOCK 
   add constraint FK_UPDATE_S_UPDATE_ST_BARANG foreign key (ID_BARANG) 
      references BARANG (ID_BARANG);

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
/

INSERT INTO KATEGORI_BARANG (ID_KATEGORI_BARANG, NAMA_KATEGORI_BARANG)  
  select NULL, 'Alat Kedokteran Umum'  FROM dual UNION ALL 
  select NULL, 'X-Ray Viewer'  FROM dual UNION ALL 
  select NULL, 'Alkes Disposable'  FROM dual UNION ALL 
  select NULL, 'Alat Bantu'  FROM dual UNION ALL 
  select NULL, 'Defibrillator'  FROM dual UNION ALL 
  select NULL, 'Rapid Test'  FROM dual UNION ALL 
  select NULL, 'Alat P3K'  FROM dual;

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

INSERT INTO BARANG (ID_BARANG, ID_KATEGORI_BARANG, NAMA_BARANG, HARGA_PRODUKSI, HARGA_JUAL, ESTIMASI_PRODUKSI, STOCK) 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Kedokteran Umum'), 'Stetoskop', 180000, 227500, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Kedokteran Umum'), 'Headlamp', 2500000, 3025000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Kedokteran Umum'), 'Examination Lamp', 17000000, 20000000, 30, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Kedokteran Umum'), 'Low Pressure Suction Apparatus', 2500000, 3100000, 30, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Kedokteran Umum'), 'Palu Reflect T', 30000, 40000, 5, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('X-Ray Viewer'), 'X Ray Film Viewer Single', 4000000, 6000000, 10, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('X-Ray Viewer'), 'X Ray Film Viewer Double', 8000000, 12000000, 13, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('X-Ray Viewer'), 'X Ray Film Viewer 3 Panel', 15000000, 20000000, 15, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('X-Ray Viewer'), 'X Ray Film Viewer 4 Panel', 17500000, 25000000, 19, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), '2 Way Folley Catheter Nomor 10', 20000, 40000, 5, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), '2 Way Folley Catheter Nomor 12', 20000, 40000, 5, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), '2 Way Folley Catheter Nomor 14', 20000, 40000, 5, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), '2 Way Folley Catheter Nomor 16', 20000, 40000, 5, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), 'Alat Jarum Infus 18G', 3000, 4000, 3, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), 'Alat Jarum Infus 20G', 3000, 4000, 3, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alkes Disposable'), 'Alat Jarum Infus 22G', 3000, 4000, 3, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Tongkat Ketiak', 200000, 350000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Tongkat Siku', 300000, 450000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Tongkat Kaki 4', 150000, 300000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Tongkat Tuna Netra', 150000, 350000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Kursi Roda', 900000, 1200000, 12, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Kursi Roda Travelling', 1800000, 2100000, 14, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Kursi Roda 3 in 1', 2500000, 3000000, 14, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Alat Bantu Dengar HA 20', 375000, 475000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat Bantu'), 'Alat Bantu Dengar HA 50', 800000, 1000000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Defibrillator'), 'Defibrillator', 80000000, 100000000, 30, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Defibrillator'), 'Defibrillator Portable', 30000000, 40000000, 30, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Defibrillator'), 'Defibrillator Instramed', 200000000, 250000000, 30, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Alat Tes Malaria', 600000, 850000, 6, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Drug Test 6 Parameter', 70000, 100000, 6, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Drug Test 5 Parameter', 60000, 80000, 6, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Drug Test Morfin', 10000, 20000, 6, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Alat Cek Kehamilan', 6000, 10000, 6, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Rapid Test MET', 10000, 20000, 6, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Rapid Test'), 'Rapid Test AMP', 10000, 20000, 6, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Air Splint', 250000, 500000, 10, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Arm Sling', 35000, 50000, 5, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Spalk Kaki', 150000, 250000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Spalk Tangan', 150000, 250000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Cervical Collar', 350000, 400000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Emergency Bag', 900000, 1000000, 7, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Perban', 20000, 50000, 4, 0  FROM dual UNION ALL 
  select null, FUNC_KATEGORI_BARANG_TO_ID('Alat P3K'), 'Emergency Blanket', 120000, 200000, 7, 0  FROM dual;

create sequence SEQ_ID_UPDATE_STOCK 
    minvalue 1 
    maxvalue 99999 
    start with 1 
    increment by 1 
    cache 20;

create or replace trigger TRG_INS_UPDATE_STOCK 
before insert on UPDATE_STOCK 
for each row 
begin 
    if (:new.ID_UPDATE_STOCK is null) 
    then 
        select 'US' || SEQ_ID_UPDATE_STOCK.nextval into :new.ID_UPDATE_STOCK from dual; 
    end if; 
end; 
/

INSERT INTO UPDATE_STOCK (ID_BARANG, ID_UPDATE_STOCK, TANGGAL_UPDATE, TIPE_UPDATE, JUMLAH_UPDATE)  
  select 'B1', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B2', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B3', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B4', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B5', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B6', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B7', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B8', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B9', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B10', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B11', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B12', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B13', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B14', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B15', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B16', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B17', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B18', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B19', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B20', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B21', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B22', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B23', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B24', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B25', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B26', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B27', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B28', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B29', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B30', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B31', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B32', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B33', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B34', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B35', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B36', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B37', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B38', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B39', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B40', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B41', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B42', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL 
  select 'B43', null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 100  FROM dual UNION ALL
  select 'B2',  null, TO_DATE('22/05/2020', 'DD/MM/YYYY'), 'Tambah', 12 FROM dual UNION ALL
  select 'B1',  null, TO_DATE('13/05/2020', 'DD/MM/YYYY'), 'Tambah', 10 FROM dual UNION ALL
  select 'B3',  null, TO_DATE('23/05/2020', 'DD/MM/YYYY'), 'Tambah', 130 FROM dual UNION ALL
  select 'B4',  null, TO_DATE('12/06/2020', 'DD/MM/YYYY'), 'Tambah', 110 FROM dual UNION ALL
  select 'B5',  null, TO_DATE('19/05/2020', 'DD/MM/YYYY'), 'Tambah', 130 FROM dual UNION ALL
  select 'B6',  null, TO_DATE('20/05/2020', 'DD/MM/YYYY'), 'Tambah', 120 FROM dual UNION ALL
  select 'B7',  null, TO_DATE('23/05/2020', 'DD/MM/YYYY'), 'Tambah', 130 FROM dual UNION ALL
  select 'B8',  null, TO_DATE('6/05/2020', 'DD/MM/YYYY'), 'Tambah', 160 FROM dual UNION ALL
  select 'B9',  null, TO_DATE('17/05/2020', 'DD/MM/YYYY'), 'Tambah', 110 FROM dual UNION ALL
  select 'B10',  null, TO_DATE('1/05/2020', 'DD/MM/YYYY'), 'Tambah', 10 FROM dual UNION ALL
  select 'B11',  null, TO_DATE('11/05/2020', 'DD/MM/YYYY'), 'Tambah', 11 FROM dual UNION ALL
  select 'B12',  null, TO_DATE('17/05/2020', 'DD/MM/YYYY'), 'Tambah', 13 FROM dual UNION ALL
  select 'B13',  null, TO_DATE('19/05/2020', 'DD/MM/YYYY'), 'Tambah', 14 FROM dual UNION ALL
  select 'B14',  null, TO_DATE('30/05/2020', 'DD/MM/YYYY'), 'Tambah', 16 FROM dual UNION ALL
  select 'B15',  null, TO_DATE('22/05/2020', 'DD/MM/YYYY'), 'Tambah', 13 FROM dual UNION ALL
  select 'B16',  null, TO_DATE('21/05/2020', 'DD/MM/YYYY'), 'Tambah', 112 FROM dual UNION ALL
  select 'B17',  null, TO_DATE('16/05/2020', 'DD/MM/YYYY'), 'Tambah', 11 FROM dual UNION ALL
  select 'B18',  null, TO_DATE('13/05/2020', 'DD/MM/YYYY'), 'Tambah', 110 FROM dual UNION ALL
  select 'B19',  null, TO_DATE('20/05/2020', 'DD/MM/YYYY'), 'Tambah', 110 FROM dual UNION ALL
  select 'B20',  null, TO_DATE('12/07/2020', 'DD/MM/YYYY'), 'Tambah', 100 FROM dual UNION ALL
  select 'B21',  null, TO_DATE('12/08/2020', 'DD/MM/YYYY'), 'Tambah', 23 FROM dual UNION ALL
  select 'B22',  null, TO_DATE('12/11/2020', 'DD/MM/YYYY'), 'Tambah', 45 FROM dual UNION ALL
  select 'B23',  null, TO_DATE('12/06/2020', 'DD/MM/YYYY'), 'Tambah', 36 FROM dual UNION ALL
  select 'B24',  null, TO_DATE('13/05/2020', 'DD/MM/YYYY'), 'Tambah', 56 FROM dual UNION ALL
  select 'B25',  null, TO_DATE('30/06/2020', 'DD/MM/YYYY'), 'Tambah', 78 FROM dual UNION ALL
  select 'B26',  null, TO_DATE('30/07/2020', 'DD/MM/YYYY'), 'Tambah', 45 FROM dual UNION ALL
  select 'B27',  null, TO_DATE('23/08/2020', 'DD/MM/YYYY'), 'Tambah', 45 FROM dual UNION ALL
  select 'B28',  null, TO_DATE('14/06/2020', 'DD/MM/YYYY'), 'Tambah', 67 FROM dual UNION ALL
  select 'B29',  null, TO_DATE('14/07/2020', 'DD/MM/YYYY'), 'Tambah', 12 FROM dual UNION ALL
  select 'B30',  null, TO_DATE('14/08/2020', 'DD/MM/YYYY'), 'Tambah', 23 FROM dual UNION ALL
  select 'B31',  null, TO_DATE('14/09/2020', 'DD/MM/YYYY'), 'Tambah', 25 FROM dual UNION ALL
  select 'B32',  null, TO_DATE('14/10/2020', 'DD/MM/YYYY'), 'Tambah', 27 FROM dual UNION ALL
  select 'B33',  null, TO_DATE('17/06/2020', 'DD/MM/YYYY'), 'Tambah', 35 FROM dual UNION ALL
  select 'B34',  null, TO_DATE('17/08/2020', 'DD/MM/YYYY'), 'Tambah', 13 FROM dual UNION ALL
  select 'B35',  null, TO_DATE('17/07/2020', 'DD/MM/YYYY'), 'Tambah', 67 FROM dual UNION ALL
  select 'B36',  null, TO_DATE('17/09/2020', 'DD/MM/YYYY'), 'Tambah', 35 FROM dual UNION ALL
  select 'B37',  null, TO_DATE('17/10/2020', 'DD/MM/YYYY'), 'Tambah', 58 FROM dual UNION ALL
  select 'B38',  null, TO_DATE('19/05/2020', 'DD/MM/YYYY'), 'Tambah', 37 FROM dual UNION ALL
  select 'B39',  null, TO_DATE('22/05/2020', 'DD/MM/YYYY'), 'Tambah', 14 FROM dual UNION ALL
  select 'B40',  null, TO_DATE('13/05/2020', 'DD/MM/YYYY'), 'Tambah', 37 FROM dual UNION ALL
  select 'B41',  null, TO_DATE('17/05/2020', 'DD/MM/YYYY'), 'Tambah', 24 FROM dual UNION ALL
  select 'B42',  null, TO_DATE('18/05/2020', 'DD/MM/YYYY'), 'Tambah', 12 FROM dual UNION ALL
  select 'B43',  null, TO_DATE('12/05/2020', 'DD/MM/YYYY'), 'Tambah', 46 FROM dual;

INSERT INTO JENIS_EKSPEDISI (ID_EKSPEDISI, NAMA_EKSPEDISI, KONTAK_EKSPEDISI)  
  select 'JE1','Papandaya Cargo','0318546393'  FROM dual UNION ALL 
  select 'JE2','Aura Abadi Logistik','082141127937'  FROM dual UNION ALL 
  select 'JE3','Klik Logistics','02189459999'  FROM dual UNION ALL 
  select 'JE4','Makharya Cargo','03199921804'  FROM dual UNION ALL 
  select 'JE5','Deliveree','0317654321'  FROM dual UNION ALL 
  select 'JE6','Expedisi Surabaya','082245318778'  FROM dual UNION ALL 
  select 'JE7','Almaguna Cargo','0313810284'  FROM dual;

INSERT INTO JENIS_PELANGGAN (ID_JENIS_PELANGGAN, NAMA_JENIS_PELANGGAN, PRIORITAS_PELANGGAN) 
  select 'JL1', 'Rumah Sakit', '1'  FROM dual UNION ALL
  select 'JL2', 'Lembaga Pemerintahan', '2'  FROM dual UNION ALL
  select 'JL3', 'Toko', '3'  FROM dual UNION ALL
  select 'JL4', 'Rumah Tangga', '4'  FROM dual;

INSERT INTO PROVINSI (ID_PROVINSI, NAMA_PROVINSI)  
  select 'PV1', 'Jawa Timur'  FROM dual UNION ALL 
  select 'PV2', 'Jawa Tengah'  FROM dual UNION ALL 
  select 'PV3', 'Jawa Barat'  FROM dual UNION ALL 
  select 'PV4', 'Jakarta'  FROM dual UNION ALL 
  select 'PV5', 'Yogyakarta'  FROM dual UNION ALL 
  select 'PV6', 'Sumatera Utara'  FROM dual UNION ALL 
  select 'PV7', 'Sumatera Selatan'  FROM dual UNION ALL 
  select 'PV8', 'Kalimantan Barat'  FROM dual UNION ALL 
  select 'PV9', 'Kalimantan Timur'  FROM dual UNION ALL 
  select 'PV10', 'Sulawesi Selatan'  FROM dual UNION ALL 
  select 'PV11', 'Sulawesi Tenggara'  FROM dual UNION ALL 
  select 'PV12', 'Nusa Tenggara Barat'  FROM dual;

INSERT INTO KOTA_KABUPATEN (ID_PROVINSI, ID_KABUPATEN, NAMA_KABUPATEN)  
  select 'PV1','K1', 'Surabaya'  FROM dual UNION ALL 
  select 'PV1','K2', 'Malang'  FROM dual UNION ALL 
  select 'PV1','K3', 'Mojokerto'  FROM dual UNION ALL 
  select 'PV1','K4', 'Pasuruan'  FROM dual UNION ALL 
  select 'PV2','K5', 'Tegal'  FROM dual UNION ALL 
  select 'PV2','K6', 'Semarang'  FROM dual UNION ALL 
  select 'PV2','K7', 'Magelang'  FROM dual UNION ALL 
  select 'PV2','K8', 'Pekalongan'  FROM dual UNION ALL 
  select 'PV3','K9', 'Bogor'  FROM dual UNION ALL 
  select 'PV3','K10', 'Depok'  FROM dual UNION ALL 
  select 'PV3','K11', 'Bekasi'  FROM dual UNION ALL 
  select 'PV3','K12', 'Cimahi'  FROM dual UNION ALL 
  select 'PV4','K13', 'Jakarta Pusat'  FROM dual UNION ALL 
  select 'PV5','K14', 'Yogyakarta'  FROM dual UNION ALL 
  select 'PV6','K15', 'Medan'  FROM dual UNION ALL 
  select 'PV6','K16', 'Samosir'  FROM dual UNION ALL 
  select 'PV6','K17', 'Asahan'  FROM dual UNION ALL 
  select 'PV6','K18', 'Karo'  FROM dual UNION ALL 
  select 'PV7','K19', 'Lahat'  FROM dual UNION ALL 
  select 'PV7','K20', 'Banyuasin'  FROM dual UNION ALL 
  select 'PV7','K21', 'Palembang'  FROM dual UNION ALL 
  select 'PV7','K22', 'Prabumulih'  FROM dual UNION ALL 
  select 'PV8','K23', 'Pontianak'  FROM dual UNION ALL 
  select 'PV8','K24', 'Singkawang'  FROM dual UNION ALL 
  select 'PV8','K25', 'Sintang'  FROM dual UNION ALL 
  select 'PV8','K26', 'Sambas'  FROM dual UNION ALL 
  select 'PV9','K27', 'Berau'  FROM dual UNION ALL 
  select 'PV9','K28', 'Balikpapan'  FROM dual UNION ALL 
  select 'PV9','K29', 'Bontang'  FROM dual UNION ALL 
  select 'PV9','K30', 'Samarinda'  FROM dual UNION ALL 
  select 'PV10','K31', 'Bantaeng'  FROM dual UNION ALL 
  select 'PV10','K32', 'Gowa'  FROM dual UNION ALL 
  select 'PV10','K33', 'Luwu'  FROM dual UNION ALL 
  select 'PV10','K34', 'Makassar'  FROM dual UNION ALL 
  select 'PV11','K35', 'Bombana'  FROM dual UNION ALL 
  select 'PV11','K36', 'Kolaka'  FROM dual UNION ALL 
  select 'PV11','K37', 'Konawe'  FROM dual UNION ALL 
  select 'PV11','K38', 'Kendari'  FROM dual UNION ALL 
  select 'PV12','K39', 'Bima'  FROM dual UNION ALL 
  select 'PV12','K40', 'Sumbawa'  FROM dual UNION ALL 
  select 'PV12','K41', 'Mataram'  FROM dual UNION ALL 
  select 'PV12','K42', 'Dompu'  FROM dual;

INSERT INTO PELANGGAN (ID_PELANGGAN, ID_JENIS_PELANGGAN, ID_KABUPATEN, NAMA_PELANGGAN, TELEPON_PELANGGAN,ALAMAT_PELANGGAN, EMAIL_PELANGGAN) 
  select 'PL1','JL1','K13','RS Islam Jakarta','0215732241','Jl.Jend. Sudirman No.Kav 49', 'RSIslamJakarta@gmail.com'  FROM dual UNION ALL
  select 'PL2','JL1','K13','RS Harum Sisma Medika','0218617212','Jl.S. Kalimalang Tarum Barat', 'RSHarumSiskaMedika@gmail.com'  FROM dual UNION ALL
  select 'PL3','JL1','K1','Medical Center ITS','0315927547','Jl.Arief Rahman Hakim No.213', 'MedCenITS@gmail.com'  FROM dual UNION ALL
  select 'PL4','JL1','K1','RS Pura Raharja','0315019898','Jl.Pucang Adi No.12-14', 'RSPuraRaharja@gmail.com'  FROM dual UNION ALL
  select 'PL5','JL1','K1','RS Premier Surabaya','0315993211','Jl.Nginden Intan Barat No.B', 'RSPremierSurabaya@gmail.com'  FROM dual UNION ALL
  select 'PL6','JL1','K9','RS Azra Bogor','02518318456','Jl.Raya Pajajaran No.219', 'RSAzraBogor@gmail.com'  FROM dual UNION ALL
  select 'PL7','JL1','K14','RS Wirosaban','0274371195','Jl.Ki Ageng Pemanahan No.1', 'RSWirosaban@gmail.com'  FROM dual UNION ALL
  select 'PL8','JL1','K15','RS Martha Friska Medan','0614149666','Jl.Multatuli No.1', 'RSMarthaFriskaMedan@gmail.com'  FROM dual UNION ALL
  select 'PL9','JL1','K21','RS Myria','0711411610','Jl.Kol. H. Burlian No.228', 'RSMyria@gmail.com'  FROM dual UNION ALL
  select 'PL10','JL1','K23','RS Yarsi','0561739685','Jl.Tanjung Raya II', 'RSYarsi@gmail.com'  FROM dual UNION ALL
  select 'PL11','JL1','K28','RS Balikpapan Baru','0542870330','Jl.Mohammad T. Haryono', 'RSBalikpapanBaru@gmail.com'  FROM dual UNION ALL
  select 'PL12','JL1','K34','RS Pelamonia','08111782399','Jl.Jend. Sudirman No.27', 'RSPelamonia@gmail.com'  FROM dual UNION ALL
  select 'PL13','JL1','K38','RS Abunawas','04017926150','Jl.Z.A. Sugianto No. 39', 'RSAbunawas@gmail.com'  FROM dual UNION ALL
  select 'PL14','JL1','K39','RS dr.Agung','037443166','Jl.Ir Sutami No.1, Rabadompu Bar', 'RSdr.Agung@gmail.com'  FROM dual UNION ALL
  select 'PL15','JL1','K4','RS Sahabat','03436743777','Jl.Raya Surabaya - Malang No.KM', 'RSSahabat.Agung@gmail.com'  FROM dual UNION ALL
  select 'PL16','JL2','K1','Kantor Walikota Surabaya','0315312144','Jl.Taman Surya No.1, Ketabang', 'KWSurabaya@gmail.com'  FROM dual UNION ALL
  select 'PL17','JL2','K1','Kantor Gubernur Jawa Timur','0315247145','Jl.Pahlawan No.110', 'KGJawaTimur@gmail.com'  FROM dual UNION ALL
  select 'PL18','JL2','K13','Kantor Walikota Jakarta Pusat','0213502575','Jl.Tanah Abang I No.1', 'KWJakartaPusat@gmail.com'  FROM dual UNION ALL
  select 'PL19','JL2','K13','Kantor Gubernur Jakarta','0213504810','Jl.Medan Merdeka Sel. No.8-9', 'KGJakarta@gmail.com'  FROM dual UNION ALL
  select 'PL20','JL2','K14','Kantor Walikota Yogyakarta','0274514448','Jl.Kenari No.56', 'KWYogyakarta@gmail.com'  FROM dual UNION ALL
  select 'PL21','JL2','K14','Kantor Gubernur Yogyakarta','562811','Jl.Malioboro No.16, Suryatmajan', 'KGYogyakarta@gmail.com'  FROM dual UNION ALL
  select 'PL22','JL2','K21','Kantor Gubernur Sumatera Selatan','0711352388','Jl.Kapten A. Rivai No.3', 'KGSumateraSelatan@gmail.com'  FROM dual UNION ALL
  select 'PL23','JL2','K21','Kantor Walikota Palembang','0711352695','Jl.Merdeka No.1', 'KWPalembang@gmail.com'  FROM dual UNION ALL
  select 'PL24','JL2','K28','Kantor Walikota Balikpapan','0542421500','Jl.Jenderal Sudirman No.1', 'KWBalikpapan@gmail.com'  FROM dual UNION ALL
  select 'PL25','JL3','K11','Toko konoj','086921986164','Jl.tojeqija xahuy no.14', 'konoj892@gmail.com'  FROM dual UNION ALL
  select 'PL26','JL3','K38','Toko sutafo sufoqic','081159441816','Jl.hepugeteko no.49', 'sutafo582@gmail.com'  FROM dual UNION ALL
  select 'PL27','JL3','K34','Toko zoci xeco','088654176986','Jl.koqiledihe qudufoc no.5', 'zoci993@gmail.com'  FROM dual UNION ALL
  select 'PL28','JL3','K18','Toko moyoguf yadajis','082747752786','Jl.horegaliqu no.80', 'moyoguf567@gmail.com'  FROM dual UNION ALL
  select 'PL29','JL3','K39','Toko zoti muki','083300145264','Jl.valedanawi bofoxapura no.74', 'zoti45@gmail.com'  FROM dual UNION ALL
  select 'PL30','JL3','K35','Toko kimiqi rudela','088670047441','Jl.somaquce no.54', 'kimiqi814@gmail.com'  FROM dual UNION ALL
  select 'PL31','JL3','K4','Toko zoyola vibevid','083689955404','Jl.nerecaroz desarax no.57', 'zoyola11@gmail.com'  FROM dual UNION ALL
  select 'PL32','JL3','K40','Toko humiqok','088299483731','Jl.wodiyaq no.90', 'humiqok365@gmail.com'  FROM dual UNION ALL
  select 'PL33','JL3','K41','Toko mivulud','088318440230','Jl.colazes no.74', 'mivulud568@gmail.com'  FROM dual UNION ALL
  select 'PL34','JL3','K29','Toko suxiga bocimin','085335888839','Jl.duwucelu no.72', 'suxiga868@gmail.com'  FROM dual UNION ALL
  select 'PL35','JL3','K24','Toko sepoti','088350501806','Jl.xorukedifi xerunu no.14', 'sepoti248@gmail.com'  FROM dual UNION ALL
  select 'PL36','JL3','K14','Toko hojeq picelu','085978532132','Jl.kamuco no.95', 'hojeq447@gmail.com'  FROM dual UNION ALL
  select 'PL37','JL3','K5','Toko qobo','085550284702','Jl.bukuna no.87', 'qobo663@gmail.com'  FROM dual UNION ALL
  select 'PL38','JL3','K27','Toko ruxora','087794695330','Jl.lucogaxu nademehet no.56', 'ruxora847@gmail.com'  FROM dual UNION ALL
  select 'PL39','JL3','K18','Toko cuhof jafifij','089917644302','Jl.qenezedu vuwer no.71', 'cuhof528@gmail.com'  FROM dual UNION ALL
  select 'PL40','JL3','K18','Toko moxapev','081863483908','Jl.rociviniho zilar no.27', 'moxapev779@gmail.com'  FROM dual UNION ALL
  select 'PL41','JL3','K9','Toko dikozo godasol','080583394464','Jl.lulemavite loyazoco no.26', 'dikozo783@gmail.com'  FROM dual UNION ALL
  select 'PL42','JL3','K35','Toko mogirag','089275833517','Jl.gevosofop no.28', 'mogirag457@gmail.com'  FROM dual UNION ALL
  select 'PL43','JL3','K15','Toko poyagit bagaloq','081892069049','Jl.paxijajaju no.2', 'poyagit165@gmail.com'  FROM dual UNION ALL
  select 'PL44','JL3','K24','Toko yuhayoc','083905268278','Jl.foxisi titunopa no.17', 'yuhayoc902@gmail.com'  FROM dual UNION ALL
  select 'PL45','JL3','K31','Toko zuma xobetuw','089525264618','Jl.jaxinoyoz no.49', 'zuma145@gmail.com'  FROM dual UNION ALL
  select 'PL46','JL3','K39','Toko laxeden','083951830517','Jl.yelefop no.21', 'laxeden903@gmail.com'  FROM dual UNION ALL
  select 'PL47','JL3','K12','Toko hebakeq','080627500596','Jl.qipalu no.40', 'hebakeq928@gmail.com'  FROM dual UNION ALL
  select 'PL48','JL3','K41','Toko bayoyid xatali','083056952587','Jl.diqurereh nusuj no.3', 'bayoyid704@gmail.com'  FROM dual UNION ALL
  select 'PL49','JL3','K27','Toko yexo','088013029468','Jl.kalagukoqa rasugu no.38', 'yexo139@gmail.com'  FROM dual UNION ALL
  select 'PL50','JL3','K40','Toko qenema telasuj','089620325304','Jl.zicaq reyoxopu no.32', 'qenema548@gmail.com'  FROM dual UNION ALL
  select 'PL51','JL3','K24','Toko fori yeke','082103122052','Jl.wepome no.94', 'fori138@gmail.com'  FROM dual UNION ALL
  select 'PL52','JL3','K25','Toko kejuso jinine','080965166596','Jl.fafamu tubaruju no.39', 'kejuso261@gmail.com'  FROM dual UNION ALL
  select 'PL53','JL3','K6','Toko fovugor quho','081379059492','Jl.kiziw no.33', 'fovugor764@gmail.com'  FROM dual UNION ALL
  select 'PL54','JL3','K5','Toko wudehod xawal','089554988309','Jl.xibaqo no.26', 'wudehod450@gmail.com'  FROM dual UNION ALL
  select 'PL55','JL3','K20','Toko vukaqi vitewis','089630055402','Jl.lulefihoqi no.2', 'vukaqi762@gmail.com'  FROM dual UNION ALL
  select 'PL56','JL3','K4','Toko netuke xoma','088087466981','Jl.bonuw cewena no.34', 'netuke994@gmail.com'  FROM dual UNION ALL
  select 'PL57','JL3','K23','Toko vajom jigot','083626089843','Jl.zeqidacabi dakikokel no.44', 'vajom511@gmail.com'  FROM dual UNION ALL
  select 'PL58','JL3','K1','Toko lanume peme','089875864608','Jl.penek yakago no.85', 'lanume267@gmail.com'  FROM dual UNION ALL
  select 'PL59','JL3','K17','Toko jojeh','088931160028','Jl.xapehanu wofepi no.44', 'jojeh547@gmail.com'  FROM dual UNION ALL
  select 'PL60','JL3','K37','Toko wucaxig vezeguj','083264783757','Jl.motutunoh no.21', 'wucaxig15@gmail.com'  FROM dual UNION ALL
  select 'PL61','JL4','K13','diqu','082855666278','Jl.zobodo no.96', 'diqu516@gmail.com'  FROM dual UNION ALL
  select 'PL62','JL4','K19','gimoloh','086161448094','Jl.fejufusow wirobiqi no.35', 'gimoloh826@gmail.com'  FROM dual UNION ALL
  select 'PL63','JL4','K30','sipuyav yufok jamen','088641807891','Jl.tehat no.80', 'sipuyav25@gmail.com'  FROM dual UNION ALL
  select 'PL64','JL4','K10','rugu feta','088985895629','Jl.cugivudomo no.16', 'rugu493@gmail.com'  FROM dual UNION ALL
  select 'PL65','JL4','K14','hoyiret dijapaz wefuye','084904701326','Jl.teviveninu no.6', 'hoyiret170@gmail.com'  FROM dual UNION ALL
  select 'PL66','JL4','K14','qapixo','082246833088','Jl.himeneki no.42', 'qapixo108@gmail.com'  FROM dual UNION ALL
  select 'PL67','JL4','K2','kupi','087227389269','Jl.pohesudi no.85', 'kupi309@gmail.com'  FROM dual UNION ALL
  select 'PL68','JL4','K32','defigun','087412147077','Jl.xicecot komih no.4', 'defigun145@gmail.com'  FROM dual UNION ALL
  select 'PL69','JL4','K5','yawu','081126478474','Jl.dosof quyuza no.48', 'yawu572@gmail.com'  FROM dual UNION ALL
  select 'PL70','JL4','K23','zilo dudi','086228174966','Jl.ticay heyijigeq no.28', 'zilo950@gmail.com'  FROM dual UNION ALL
  select 'PL71','JL4','K14','wiquto cisal menu','080730981218','Jl.vixibiloru luxageco no.94', 'wiquto860@gmail.com'  FROM dual UNION ALL
  select 'PL72','JL4','K39','nafisi sutofe','086641592843','Jl.yesad no.46', 'nafisi344@gmail.com'  FROM dual UNION ALL
  select 'PL73','JL4','K19','hajaca zazusoq ruco','080270928308','Jl.raravalok no.58', 'hajaca761@gmail.com'  FROM dual UNION ALL
  select 'PL74','JL4','K22','yece kaziwu','089790855238','Jl.wuvire no.30', 'yece365@gmail.com'  FROM dual UNION ALL
  select 'PL75','JL4','K36','ceha feliz beni','083999584016','Jl.xekafefepi jifipe no.16', 'ceha162@gmail.com'  FROM dual UNION ALL
  select 'PL76','JL4','K36','kelu','089749536162','Jl.hazufotek jekakigi no.35', 'kelu668@gmail.com'  FROM dual UNION ALL
  select 'PL77','JL4','K17','viye nuhinun nulodu','083689390149','Jl.leduz xegaqica no.49', 'viye206@gmail.com'  FROM dual UNION ALL
  select 'PL78','JL4','K20','rehebo salaxe','085857160458','Jl.gusawu ranuwofe no.94', 'rehebo590@gmail.com'  FROM dual UNION ALL
  select 'PL79','JL4','K15','qanag lusikiw vuza','086087656127','Jl.gidonejime fihinikeli no.79', 'qanag29@gmail.com'  FROM dual UNION ALL
  select 'PL80','JL4','K22','bope lohoxu','082510831428','Jl.ceregepo ruhile no.33', 'bope896@gmail.com'  FROM dual UNION ALL
  select 'PL81','JL4','K20','xosil yebikiy vetutap','086575971636','Jl.mohoku juqocexeb no.42', 'xosil25@gmail.com'  FROM dual UNION ALL
  select 'PL82','JL4','K18','geqade','087430070116','Jl.seqapuzole balacuya no.20', 'geqade794@gmail.com'  FROM dual UNION ALL
  select 'PL83','JL4','K17','fibofih','082913991341','Jl.kitela lekidare no.62', 'fibofih926@gmail.com'  FROM dual UNION ALL
  select 'PL84','JL4','K25','pube vomeg foqeqah','080757440359','Jl.zehamamifi bucuhisare no.93', 'pube450@gmail.com'  FROM dual UNION ALL
  select 'PL85','JL4','K2','fenar xijiya','087810134305','Jl.nihihopu fixenulam no.55', 'fenar227@gmail.com'  FROM dual UNION ALL
  select 'PL86','JL4','K3','nile kebex kayayip','081142542959','Jl.honopepogu qusobalive no.28', 'nile791@gmail.com'  FROM dual UNION ALL
  select 'PL87','JL4','K5','cubi mipelaf nagiwi','084008634895','Jl.mosigeqozi qopifevih no.24', 'cubi377@gmail.com'  FROM dual UNION ALL
  select 'PL88','JL4','K35','sepa jufizu','089097203039','Jl.vipeseze wikeyeji no.74', 'sepa239@gmail.com'  FROM dual UNION ALL
  select 'PL89','JL4','K10','xogabit mamubib','086100284547','Jl.veyakez no.82', 'xogabit877@gmail.com'  FROM dual UNION ALL
  select 'PL90','JL4','K20','yutix vajux medis','087976922559','Jl.cequsegum no.49', 'yutix625@gmail.com'  FROM dual UNION ALL
  select 'PL91','JL4','K1','tuxi xovahem','085970086017','Jl.fumoqox mogesazazi no.63', 'tuxi231@gmail.com'  FROM dual UNION ALL
  select 'PL92','JL4','K21','zilo wucusas katug','089219173934','Jl.boqonadu no.17', 'zilo159@gmail.com'  FROM dual UNION ALL
  select 'PL93','JL4','K29','lazo pesoqe wizuru','083168959594','Jl.hojexonet no.4', 'lazo820@gmail.com'  FROM dual UNION ALL
  select 'PL94','JL4','K35','buno','086081970574','Jl.riwica gaxezebid no.10', 'buno109@gmail.com'  FROM dual UNION ALL
  select 'PL95','JL4','K38','nazo yokube dezim','085946979494','Jl.naliki tibelemawu no.82', 'nazo570@gmail.com'  FROM dual UNION ALL
  select 'PL96','JL4','K13','disaq relotid fipano','082385063093','Jl.yapefeb hovuy no.29', 'disaq674@gmail.com'  FROM dual UNION ALL
  select 'PL97','JL4','K39','noyekot beye','086388585867','Jl.suzah no.81', 'noyekot177@gmail.com'  FROM dual UNION ALL
  select 'PL98','JL4','K9','megezin bare','080427397576','Jl.yiciwuv no.77', 'megezin439@gmail.com'  FROM dual UNION ALL
  select 'PL99','JL4','K21','gasabod voru','080219101216','Jl.xaqifaja fulisefap no.63', 'gasabod977@gmail.com'  FROM dual UNION ALL
  select 'PL100','JL4','K36','nofegen','088717835797','Jl.zedonizu no.9', 'nofegen971@gmail.com'  FROM dual UNION ALL
  select 'PL101','JL4','K1','faye','080639587726','Jl.vohilir no.1', 'faye354@gmail.com'  FROM dual UNION ALL
  select 'PL102','JL4','K32','jicod dobo','080400706842','Jl.vecej no.22', 'jicod881@gmail.com'  FROM dual UNION ALL
  select 'PL103','JL4','K22','jiva wivukal podez','083349887696','Jl.jijiqiralo fegesodoso no.53', 'jiva16@gmail.com'  FROM dual UNION ALL
  select 'PL104','JL4','K35','jabe','084462163112','Jl.sagicazuc no.68', 'jabe249@gmail.com'  FROM dual UNION ALL
  select 'PL105','JL4','K18','raberaz lanadag honeg','086609058508','Jl.xurowulequ mikel no.2', 'raberaz429@gmail.com'  FROM dual UNION ALL
  select 'PL106','JL4','K18','qukobo dutuyiy xaduqax','085144878253','Jl.fabuja no.97', 'qukobo79@gmail.com'  FROM dual UNION ALL
  select 'PL107','JL4','K40','hexum worexex','080808230593','Jl.hediwud no.89', 'hexum437@gmail.com'  FROM dual UNION ALL
  select 'PL108','JL4','K13','feho fovaki radul','085420758109','Jl.lagul nixohuy no.15', 'feho690@gmail.com'  FROM dual UNION ALL
  select 'PL109','JL4','K2','logiq dequfom panil','086385550636','Jl.xifil no.33', 'logiq795@gmail.com'  FROM dual UNION ALL
  select 'PL110','JL4','K27','laxe memaku','089833658565','Jl.girewayu no.44', 'laxe136@gmail.com'  FROM dual UNION ALL
  select 'PL111','JL4','K36','pebar nasoz','086643555332','Jl.zegugudov no.44', 'pebar280@gmail.com'  FROM dual UNION ALL
  select 'PL112','JL4','K36','rigabin puzumuk','080119122251','Jl.jasodicum turor no.66', 'rigabin23@gmail.com'  FROM dual UNION ALL
  select 'PL113','JL4','K4','gebub xuquxey','087203163632','Jl.xezukaja mudewile no.43', 'gebub98@gmail.com'  FROM dual UNION ALL
  select 'PL114','JL4','K2','jujaw hugoku betuvu','086970066803','Jl.gafeh no.58', 'jujaw52@gmail.com'  FROM dual UNION ALL
  select 'PL115','JL4','K1','kovil','089496918687','Jl.tozape yavohima no.88', 'kovil606@gmail.com'  FROM dual UNION ALL
  select 'PL116','JL4','K1','gixibur kadey wuxeni','086563894355','Jl.rasig no.97', 'gixibur261@gmail.com'  FROM dual UNION ALL
  select 'PL117','JL4','K41','woba riduje','089873563385','Jl.huloyiwoyo no.53', 'woba35@gmail.com'  FROM dual UNION ALL
  select 'PL118','JL4','K2','lozogor gula','088530172088','Jl.kujuze no.92', 'lozogor700@gmail.com'  FROM dual UNION ALL
  select 'PL119','JL4','K24','naguxo civab','086095790495','Jl.babasat no.15', 'naguxo207@gmail.com'  FROM dual UNION ALL
  select 'PL120','JL4','K18','dihal humi','085896013677','Jl.hibela no.80', 'dihal833@gmail.com'  FROM dual UNION ALL
  select 'PL121','JL4','K30','jibon dece foyewaf','081573280152','Jl.ciripiniz lojoyuhiz no.74', 'jibon565@gmail.com'  FROM dual UNION ALL
  select 'PL122','JL4','K40','furuqi','086943966242','Jl.wawogeco no.31', 'furuqi741@gmail.com'  FROM dual UNION ALL
  select 'PL123','JL4','K11','zaxad maribot foteset','088420765420','Jl.rihawagu kacise no.90', 'zaxad239@gmail.com'  FROM dual UNION ALL
  select 'PL124','JL4','K20','coparo zura','087614590634','Jl.torofenoya no.62', 'coparo948@gmail.com'  FROM dual UNION ALL
  select 'PL125','JL4','K12','deyeb boji sekerom','086509236099','Jl.fefogicat tupuki no.65', 'deyeb582@gmail.com'  FROM dual UNION ALL
  select 'PL126','JL4','K27','bota','089066129151','Jl.yutufaquj lerabebi no.74', 'bota763@gmail.com'  FROM dual UNION ALL
  select 'PL127','JL4','K25','yofuj hikasez dadogor','088170273965','Jl.pihiqihel no.95', 'yofuj347@gmail.com'  FROM dual UNION ALL
  select 'PL128','JL4','K18','bazapa','085895260100','Jl.rimewasa qociyi no.27', 'bazapa556@gmail.com'  FROM dual UNION ALL
  select 'PL129','JL4','K32','kofip sopa fodukuc','089553607210','Jl.zofixufilo no.99', 'kofip156@gmail.com'  FROM dual UNION ALL
  select 'PL130','JL4','K13','detebe dobumep','089805487875','Jl.hodaf fowozoko no.1', 'detebe629@gmail.com'  FROM dual UNION ALL
  select 'PL131','JL4','K10','pime riwibez zibokuf','081684250448','Jl.cosoku no.43', 'pime729@gmail.com'  FROM dual UNION ALL
  select 'PL132','JL4','K2','ruris mucexun','089919247489','Jl.nafawefig saruhej no.70', 'ruris247@gmail.com'  FROM dual UNION ALL
  select 'PL133','JL4','K5','jeye cowoteq','086801126481','Jl.julezepida no.68', 'jeye875@gmail.com'  FROM dual UNION ALL
  select 'PL134','JL4','K21','gurumo nulona','080697181239','Jl.muboga nusigaroco no.11', 'gurumo937@gmail.com'  FROM dual UNION ALL
  select 'PL135','JL4','K42','lerax','083705262290','Jl.xowidozug no.84', 'lerax803@gmail.com'  FROM dual UNION ALL
  select 'PL136','JL4','K42','xocu lojawez kacuyu','085610231862','Jl.piqidaqa hefuhud no.70', 'xocu106@gmail.com'  FROM dual UNION ALL
  select 'PL137','JL4','K16','goboy','084730460373','Jl.rirapiy no.24', 'goboy173@gmail.com'  FROM dual UNION ALL
  select 'PL138','JL4','K13','nozux siyuyas zavipi','086236086555','Jl.samoforuz no.18', 'nozux198@gmail.com'  FROM dual UNION ALL
  select 'PL139','JL4','K41','moroveq fubi','089808781581','Jl.xowemix no.79', 'moroveq455@gmail.com'  FROM dual UNION ALL
  select 'PL140','JL4','K2','lifawix','087279694718','Jl.kodopid nunuyuwege no.77', 'lifawix638@gmail.com'  FROM dual UNION ALL
  select 'PL141','JL4','K2','junej','089045319599','Jl.tasizu zabozida no.20', 'junej424@gmail.com'  FROM dual UNION ALL
  select 'PL142','JL4','K39','qofa','086221548229','Jl.hezak no.65', 'qofa879@gmail.com'  FROM dual UNION ALL
  select 'PL143','JL4','K10','tegose kame lapihes','084120214180','Jl.rejoyiro no.98', 'tegose267@gmail.com'  FROM dual UNION ALL
  select 'PL144','JL4','K19','jazu','088651767289','Jl.xakecebodu no.84', 'jazu609@gmail.com'  FROM dual UNION ALL
  select 'PL145','JL4','K24','zebom poyute','083774602303','Jl.pivisujul letela no.67', 'zebom571@gmail.com'  FROM dual UNION ALL
  select 'PL146','JL4','K15','memiyal sami','081561508425','Jl.rahuhogud raxavif no.99', 'memiyal564@gmail.com'  FROM dual UNION ALL
  select 'PL147','JL4','K23','teres votuza','084575917020','Jl.deceliyahi pagaxevexu no.75', 'teres832@gmail.com'  FROM dual UNION ALL
  select 'PL148','JL4','K39','nige vepuhap','089763824481','Jl.cekowaviro no.78', 'nige785@gmail.com'  FROM dual UNION ALL
  select 'PL149','JL4','K36','leyiyi','085800105420','Jl.fupixul vosemur no.54', 'leyiyi887@gmail.com'  FROM dual UNION ALL
  select 'PL150','JL4','K30','meqefus xoqavuf weto','083522717849','Jl.nohixoq no.37', 'meqefus922@gmail.com'  FROM dual UNION ALL
  select 'PL151','JL4','K17','sufiv nuyi','083902993954','Jl.wodoq no.75', 'sufiv928@gmail.com'  FROM dual UNION ALL
  select 'PL152','JL4','K40','qeyez haku bawib','086752023768','Jl.pajija no.71', 'qeyez796@gmail.com'  FROM dual UNION ALL
  select 'PL153','JL4','K32','pucone josil','086634616370','Jl.demamunox hiqecebo no.93', 'pucone533@gmail.com'  FROM dual UNION ALL
  select 'PL154','JL4','K26','notevo jibez','080765701044','Jl.kaqira no.36', 'notevo872@gmail.com'  FROM dual UNION ALL
  select 'PL155','JL4','K6','guzum','084036259276','Jl.yoqupa no.7', 'guzum156@gmail.com'  FROM dual UNION ALL
  select 'PL156','JL4','K42','xariwo yaqo','082302658270','Jl.cajira no.81', 'xariwo147@gmail.com'  FROM dual UNION ALL
  select 'PL157','JL4','K14','vusoj xagufuf jihiway','087674097751','Jl.lubep diboyigel no.45', 'vusoj608@gmail.com'  FROM dual UNION ALL
  select 'PL158','JL4','K31','bifawu','088466906275','Jl.jiviki no.24', 'bifawu792@gmail.com'  FROM dual UNION ALL
  select 'PL159','JL4','K2','mirayav fulefe','083002511730','Jl.baniyowuyo mumilo no.5', 'mirayav647@gmail.com'  FROM dual UNION ALL
  select 'PL160','JL4','K17','furey','084507602337','Jl.wiqohe no.87', 'furey762@gmail.com'  FROM dual UNION ALL
  select 'PL161','JL4','K28','qobul soqol kilaro','088641265546','Jl.tudifakaqa joyasexiq no.35', 'qobul470@gmail.com'  FROM dual UNION ALL
  select 'PL162','JL4','K23','golelu','084615209433','Jl.picexiqop no.15', 'golelu959@gmail.com'  FROM dual UNION ALL
  select 'PL163','JL4','K36','yulahe','087292247273','Jl.luheh no.5', 'yulahe409@gmail.com'  FROM dual UNION ALL
  select 'PL164','JL4','K1','vasi yomepeh wiyaxuf','087082315815','Jl.xuralohixi lameji no.24', 'vasi608@gmail.com'  FROM dual UNION ALL
  select 'PL165','JL4','K32','deloru fuvegel yesu','080674411418','Jl.huboh haciwobeco no.66', 'deloru946@gmail.com'  FROM dual UNION ALL
  select 'PL166','JL4','K20','yesifiy dojuqem','086585239316','Jl.sewokiwew soherorici no.55', 'yesifiy318@gmail.com'  FROM dual UNION ALL
  select 'PL167','JL4','K23','qiyefa paleti selox','084479922987','Jl.padayute no.29', 'qiyefa573@gmail.com'  FROM dual UNION ALL
  select 'PL168','JL4','K8','razol kezomo','082104401070','Jl.zedup fejudebac no.50', 'razol506@gmail.com'  FROM dual UNION ALL
  select 'PL169','JL4','K34','kiseko maloy tabora','088798324138','Jl.qeyupeso rononaseyi no.23', 'kiseko17@gmail.com'  FROM dual UNION ALL
  select 'PL170','JL4','K19','wedey bogu boleno','081836841630','Jl.boxihalamu no.81', 'wedey885@gmail.com'  FROM dual UNION ALL
  select 'PL171','JL4','K5','kuhuyu pubiki sorepik','089816890147','Jl.ligotapupu nefigexok no.68', 'kuhuyu84@gmail.com'  FROM dual UNION ALL
  select 'PL172','JL4','K18','fagu','082811870148','Jl.fuyof zofehixam no.83', 'fagu455@gmail.com'  FROM dual UNION ALL
  select 'PL173','JL4','K38','wawurub moxol','087467825693','Jl.sasososin puxojipi no.35', 'wawurub655@gmail.com'  FROM dual UNION ALL
  select 'PL174','JL4','K33','radij xenido','086799781501','Jl.tofiq xafavuqor no.78', 'radij393@gmail.com'  FROM dual UNION ALL
  select 'PL175','JL4','K2','sabuja refi','086676077904','Jl.kadoka pazapi no.97', 'sabuja435@gmail.com'  FROM dual UNION ALL
  select 'PL176','JL4','K32','kido savij jaqi','088012169988','Jl.zafepa paged no.90', 'kido385@gmail.com'  FROM dual UNION ALL
  select 'PL177','JL4','K3','riyihu','081693248807','Jl.zabevaz no.11', 'riyihu642@gmail.com'  FROM dual UNION ALL
  select 'PL178','JL4','K32','qasa','084658887703','Jl.voseb hixole no.59', 'qasa826@gmail.com'  FROM dual UNION ALL
  select 'PL179','JL4','K35','jiga jugowu barig','084763040518','Jl.vijiva vetozurulu no.96', 'jiga887@gmail.com'  FROM dual UNION ALL
  select 'PL180','JL4','K42','zonim kunorug woze','081211736776','Jl.hodafale jasabuzote no.14', 'zonim458@gmail.com'  FROM dual UNION ALL
  select 'PL181','JL4','K21','xusapas jisawi bujene','084165317592','Jl.qodamot no.42', 'xusapas198@gmail.com'  FROM dual UNION ALL
  select 'PL182','JL4','K30','zekawo sire rikiqe','087697236177','Jl.mutuhabe gefavo no.17', 'zekawo627@gmail.com'  FROM dual UNION ALL
  select 'PL183','JL4','K25','hecejom xeti xuzuwa','088446973551','Jl.gopifok no.94', 'hecejom991@gmail.com'  FROM dual UNION ALL
  select 'PL184','JL4','K13','vuqozi sifum benoma','086653321923','Jl.yizomebava no.38', 'vuqozi75@gmail.com'  FROM dual UNION ALL
  select 'PL185','JL4','K32','lifepu','082210728325','Jl.pafujenoc no.11', 'lifepu333@gmail.com'  FROM dual UNION ALL
  select 'PL186','JL4','K15','jodin xitami','083851900179','Jl.qosil no.67', 'jodin639@gmail.com'  FROM dual UNION ALL
  select 'PL187','JL4','K37','cafiqan gede','086981328334','Jl.fuden no.64', 'cafiqan838@gmail.com'  FROM dual UNION ALL
  select 'PL188','JL4','K25','dizo pizi votiz','084608859310','Jl.zocujis zavuzi no.3', 'dizo12@gmail.com'  FROM dual UNION ALL
  select 'PL189','JL4','K37','kana rowez modoh','089739114678','Jl.jinayikoga nuvol no.15', 'kana15@gmail.com'  FROM dual UNION ALL
  select 'PL190','JL4','K42','yafokip wuyahe reqasa','086813422399','Jl.nojusik no.29', 'yafokip59@gmail.com'  FROM dual UNION ALL
  select 'PL191','JL4','K12','hoqu','083268954573','Jl.gogicog no.2', 'hoqu636@gmail.com'  FROM dual UNION ALL
  select 'PL192','JL4','K24','jukoxip zuwa','088996557059','Jl.bedohix riseku no.5', 'jukoxip850@gmail.com'  FROM dual UNION ALL
  select 'PL193','JL4','K30','qejec bawexi','081847633465','Jl.qokiti bequni no.0', 'qejec400@gmail.com'  FROM dual UNION ALL
  select 'PL194','JL4','K25','qudo quju','080493295615','Jl.liqewo no.60', 'qudo12@gmail.com'  FROM dual UNION ALL
  select 'PL195','JL4','K3','soyox zata','085100657770','Jl.fujoxih no.45', 'soyox975@gmail.com'  FROM dual UNION ALL
  select 'PL196','JL4','K24','ralem','083495823230','Jl.litene fiwubegozi no.30', 'ralem440@gmail.com'  FROM dual UNION ALL
  select 'PL197','JL4','K10','hipa','087985946899','Jl.vuday wixojari no.48', 'hipa126@gmail.com'  FROM dual UNION ALL
  select 'PL198','JL4','K13','ziha','083079751306','Jl.jizij no.76', 'ziha642@gmail.com'  FROM dual UNION ALL
  select 'PL199','JL4','K7','qesude','089932306413','Jl.nefukivu biloyiyime no.14', 'qesude184@gmail.com'  FROM dual UNION ALL
  select 'PL200','JL4','K9','genigob fodul poduhok','084146391974','Jl.hosuwo no.80', 'genigob782@gmail.com'  FROM dual;

create sequence SEQ_ID_PESANAN 
    minvalue 1 
    maxvalue 999999 
    start with 1 
    increment by 1 
    cache 20;

create or replace trigger TRG_INS_PESANAN 
before insert on PESANAN 
for each row 
begin 
    if (:new.ID_PESANAN is null) 
    then 
        select 'P' || SEQ_ID_PESANAN.nextval into :new.ID_PESANAN from dual; 
    end if; 
end; 
/

INSERT INTO PESANAN (ID_PESANAN, ID_PELANGGAN, TANGGAL_PESAN, STATUS_PESANAN, DISCOUNT_PESANAN,TOTAL_HARGA, JUMLAH_TERBAYARKAN)  
  select 'P1', 'PL3', TO_DATE('01/08/2019', 'DD/MM/YYYY'), 1, 0, 1158000000, 1158000000  FROM dual UNION ALL 
  select 'P2', 'PL100', TO_DATE('01/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P3', 'PL142', TO_DATE('01/08/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P4', 'PL156', TO_DATE('01/08/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P5', 'PL74', TO_DATE('01/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P6', 'PL24', TO_DATE('01/08/2019', 'DD/MM/YYYY'), 1, 0, 15550000, 15550000  FROM dual UNION ALL 
  select 'P7', 'PL133', TO_DATE('01/08/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P8', 'PL106', TO_DATE('02/08/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P9', 'PL29', TO_DATE('02/08/2019', 'DD/MM/YYYY'), 1, 0, 1951118000, 1951118000  FROM dual UNION ALL 
  select 'P10', 'PL132', TO_DATE('02/08/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P11', 'PL82', TO_DATE('02/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P12', 'PL196', TO_DATE('02/08/2019', 'DD/MM/YYYY'), 1, 0, 950000, 950000  FROM dual UNION ALL 
  select 'P13', 'PL112', TO_DATE('02/08/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P14', 'PL161', TO_DATE('02/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P15', 'PL184', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P16', 'PL120', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P17', 'PL13', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 1, 0, 456300000, 456300000  FROM dual UNION ALL 
  select 'P18', 'PL150', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P19', 'PL174', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P20', 'PL96', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P21', 'PL128', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P22', 'PL101', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 1, 0, 1450000, 1450000  FROM dual UNION ALL 
  select 'P23', 'PL47', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 1, 0, 3765900000, 3765900000  FROM dual UNION ALL 
  select 'P24', 'PL41', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 1, 0, 5584842000, 5584842000  FROM dual UNION ALL 
  select 'P25', 'PL159', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 1, 0, 3050000, 3050000  FROM dual UNION ALL 
  select 'P26', 'PL190', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P27', 'PL44', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 1, 0, 2840000000, 2840000000  FROM dual UNION ALL 
  select 'P28', 'PL122', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 1, 0, 525000, 525000  FROM dual UNION ALL 
  select 'P29', 'PL133', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P30', 'PL107', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 1, 0, 900000, 900000  FROM dual UNION ALL 
  select 'P31', 'PL173', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P32', 'PL132', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P33', 'PL156', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P34', 'PL40', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 1, 0, 5059910000, 5059910000  FROM dual UNION ALL 
  select 'P35', 'PL39', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 1, 0, 59950000, 59950000  FROM dual UNION ALL 
  select 'P36', 'PL179', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P37', 'PL36', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 1, 0, 15480000, 15480000  FROM dual UNION ALL 
  select 'P38', 'PL73', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P39', 'PL38', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 1, 0, 20230000, 20230000  FROM dual UNION ALL 
  select 'P40', 'PL87', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 1, 0, 1300000, 1300000  FROM dual UNION ALL 
  select 'P41', 'PL55', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 1, 0, 4954610000, 4954610000  FROM dual UNION ALL 
  select 'P42', 'PL55', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 1, 0, 341712000, 341712000  FROM dual UNION ALL 
  select 'P43', 'PL141', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P44', 'PL60', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 1, 0, 292220000, 292220000  FROM dual UNION ALL 
  select 'P45', 'PL41', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 1, 0, 1992600000, 1992600000  FROM dual UNION ALL 
  select 'P46', 'PL13', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 1, 0, 2681747000, 2681747000  FROM dual UNION ALL 
  select 'P47', 'PL149', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P48', 'PL74', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P49', 'PL103', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P50', 'PL126', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P51', 'PL78', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P52', 'PL191', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P53', 'PL55', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 1, 0, 1328210000, 1328210000  FROM dual UNION ALL 
  select 'P54', 'PL184', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P55', 'PL182', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P56', 'PL78', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P57', 'PL74', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P58', 'PL30', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1, 0, 288440000, 288440000  FROM dual UNION ALL 
  select 'P59', 'PL58', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1, 0, 1954090000, 1954090000  FROM dual UNION ALL 
  select 'P60', 'PL112', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P61', 'PL159', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1, 0, 2150000, 2150000  FROM dual UNION ALL 
  select 'P62', 'PL174', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P63', 'PL130', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P64', 'PL158', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 1, 0, 1475000, 1475000  FROM dual UNION ALL 
  select 'P65', 'PL190', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P66', 'PL169', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P67', 'PL150', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P68', 'PL161', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P69', 'PL3', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 1, 0, 661288000, 661288000  FROM dual UNION ALL 
  select 'P70', 'PL118', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P71', 'PL146', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P72', 'PL182', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P73', 'PL134', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 1, 0, 3050000, 3050000  FROM dual UNION ALL 
  select 'P74', 'PL26', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 1, 0, 914320000, 914320000  FROM dual UNION ALL 
  select 'P75', 'PL163', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P76', 'PL162', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P77', 'PL152', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P78', 'PL66', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P79', 'PL52', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 1, 0, 12664000, 12664000  FROM dual UNION ALL 
  select 'P80', 'PL74', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 1, 0, 1500000, 1500000  FROM dual UNION ALL 
  select 'P81', 'PL32', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 1, 0, 81064000, 81064000  FROM dual UNION ALL 
  select 'P82', 'PL34', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 1, 0, 37480000, 37480000  FROM dual UNION ALL 
  select 'P83', 'PL29', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 1, 0, 140677000, 140677000  FROM dual UNION ALL 
  select 'P84', 'PL32', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 1, 0, 1322260000, 1322260000  FROM dual UNION ALL 
  select 'P85', 'PL174', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P86', 'PL182', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P87', 'PL171', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P88', 'PL109', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P89', 'PL199', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P90', 'PL14', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 1, 0, 83505000, 83505000  FROM dual UNION ALL 
  select 'P91', 'PL169', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 1, 0, 1700000, 1700000  FROM dual UNION ALL 
  select 'P92', 'PL123', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 1, 0, 1350000, 1350000  FROM dual UNION ALL 
  select 'P93', 'PL22', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 1, 0, 4740000, 4740000  FROM dual UNION ALL 
  select 'P94', 'PL117', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P95', 'PL170', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P96', 'PL88', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P97', 'PL80', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 1, 0, 525000, 525000  FROM dual UNION ALL 
  select 'P98', 'PL64', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 1, 0, 2000000, 2000000  FROM dual UNION ALL 
  select 'P99', 'PL151', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 1, 0, 1475000, 1475000  FROM dual UNION ALL 
  select 'P100', 'PL86', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P101', 'PL178', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P102', 'PL135', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P103', 'PL75', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 1, 0, 900000, 900000  FROM dual UNION ALL 
  select 'P104', 'PL137', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 1, 0, 825000, 825000  FROM dual UNION ALL 
  select 'P105', 'PL103', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P106', 'PL57', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 1, 0, 248440000, 248440000  FROM dual UNION ALL 
  select 'P107', 'PL35', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 1, 0, 3329185000, 3329185000  FROM dual UNION ALL 
  select 'P108', 'PL200', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P109', 'PL53', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 1, 0, 394320000, 394320000  FROM dual UNION ALL 
  select 'P110', 'PL82', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P111', 'PL191', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 1, 0, 2000000, 2000000  FROM dual UNION ALL 
  select 'P112', 'PL72', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 1, 0, 3350000, 3350000  FROM dual UNION ALL 
  select 'P113', 'PL11', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 1, 0, 150276000, 150276000  FROM dual UNION ALL 
  select 'P114', 'PL126', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P115', 'PL83', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P116', 'PL16', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 1, 0, 4300000, 4300000  FROM dual UNION ALL 
  select 'P117', 'PL151', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P118', 'PL31', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 1, 0, 1595900000, 1595900000  FROM dual UNION ALL 
  select 'P119', 'PL142', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P120', 'PL150', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P121', 'PL138', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P122', 'PL2', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 1, 0, 2409780000, 2409780000  FROM dual UNION ALL 
  select 'P123', 'PL59', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 1, 0, 45310000, 45310000  FROM dual UNION ALL 
  select 'P124', 'PL181', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P125', 'PL80', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P126', 'PL177', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P127', 'PL21', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 1, 0, 2760000, 2760000  FROM dual UNION ALL 
  select 'P128', 'PL188', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 1, 0, 3450000, 3450000  FROM dual UNION ALL 
  select 'P129', 'PL152', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 1, 0, 2200000, 2200000  FROM dual UNION ALL 
  select 'P130', 'PL112', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P131', 'PL44', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 1, 0, 5973400000, 5973400000  FROM dual UNION ALL 
  select 'P132', 'PL195', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P133', 'PL155', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P134', 'PL84', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P135', 'PL59', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 1, 0, 57010000, 57010000  FROM dual UNION ALL 
  select 'P136', 'PL81', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P137', 'PL175', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P138', 'PL60', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 1, 0, 1059905000, 1059905000  FROM dual UNION ALL 
  select 'P139', 'PL193', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P140', 'PL181', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P141', 'PL83', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P142', 'PL14', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 1, 0, 112954000, 112954000  FROM dual UNION ALL 
  select 'P143', 'PL106', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P144', 'PL146', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P145', 'PL32', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 1, 0, 1003910000, 1003910000  FROM dual UNION ALL 
  select 'P146', 'PL41', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 1, 0, 1942490000, 1942490000  FROM dual UNION ALL 
  select 'P147', 'PL113', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P148', 'PL15', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 1, 0, 5769642000, 5769642000  FROM dual UNION ALL 
  select 'P149', 'PL78', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P150', 'PL110', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P151', 'PL70', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P152', 'PL128', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P153', 'PL143', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P154', 'PL170', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P155', 'PL62', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P156', 'PL62', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P157', 'PL26', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 1, 0, 41780000, 41780000  FROM dual UNION ALL 
  select 'P158', 'PL129', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 1, 0, 1475000, 1475000  FROM dual UNION ALL 
  select 'P159', 'PL198', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P160', 'PL110', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P161', 'PL89', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P162', 'PL45', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 1, 0, 113600000, 113600000  FROM dual UNION ALL 
  select 'P163', 'PL183', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 1, 0, 2300000, 2300000  FROM dual UNION ALL 
  select 'P164', 'PL40', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 1, 0, 1288750000, 1288750000  FROM dual UNION ALL 
  select 'P165', 'PL127', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P166', 'PL192', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P167', 'PL19', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 1, 0, 23550000, 23550000  FROM dual UNION ALL 
  select 'P168', 'PL104', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P169', 'PL96', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1, 0, 1350000, 1350000  FROM dual UNION ALL 
  select 'P170', 'PL81', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P171', 'PL21', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1, 0, 27460000, 27460000  FROM dual UNION ALL 
  select 'P172', 'PL31', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1, 0, 59350000, 59350000  FROM dual UNION ALL 
  select 'P173', 'PL102', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P174', 'PL132', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P175', 'PL108', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P176', 'PL112', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P177', 'PL178', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P178', 'PL108', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 1, 0, 2600000, 2600000  FROM dual UNION ALL 
  select 'P179', 'PL6', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 1, 0, 4033000000, 4033000000  FROM dual UNION ALL 
  select 'P180', 'PL190', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P181', 'PL68', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P182', 'PL106', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P183', 'PL7', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 1, 0, 281908000, 281908000  FROM dual UNION ALL 
  select 'P184', 'PL186', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 1, 0, 2500000, 2500000  FROM dual UNION ALL 
  select 'P185', 'PL101', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P186', 'PL53', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 1, 0, 81590000, 81590000  FROM dual UNION ALL 
  select 'P187', 'PL109', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 1, 0, 3350000, 3350000  FROM dual UNION ALL 
  select 'P188', 'PL184', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P189', 'PL26', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 1, 0, 1399590000, 1399590000  FROM dual UNION ALL 
  select 'P190', 'PL69', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P191', 'PL42', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 1, 0, 1359840000, 1359840000  FROM dual UNION ALL 
  select 'P192', 'PL74', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P193', 'PL44', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 1, 0, 2012360000, 2012360000  FROM dual UNION ALL 
  select 'P194', 'PL82', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 1, 0, 1550000, 1550000  FROM dual UNION ALL 
  select 'P195', 'PL40', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 1, 0, 379910000, 379910000  FROM dual UNION ALL 
  select 'P196', 'PL52', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 1, 0, 6208222000, 6208222000  FROM dual UNION ALL 
  select 'P197', 'PL31', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 1, 0, 2791056000, 2791056000  FROM dual UNION ALL 
  select 'P198', 'PL76', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P199', 'PL112', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P200', 'PL45', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 1, 0, 4539415000, 4539415000  FROM dual UNION ALL 
  select 'P201', 'PL47', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 1, 0, 114268000, 114268000  FROM dual UNION ALL 
  select 'P202', 'PL190', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 1, 0, 1350000, 1350000  FROM dual UNION ALL 
  select 'P203', 'PL42', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 1, 0, 4165310000, 4165310000  FROM dual UNION ALL 
  select 'P204', 'PL131', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 1, 0, 675000, 675000  FROM dual UNION ALL 
  select 'P205', 'PL91', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P206', 'PL167', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P207', 'PL65', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 1, 0, 525000, 525000  FROM dual UNION ALL 
  select 'P208', 'PL185', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 1, 0, 3475000, 3475000  FROM dual UNION ALL 
  select 'P209', 'PL140', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P210', 'PL90', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P211', 'PL127', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P212', 'PL48', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 1, 0, 245600000, 245600000  FROM dual UNION ALL 
  select 'P213', 'PL94', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P214', 'PL127', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P215', 'PL2', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 1, 0, 61575000, 61575000  FROM dual UNION ALL 
  select 'P216', 'PL153', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P217', 'PL22', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 1, 0, 2260000, 2260000  FROM dual UNION ALL 
  select 'P218', 'PL193', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 1, 0, 1500000, 1500000  FROM dual UNION ALL 
  select 'P219', 'PL150', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 1, 0, 100000, 100000  FROM dual UNION ALL 
  select 'P220', 'PL22', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 1, 0, 1180000, 1180000  FROM dual UNION ALL 
  select 'P221', 'PL177', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P222', 'PL8', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 1, 0, 1714966000, 1714966000  FROM dual UNION ALL 
  select 'P223', 'PL21', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 1, 0, 2680000, 2680000  FROM dual UNION ALL 
  select 'P224', 'PL24', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 1, 0, 27520000, 27520000  FROM dual UNION ALL 
  select 'P225', 'PL4', TO_DATE('02/09/2019', 'DD/MM/YYYY'), 1, 0, 69665000, 69665000  FROM dual UNION ALL 
  select 'P226', 'PL16', TO_DATE('02/09/2019', 'DD/MM/YYYY'), 1, 0, 2360000, 2360000  FROM dual UNION ALL 
  select 'P227', 'PL200', TO_DATE('02/09/2019', 'DD/MM/YYYY'), 1, 0, 1450000, 1450000  FROM dual UNION ALL 
  select 'P228', 'PL29', TO_DATE('02/09/2019', 'DD/MM/YYYY'), 1, 0, 39725000, 39725000  FROM dual UNION ALL 
  select 'P229', 'PL168', TO_DATE('02/09/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P230', 'PL104', TO_DATE('02/09/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P231', 'PL182', TO_DATE('02/09/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P232', 'PL99', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 1, 0, 950000, 950000  FROM dual UNION ALL 
  select 'P233', 'PL38', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 1, 0, 5067700000, 5067700000  FROM dual UNION ALL 
  select 'P234', 'PL163', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P235', 'PL3', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 1, 0, 61045000, 61045000  FROM dual UNION ALL 
  select 'P236', 'PL153', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 1, 0, 3475000, 3475000  FROM dual UNION ALL 
  select 'P237', 'PL150', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P238', 'PL158', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P239', 'PL115', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P240', 'PL59', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 1, 0, 101515000, 101515000  FROM dual UNION ALL 
  select 'P241', 'PL45', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 1, 0, 6077130000, 6077130000  FROM dual UNION ALL 
  select 'P242', 'PL107', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P243', 'PL9', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 1, 0, 315800000, 315800000  FROM dual UNION ALL 
  select 'P244', 'PL71', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P245', 'PL139', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 1, 0, 2350000, 2350000  FROM dual UNION ALL 
  select 'P246', 'PL189', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 1, 0, 1450000, 1450000  FROM dual UNION ALL 
  select 'P247', 'PL74', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P248', 'PL44', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 1, 0, 794962000, 794962000  FROM dual UNION ALL 
  select 'P249', 'PL20', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 1, 0, 16190000, 16190000  FROM dual UNION ALL 
  select 'P250', 'PL138', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 1, 0, 1475000, 1475000  FROM dual;

INSERT INTO PESANAN (ID_PESANAN, ID_PELANGGAN, TANGGAL_PESAN, STATUS_PESANAN, DISCOUNT_PESANAN,TOTAL_HARGA, JUMLAH_TERBAYARKAN)  
  select 'P251', 'PL120', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P252', 'PL130', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P253', 'PL71', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P254', 'PL81', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P255', 'PL194', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P256', 'PL198', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 1, 0, 100000, 100000  FROM dual UNION ALL 
  select 'P257', 'PL182', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 1, 0, 100000, 100000  FROM dual UNION ALL 
  select 'P258', 'PL41', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 1, 0, 86060000, 86060000  FROM dual UNION ALL 
  select 'P259', 'PL109', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P260', 'PL65', TO_DATE('07/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P261', 'PL192', TO_DATE('07/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P262', 'PL16', TO_DATE('07/09/2019', 'DD/MM/YYYY'), 1, 0, 900000, 900000  FROM dual UNION ALL 
  select 'P263', 'PL187', TO_DATE('07/09/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P264', 'PL123', TO_DATE('07/09/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P265', 'PL162', TO_DATE('07/09/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P266', 'PL198', TO_DATE('07/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P267', 'PL43', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 1, 0, 307820000, 307820000  FROM dual UNION ALL 
  select 'P268', 'PL83', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P269', 'PL8', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 1, 0, 3040175000, 3040175000  FROM dual UNION ALL 
  select 'P270', 'PL69', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P271', 'PL190', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P272', 'PL33', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 1, 0, 47970000, 47970000  FROM dual UNION ALL 
  select 'P273', 'PL26', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 1, 0, 2235680000, 2235680000  FROM dual UNION ALL 
  select 'P274', 'PL193', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P275', 'PL86', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 1, 0, 1500000, 1500000  FROM dual UNION ALL 
  select 'P276', 'PL150', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 1, 0, 875000, 875000  FROM dual UNION ALL 
  select 'P277', 'PL24', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 1, 0, 3320000, 3320000  FROM dual UNION ALL 
  select 'P278', 'PL162', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P279', 'PL56', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 1, 0, 1018750000, 1018750000  FROM dual UNION ALL 
  select 'P280', 'PL23', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 1, 0, 2580000, 2580000  FROM dual UNION ALL 
  select 'P281', 'PL10', TO_DATE('10/09/2019', 'DD/MM/YYYY'), 1, 0, 2325984000, 2325984000  FROM dual UNION ALL 
  select 'P282', 'PL74', TO_DATE('10/09/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P283', 'PL154', TO_DATE('10/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P284', 'PL139', TO_DATE('10/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P285', 'PL121', TO_DATE('10/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P286', 'PL56', TO_DATE('10/09/2019', 'DD/MM/YYYY'), 1, 0, 362140000, 362140000  FROM dual UNION ALL 
  select 'P287', 'PL171', TO_DATE('10/09/2019', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P288', 'PL3', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 1, 0, 1310932000, 1310932000  FROM dual UNION ALL 
  select 'P289', 'PL141', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P290', 'PL98', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 1, 0, 3050000, 3050000  FROM dual UNION ALL 
  select 'P291', 'PL174', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P292', 'PL51', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 1, 0, 48275000, 48275000  FROM dual UNION ALL 
  select 'P293', 'PL143', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P294', 'PL84', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P295', 'PL119', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P296', 'PL55', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 1, 0, 1334180000, 1334180000  FROM dual UNION ALL 
  select 'P297', 'PL181', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 1, 0, 4000000, 4000000  FROM dual UNION ALL 
  select 'P298', 'PL146', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P299', 'PL29', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 1, 0, 4789625000, 4789625000  FROM dual UNION ALL 
  select 'P300', 'PL175', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P301', 'PL154', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P302', 'PL59', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 1, 0, 872590000, 872590000  FROM dual UNION ALL 
  select 'P303', 'PL19', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 1, 0, 13800000, 13800000  FROM dual UNION ALL 
  select 'P304', 'PL132', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 1, 0, 1475000, 1475000  FROM dual UNION ALL 
  select 'P305', 'PL109', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P306', 'PL146', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P307', 'PL58', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 1, 0, 1238188000, 1238188000  FROM dual UNION ALL 
  select 'P308', 'PL42', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 1, 0, 627600000, 627600000  FROM dual UNION ALL 
  select 'P309', 'PL174', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 1, 0, 1550000, 1550000  FROM dual UNION ALL 
  select 'P310', 'PL100', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P311', 'PL166', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P312', 'PL132', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P313', 'PL37', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 1, 0, 21540000, 21540000  FROM dual UNION ALL 
  select 'P314', 'PL65', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 1, 0, 1300000, 1300000  FROM dual UNION ALL 
  select 'P315', 'PL147', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 1, 0, 1300000, 1300000  FROM dual UNION ALL 
  select 'P316', 'PL105', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 1, 0, 1650000, 1650000  FROM dual UNION ALL 
  select 'P317', 'PL180', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P318', 'PL4', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 1, 0, 503400000, 503400000  FROM dual UNION ALL 
  select 'P319', 'PL194', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P320', 'PL169', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P321', 'PL128', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P322', 'PL27', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 1, 0, 702980000, 702980000  FROM dual UNION ALL 
  select 'P323', 'PL72', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P324', 'PL124', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P325', 'PL139', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P326', 'PL84', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P327', 'PL174', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P328', 'PL150', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P329', 'PL13', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 1, 0, 12388395000, 12388395000  FROM dual UNION ALL 
  select 'P330', 'PL190', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P331', 'PL31', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1, 0, 41130000, 41130000  FROM dual UNION ALL 
  select 'P332', 'PL174', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P333', 'PL131', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P334', 'PL38', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1, 0, 594806000, 594806000  FROM dual UNION ALL 
  select 'P335', 'PL185', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P336', 'PL60', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1, 0, 42300000, 42300000  FROM dual UNION ALL 
  select 'P337', 'PL20', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 1, 0, 2520000, 2520000  FROM dual UNION ALL 
  select 'P338', 'PL162', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P339', 'PL72', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P340', 'PL101', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P341', 'PL81', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P342', 'PL116', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P343', 'PL103', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P344', 'PL129', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P345', 'PL7', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 1, 0, 621771000, 621771000  FROM dual UNION ALL 
  select 'P346', 'PL153', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P347', 'PL28', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 1, 0, 226306000, 226306000  FROM dual UNION ALL 
  select 'P348', 'PL195', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P349', 'PL34', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 1, 0, 61450000, 61450000  FROM dual UNION ALL 
  select 'P350', 'PL18', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 1, 0, 15050000, 15050000  FROM dual UNION ALL 
  select 'P351', 'PL189', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 1, 0, 1650000, 1650000  FROM dual UNION ALL 
  select 'P352', 'PL91', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P353', 'PL88', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P354', 'PL85', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 1, 0, 2200000, 2200000  FROM dual UNION ALL 
  select 'P355', 'PL4', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 1, 0, 474730000, 474730000  FROM dual UNION ALL 
  select 'P356', 'PL137', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P357', 'PL49', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 1, 0, 507020000, 507020000  FROM dual UNION ALL 
  select 'P358', 'PL17', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 1, 0, 19190000, 19190000  FROM dual UNION ALL 
  select 'P359', 'PL159', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P360', 'PL188', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P361', 'PL3', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 1, 0, 7283457500, 7283457500  FROM dual UNION ALL 
  select 'P362', 'PL44', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 1, 0, 4577668000, 4577668000  FROM dual UNION ALL 
  select 'P363', 'PL161', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 1, 0, 1350000, 1350000  FROM dual UNION ALL 
  select 'P364', 'PL169', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 1, 0, 950000, 950000  FROM dual UNION ALL 
  select 'P365', 'PL106', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P366', 'PL108', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P367', 'PL191', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P368', 'PL136', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P369', 'PL130', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P370', 'PL70', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 1, 0, 6000000, 6000000  FROM dual UNION ALL 
  select 'P371', 'PL57', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 1, 0, 5976000, 5976000  FROM dual UNION ALL 
  select 'P372', 'PL84', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P373', 'PL74', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P374', 'PL186', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P375', 'PL178', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P376', 'PL112', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P377', 'PL200', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P378', 'PL15', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 1, 0, 6875820000, 6875820000  FROM dual UNION ALL 
  select 'P379', 'PL48', TO_DATE('24/09/2019', 'DD/MM/YYYY'), 1, 0, 4242800000, 4242800000  FROM dual UNION ALL 
  select 'P380', 'PL74', TO_DATE('24/09/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P381', 'PL153', TO_DATE('24/09/2019', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P382', 'PL22', TO_DATE('24/09/2019', 'DD/MM/YYYY'), 1, 0, 3920000, 3920000  FROM dual UNION ALL 
  select 'P383', 'PL198', TO_DATE('24/09/2019', 'DD/MM/YYYY'), 1, 0, 2200000, 2200000  FROM dual UNION ALL 
  select 'P384', 'PL44', TO_DATE('24/09/2019', 'DD/MM/YYYY'), 1, 0, 369090000, 369090000  FROM dual UNION ALL 
  select 'P385', 'PL162', TO_DATE('24/09/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P386', 'PL108', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P387', 'PL64', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P388', 'PL70', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P389', 'PL16', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 1, 0, 24320000, 24320000  FROM dual UNION ALL 
  select 'P390', 'PL185', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P391', 'PL46', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 1, 0, 1791172000, 1791172000  FROM dual UNION ALL 
  select 'P392', 'PL57', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 1, 0, 63361000, 63361000  FROM dual UNION ALL 
  select 'P393', 'PL125', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 1, 0, 1450000, 1450000  FROM dual UNION ALL 
  select 'P394', 'PL30', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 1, 0, 57740000, 57740000  FROM dual UNION ALL 
  select 'P395', 'PL198', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P396', 'PL18', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 1, 0, 14460000, 14460000  FROM dual UNION ALL 
  select 'P397', 'PL55', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 1, 0, 2037400000, 2037400000  FROM dual UNION ALL 
  select 'P398', 'PL40', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 1, 0, 3896444000, 3896444000  FROM dual UNION ALL 
  select 'P399', 'PL177', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P400', 'PL174', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P401', 'PL154', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P402', 'PL53', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 1, 0, 42230000, 42230000  FROM dual UNION ALL 
  select 'P403', 'PL170', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 1, 0, 2150000, 2150000  FROM dual UNION ALL 
  select 'P404', 'PL26', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 1, 0, 5019888000, 5019888000  FROM dual UNION ALL 
  select 'P405', 'PL16', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 1, 0, 15760000, 15760000  FROM dual UNION ALL 
  select 'P406', 'PL17', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 1, 0, 9720000, 9720000  FROM dual UNION ALL 
  select 'P407', 'PL4', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 1, 0, 65630000, 65630000  FROM dual UNION ALL 
  select 'P408', 'PL92', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P409', 'PL177', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P410', 'PL148', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P411', 'PL91', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P412', 'PL90', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P413', 'PL163', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P414', 'PL148', TO_DATE('29/09/2019', 'DD/MM/YYYY'), 1, 0, 4000000, 4000000  FROM dual UNION ALL 
  select 'P415', 'PL64', TO_DATE('29/09/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P416', 'PL183', TO_DATE('29/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P417', 'PL32', TO_DATE('29/09/2019', 'DD/MM/YYYY'), 1, 0, 39752000, 39752000  FROM dual UNION ALL 
  select 'P418', 'PL53', TO_DATE('29/09/2019', 'DD/MM/YYYY'), 1, 0, 558980000, 558980000  FROM dual UNION ALL 
  select 'P419', 'PL146', TO_DATE('29/09/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P420', 'PL145', TO_DATE('29/09/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P421', 'PL58', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 1, 0, 603320000, 603320000  FROM dual UNION ALL 
  select 'P422', 'PL69', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P423', 'PL102', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P424', 'PL145', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P425', 'PL165', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P426', 'PL26', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 1, 0, 633335000, 633335000  FROM dual UNION ALL 
  select 'P427', 'PL33', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 1, 0, 320190000, 320190000  FROM dual UNION ALL 
  select 'P428', 'PL118', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P429', 'PL7', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 1, 0, 1640159000, 1640159000  FROM dual UNION ALL 
  select 'P430', 'PL69', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P431', 'PL29', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 1, 0, 45930000, 45930000  FROM dual UNION ALL 
  select 'P432', 'PL45', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 1, 0, 5541230000, 5541230000  FROM dual UNION ALL 
  select 'P433', 'PL133', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P434', 'PL64', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P435', 'PL51', TO_DATE('02/10/2019', 'DD/MM/YYYY'), 1, 0, 857996000, 857996000  FROM dual UNION ALL 
  select 'P436', 'PL82', TO_DATE('02/10/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P437', 'PL173', TO_DATE('02/10/2019', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P438', 'PL136', TO_DATE('02/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P439', 'PL41', TO_DATE('02/10/2019', 'DD/MM/YYYY'), 1, 0, 2921800000, 2921800000  FROM dual UNION ALL 
  select 'P440', 'PL117', TO_DATE('02/10/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P441', 'PL59', TO_DATE('02/10/2019', 'DD/MM/YYYY'), 1, 0, 3380521000, 3380521000  FROM dual UNION ALL 
  select 'P442', 'PL89', TO_DATE('03/10/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P443', 'PL29', TO_DATE('03/10/2019', 'DD/MM/YYYY'), 1, 0, 52996000, 52996000  FROM dual UNION ALL 
  select 'P444', 'PL119', TO_DATE('03/10/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P445', 'PL127', TO_DATE('03/10/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P446', 'PL109', TO_DATE('03/10/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P447', 'PL131', TO_DATE('03/10/2019', 'DD/MM/YYYY'), 1, 0, 675000, 675000  FROM dual UNION ALL 
  select 'P448', 'PL155', TO_DATE('03/10/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P449', 'PL96', TO_DATE('04/10/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P450', 'PL106', TO_DATE('04/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P451', 'PL108', TO_DATE('04/10/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P452', 'PL74', TO_DATE('04/10/2019', 'DD/MM/YYYY'), 1, 0, 1350000, 1350000  FROM dual UNION ALL 
  select 'P453', 'PL154', TO_DATE('04/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P454', 'PL184', TO_DATE('04/10/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P455', 'PL22', TO_DATE('04/10/2019', 'DD/MM/YYYY'), 1, 0, 3180000, 3180000  FROM dual UNION ALL 
  select 'P456', 'PL108', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P457', 'PL29', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 1, 0, 2175810000, 2175810000  FROM dual UNION ALL 
  select 'P458', 'PL200', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P459', 'PL79', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P460', 'PL93', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P461', 'PL57', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 1, 0, 388760000, 388760000  FROM dual UNION ALL 
  select 'P462', 'PL94', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P463', 'PL32', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 1, 0, 4977920000, 4977920000  FROM dual UNION ALL 
  select 'P464', 'PL140', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P465', 'PL160', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P466', 'PL139', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P467', 'PL93', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 1, 0, 1300000, 1300000  FROM dual UNION ALL 
  select 'P468', 'PL171', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P469', 'PL168', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P470', 'PL24', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 1, 0, 20960000, 20960000  FROM dual UNION ALL 
  select 'P471', 'PL48', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 1, 0, 1130339000, 1130339000  FROM dual UNION ALL 
  select 'P472', 'PL167', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P473', 'PL173', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P474', 'PL88', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P475', 'PL43', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 1, 0, 234775000, 234775000  FROM dual UNION ALL 
  select 'P476', 'PL191', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P477', 'PL101', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P478', 'PL184', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P479', 'PL63', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P480', 'PL57', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1, 0, 441965000, 441965000  FROM dual UNION ALL 
  select 'P481', 'PL79', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1, 0, 675000, 675000  FROM dual UNION ALL 
  select 'P482', 'PL134', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1, 0, 3100000, 3100000  FROM dual UNION ALL 
  select 'P483', 'PL172', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P484', 'PL44', TO_DATE('09/10/2019', 'DD/MM/YYYY'), 1, 0, 1114178000, 1114178000  FROM dual UNION ALL 
  select 'P485', 'PL156', TO_DATE('09/10/2019', 'DD/MM/YYYY'), 1, 0, 5100000, 5100000  FROM dual UNION ALL 
  select 'P486', 'PL80', TO_DATE('09/10/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P487', 'PL82', TO_DATE('09/10/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P488', 'PL65', TO_DATE('09/10/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P489', 'PL12', TO_DATE('09/10/2019', 'DD/MM/YYYY'), 1, 0, 872060000, 872060000  FROM dual UNION ALL 
  select 'P490', 'PL95', TO_DATE('09/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P491', 'PL90', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 1, 0, 2300000, 2300000  FROM dual UNION ALL 
  select 'P492', 'PL183', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P493', 'PL159', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P494', 'PL183', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P495', 'PL177', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P496', 'PL126', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P497', 'PL9', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 1, 0, 776012500, 776012500  FROM dual UNION ALL 
  select 'P498', 'PL66', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P499', 'PL87', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P500', 'PL52', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 1, 0, 7914000, 7914000  FROM dual;

INSERT INTO PESANAN (ID_PESANAN, ID_PELANGGAN, TANGGAL_PESAN, STATUS_PESANAN, DISCOUNT_PESANAN,TOTAL_HARGA, JUMLAH_TERBAYARKAN)  
  select 'P501', 'PL24', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 1, 0, 17880000, 17880000  FROM dual UNION ALL 
  select 'P502', 'PL103', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P503', 'PL114', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 1, 0, 1450000, 1450000  FROM dual UNION ALL 
  select 'P504', 'PL84', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P505', 'PL9', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 1, 0, 4500000, 4500000  FROM dual UNION ALL 
  select 'P506', 'PL156', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 1, 0, 725000, 725000  FROM dual UNION ALL 
  select 'P507', 'PL87', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P508', 'PL91', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P509', 'PL149', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P510', 'PL177', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P511', 'PL190', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P512', 'PL5', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 1, 0, 482484000, 482484000  FROM dual UNION ALL 
  select 'P513', 'PL59', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 1, 0, 39080000, 39080000  FROM dual UNION ALL 
  select 'P514', 'PL99', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P515', 'PL180', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 1, 0, 2150000, 2150000  FROM dual UNION ALL 
  select 'P516', 'PL163', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 1, 0, 3050000, 3050000  FROM dual UNION ALL 
  select 'P517', 'PL47', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 1, 0, 392050000, 392050000  FROM dual UNION ALL 
  select 'P518', 'PL11', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 1, 0, 12820000, 12820000  FROM dual UNION ALL 
  select 'P519', 'PL24', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 1, 0, 19120000, 19120000  FROM dual UNION ALL 
  select 'P520', 'PL104', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P521', 'PL96', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 1, 0, 3350000, 3350000  FROM dual UNION ALL 
  select 'P522', 'PL83', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P523', 'PL75', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P524', 'PL183', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P525', 'PL90', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P526', 'PL142', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P527', 'PL21', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 1, 0, 19920000, 19920000  FROM dual UNION ALL 
  select 'P528', 'PL188', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P529', 'PL180', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P530', 'PL178', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P531', 'PL186', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P532', 'PL68', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P533', 'PL96', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P534', 'PL9', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 1, 0, 528820000, 528820000  FROM dual UNION ALL 
  select 'P535', 'PL47', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 1, 0, 25580000, 25580000  FROM dual UNION ALL 
  select 'P536', 'PL18', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 1, 0, 740000, 740000  FROM dual UNION ALL 
  select 'P537', 'PL166', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P538', 'PL140', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P539', 'PL25', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 1, 0, 1829576000, 1829576000  FROM dual UNION ALL 
  select 'P540', 'PL148', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P541', 'PL164', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P542', 'PL7', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 1, 0, 110930000, 110930000  FROM dual UNION ALL 
  select 'P543', 'PL2', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 1, 0, 779640000, 779640000  FROM dual UNION ALL 
  select 'P544', 'PL26', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 1, 0, 5535220000, 5535220000  FROM dual UNION ALL 
  select 'P545', 'PL63', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P546', 'PL12', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 1, 0, 6040000, 6040000  FROM dual UNION ALL 
  select 'P547', 'PL65', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 1, 0, 3350000, 3350000  FROM dual UNION ALL 
  select 'P548', 'PL187', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P549', 'PL10', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 1, 0, 810020000, 810020000  FROM dual UNION ALL 
  select 'P550', 'PL43', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 1, 0, 441250000, 441250000  FROM dual UNION ALL 
  select 'P551', 'PL157', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 1, 0, 3450000, 3450000  FROM dual UNION ALL 
  select 'P552', 'PL52', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 1, 0, 860540000, 860540000  FROM dual UNION ALL 
  select 'P553', 'PL173', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 1, 0, 1475000, 1475000  FROM dual UNION ALL 
  select 'P554', 'PL142', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P555', 'PL107', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P556', 'PL9', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 1, 0, 473900000, 473900000  FROM dual UNION ALL 
  select 'P557', 'PL71', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P558', 'PL172', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 1, 0, 2000000, 2000000  FROM dual UNION ALL 
  select 'P559', 'PL23', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 1, 0, 18540000, 18540000  FROM dual UNION ALL 
  select 'P560', 'PL59', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 1, 0, 301670000, 301670000  FROM dual UNION ALL 
  select 'P561', 'PL56', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 1, 0, 1531172000, 1531172000  FROM dual UNION ALL 
  select 'P562', 'PL143', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P563', 'PL43', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 1, 0, 2780350000, 2780350000  FROM dual UNION ALL 
  select 'P564', 'PL167', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 1, 0, 1500000, 1500000  FROM dual UNION ALL 
  select 'P565', 'PL146', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P566', 'PL192', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P567', 'PL96', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P568', 'PL166', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P569', 'PL38', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 1, 0, 94910000, 94910000  FROM dual UNION ALL 
  select 'P570', 'PL165', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P571', 'PL112', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P572', 'PL26', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 1, 0, 58462000, 58462000  FROM dual UNION ALL 
  select 'P573', 'PL37', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 1, 0, 765275000, 765275000  FROM dual UNION ALL 
  select 'P574', 'PL198', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P575', 'PL20', TO_DATE('22/10/2019', 'DD/MM/YYYY'), 1, 0, 2140000, 2140000  FROM dual UNION ALL 
  select 'P576', 'PL74', TO_DATE('22/10/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P577', 'PL127', TO_DATE('22/10/2019', 'DD/MM/YYYY'), 1, 0, 1700000, 1700000  FROM dual UNION ALL 
  select 'P578', 'PL121', TO_DATE('22/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P579', 'PL156', TO_DATE('22/10/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P580', 'PL163', TO_DATE('22/10/2019', 'DD/MM/YYYY'), 1, 0, 2000000, 2000000  FROM dual UNION ALL 
  select 'P581', 'PL17', TO_DATE('22/10/2019', 'DD/MM/YYYY'), 1, 0, 5360000, 5360000  FROM dual UNION ALL 
  select 'P582', 'PL70', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P583', 'PL41', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 1, 0, 3270090000, 3270090000  FROM dual UNION ALL 
  select 'P584', 'PL91', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P585', 'PL98', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P586', 'PL27', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 1, 0, 3231320000, 3231320000  FROM dual UNION ALL 
  select 'P587', 'PL48', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 1, 0, 857055000, 857055000  FROM dual UNION ALL 
  select 'P588', 'PL124', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 1, 0, 775000, 775000  FROM dual UNION ALL 
  select 'P589', 'PL25', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 1, 0, 3795320000, 3795320000  FROM dual UNION ALL 
  select 'P590', 'PL103', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P591', 'PL3', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 1, 0, 3361760000, 3361760000  FROM dual UNION ALL 
  select 'P592', 'PL89', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P593', 'PL160', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P594', 'PL162', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P595', 'PL178', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P596', 'PL72', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P597', 'PL159', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 1, 0, 1350000, 1350000  FROM dual UNION ALL 
  select 'P598', 'PL119', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P599', 'PL60', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 1, 0, 953550000, 953550000  FROM dual UNION ALL 
  select 'P600', 'PL181', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 1, 0, 3050000, 3050000  FROM dual UNION ALL 
  select 'P601', 'PL144', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P602', 'PL154', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P603', 'PL24', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 1, 0, 29200000, 29200000  FROM dual UNION ALL 
  select 'P604', 'PL95', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P605', 'PL142', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 1, 0, 100000, 100000  FROM dual UNION ALL 
  select 'P606', 'PL26', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 1, 0, 345380000, 345380000  FROM dual UNION ALL 
  select 'P607', 'PL117', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 1, 0, 3300000, 3300000  FROM dual UNION ALL 
  select 'P608', 'PL118', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P609', 'PL180', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 1, 0, 775000, 775000  FROM dual UNION ALL 
  select 'P610', 'PL9', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 1, 0, 80950000, 80950000  FROM dual UNION ALL 
  select 'P611', 'PL28', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 1, 0, 1532670000, 1532670000  FROM dual UNION ALL 
  select 'P612', 'PL134', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P613', 'PL194', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P614', 'PL64', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P615', 'PL65', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P616', 'PL158', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P617', 'PL199', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P618', 'PL14', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 1, 0, 70671500, 70671500  FROM dual UNION ALL 
  select 'P619', 'PL28', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 1, 0, 1384372000, 1384372000  FROM dual UNION ALL 
  select 'P620', 'PL38', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 1, 0, 3599788000, 3599788000  FROM dual UNION ALL 
  select 'P621', 'PL14', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 1, 0, 8416872000, 8416872000  FROM dual UNION ALL 
  select 'P622', 'PL94', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P623', 'PL88', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P624', 'PL123', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P625', 'PL74', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 1, 0, 1450000, 1450000  FROM dual UNION ALL 
  select 'P626', 'PL98', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 1, 0, 4200000, 4200000  FROM dual UNION ALL 
  select 'P627', 'PL138', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P628', 'PL20', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 1, 0, 3480000, 3480000  FROM dual UNION ALL 
  select 'P629', 'PL100', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P630', 'PL90', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P631', 'PL92', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 1, 0, 525000, 525000  FROM dual UNION ALL 
  select 'P632', 'PL25', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 1, 0, 11260000, 11260000  FROM dual UNION ALL 
  select 'P633', 'PL25', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 1, 0, 465630000, 465630000  FROM dual UNION ALL 
  select 'P634', 'PL58', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 1, 0, 1700570000, 1700570000  FROM dual UNION ALL 
  select 'P635', 'PL135', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P636', 'PL33', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 1, 0, 71860000, 71860000  FROM dual UNION ALL 
  select 'P637', 'PL56', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 1, 0, 597450000, 597450000  FROM dual UNION ALL 
  select 'P638', 'PL132', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P639', 'PL26', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 1, 0, 1400350000, 1400350000  FROM dual UNION ALL 
  select 'P640', 'PL78', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P641', 'PL63', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 1, 0, 975000, 975000  FROM dual UNION ALL 
  select 'P642', 'PL147', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 1, 0, 950000, 950000  FROM dual UNION ALL 
  select 'P643', 'PL180', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P644', 'PL90', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P645', 'PL169', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P646', 'PL150', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P647', 'PL137', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P648', 'PL36', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1, 0, 159100000, 159100000  FROM dual UNION ALL 
  select 'P649', 'PL172', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P650', 'PL33', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1, 0, 241430000, 241430000  FROM dual UNION ALL 
  select 'P651', 'PL116', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P652', 'PL190', TO_DATE('02/11/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P653', 'PL125', TO_DATE('02/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P654', 'PL188', TO_DATE('02/11/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P655', 'PL132', TO_DATE('02/11/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P656', 'PL14', TO_DATE('02/11/2019', 'DD/MM/YYYY'), 1, 0, 738130000, 738130000  FROM dual UNION ALL 
  select 'P657', 'PL115', TO_DATE('02/11/2019', 'DD/MM/YYYY'), 1, 0, 2550000, 2550000  FROM dual UNION ALL 
  select 'P658', 'PL87', TO_DATE('02/11/2019', 'DD/MM/YYYY'), 1, 0, 950000, 950000  FROM dual UNION ALL 
  select 'P659', 'PL85', TO_DATE('03/11/2019', 'DD/MM/YYYY'), 1, 0, 1350000, 1350000  FROM dual UNION ALL 
  select 'P660', 'PL36', TO_DATE('03/11/2019', 'DD/MM/YYYY'), 1, 0, 486860000, 486860000  FROM dual UNION ALL 
  select 'P661', 'PL200', TO_DATE('03/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P662', 'PL149', TO_DATE('03/11/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P663', 'PL76', TO_DATE('03/11/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P664', 'PL190', TO_DATE('03/11/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P665', 'PL134', TO_DATE('03/11/2019', 'DD/MM/YYYY'), 1, 0, 3300000, 3300000  FROM dual UNION ALL 
  select 'P666', 'PL116', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P667', 'PL65', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P668', 'PL113', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P669', 'PL36', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 1, 0, 411180000, 411180000  FROM dual UNION ALL 
  select 'P670', 'PL121', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P671', 'PL46', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 1, 0, 63210000, 63210000  FROM dual UNION ALL 
  select 'P672', 'PL18', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 1, 0, 38950000, 38950000  FROM dual UNION ALL 
  select 'P673', 'PL127', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 1, 0, 1700000, 1700000  FROM dual UNION ALL 
  select 'P674', 'PL61', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P675', 'PL105', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 1, 0, 3500000, 3500000  FROM dual UNION ALL 
  select 'P676', 'PL135', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P677', 'PL149', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P678', 'PL192', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P679', 'PL118', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P680', 'PL148', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P681', 'PL102', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P682', 'PL110', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P683', 'PL56', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 1, 0, 2051638000, 2051638000  FROM dual UNION ALL 
  select 'P684', 'PL7', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 1, 0, 7262210000, 7262210000  FROM dual UNION ALL 
  select 'P685', 'PL166', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P686', 'PL13', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 1, 0, 578740000, 578740000  FROM dual UNION ALL 
  select 'P687', 'PL180', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P688', 'PL76', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P689', 'PL152', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P690', 'PL118', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 1, 0, 4200000, 4200000  FROM dual UNION ALL 
  select 'P691', 'PL178', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P692', 'PL181', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P693', 'PL62', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 1, 0, 2150000, 2150000  FROM dual UNION ALL 
  select 'P694', 'PL110', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P695', 'PL148', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P696', 'PL192', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P697', 'PL73', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P698', 'PL44', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 1, 0, 750050000, 750050000  FROM dual UNION ALL 
  select 'P699', 'PL167', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P700', 'PL143', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 1, 0, 100000, 100000  FROM dual UNION ALL 
  select 'P701', 'PL25', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 1, 0, 4508100000, 4508100000  FROM dual UNION ALL 
  select 'P702', 'PL90', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P703', 'PL99', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P704', 'PL72', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 1, 0, 1300000, 1300000  FROM dual UNION ALL 
  select 'P705', 'PL80', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P706', 'PL80', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P707', 'PL83', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P708', 'PL108', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P709', 'PL55', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 1, 0, 68360000, 68360000  FROM dual UNION ALL 
  select 'P710', 'PL74', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P711', 'PL49', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 1, 0, 54900000, 54900000  FROM dual UNION ALL 
  select 'P712', 'PL193', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P713', 'PL37', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 1, 0, 24752000, 24752000  FROM dual UNION ALL 
  select 'P714', 'PL108', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P715', 'PL96', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P716', 'PL194', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P717', 'PL7', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 1, 0, 1393640000, 1393640000  FROM dual UNION ALL 
  select 'P718', 'PL37', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 1, 0, 89488000, 89488000  FROM dual UNION ALL 
  select 'P719', 'PL39', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 1, 0, 4852760000, 4852760000  FROM dual UNION ALL 
  select 'P720', 'PL127', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 1, 0, 2350000, 2350000  FROM dual UNION ALL 
  select 'P721', 'PL60', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 1, 0, 872705000, 872705000  FROM dual UNION ALL 
  select 'P722', 'PL137', TO_DATE('12/11/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P723', 'PL135', TO_DATE('12/11/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P724', 'PL192', TO_DATE('12/11/2019', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P725', 'PL175', TO_DATE('12/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P726', 'PL36', TO_DATE('12/11/2019', 'DD/MM/YYYY'), 1, 0, 16300000, 16300000  FROM dual UNION ALL 
  select 'P727', 'PL32', TO_DATE('12/11/2019', 'DD/MM/YYYY'), 1, 0, 4689780000, 4689780000  FROM dual UNION ALL 
  select 'P728', 'PL78', TO_DATE('12/11/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P729', 'PL163', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P730', 'PL181', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P731', 'PL68', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P732', 'PL40', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 1, 0, 189290000, 189290000  FROM dual UNION ALL 
  select 'P733', 'PL177', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P734', 'PL197', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P735', 'PL1', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 1, 0, 29866000, 29866000  FROM dual UNION ALL 
  select 'P736', 'PL97', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P737', 'PL162', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P738', 'PL32', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 1, 0, 6590000, 6590000  FROM dual UNION ALL 
  select 'P739', 'PL198', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 1, 0, 875000, 875000  FROM dual UNION ALL 
  select 'P740', 'PL89', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P741', 'PL91', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P742', 'PL159', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P743', 'PL15', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 1, 0, 3362353500, 3362353500  FROM dual UNION ALL 
  select 'P744', 'PL177', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P745', 'PL149', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 1, 0, 1700000, 1700000  FROM dual UNION ALL 
  select 'P746', 'PL80', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P747', 'PL2', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 1, 0, 119875000, 119875000  FROM dual UNION ALL 
  select 'P748', 'PL127', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P749', 'PL144', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P750', 'PL20', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 1, 0, 3820000, 3820000  FROM dual;

INSERT INTO PESANAN (ID_PESANAN, ID_PELANGGAN, TANGGAL_PESAN, STATUS_PESANAN, DISCOUNT_PESANAN,TOTAL_HARGA, JUMLAH_TERBAYARKAN)  
  select 'P751', 'PL174', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 1, 0, 3050000, 3050000  FROM dual UNION ALL 
  select 'P752', 'PL181', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P753', 'PL137', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 1, 0, 1350000, 1350000  FROM dual UNION ALL 
  select 'P754', 'PL149', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 1, 0, 900000, 900000  FROM dual UNION ALL 
  select 'P755', 'PL98', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P756', 'PL27', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 1, 0, 571072000, 571072000  FROM dual UNION ALL 
  select 'P757', 'PL176', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 1, 0, 1500000, 1500000  FROM dual UNION ALL 
  select 'P758', 'PL24', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 1, 0, 4000000, 4000000  FROM dual UNION ALL 
  select 'P759', 'PL98', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P760', 'PL61', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P761', 'PL53', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 1, 0, 1039655000, 1039655000  FROM dual UNION ALL 
  select 'P762', 'PL64', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P763', 'PL23', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 1, 0, 14610000, 14610000  FROM dual UNION ALL 
  select 'P764', 'PL126', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P765', 'PL53', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 1, 0, 231650000, 231650000  FROM dual UNION ALL 
  select 'P766', 'PL58', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 1, 0, 5636452000, 5636452000  FROM dual UNION ALL 
  select 'P767', 'PL61', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P768', 'PL32', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 1, 0, 6693520000, 6693520000  FROM dual UNION ALL 
  select 'P769', 'PL81', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P770', 'PL198', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P771', 'PL4', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 1, 0, 853590500, 853590500  FROM dual UNION ALL 
  select 'P772', 'PL145', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P773', 'PL88', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P774', 'PL91', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 1, 0, 3475000, 3475000  FROM dual UNION ALL 
  select 'P775', 'PL172', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 1, 0, 1300000, 1300000  FROM dual UNION ALL 
  select 'P776', 'PL174', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P777', 'PL133', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P778', 'PL7', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 1, 0, 81100000, 81100000  FROM dual UNION ALL 
  select 'P779', 'PL3', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 1, 0, 107240000, 107240000  FROM dual UNION ALL 
  select 'P780', 'PL11', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 1, 0, 1068154000, 1068154000  FROM dual UNION ALL 
  select 'P781', 'PL80', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P782', 'PL121', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P783', 'PL82', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P784', 'PL200', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P785', 'PL62', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 1, 0, 4200000, 4200000  FROM dual UNION ALL 
  select 'P786', 'PL188', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P787', 'PL154', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 1, 0, 825000, 825000  FROM dual UNION ALL 
  select 'P788', 'PL15', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 1, 0, 3096385000, 3096385000  FROM dual UNION ALL 
  select 'P789', 'PL19', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 1, 0, 15190000, 15190000  FROM dual UNION ALL 
  select 'P790', 'PL63', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P791', 'PL61', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P792', 'PL65', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P793', 'PL156', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P794', 'PL34', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1, 0, 3108806000, 3108806000  FROM dual UNION ALL 
  select 'P795', 'PL131', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P796', 'PL2', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1, 0, 542800000, 542800000  FROM dual UNION ALL 
  select 'P797', 'PL8', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1, 0, 402766000, 402766000  FROM dual UNION ALL 
  select 'P798', 'PL104', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P799', 'PL181', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 1, 0, 2350000, 2350000  FROM dual UNION ALL 
  select 'P800', 'PL75', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P801', 'PL38', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 1, 0, 150210000, 150210000  FROM dual UNION ALL 
  select 'P802', 'PL121', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P803', 'PL168', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P804', 'PL142', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P805', 'PL31', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 1, 0, 4618105000, 4618105000  FROM dual UNION ALL 
  select 'P806', 'PL61', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P807', 'PL26', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 1, 0, 972210000, 972210000  FROM dual UNION ALL 
  select 'P808', 'PL180', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 1, 0, 100000, 100000  FROM dual UNION ALL 
  select 'P809', 'PL151', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P810', 'PL138', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P811', 'PL31', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 1, 0, 100736000, 100736000  FROM dual UNION ALL 
  select 'P812', 'PL191', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P813', 'PL103', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P814', 'PL7', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 1, 0, 144400000, 144400000  FROM dual UNION ALL 
  select 'P815', 'PL43', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 1, 0, 3238832000, 3238832000  FROM dual UNION ALL 
  select 'P816', 'PL32', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 1, 0, 455600000, 455600000  FROM dual UNION ALL 
  select 'P817', 'PL14', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 1, 0, 684557500, 684557500  FROM dual UNION ALL 
  select 'P818', 'PL76', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P819', 'PL86', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P820', 'PL108', TO_DATE('26/11/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P821', 'PL12', TO_DATE('26/11/2019', 'DD/MM/YYYY'), 1, 0, 556750000, 556750000  FROM dual UNION ALL 
  select 'P822', 'PL4', TO_DATE('26/11/2019', 'DD/MM/YYYY'), 1, 0, 647256000, 647256000  FROM dual UNION ALL 
  select 'P823', 'PL55', TO_DATE('26/11/2019', 'DD/MM/YYYY'), 1, 0, 289976000, 289976000  FROM dual UNION ALL 
  select 'P824', 'PL112', TO_DATE('26/11/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P825', 'PL200', TO_DATE('26/11/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P826', 'PL124', TO_DATE('26/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P827', 'PL53', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 1, 0, 468044000, 468044000  FROM dual UNION ALL 
  select 'P828', 'PL70', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P829', 'PL45', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 1, 0, 743630000, 743630000  FROM dual UNION ALL 
  select 'P830', 'PL86', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P831', 'PL42', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 1, 0, 346320000, 346320000  FROM dual UNION ALL 
  select 'P832', 'PL129', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P833', 'PL6', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 1, 0, 510959000, 510959000  FROM dual UNION ALL 
  select 'P834', 'PL163', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P835', 'PL85', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 1, 0, 1450000, 1450000  FROM dual UNION ALL 
  select 'P836', 'PL187', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P837', 'PL23', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 1, 0, 17680000, 17680000  FROM dual UNION ALL 
  select 'P838', 'PL91', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P839', 'PL168', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P840', 'PL96', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P841', 'PL78', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 1, 0, 2600000, 2600000  FROM dual UNION ALL 
  select 'P842', 'PL27', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 1, 0, 53600000, 53600000  FROM dual UNION ALL 
  select 'P843', 'PL164', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 1, 0, 4000000, 4000000  FROM dual UNION ALL 
  select 'P844', 'PL164', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P845', 'PL59', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 1, 0, 115020000, 115020000  FROM dual UNION ALL 
  select 'P846', 'PL189', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P847', 'PL81', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P848', 'PL71', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 1, 0, 2000000, 2000000  FROM dual UNION ALL 
  select 'P849', 'PL146', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P850', 'PL59', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 1, 0, 28612000, 28612000  FROM dual UNION ALL 
  select 'P851', 'PL110', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P852', 'PL66', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P853', 'PL86', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P854', 'PL196', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P855', 'PL39', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 1, 0, 2942398000, 2942398000  FROM dual UNION ALL 
  select 'P856', 'PL98', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P857', 'PL194', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 1, 0, 3300000, 3300000  FROM dual UNION ALL 
  select 'P858', 'PL182', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P859', 'PL176', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P860', 'PL86', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P861', 'PL97', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P862', 'PL17', TO_DATE('02/12/2019', 'DD/MM/YYYY'), 1, 0, 42430000, 42430000  FROM dual UNION ALL 
  select 'P863', 'PL100', TO_DATE('02/12/2019', 'DD/MM/YYYY'), 1, 0, 2550000, 2550000  FROM dual UNION ALL 
  select 'P864', 'PL70', TO_DATE('02/12/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P865', 'PL9', TO_DATE('02/12/2019', 'DD/MM/YYYY'), 1, 0, 768630000, 768630000  FROM dual UNION ALL 
  select 'P866', 'PL147', TO_DATE('02/12/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P867', 'PL35', TO_DATE('02/12/2019', 'DD/MM/YYYY'), 1, 0, 7320000, 7320000  FROM dual UNION ALL 
  select 'P868', 'PL57', TO_DATE('02/12/2019', 'DD/MM/YYYY'), 1, 0, 616300000, 616300000  FROM dual UNION ALL 
  select 'P869', 'PL170', TO_DATE('03/12/2019', 'DD/MM/YYYY'), 1, 0, 900000, 900000  FROM dual UNION ALL 
  select 'P870', 'PL16', TO_DATE('03/12/2019', 'DD/MM/YYYY'), 1, 0, 23410000, 23410000  FROM dual UNION ALL 
  select 'P871', 'PL138', TO_DATE('03/12/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P872', 'PL141', TO_DATE('03/12/2019', 'DD/MM/YYYY'), 1, 0, 1700000, 1700000  FROM dual UNION ALL 
  select 'P873', 'PL56', TO_DATE('03/12/2019', 'DD/MM/YYYY'), 1, 0, 67275000, 67275000  FROM dual UNION ALL 
  select 'P874', 'PL56', TO_DATE('03/12/2019', 'DD/MM/YYYY'), 1, 0, 32804000, 32804000  FROM dual UNION ALL 
  select 'P875', 'PL120', TO_DATE('03/12/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P876', 'PL184', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P877', 'PL110', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P878', 'PL54', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 1, 0, 336606000, 336606000  FROM dual UNION ALL 
  select 'P879', 'PL4', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 1, 0, 8169160000, 8169160000  FROM dual UNION ALL 
  select 'P880', 'PL138', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P881', 'PL166', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P882', 'PL52', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 1, 0, 3556000, 3556000  FROM dual UNION ALL 
  select 'P883', 'PL111', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P884', 'PL164', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P885', 'PL184', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P886', 'PL168', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P887', 'PL71', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P888', 'PL60', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 1, 0, 5052470000, 5052470000  FROM dual UNION ALL 
  select 'P889', 'PL172', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 1, 0, 1450000, 1450000  FROM dual UNION ALL 
  select 'P890', 'PL99', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P891', 'PL12', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 1, 0, 668600000, 668600000  FROM dual UNION ALL 
  select 'P892', 'PL159', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P893', 'PL24', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 1, 0, 1660000, 1660000  FROM dual UNION ALL 
  select 'P894', 'PL84', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P895', 'PL171', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P896', 'PL48', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 1, 0, 108300000, 108300000  FROM dual UNION ALL 
  select 'P897', 'PL156', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P898', 'PL132', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P899', 'PL31', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 1, 0, 7010000, 7010000  FROM dual UNION ALL 
  select 'P900', 'PL167', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P901', 'PL178', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P902', 'PL171', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P903', 'PL1', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 1, 0, 294750000, 294750000  FROM dual UNION ALL 
  select 'P904', 'PL119', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P905', 'PL81', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 1, 0, 4200000, 4200000  FROM dual UNION ALL 
  select 'P906', 'PL151', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P907', 'PL182', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P908', 'PL114', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P909', 'PL187', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P910', 'PL145', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P911', 'PL129', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P912', 'PL21', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 1, 0, 14290000, 14290000  FROM dual UNION ALL 
  select 'P913', 'PL77', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 1, 0, 525000, 525000  FROM dual UNION ALL 
  select 'P914', 'PL55', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 1, 0, 4813750000, 4813750000  FROM dual UNION ALL 
  select 'P915', 'PL138', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P916', 'PL197', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P917', 'PL141', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P918', 'PL182', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P919', 'PL196', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P920', 'PL104', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 1, 0, 3300000, 3300000  FROM dual UNION ALL 
  select 'P921', 'PL192', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P922', 'PL108', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P923', 'PL154', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P924', 'PL16', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 1, 0, 11410000, 11410000  FROM dual UNION ALL 
  select 'P925', 'PL35', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 1, 0, 240640000, 240640000  FROM dual UNION ALL 
  select 'P926', 'PL57', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 1, 0, 520574000, 520574000  FROM dual UNION ALL 
  select 'P927', 'PL68', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P928', 'PL61', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P929', 'PL177', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P930', 'PL39', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 1, 0, 341673000, 341673000  FROM dual UNION ALL 
  select 'P931', 'PL89', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P932', 'PL124', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P933', 'PL7', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1, 0, 19080000, 19080000  FROM dual UNION ALL 
  select 'P934', 'PL36', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1, 0, 2266352000, 2266352000  FROM dual UNION ALL 
  select 'P935', 'PL32', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1, 0, 6645280000, 6645280000  FROM dual UNION ALL 
  select 'P936', 'PL166', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1, 0, 900000, 900000  FROM dual UNION ALL 
  select 'P937', 'PL81', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P938', 'PL123', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P939', 'PL130', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P940', 'PL183', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P941', 'PL64', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 1, 0, 2575000, 2575000  FROM dual UNION ALL 
  select 'P942', 'PL66', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P943', 'PL89', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P944', 'PL77', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P945', 'PL189', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P946', 'PL199', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P947', 'PL99', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P948', 'PL66', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P949', 'PL199', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P950', 'PL84', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P951', 'PL7', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 1, 0, 264938000, 264938000  FROM dual UNION ALL 
  select 'P952', 'PL120', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P953', 'PL87', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P954', 'PL101', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P955', 'PL188', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 1, 0, 1700000, 1700000  FROM dual UNION ALL 
  select 'P956', 'PL35', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 1, 0, 60820000, 60820000  FROM dual UNION ALL 
  select 'P957', 'PL55', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 1, 0, 1029360000, 1029360000  FROM dual UNION ALL 
  select 'P958', 'PL58', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 1, 0, 2014760000, 2014760000  FROM dual UNION ALL 
  select 'P959', 'PL68', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P960', 'PL118', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P961', 'PL113', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 1, 0, 925000, 925000  FROM dual UNION ALL 
  select 'P962', 'PL69', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P963', 'PL127', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P964', 'PL122', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P965', 'PL160', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P966', 'PL183', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P967', 'PL109', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P968', 'PL39', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 1, 0, 163046000, 163046000  FROM dual UNION ALL 
  select 'P969', 'PL138', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P970', 'PL103', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 1, 0, 1475000, 1475000  FROM dual UNION ALL 
  select 'P971', 'PL40', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 1, 0, 174370000, 174370000  FROM dual UNION ALL 
  select 'P972', 'PL107', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P973', 'PL154', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P974', 'PL35', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 1, 0, 436140000, 436140000  FROM dual UNION ALL 
  select 'P975', 'PL104', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 1, 0, 100000, 100000  FROM dual UNION ALL 
  select 'P976', 'PL16', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 1, 0, 1500000, 1500000  FROM dual UNION ALL 
  select 'P977', 'PL153', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P978', 'PL69', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P979', 'PL37', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 1, 0, 1548200000, 1548200000  FROM dual UNION ALL 
  select 'P980', 'PL72', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P981', 'PL122', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P982', 'PL136', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P983', 'PL47', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1, 0, 1765072000, 1765072000  FROM dual UNION ALL 
  select 'P984', 'PL125', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P985', 'PL143', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P986', 'PL54', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1, 0, 85500000, 85500000  FROM dual UNION ALL 
  select 'P987', 'PL4', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1, 0, 528084000, 528084000  FROM dual UNION ALL 
  select 'P988', 'PL30', TO_DATE('20/12/2019', 'DD/MM/YYYY'), 1, 0, 282560000, 282560000  FROM dual UNION ALL 
  select 'P989', 'PL53', TO_DATE('20/12/2019', 'DD/MM/YYYY'), 1, 0, 209253000, 209253000  FROM dual UNION ALL 
  select 'P990', 'PL40', TO_DATE('20/12/2019', 'DD/MM/YYYY'), 1, 0, 2322874000, 2322874000  FROM dual UNION ALL 
  select 'P991', 'PL124', TO_DATE('20/12/2019', 'DD/MM/YYYY'), 1, 0, 1350000, 1350000  FROM dual UNION ALL 
  select 'P992', 'PL142', TO_DATE('20/12/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P993', 'PL94', TO_DATE('20/12/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P994', 'PL31', TO_DATE('20/12/2019', 'DD/MM/YYYY'), 1, 0, 173830000, 173830000  FROM dual UNION ALL 
  select 'P995', 'PL13', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 1, 0, 69610000, 69610000  FROM dual UNION ALL 
  select 'P996', 'PL197', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P997', 'PL43', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 1, 0, 2840060000, 2840060000  FROM dual UNION ALL 
  select 'P998', 'PL24', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 1, 0, 22540000, 22540000  FROM dual UNION ALL 
  select 'P999', 'PL117', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P1000', 'PL61', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P1001', 'PL108', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P1002', 'PL42', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 1, 0, 324005000, 324005000  FROM dual UNION ALL 
  select 'P1003', 'PL103', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P1004', 'PL200', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P1005', 'PL162', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1006', 'PL55', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 1, 0, 197845000, 197845000  FROM dual UNION ALL 
  select 'P1007', 'PL25', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 1, 0, 812680000, 812680000  FROM dual UNION ALL 
  select 'P1008', 'PL166', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P1009', 'PL48', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1, 0, 150085000, 150085000  FROM dual UNION ALL 
  select 'P1010', 'PL100', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1, 0, 100000, 100000  FROM dual UNION ALL 
  select 'P1011', 'PL17', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1, 0, 2020000, 2020000  FROM dual UNION ALL 
  select 'P1012', 'PL76', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1013', 'PL125', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1, 0, 900000, 900000  FROM dual UNION ALL 
  select 'P1014', 'PL91', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P1015', 'PL194', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1, 0, 5100000, 5100000  FROM dual UNION ALL 
  select 'P1016', 'PL180', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 1, 0, 1700000, 1700000  FROM dual UNION ALL 
  select 'P1017', 'PL115', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 1, 0, 1550000, 1550000  FROM dual UNION ALL 
  select 'P1018', 'PL11', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 1, 0, 664967500, 664967500  FROM dual UNION ALL 
  select 'P1019', 'PL88', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual;

INSERT INTO PESANAN (ID_PESANAN, ID_PELANGGAN, TANGGAL_PESAN, STATUS_PESANAN, DISCOUNT_PESANAN,TOTAL_HARGA, JUMLAH_TERBAYARKAN)  
  select 'P1020', 'PL112', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P1021', 'PL136', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P1022', 'PL30', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 1, 0, 492640000, 492640000  FROM dual UNION ALL 
  select 'P1023', 'PL29', TO_DATE('25/12/2019', 'DD/MM/YYYY'), 1, 0, 50010000, 50010000  FROM dual UNION ALL 
  select 'P1024', 'PL6', TO_DATE('25/12/2019', 'DD/MM/YYYY'), 1, 0, 941575000, 941575000  FROM dual UNION ALL 
  select 'P1025', 'PL139', TO_DATE('25/12/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P1026', 'PL16', TO_DATE('25/12/2019', 'DD/MM/YYYY'), 1, 0, 11730000, 11730000  FROM dual UNION ALL 
  select 'P1027', 'PL188', TO_DATE('25/12/2019', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P1028', 'PL26', TO_DATE('25/12/2019', 'DD/MM/YYYY'), 1, 0, 12540000, 12540000  FROM dual UNION ALL 
  select 'P1029', 'PL145', TO_DATE('25/12/2019', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P1030', 'PL125', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1031', 'PL7', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 1, 0, 7251326000, 7251326000  FROM dual UNION ALL 
  select 'P1032', 'PL141', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P1033', 'PL198', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P1034', 'PL145', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P1035', 'PL58', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 1, 0, 614344000, 614344000  FROM dual UNION ALL 
  select 'P1036', 'PL70', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P1037', 'PL26', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 1, 0, 26000000, 26000000  FROM dual UNION ALL 
  select 'P1038', 'PL69', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P1039', 'PL6', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 1, 0, 26500000, 26500000  FROM dual UNION ALL 
  select 'P1040', 'PL72', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 1, 0, 900000, 900000  FROM dual UNION ALL 
  select 'P1041', 'PL171', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P1042', 'PL141', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P1043', 'PL59', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 1, 0, 388960000, 388960000  FROM dual UNION ALL 
  select 'P1044', 'PL39', TO_DATE('28/12/2019', 'DD/MM/YYYY'), 1, 0, 4889760000, 4889760000  FROM dual UNION ALL 
  select 'P1045', 'PL126', TO_DATE('28/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1046', 'PL113', TO_DATE('28/12/2019', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P1047', 'PL140', TO_DATE('28/12/2019', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P1048', 'PL155', TO_DATE('28/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1049', 'PL43', TO_DATE('28/12/2019', 'DD/MM/YYYY'), 1, 0, 4155080000, 4155080000  FROM dual UNION ALL 
  select 'P1050', 'PL131', TO_DATE('28/12/2019', 'DD/MM/YYYY'), 1, 0, 2350000, 2350000  FROM dual UNION ALL 
  select 'P1051', 'PL43', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 1, 0, 699108000, 699108000  FROM dual UNION ALL 
  select 'P1052', 'PL176', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P1053', 'PL66', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P1054', 'PL3', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 1, 0, 62470000, 62470000  FROM dual UNION ALL 
  select 'P1055', 'PL151', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 1, 0, 475000, 475000  FROM dual UNION ALL 
  select 'P1056', 'PL63', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P1057', 'PL197', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P1058', 'PL78', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P1059', 'PL16', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 1, 0, 18070000, 18070000  FROM dual UNION ALL 
  select 'P1060', 'PL69', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 1, 0, 100000, 100000  FROM dual UNION ALL 
  select 'P1061', 'PL78', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P1062', 'PL33', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 1, 0, 83948000, 83948000  FROM dual UNION ALL 
  select 'P1063', 'PL112', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 1, 0, 2100000, 2100000  FROM dual UNION ALL 
  select 'P1064', 'PL145', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P1065', 'PL96', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 1, 0, 3350000, 3350000  FROM dual UNION ALL 
  select 'P1066', 'PL60', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 1, 0, 3112606000, 3112606000  FROM dual UNION ALL 
  select 'P1067', 'PL154', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1068', 'PL143', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 1, 0, 800000, 800000  FROM dual UNION ALL 
  select 'P1069', 'PL93', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P1070', 'PL33', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 1, 0, 413525000, 413525000  FROM dual UNION ALL 
  select 'P1071', 'PL62', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1072', 'PL167', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1073', 'PL114', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P1074', 'PL199', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 1, 0, 1600000, 1600000  FROM dual UNION ALL 
  select 'P1075', 'PL155', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 1, 0, 725000, 725000  FROM dual UNION ALL 
  select 'P1076', 'PL79', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 1, 0, 2350000, 2350000  FROM dual UNION ALL 
  select 'P1077', 'PL188', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1078', 'PL171', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1079', 'PL35', TO_DATE('02/01/2020', 'DD/MM/YYYY'), 1, 0, 22016000, 22016000  FROM dual UNION ALL 
  select 'P1080', 'PL73', TO_DATE('02/01/2020', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P1081', 'PL117', TO_DATE('02/01/2020', 'DD/MM/YYYY'), 1, 0, 3350000, 3350000  FROM dual UNION ALL 
  select 'P1082', 'PL121', TO_DATE('02/01/2020', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P1083', 'PL122', TO_DATE('02/01/2020', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P1084', 'PL123', TO_DATE('02/01/2020', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1085', 'PL141', TO_DATE('02/01/2020', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P1086', 'PL186', TO_DATE('03/01/2020', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P1087', 'PL2', TO_DATE('03/01/2020', 'DD/MM/YYYY'), 1, 0, 6020000, 6020000  FROM dual UNION ALL 
  select 'P1088', 'PL44', TO_DATE('03/01/2020', 'DD/MM/YYYY'), 1, 0, 2465060000, 2465060000  FROM dual UNION ALL 
  select 'P1089', 'PL79', TO_DATE('03/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1090', 'PL79', TO_DATE('03/01/2020', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P1091', 'PL146', TO_DATE('03/01/2020', 'DD/MM/YYYY'), 1, 0, 1250000, 1250000  FROM dual UNION ALL 
  select 'P1092', 'PL66', TO_DATE('03/01/2020', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P1093', 'PL167', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1094', 'PL111', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P1095', 'PL150', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1096', 'PL196', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1097', 'PL200', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 1, 0, 3050000, 3050000  FROM dual UNION ALL 
  select 'P1098', 'PL120', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P1099', 'PL169', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P1100', 'PL148', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P1101', 'PL98', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 1, 0, 650000, 650000  FROM dual UNION ALL 
  select 'P1102', 'PL196', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P1103', 'PL108', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P1104', 'PL86', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P1105', 'PL174', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 1, 0, 975000, 975000  FROM dual UNION ALL 
  select 'P1106', 'PL62', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1107', 'PL94', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1108', 'PL119', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 1, 0, 2350000, 2350000  FROM dual UNION ALL 
  select 'P1109', 'PL137', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1110', 'PL141', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 1, 0, 1400000, 1400000  FROM dual UNION ALL 
  select 'P1111', 'PL19', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 1, 0, 15880000, 15880000  FROM dual UNION ALL 
  select 'P1112', 'PL10', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 1, 0, 699752500, 699752500  FROM dual UNION ALL 
  select 'P1113', 'PL183', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 1, 0, 2150000, 2150000  FROM dual UNION ALL 
  select 'P1114', 'PL195', TO_DATE('07/01/2020', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P1115', 'PL192', TO_DATE('07/01/2020', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P1116', 'PL148', TO_DATE('07/01/2020', 'DD/MM/YYYY'), 1, 0, 100000, 100000  FROM dual UNION ALL 
  select 'P1117', 'PL78', TO_DATE('07/01/2020', 'DD/MM/YYYY'), 1, 0, 1500000, 1500000  FROM dual UNION ALL 
  select 'P1118', 'PL129', TO_DATE('07/01/2020', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1119', 'PL118', TO_DATE('07/01/2020', 'DD/MM/YYYY'), 1, 0, 3050000, 3050000  FROM dual UNION ALL 
  select 'P1120', 'PL100', TO_DATE('07/01/2020', 'DD/MM/YYYY'), 1, 0, 300000, 300000  FROM dual UNION ALL 
  select 'P1121', 'PL197', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1122', 'PL93', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 1, 0, 750000, 750000  FROM dual UNION ALL 
  select 'P1123', 'PL144', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P1124', 'PL196', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P1125', 'PL24', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 1, 0, 4060000, 4060000  FROM dual UNION ALL 
  select 'P1126', 'PL60', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 1, 0, 384530000, 384530000  FROM dual UNION ALL 
  select 'P1127', 'PL113', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 1, 0, 400000, 400000  FROM dual UNION ALL 
  select 'P1128', 'PL48', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 1, 0, 2671260000, 2671260000  FROM dual UNION ALL 
  select 'P1129', 'PL128', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 1, 0, 2575000, 2575000  FROM dual UNION ALL 
  select 'P1130', 'PL109', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P1131', 'PL104', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 1, 0, 550000, 550000  FROM dual UNION ALL 
  select 'P1132', 'PL39', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 1, 0, 74630000, 74630000  FROM dual UNION ALL 
  select 'P1133', 'PL83', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P1134', 'PL70', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P1135', 'PL79', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P1136', 'PL153', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1137', 'PL129', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P1138', 'PL87', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1139', 'PL80', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P1140', 'PL36', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1, 0, 663020000, 663020000  FROM dual UNION ALL 
  select 'P1141', 'PL70', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1, 0, 1200000, 1200000  FROM dual UNION ALL 
  select 'P1142', 'PL175', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 1, 0, 2200000, 2200000  FROM dual UNION ALL 
  select 'P1143', 'PL57', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 1, 0, 440974000, 440974000  FROM dual UNION ALL 
  select 'P1144', 'PL174', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P1145', 'PL50', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 1, 0, 2585138000, 2585138000  FROM dual UNION ALL 
  select 'P1146', 'PL90', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 1, 0, 525000, 525000  FROM dual UNION ALL 
  select 'P1147', 'PL90', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P1148', 'PL60', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 1, 0, 1633550000, 1633550000  FROM dual UNION ALL 
  select 'P1149', 'PL62', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1150', 'PL38', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 1, 0, 1037270000, 1037270000  FROM dual UNION ALL 
  select 'P1151', 'PL116', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 1, 0, 850000, 850000  FROM dual UNION ALL 
  select 'P1152', 'PL193', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P1153', 'PL18', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 1, 0, 4360000, 4360000  FROM dual UNION ALL 
  select 'P1154', 'PL36', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 1, 0, 32900000, 32900000  FROM dual UNION ALL 
  select 'P1155', 'PL45', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 1, 0, 870485000, 870485000  FROM dual UNION ALL 
  select 'P1156', 'PL7', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 1, 0, 6885440000, 6885440000  FROM dual UNION ALL 
  select 'P1157', 'PL90', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1158', 'PL65', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P1159', 'PL51', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 1, 0, 32150000, 32150000  FROM dual UNION ALL 
  select 'P1160', 'PL186', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P1161', 'PL155', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1162', 'PL162', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P1163', 'PL102', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 1, 0, 700000, 700000  FROM dual UNION ALL 
  select 'P1164', 'PL162', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P1165', 'PL172', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P1166', 'PL47', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 1, 0, 897614000, 897614000  FROM dual UNION ALL 
  select 'P1167', 'PL27', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 1, 0, 641228000, 641228000  FROM dual UNION ALL 
  select 'P1168', 'PL35', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 1, 0, 23600000, 23600000  FROM dual UNION ALL 
  select 'P1169', 'PL19', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 1, 0, 11530000, 11530000  FROM dual UNION ALL 
  select 'P1170', 'PL126', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P1171', 'PL143', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 1, 0, 200000, 200000  FROM dual UNION ALL 
  select 'P1172', 'PL91', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 1, 0, 2450000, 2450000  FROM dual UNION ALL 
  select 'P1173', 'PL174', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 1, 0, 4000000, 4000000  FROM dual UNION ALL 
  select 'P1174', 'PL18', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 1, 0, 12130000, 12130000  FROM dual UNION ALL 
  select 'P1175', 'PL50', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 1, 0, 190960000, 190960000  FROM dual UNION ALL 
  select 'P1176', 'PL13', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 1, 0, 8874998000, 8874998000  FROM dual UNION ALL 
  select 'P1177', 'PL97', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1178', 'PL40', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 1, 0, 4431100000, 4431100000  FROM dual UNION ALL 
  select 'P1179', 'PL188', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 1, 0, 675000, 675000  FROM dual UNION ALL 
  select 'P1180', 'PL178', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1181', 'PL87', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1182', 'PL32', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 1, 0, 11061300000, 11061300000  FROM dual UNION ALL 
  select 'P1183', 'PL90', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1184', 'PL174', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1185', 'PL86', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P1186', 'PL125', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 1, 0, 1000000, 1000000  FROM dual UNION ALL 
  select 'P1187', 'PL30', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 1, 0, 62676000, 62676000  FROM dual UNION ALL 
  select 'P1188', 'PL164', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 1, 0, 3000000, 3000000  FROM dual UNION ALL 
  select 'P1189', 'PL23', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 1, 0, 4720000, 4720000  FROM dual UNION ALL 
  select 'P1190', 'PL158', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 1, 0, 950000, 950000  FROM dual UNION ALL 
  select 'P1191', 'PL176', TO_DATE('18/01/2020', 'DD/MM/YYYY'), 1, 0, 450000, 450000  FROM dual UNION ALL 
  select 'P1192', 'PL155', TO_DATE('18/01/2020', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P1193', 'PL174', TO_DATE('18/01/2020', 'DD/MM/YYYY'), 1, 0, 250000, 250000  FROM dual UNION ALL 
  select 'P1194', 'PL195', TO_DATE('18/01/2020', 'DD/MM/YYYY'), 1, 0, 600000, 600000  FROM dual UNION ALL 
  select 'P1195', 'PL199', TO_DATE('18/01/2020', 'DD/MM/YYYY'), 1, 0, 2600000, 2600000  FROM dual UNION ALL 
  select 'P1196', 'PL61', TO_DATE('18/01/2020', 'DD/MM/YYYY'), 1, 0, 350000, 350000  FROM dual UNION ALL 
  select 'P1197', 'PL160', TO_DATE('18/01/2020', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P1198', 'PL195', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 1, 0, 500000, 500000  FROM dual UNION ALL 
  select 'P1199', 'PL183', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 1, 0, 1050000, 1050000  FROM dual UNION ALL 
  select 'P1200', 'PL150', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 1, 0, 50000, 50000  FROM dual UNION ALL 
  select 'P1201', 'PL166', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 0, 0, 300000, 150000  FROM dual UNION ALL 
  select 'P1202', 'PL11', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 0, 0, 604564000, 302282000  FROM dual UNION ALL 
  select 'P1203', 'PL62', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 0, 0, 500000, 250000  FROM dual UNION ALL 
  select 'P1204', 'PL34', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 0, 0, 6634260000, 3317130000  FROM dual UNION ALL 
  select 'P1205', 'PL146', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 0, 0, 350000, 175000  FROM dual UNION ALL 
  select 'P1206', 'PL47', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 0, 0, 3028425000, 1514212500  FROM dual UNION ALL 
  select 'P1207', 'PL1', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 0, 0, 970760000, 485380000  FROM dual UNION ALL 
  select 'P1208', 'PL160', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 0, 0, 800000, 400000  FROM dual UNION ALL 
  select 'P1209', 'PL152', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 0, 0, 1300000, 650000  FROM dual UNION ALL 
  select 'P1210', 'PL155', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 0, 0, 550000, 275000  FROM dual UNION ALL 
  select 'P1211', 'PL25', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 0, 0, 753060000, 376530000  FROM dual UNION ALL 
  select 'P1212', 'PL166', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 0, 0, 300000, 150000  FROM dual UNION ALL 
  select 'P1213', 'PL27', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 0, 0, 2297799000, 1148899500  FROM dual UNION ALL 
  select 'P1214', 'PL50', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 0, 0, 3545400000, 1772700000  FROM dual UNION ALL 
  select 'P1215', 'PL176', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 0, 0, 400000, 200000  FROM dual UNION ALL 
  select 'P1216', 'PL26', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 0, 0, 661620000, 330810000  FROM dual UNION ALL 
  select 'P1217', 'PL171', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 0, 0, 600000, 300000  FROM dual UNION ALL 
  select 'P1218', 'PL63', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 0, 0, 800000, 400000  FROM dual UNION ALL 
  select 'P1219', 'PL152', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 0, 0, 1200000, 600000  FROM dual UNION ALL 
  select 'P1220', 'PL114', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 0, 0, 2200000, 1100000  FROM dual UNION ALL 
  select 'P1221', 'PL15', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 0, 0, 1293200000, 646600000  FROM dual UNION ALL 
  select 'P1222', 'PL171', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 0, 0, 200000, 100000  FROM dual UNION ALL 
  select 'P1223', 'PL139', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 0, 0, 2100000, 1050000  FROM dual UNION ALL 
  select 'P1224', 'PL199', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 0, 0, 200000, 100000  FROM dual UNION ALL 
  select 'P1225', 'PL76', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 0, 0, 300000, 150000  FROM dual UNION ALL 
  select 'P1226', 'PL165', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 0, 0, 450000, 225000  FROM dual UNION ALL 
  select 'P1227', 'PL137', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 0, 0, 825000, 412500  FROM dual UNION ALL 
  select 'P1228', 'PL48', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 0, 0, 3950045000, 1975022500  FROM dual UNION ALL 
  select 'P1229', 'PL24', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 0, 0, 2080000, 1040000  FROM dual UNION ALL 
  select 'P1230', 'PL4', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 0, 0, 4174890000, 2087445000  FROM dual UNION ALL 
  select 'P1231', 'PL197', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 0, 0, 450000, 225000  FROM dual UNION ALL 
  select 'P1232', 'PL44', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 0, 0, 457270000, 228635000  FROM dual UNION ALL 
  select 'P1233', 'PL148', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 0, 0, 500000, 250000  FROM dual UNION ALL 
  select 'P1234', 'PL12', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 0, 0, 710324000, 355162000  FROM dual UNION ALL 
  select 'P1235', 'PL167', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 0, 0, 1475000, 737500  FROM dual UNION ALL 
  select 'P1236', 'PL198', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 0, 0, 550000, 275000  FROM dual UNION ALL 
  select 'P1237', 'PL107', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 0, 0, 350000, 175000  FROM dual UNION ALL 
  select 'P1238', 'PL93', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 0, 0, 500000, 250000  FROM dual UNION ALL 
  select 'P1239', 'PL113', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 0, 0, 600000, 300000  FROM dual UNION ALL 
  select 'P1240', 'PL39', TO_DATE('25/01/2020', 'DD/MM/YYYY'), 0, 0, 697680000, 348840000  FROM dual UNION ALL 
  select 'P1241', 'PL114', TO_DATE('25/01/2020', 'DD/MM/YYYY'), 0, 0, 850000, 425000  FROM dual UNION ALL 
  select 'P1242', 'PL10', TO_DATE('25/01/2020', 'DD/MM/YYYY'), 0, 0, 185384000, 92692000  FROM dual UNION ALL 
  select 'P1243', 'PL10', TO_DATE('25/01/2020', 'DD/MM/YYYY'), 0, 0, 340583000, 170291500  FROM dual UNION ALL 
  select 'P1244', 'PL103', TO_DATE('25/01/2020', 'DD/MM/YYYY'), 0, 0, 400000, 200000  FROM dual UNION ALL 
  select 'P1245', 'PL184', TO_DATE('25/01/2020', 'DD/MM/YYYY'), 0, 0, 1200000, 600000  FROM dual UNION ALL 
  select 'P1246', 'PL143', TO_DATE('25/01/2020', 'DD/MM/YYYY'), 0, 0, 650000, 325000  FROM dual UNION ALL 
  select 'P1247', 'PL198', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 0, 0, 400000, 200000  FROM dual UNION ALL 
  select 'P1248', 'PL78', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 0, 0, 850000, 425000  FROM dual UNION ALL 
  select 'P1249', 'PL75', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 0, 0, 50000, 25000  FROM dual UNION ALL 
  select 'P1250', 'PL20', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 0, 0, 920000, 460000  FROM dual UNION ALL 
  select 'P1251', 'PL115', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 0, 0, 550000, 0  FROM dual UNION ALL 
  select 'P1252', 'PL20', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 0, 0, 3420000, 0  FROM dual UNION ALL 
  select 'P1253', 'PL157', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 0, 0, 875000, 0  FROM dual UNION ALL 
  select 'P1254', 'PL184', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 0, 0, 2350000, 0  FROM dual UNION ALL 
  select 'P1255', 'PL185', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 0, 0, 500000, 0  FROM dual UNION ALL 
  select 'P1256', 'PL54', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 0, 0, 1784100000, 0  FROM dual UNION ALL 
  select 'P1257', 'PL14', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 0, 0, 362840000, 0  FROM dual UNION ALL 
  select 'P1258', 'PL27', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 0, 0, 3042980000, 0  FROM dual UNION ALL 
  select 'P1259', 'PL189', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 0, 0, 400000, 0  FROM dual UNION ALL 
  select 'P1260', 'PL5', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 0, 0, 7658765000, 0  FROM dual UNION ALL 
  select 'P1261', 'PL155', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 0, 0, 1400000, 0  FROM dual UNION ALL 
  select 'P1262', 'PL84', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 0, 0, 250000, 0  FROM dual UNION ALL 
  select 'P1263', 'PL57', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 0, 0, 3872000, 0  FROM dual UNION ALL 
  select 'P1264', 'PL54', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 0, 0, 463650000, 0  FROM dual UNION ALL 
  select 'P1265', 'PL109', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 0, 0, 800000, 0  FROM dual UNION ALL 
  select 'P1266', 'PL106', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 0, 0, 300000, 0  FROM dual UNION ALL 
  select 'P1267', 'PL85', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 0, 0, 1250000, 0  FROM dual UNION ALL 
  select 'P1268', 'PL98', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 0, 0, 2200000, 0  FROM dual UNION ALL 
  select 'P1269', 'PL113', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 0, 0, 250000, 0  FROM dual UNION ALL 
  select 'P1270', 'PL12', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 0, 0, 1825117500, 0  FROM dual UNION ALL 
  select 'P1271', 'PL175', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 0, 0, 3100000, 0  FROM dual UNION ALL 
  select 'P1272', 'PL110', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 0, 0, 200000, 0  FROM dual UNION ALL 
  select 'P1273', 'PL150', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 0, 0, 2150000, 0  FROM dual UNION ALL 
  select 'P1274', 'PL92', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 0, 0, 1200000, 0  FROM dual UNION ALL 
  select 'P1275', 'PL96', TO_DATE('30/01/2020', 'DD/MM/YYYY'), 0, 0, 400000, 0  FROM dual UNION ALL 
  select 'P1276', 'PL110', TO_DATE('30/01/2020', 'DD/MM/YYYY'), 0, 0, 1475000, 0  FROM dual UNION ALL 
  select 'P1277', 'PL30', TO_DATE('30/01/2020', 'DD/MM/YYYY'), 0, 0, 2484430000, 0  FROM dual UNION ALL 
  select 'P1278', 'PL191', TO_DATE('30/01/2020', 'DD/MM/YYYY'), 0, 0, 300000, 0  FROM dual UNION ALL 
  select 'P1279', 'PL24', TO_DATE('30/01/2020', 'DD/MM/YYYY'), 0, 0, 26300000, 0  FROM dual UNION ALL 
  select 'P1280', 'PL116', TO_DATE('30/01/2020', 'DD/MM/YYYY'), 0, 0, 700000, 0  FROM dual UNION ALL 
  select 'P1281', 'PL194', TO_DATE('30/01/2020', 'DD/MM/YYYY'), 0, 0, 1250000, 0  FROM dual UNION ALL 
  select 'P1282', 'PL29', TO_DATE('31/01/2020', 'DD/MM/YYYY'), 0, 0, 180080000, 0  FROM dual UNION ALL 
  select 'P1283', 'PL3', TO_DATE('31/01/2020', 'DD/MM/YYYY'), 0, 0, 587770000, 0  FROM dual UNION ALL 
  select 'P1284', 'PL156', TO_DATE('31/01/2020', 'DD/MM/YYYY'), 0, 0, 550000, 0  FROM dual UNION ALL 
  select 'P1285', 'PL138', TO_DATE('31/01/2020', 'DD/MM/YYYY'), 0, 0, 250000, 0  FROM dual UNION ALL 
  select 'P1286', 'PL189', TO_DATE('31/01/2020', 'DD/MM/YYYY'), 0, 0, 1250000, 0  FROM dual UNION ALL 
  select 'P1287', 'PL189', TO_DATE('31/01/2020', 'DD/MM/YYYY'), 0, 0, 900000, 0  FROM dual UNION ALL 
  select 'P1288', 'PL157', TO_DATE('31/01/2020', 'DD/MM/YYYY'), 0, 0, 50000, 0  FROM dual UNION ALL 
  select 'P1289', 'PL88', TO_DATE('01/02/2020', 'DD/MM/YYYY'), 0, 0, 350000, 0  FROM dual UNION ALL 
  select 'P1290', 'PL134', TO_DATE('01/02/2020', 'DD/MM/YYYY'), 0, 0, 750000, 0  FROM dual UNION ALL 
  select 'P1291', 'PL117', TO_DATE('01/02/2020', 'DD/MM/YYYY'), 0, 0, 600000, 0  FROM dual UNION ALL 
  select 'P1292', 'PL111', TO_DATE('01/02/2020', 'DD/MM/YYYY'), 0, 0, 525000, 0  FROM dual UNION ALL 
  select 'P1293', 'PL144', TO_DATE('01/02/2020', 'DD/MM/YYYY'), 0, 0, 2500000, 0  FROM dual UNION ALL 
  select 'P1294', 'PL200', TO_DATE('01/02/2020', 'DD/MM/YYYY'), 0, 0, 500000, 0  FROM dual UNION ALL 
  select 'P1295', 'PL198', TO_DATE('01/02/2020', 'DD/MM/YYYY'), 0, 0, 525000, 0  FROM dual UNION ALL 
  select 'P1296', 'PL95', TO_DATE('02/02/2020', 'DD/MM/YYYY'), 0, 0, 600000, 0  FROM dual UNION ALL 
  select 'P1297', 'PL54', TO_DATE('02/02/2020', 'DD/MM/YYYY'), 0, 0, 506903000, 0  FROM dual UNION ALL 
  select 'P1298', 'PL30', TO_DATE('02/02/2020', 'DD/MM/YYYY'), 0, 0, 1919460000, 0  FROM dual UNION ALL 
  select 'P1299', 'PL48', TO_DATE('02/02/2020', 'DD/MM/YYYY'), 0, 0, 5053155000, 0  FROM dual UNION ALL 
  select 'P1300', 'PL135', TO_DATE('02/02/2020', 'DD/MM/YYYY'), 0, 0, 1500000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B8', 'P1', 26, 20000000, 0  FROM dual UNION ALL 
  select 'B36', 'P1', 25, 500000, 0  FROM dual UNION ALL 
  select 'B6', 'P1', 23, 6000000, 0  FROM dual UNION ALL 
  select 'B38', 'P1', 30, 250000, 0  FROM dual UNION ALL 
  select 'B8', 'P1', 24, 20000000, 0  FROM dual UNION ALL 
  select 'B41', 'P2', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B36', 'P3', 1, 500000, 0  FROM dual UNION ALL 
  select 'B36', 'P4', 1, 500000, 0  FROM dual UNION ALL 
  select 'B25', 'P5', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B32', 'P6', 20, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P6', 16, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P6', 19, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P6', 17, 850000, 0  FROM dual UNION ALL 
  select 'B43', 'P7', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P8', 1, 400000, 0  FROM dual UNION ALL 
  select 'B24', 'P9', 10, 475000, 0  FROM dual UNION ALL 
  select 'B26', 'P9', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B21', 'P9', 12, 1200000, 0  FROM dual UNION ALL 
  select 'B41', 'P9', 12, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P9', 14, 350000, 0  FROM dual UNION ALL 
  select 'B6', 'P9', 18, 6000000, 0  FROM dual UNION ALL 
  select 'B14', 'P9', 17, 4000, 0  FROM dual UNION ALL 
  select 'B30', 'P9', 10, 100000, 0  FROM dual UNION ALL 
  select 'B40', 'P9', 15, 400000, 0  FROM dual UNION ALL 
  select 'B37', 'P10', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P11', 1, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P12', 1, 450000, 0  FROM dual UNION ALL 
  select 'B36', 'P12', 1, 500000, 0  FROM dual UNION ALL 
  select 'B36', 'P13', 1, 500000, 0  FROM dual UNION ALL 
  select 'B19', 'P13', 1, 300000, 0  FROM dual UNION ALL 
  select 'B38', 'P14', 1, 250000, 0  FROM dual UNION ALL 
  select 'B37', 'P15', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P15', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P16', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P16', 1, 200000, 0  FROM dual UNION ALL 
  select 'B8', 'P17', 22, 20000000, 0  FROM dual UNION ALL 
  select 'B29', 'P17', 19, 850000, 0  FROM dual UNION ALL 
  select 'B33', 'P17', 15, 10000, 0  FROM dual UNION ALL 
  select 'B43', 'P18', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P19', 1, 400000, 0  FROM dual UNION ALL 
  select 'B37', 'P20', 1, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P20', 1, 400000, 0  FROM dual UNION ALL 
  select 'B25', 'P21', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P21', 1, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P22', 1, 450000, 0  FROM dual UNION ALL 
  select 'B41', 'P22', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B26', 'P23', 15, 100000000, 0  FROM dual UNION ALL 
  select 'B4', 'P23', 20, 3100000, 0  FROM dual UNION ALL 
  select 'B7', 'P23', 12, 12000000, 0  FROM dual UNION ALL 
  select 'B38', 'P23', 10, 250000, 0  FROM dual UNION ALL 
  select 'B9', 'P23', 10, 25000000, 0  FROM dual UNION ALL 
  select 'B30', 'P23', 11, 100000, 0  FROM dual UNION ALL 
  select 'B26', 'P23', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B20', 'P23', 18, 350000, 0  FROM dual UNION ALL 
  select 'B9', 'P24', 14, 25000000, 0  FROM dual UNION ALL 
  select 'B16', 'P24', 11, 4000, 0  FROM dual UNION ALL 
  select 'B3', 'P24', 11, 20000000, 0  FROM dual UNION ALL 
  select 'B15', 'P24', 11, 4000, 0  FROM dual UNION ALL 
  select 'B34', 'P24', 19, 20000, 0  FROM dual UNION ALL 
  select 'B33', 'P24', 13, 10000, 0  FROM dual UNION ALL 
  select 'B14', 'P24', 11, 4000, 0  FROM dual UNION ALL 
  select 'B8', 'P24', 13, 20000000, 0  FROM dual UNION ALL 
  select 'B28', 'P24', 19, 250000000, 0  FROM dual UNION ALL 
  select 'B20', 'P24', 12, 350000, 0  FROM dual UNION ALL 
  select 'B37', 'P25', 1, 50000, 0  FROM dual UNION ALL 
  select 'B23', 'P25', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B40', 'P26', 1, 400000, 0  FROM dual UNION ALL 
  select 'B26', 'P27', 20, 100000000, 0  FROM dual UNION ALL 
  select 'B3', 'P27', 11, 20000000, 0  FROM dual UNION ALL 
  select 'B19', 'P27', 16, 300000, 0  FROM dual UNION ALL 
  select 'B34', 'P27', 20, 20000, 0  FROM dual UNION ALL 
  select 'B22', 'P27', 20, 2100000, 0  FROM dual UNION ALL 
  select 'B36', 'P27', 19, 500000, 0  FROM dual UNION ALL 
  select 'B4', 'P27', 16, 3100000, 0  FROM dual UNION ALL 
  select 'B8', 'P27', 17, 20000000, 0  FROM dual UNION ALL 
  select 'B24', 'P27', 12, 475000, 0  FROM dual UNION ALL 
  select 'B7', 'P27', 14, 12000000, 0  FROM dual UNION ALL 
  select 'B42', 'P28', 1, 50000, 0  FROM dual UNION ALL 
  select 'B24', 'P28', 1, 475000, 0  FROM dual UNION ALL 
  select 'B19', 'P29', 1, 300000, 0  FROM dual UNION ALL 
  select 'B39', 'P29', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P30', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P30', 1, 500000, 0  FROM dual UNION ALL 
  select 'B38', 'P31', 1, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P32', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P32', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P33', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B9', 'P34', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B9', 'P34', 10, 25000000, 0  FROM dual UNION ALL 
  select 'B28', 'P34', 17, 250000000, 0  FROM dual UNION ALL 
  select 'B11', 'P34', 11, 40000, 0  FROM dual UNION ALL 
  select 'B12', 'P34', 12, 40000, 0  FROM dual UNION ALL 
  select 'B22', 'P34', 13, 2100000, 0  FROM dual UNION ALL 
  select 'B23', 'P34', 16, 3000000, 0  FROM dual UNION ALL 
  select 'B35', 'P34', 12, 20000, 0  FROM dual UNION ALL 
  select 'B19', 'P34', 13, 300000, 0  FROM dual UNION ALL 
  select 'B17', 'P34', 13, 350000, 0  FROM dual UNION ALL 
  select 'B29', 'P35', 20, 850000, 0  FROM dual UNION ALL 
  select 'B22', 'P35', 16, 2100000, 0  FROM dual UNION ALL 
  select 'B12', 'P35', 15, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P35', 19, 450000, 0  FROM dual UNION ALL 
  select 'B33', 'P35', 20, 10000, 0  FROM dual UNION ALL 
  select 'B43', 'P36', 1, 200000, 0  FROM dual UNION ALL 
  select 'B39', 'P37', 13, 250000, 0  FROM dual UNION ALL 
  select 'B35', 'P37', 19, 20000, 0  FROM dual UNION ALL 
  select 'B38', 'P37', 12, 250000, 0  FROM dual UNION ALL 
  select 'B10', 'P37', 20, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P37', 17, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P37', 19, 200000, 0  FROM dual UNION ALL 
  select 'B18', 'P38', 1, 450000, 0  FROM dual UNION ALL 
  select 'B17', 'P38', 1, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P39', 11, 50000, 0  FROM dual UNION ALL 
  select 'B33', 'P39', 18, 10000, 0  FROM dual UNION ALL 
  select 'B18', 'P39', 16, 450000, 0  FROM dual UNION ALL 
  select 'B37', 'P39', 15, 50000, 0  FROM dual UNION ALL 
  select 'B30', 'P39', 17, 100000, 0  FROM dual UNION ALL 
  select 'B11', 'P39', 10, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P39', 15, 450000, 0  FROM dual UNION ALL 
  select 'B13', 'P39', 11, 40000, 0  FROM dual UNION ALL 
  select 'B35', 'P39', 18, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P39', 19, 100000, 0  FROM dual UNION ALL 
  select 'B19', 'P40', 1, 300000, 0  FROM dual UNION ALL 
  select 'B25', 'P40', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B33', 'P41', 18, 10000, 0  FROM dual UNION ALL 
  select 'B31', 'P41', 18, 80000, 0  FROM dual UNION ALL 
  select 'B37', 'P41', 15, 50000, 0  FROM dual UNION ALL 
  select 'B5', 'P41', 14, 40000, 0  FROM dual UNION ALL 
  select 'B32', 'P41', 10, 20000, 0  FROM dual UNION ALL 
  select 'B8', 'P41', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B23', 'P41', 18, 3000000, 0  FROM dual UNION ALL 
  select 'B25', 'P41', 17, 1000000, 0  FROM dual UNION ALL 
  select 'B28', 'P41', 18, 250000000, 0  FROM dual UNION ALL 
  select 'B10', 'P41', 12, 40000, 0  FROM dual UNION ALL 
  select 'B15', 'P42', 14, 4000, 0  FROM dual UNION ALL 
  select 'B20', 'P42', 10, 350000, 0  FROM dual UNION ALL 
  select 'B3', 'P42', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B14', 'P42', 19, 4000, 0  FROM dual UNION ALL 
  select 'B33', 'P42', 20, 10000, 0  FROM dual UNION ALL 
  select 'B11', 'P42', 13, 40000, 0  FROM dual UNION ALL 
  select 'B30', 'P42', 19, 100000, 0  FROM dual UNION ALL 
  select 'B4', 'P42', 16, 3100000, 0  FROM dual UNION ALL 
  select 'B17', 'P42', 16, 350000, 0  FROM dual UNION ALL 
  select 'B34', 'P42', 13, 20000, 0  FROM dual UNION ALL 
  select 'B41', 'P43', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B13', 'P44', 10, 40000, 0  FROM dual UNION ALL 
  select 'B30', 'P44', 11, 100000, 0  FROM dual UNION ALL 
  select 'B11', 'P44', 18, 40000, 0  FROM dual UNION ALL 
  select 'B8', 'P44', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B41', 'P44', 10, 1000000, 0  FROM dual UNION ALL 
  select 'B12', 'P45', 20, 40000, 0  FROM dual UNION ALL 
  select 'B26', 'P45', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B38', 'P45', 10, 250000, 0  FROM dual UNION ALL 
  select 'B35', 'P45', 18, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P45', 19, 20000, 0  FROM dual UNION ALL 
  select 'B7', 'P45', 14, 12000000, 0  FROM dual UNION ALL 
  select 'B13', 'P45', 14, 40000, 0  FROM dual UNION ALL 
  select 'B41', 'P45', 20, 1000000, 0  FROM dual UNION ALL 
  select 'B26', 'P46', 26, 100000000, 0  FROM dual UNION ALL 
  select 'B2', 'P46', 27, 3025000, 0  FROM dual UNION ALL 
  select 'B15', 'P46', 18, 4000, 0  FROM dual UNION ALL 
  select 'B17', 'P47', 1, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P47', 1, 500000, 0  FROM dual UNION ALL 
  select 'B23', 'P48', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B43', 'P49', 1, 200000, 0  FROM dual UNION ALL 
  select 'B21', 'P50', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B21', 'P51', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B42', 'P51', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P52', 1, 50000, 0  FROM dual UNION ALL 
  select 'B26', 'P53', 10, 100000000, 0  FROM dual UNION ALL 
  select 'B9', 'P53', 13, 25000000, 0  FROM dual UNION ALL 
  select 'B5', 'P53', 15, 40000, 0  FROM dual UNION ALL 
  select 'B33', 'P53', 11, 10000, 0  FROM dual UNION ALL 
  select 'B30', 'P53', 11, 100000, 0  FROM dual UNION ALL 
  select 'B30', 'P53', 14, 100000, 0  FROM dual UNION ALL 
  select 'B19', 'P54', 1, 300000, 0  FROM dual UNION ALL 
  select 'B17', 'P54', 1, 350000, 0  FROM dual UNION ALL 
  select 'B19', 'P55', 1, 300000, 0  FROM dual UNION ALL 
  select 'B39', 'P56', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P56', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P57', 1, 500000, 0  FROM dual UNION ALL 
  select 'B39', 'P57', 1, 250000, 0  FROM dual UNION ALL 
  select 'B24', 'P58', 12, 475000, 0  FROM dual UNION ALL 
  select 'B31', 'P58', 13, 80000, 0  FROM dual UNION ALL 
  select 'B3', 'P58', 11, 20000000, 0  FROM dual UNION ALL 
  select 'B32', 'P58', 13, 20000, 0  FROM dual UNION ALL 
  select 'B11', 'P58', 11, 40000, 0  FROM dual UNION ALL 
  select 'B23', 'P58', 10, 3000000, 0  FROM dual UNION ALL 
  select 'B4', 'P58', 10, 3100000, 0  FROM dual UNION ALL 
  select 'B12', 'P59', 20, 40000, 0  FROM dual UNION ALL 
  select 'B41', 'P59', 15, 1000000, 0  FROM dual UNION ALL 
  select 'B26', 'P59', 19, 100000000, 0  FROM dual UNION ALL 
  select 'B20', 'P59', 17, 350000, 0  FROM dual UNION ALL 
  select 'B22', 'P59', 15, 2100000, 0  FROM dual UNION ALL 
  select 'B12', 'P59', 11, 40000, 0  FROM dual UNION ALL 
  select 'B13', 'P59', 10, 40000, 0  FROM dual UNION ALL 
  select 'B25', 'P60', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P60', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P61', 1, 50000, 0  FROM dual UNION ALL 
  select 'B22', 'P61', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B38', 'P62', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P62', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P63', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P64', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P64', 1, 475000, 0  FROM dual UNION ALL 
  select 'B17', 'P65', 1, 350000, 0  FROM dual UNION ALL 
  select 'B39', 'P66', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P66', 1, 200000, 0  FROM dual UNION ALL 
  select 'B21', 'P67', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B43', 'P67', 1, 200000, 0  FROM dual UNION ALL 
  select 'B41', 'P68', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P69', 20, 475000, 0  FROM dual UNION ALL 
  select 'B4', 'P69', 15, 3100000, 0  FROM dual UNION ALL 
  select 'B16', 'P69', 22, 4000, 0  FROM dual UNION ALL 
  select 'B43', 'P69', 21, 200000, 0  FROM dual UNION ALL 
  select 'B10', 'P69', 25, 40000, 0  FROM dual UNION ALL 
  select 'B9', 'P69', 24, 25000000, 0  FROM dual UNION ALL 
  select 'B36', 'P70', 1, 500000, 0  FROM dual UNION ALL 
  select 'B38', 'P71', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P72', 1, 400000, 0  FROM dual UNION ALL 
  select 'B25', 'P72', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P73', 1, 50000, 0  FROM dual UNION ALL 
  select 'B23', 'P73', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B27', 'P74', 15, 40000000, 0  FROM dual UNION ALL 
  select 'B36', 'P74', 18, 500000, 0  FROM dual UNION ALL 
  select 'B35', 'P74', 13, 20000, 0  FROM dual UNION ALL 
  select 'B9', 'P74', 12, 25000000, 0  FROM dual UNION ALL 
  select 'B40', 'P74', 12, 400000, 0  FROM dual UNION ALL 
  select 'B35', 'P74', 13, 20000, 0  FROM dual UNION ALL 
  select 'B41', 'P75', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P76', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P76', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P77', 1, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P77', 1, 250000, 0  FROM dual UNION ALL 
  select 'B23', 'P78', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B39', 'P79', 12, 250000, 0  FROM dual UNION ALL 
  select 'B10', 'P79', 12, 40000, 0  FROM dual UNION ALL 
  select 'B5', 'P79', 15, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P79', 12, 450000, 0  FROM dual UNION ALL 
  select 'B30', 'P79', 16, 100000, 0  FROM dual UNION ALL 
  select 'B15', 'P79', 11, 4000, 0  FROM dual UNION ALL 
  select 'B42', 'P79', 10, 50000, 0  FROM dual UNION ALL 
  select 'B31', 'P79', 13, 80000, 0  FROM dual UNION ALL 
  select 'B25', 'P80', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B36', 'P80', 1, 500000, 0  FROM dual UNION ALL 
  select 'B42', 'P81', 12, 50000, 0  FROM dual UNION ALL 
  select 'B35', 'P81', 19, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P81', 16, 100000, 0  FROM dual UNION ALL 
  select 'B16', 'P81', 15, 4000, 0  FROM dual UNION ALL 
  select 'B15', 'P81', 16, 4000, 0  FROM dual UNION ALL 
  select 'B6', 'P81', 13, 6000000, 0  FROM dual UNION ALL 
  select 'B16', 'P81', 15, 4000, 0  FROM dual UNION ALL 
  select 'B34', 'P81', 11, 20000, 0  FROM dual UNION ALL 
  select 'B16', 'P81', 20, 4000, 0  FROM dual UNION ALL 
  select 'B5', 'P82', 14, 40000, 0  FROM dual UNION ALL 
  select 'B36', 'P82', 11, 500000, 0  FROM dual UNION ALL 
  select 'B29', 'P82', 10, 850000, 0  FROM dual UNION ALL 
  select 'B41', 'P82', 11, 1000000, 0  FROM dual UNION ALL 
  select 'B36', 'P82', 16, 500000, 0  FROM dual UNION ALL 
  select 'B33', 'P82', 10, 10000, 0  FROM dual UNION ALL 
  select 'B34', 'P82', 11, 20000, 0  FROM dual UNION ALL 
  select 'B12', 'P82', 15, 40000, 0  FROM dual UNION ALL 
  select 'B38', 'P82', 12, 250000, 0  FROM dual UNION ALL 
  select 'B14', 'P83', 13, 4000, 0  FROM dual UNION ALL 
  select 'B31', 'P83', 13, 80000, 0  FROM dual UNION ALL 
  select 'B13', 'P83', 12, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P83', 12, 6000000, 0  FROM dual UNION ALL 
  select 'B2', 'P83', 13, 3025000, 0  FROM dual UNION ALL 
  select 'B12', 'P83', 13, 40000, 0  FROM dual UNION ALL 
  select 'B21', 'P83', 19, 1200000, 0  FROM dual UNION ALL 
  select 'B30', 'P83', 17, 100000, 0  FROM dual UNION ALL 
  select 'B30', 'P83', 20, 100000, 0  FROM dual UNION ALL 
  select 'B10', 'P83', 19, 40000, 0  FROM dual UNION ALL 
  select 'B34', 'P84', 18, 20000, 0  FROM dual UNION ALL 
  select 'B27', 'P84', 15, 40000000, 0  FROM dual UNION ALL 
  select 'B41', 'P84', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B33', 'P84', 10, 10000, 0  FROM dual UNION ALL 
  select 'B31', 'P84', 11, 80000, 0  FROM dual UNION ALL 
  select 'B27', 'P84', 16, 40000000, 0  FROM dual UNION ALL 
  select 'B5', 'P84', 10, 40000, 0  FROM dual UNION ALL 
  select 'B33', 'P84', 17, 10000, 0  FROM dual UNION ALL 
  select 'B2', 'P84', 20, 3025000, 0  FROM dual UNION ALL 
  select 'B17', 'P84', 11, 350000, 0  FROM dual UNION ALL 
  select 'B18', 'P85', 1, 450000, 0  FROM dual UNION ALL 
  select 'B41', 'P86', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P87', 1, 250000, 0  FROM dual UNION ALL 
  select 'B37', 'P87', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P88', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P88', 1, 400000, 0  FROM dual UNION ALL 
  select 'B21', 'P89', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B42', 'P89', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P90', 29, 50000, 0  FROM dual UNION ALL 
  select 'B34', 'P90', 19, 20000, 0  FROM dual UNION ALL 
  select 'B2', 'P90', 27, 3025000, 0  FROM dual UNION ALL 
  select 'B36', 'P91', 1, 500000, 0  FROM dual UNION ALL 
  select 'B21', 'P91', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B17', 'P92', 1, 350000, 0  FROM dual UNION ALL 
  select 'B25', 'P92', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B30', 'P93', 16, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P93', 11, 20000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B31', 'P93', 19, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P93', 12, 100000, 0  FROM dual UNION ALL 
  select 'B32', 'P93', 10, 20000, 0  FROM dual UNION ALL 
  select 'B39', 'P94', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P94', 1, 50000, 0  FROM dual UNION ALL 
  select 'B25', 'P95', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P96', 1, 50000, 0  FROM dual UNION ALL 
  select 'B21', 'P96', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B24', 'P97', 1, 475000, 0  FROM dual UNION ALL 
  select 'B42', 'P97', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P98', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B41', 'P98', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B41', 'P99', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P99', 1, 475000, 0  FROM dual UNION ALL 
  select 'B37', 'P100', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P100', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P101', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P102', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P103', 1, 500000, 0  FROM dual UNION ALL 
  select 'B40', 'P103', 1, 400000, 0  FROM dual UNION ALL 
  select 'B17', 'P104', 1, 350000, 0  FROM dual UNION ALL 
  select 'B24', 'P104', 1, 475000, 0  FROM dual UNION ALL 
  select 'B42', 'P105', 1, 50000, 0  FROM dual UNION ALL 
  select 'B17', 'P105', 1, 350000, 0  FROM dual UNION ALL 
  select 'B32', 'P106', 20, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P106', 11, 100000, 0  FROM dual UNION ALL 
  select 'B12', 'P106', 13, 40000, 0  FROM dual UNION ALL 
  select 'B3', 'P106', 11, 20000000, 0  FROM dual UNION ALL 
  select 'B20', 'P106', 17, 350000, 0  FROM dual UNION ALL 
  select 'B34', 'P106', 12, 20000, 0  FROM dual UNION ALL 
  select 'B41', 'P106', 19, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P106', 15, 50000, 0  FROM dual UNION ALL 
  select 'B5', 'P106', 12, 40000, 0  FROM dual UNION ALL 
  select 'B28', 'P107', 13, 250000000, 0  FROM dual UNION ALL 
  select 'B22', 'P107', 12, 2100000, 0  FROM dual UNION ALL 
  select 'B30', 'P107', 10, 100000, 0  FROM dual UNION ALL 
  select 'B2', 'P107', 17, 3025000, 0  FROM dual UNION ALL 
  select 'B34', 'P107', 13, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P107', 13, 100000, 0  FROM dual UNION ALL 
  select 'B38', 'P108', 1, 250000, 0  FROM dual UNION ALL 
  select 'B20', 'P108', 1, 350000, 0  FROM dual UNION ALL 
  select 'B21', 'P109', 12, 1200000, 0  FROM dual UNION ALL 
  select 'B2', 'P109', 16, 3025000, 0  FROM dual UNION ALL 
  select 'B35', 'P109', 12, 20000, 0  FROM dual UNION ALL 
  select 'B4', 'P109', 16, 3100000, 0  FROM dual UNION ALL 
  select 'B9', 'P109', 11, 25000000, 0  FROM dual UNION ALL 
  select 'B32', 'P109', 19, 20000, 0  FROM dual UNION ALL 
  select 'B12', 'P109', 15, 40000, 0  FROM dual UNION ALL 
  select 'B19', 'P109', 19, 300000, 0  FROM dual UNION ALL 
  select 'B39', 'P110', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P110', 1, 500000, 0  FROM dual UNION ALL 
  select 'B41', 'P111', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B41', 'P111', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B23', 'P112', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B20', 'P112', 1, 350000, 0  FROM dual UNION ALL 
  select 'B14', 'P113', 29, 4000, 0  FROM dual UNION ALL 
  select 'B6', 'P113', 21, 6000000, 0  FROM dual UNION ALL 
  select 'B25', 'P113', 20, 1000000, 0  FROM dual UNION ALL 
  select 'B14', 'P113', 20, 4000, 0  FROM dual UNION ALL 
  select 'B10', 'P113', 18, 40000, 0  FROM dual UNION ALL 
  select 'B35', 'P113', 23, 20000, 0  FROM dual UNION ALL 
  select 'B42', 'P113', 20, 50000, 0  FROM dual UNION ALL 
  select 'B30', 'P113', 19, 100000, 0  FROM dual UNION ALL 
  select 'B36', 'P114', 1, 500000, 0  FROM dual UNION ALL 
  select 'B20', 'P114', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P115', 1, 400000, 0  FROM dual UNION ALL 
  select 'B39', 'P115', 1, 250000, 0  FROM dual UNION ALL 
  select 'B30', 'P116', 19, 100000, 0  FROM dual UNION ALL 
  select 'B30', 'P116', 19, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P116', 13, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P116', 12, 20000, 0  FROM dual UNION ALL 
  select 'B41', 'P117', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B33', 'P118', 16, 10000, 0  FROM dual UNION ALL 
  select 'B29', 'P118', 17, 850000, 0  FROM dual UNION ALL 
  select 'B17', 'P118', 19, 350000, 0  FROM dual UNION ALL 
  select 'B14', 'P118', 10, 4000, 0  FROM dual UNION ALL 
  select 'B20', 'P118', 20, 350000, 0  FROM dual UNION ALL 
  select 'B22', 'P118', 15, 2100000, 0  FROM dual UNION ALL 
  select 'B22', 'P118', 16, 2100000, 0  FROM dual UNION ALL 
  select 'B26', 'P118', 15, 100000000, 0  FROM dual UNION ALL 
  select 'B39', 'P118', 10, 250000, 0  FROM dual UNION ALL 
  select 'B37', 'P119', 1, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P119', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P120', 1, 500000, 0  FROM dual UNION ALL 
  select 'B42', 'P121', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P121', 1, 500000, 0  FROM dual UNION ALL 
  select 'B5', 'P122', 27, 40000, 0  FROM dual UNION ALL 
  select 'B4', 'P122', 28, 3100000, 0  FROM dual UNION ALL 
  select 'B20', 'P122', 24, 350000, 0  FROM dual UNION ALL 
  select 'B18', 'P122', 30, 450000, 0  FROM dual UNION ALL 
  select 'B26', 'P122', 23, 100000000, 0  FROM dual UNION ALL 
  select 'B39', 'P123', 11, 250000, 0  FROM dual UNION ALL 
  select 'B34', 'P123', 12, 20000, 0  FROM dual UNION ALL 
  select 'B25', 'P123', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B36', 'P123', 10, 500000, 0  FROM dual UNION ALL 
  select 'B25', 'P123', 19, 1000000, 0  FROM dual UNION ALL 
  select 'B35', 'P123', 16, 20000, 0  FROM dual UNION ALL 
  select 'B36', 'P124', 1, 500000, 0  FROM dual UNION ALL 
  select 'B36', 'P124', 1, 500000, 0  FROM dual UNION ALL 
  select 'B25', 'P125', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P125', 1, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P126', 1, 450000, 0  FROM dual UNION ALL 
  select 'B30', 'P127', 12, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P127', 16, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P127', 13, 80000, 0  FROM dual UNION ALL 
  select 'B35', 'P127', 10, 20000, 0  FROM dual UNION ALL 
  select 'B18', 'P128', 1, 450000, 0  FROM dual UNION ALL 
  select 'B23', 'P128', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B21', 'P129', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B25', 'P129', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B22', 'P130', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B32', 'P131', 16, 20000, 0  FROM dual UNION ALL 
  select 'B28', 'P131', 20, 250000000, 0  FROM dual UNION ALL 
  select 'B9', 'P131', 15, 25000000, 0  FROM dual UNION ALL 
  select 'B9', 'P131', 12, 25000000, 0  FROM dual UNION ALL 
  select 'B16', 'P131', 20, 4000, 0  FROM dual UNION ALL 
  select 'B25', 'P131', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B22', 'P131', 20, 2100000, 0  FROM dual UNION ALL 
  select 'B7', 'P131', 20, 12000000, 0  FROM dual UNION ALL 
  select 'B43', 'P132', 1, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P133', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P134', 1, 50000, 0  FROM dual UNION ALL 
  select 'B31', 'P135', 19, 80000, 0  FROM dual UNION ALL 
  select 'B33', 'P135', 20, 10000, 0  FROM dual UNION ALL 
  select 'B25', 'P135', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P135', 10, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P135', 11, 50000, 0  FROM dual UNION ALL 
  select 'B11', 'P135', 16, 40000, 0  FROM dual UNION ALL 
  select 'B20', 'P135', 20, 350000, 0  FROM dual UNION ALL 
  select 'B39', 'P135', 14, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P135', 11, 2100000, 0  FROM dual UNION ALL 
  select 'B39', 'P136', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P137', 1, 400000, 0  FROM dual UNION ALL 
  select 'B38', 'P137', 1, 250000, 0  FROM dual UNION ALL 
  select 'B16', 'P138', 12, 4000, 0  FROM dual UNION ALL 
  select 'B8', 'P138', 13, 20000000, 0  FROM dual UNION ALL 
  select 'B2', 'P138', 12, 3025000, 0  FROM dual UNION ALL 
  select 'B16', 'P138', 14, 4000, 0  FROM dual UNION ALL 
  select 'B15', 'P138', 14, 4000, 0  FROM dual UNION ALL 
  select 'B4', 'P138', 14, 3100000, 0  FROM dual UNION ALL 
  select 'B2', 'P138', 13, 3025000, 0  FROM dual UNION ALL 
  select 'B37', 'P138', 10, 50000, 0  FROM dual UNION ALL 
  select 'B35', 'P138', 11, 20000, 0  FROM dual UNION ALL 
  select 'B27', 'P138', 17, 40000000, 0  FROM dual UNION ALL 
  select 'B20', 'P139', 1, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P140', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P141', 1, 200000, 0  FROM dual UNION ALL 
  select 'B37', 'P141', 1, 50000, 0  FROM dual UNION ALL 
  select 'B25', 'P142', 28, 1000000, 0  FROM dual UNION ALL 
  select 'B21', 'P142', 29, 1200000, 0  FROM dual UNION ALL 
  select 'B17', 'P142', 29, 350000, 0  FROM dual UNION ALL 
  select 'B22', 'P142', 19, 2100000, 0  FROM dual UNION ALL 
  select 'B16', 'P142', 26, 4000, 0  FROM dual UNION ALL 
  select 'B43', 'P143', 1, 200000, 0  FROM dual UNION ALL 
  select 'B17', 'P144', 1, 350000, 0  FROM dual UNION ALL 
  select 'B2', 'P145', 16, 3025000, 0  FROM dual UNION ALL 
  select 'B41', 'P145', 20, 1000000, 0  FROM dual UNION ALL 
  select 'B18', 'P145', 19, 450000, 0  FROM dual UNION ALL 
  select 'B7', 'P145', 12, 12000000, 0  FROM dual UNION ALL 
  select 'B15', 'P145', 20, 4000, 0  FROM dual UNION ALL 
  select 'B3', 'P145', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B43', 'P145', 14, 200000, 0  FROM dual UNION ALL 
  select 'B9', 'P145', 20, 25000000, 0  FROM dual UNION ALL 
  select 'B16', 'P145', 20, 4000, 0  FROM dual UNION ALL 
  select 'B11', 'P146', 17, 40000, 0  FROM dual UNION ALL 
  select 'B25', 'P146', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B14', 'P146', 15, 4000, 0  FROM dual UNION ALL 
  select 'B39', 'P146', 13, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P146', 19, 2100000, 0  FROM dual UNION ALL 
  select 'B29', 'P146', 16, 850000, 0  FROM dual UNION ALL 
  select 'B37', 'P146', 16, 50000, 0  FROM dual UNION ALL 
  select 'B2', 'P146', 20, 3025000, 0  FROM dual UNION ALL 
  select 'B26', 'P146', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B24', 'P146', 12, 475000, 0  FROM dual UNION ALL 
  select 'B25', 'P147', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B20', 'P148', 25, 350000, 0  FROM dual UNION ALL 
  select 'B15', 'P148', 23, 4000, 0  FROM dual UNION ALL 
  select 'B28', 'P148', 23, 250000000, 0  FROM dual UNION ALL 
  select 'B40', 'P148', 27, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P149', 1, 500000, 0  FROM dual UNION ALL 
  select 'B20', 'P149', 1, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P150', 1, 50000, 0  FROM dual UNION ALL 
  select 'B20', 'P151', 1, 350000, 0  FROM dual UNION ALL 
  select 'B37', 'P151', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P152', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P153', 1, 500000, 0  FROM dual UNION ALL 
  select 'B40', 'P154', 1, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P155', 1, 400000, 0  FROM dual UNION ALL 
  select 'B39', 'P155', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P156', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B12', 'P157', 15, 40000, 0  FROM dual UNION ALL 
  select 'B16', 'P157', 17, 4000, 0  FROM dual UNION ALL 
  select 'B32', 'P157', 12, 20000, 0  FROM dual UNION ALL 
  select 'B22', 'P157', 15, 2100000, 0  FROM dual UNION ALL 
  select 'B40', 'P157', 12, 400000, 0  FROM dual UNION ALL 
  select 'B14', 'P157', 18, 4000, 0  FROM dual UNION ALL 
  select 'B18', 'P157', 10, 450000, 0  FROM dual UNION ALL 
  select 'B41', 'P158', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P158', 1, 475000, 0  FROM dual UNION ALL 
  select 'B41', 'P159', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P160', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P161', 1, 250000, 0  FROM dual UNION ALL 
  select 'B4', 'P162', 17, 3100000, 0  FROM dual UNION ALL 
  select 'B39', 'P162', 15, 250000, 0  FROM dual UNION ALL 
  select 'B4', 'P162', 12, 3100000, 0  FROM dual UNION ALL 
  select 'B43', 'P162', 15, 200000, 0  FROM dual UNION ALL 
  select 'B37', 'P162', 20, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P162', 20, 400000, 0  FROM dual UNION ALL 
  select 'B17', 'P162', 13, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P162', 17, 200000, 0  FROM dual UNION ALL 
  select 'B43', 'P163', 1, 200000, 0  FROM dual UNION ALL 
  select 'B22', 'P163', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B29', 'P164', 17, 850000, 0  FROM dual UNION ALL 
  select 'B27', 'P164', 13, 40000000, 0  FROM dual UNION ALL 
  select 'B22', 'P164', 13, 2100000, 0  FROM dual UNION ALL 
  select 'B36', 'P164', 14, 500000, 0  FROM dual UNION ALL 
  select 'B27', 'P164', 18, 40000000, 0  FROM dual UNION ALL 
  select 'B39', 'P165', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P166', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P166', 1, 50000, 0  FROM dual UNION ALL 
  select 'B29', 'P167', 13, 850000, 0  FROM dual UNION ALL 
  select 'B35', 'P167', 15, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P167', 12, 850000, 0  FROM dual UNION ALL 
  select 'B30', 'P167', 20, 100000, 0  FROM dual UNION ALL 
  select 'B43', 'P168', 1, 200000, 0  FROM dual UNION ALL 
  select 'B25', 'P169', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B20', 'P169', 1, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P170', 1, 50000, 0  FROM dual UNION ALL 
  select 'B35', 'P171', 13, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P171', 14, 850000, 0  FROM dual UNION ALL 
  select 'B30', 'P171', 14, 100000, 0  FROM dual UNION ALL 
  select 'B30', 'P171', 20, 100000, 0  FROM dual UNION ALL 
  select 'B29', 'P171', 14, 850000, 0  FROM dual UNION ALL 
  select 'B42', 'P172', 19, 50000, 0  FROM dual UNION ALL 
  select 'B4', 'P172', 12, 3100000, 0  FROM dual UNION ALL 
  select 'B25', 'P172', 12, 1000000, 0  FROM dual UNION ALL 
  select 'B19', 'P172', 19, 300000, 0  FROM dual UNION ALL 
  select 'B17', 'P172', 10, 350000, 0  FROM dual UNION ALL 
  select 'B20', 'P173', 1, 350000, 0  FROM dual UNION ALL 
  select 'B22', 'P174', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B37', 'P175', 1, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P175', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P176', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P176', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P177', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P178', 1, 500000, 0  FROM dual UNION ALL 
  select 'B22', 'P178', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B33', 'P179', 20, 10000, 0  FROM dual UNION ALL 
  select 'B28', 'P179', 16, 250000000, 0  FROM dual UNION ALL 
  select 'B40', 'P179', 28, 400000, 0  FROM dual UNION ALL 
  select 'B21', 'P179', 18, 1200000, 0  FROM dual UNION ALL 
  select 'B43', 'P180', 1, 200000, 0  FROM dual UNION ALL 
  select 'B36', 'P180', 1, 500000, 0  FROM dual UNION ALL 
  select 'B42', 'P181', 1, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P182', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P182', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P183', 21, 250000, 0  FROM dual UNION ALL 
  select 'B38', 'P183', 24, 250000, 0  FROM dual UNION ALL 
  select 'B14', 'P183', 29, 4000, 0  FROM dual UNION ALL 
  select 'B7', 'P183', 18, 12000000, 0  FROM dual UNION ALL 
  select 'B40', 'P183', 21, 400000, 0  FROM dual UNION ALL 
  select 'B43', 'P183', 16, 200000, 0  FROM dual UNION ALL 
  select 'B17', 'P183', 19, 350000, 0  FROM dual UNION ALL 
  select 'B25', 'P183', 29, 1000000, 0  FROM dual UNION ALL 
  select 'B19', 'P183', 24, 300000, 0  FROM dual UNION ALL 
  select 'B16', 'P183', 23, 4000, 0  FROM dual UNION ALL 
  select 'B40', 'P184', 1, 400000, 0  FROM dual UNION ALL 
  select 'B22', 'P184', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B19', 'P185', 1, 300000, 0  FROM dual UNION ALL 
  select 'B17', 'P185', 1, 350000, 0  FROM dual UNION ALL 
  select 'B5', 'P186', 15, 40000, 0  FROM dual UNION ALL 
  select 'B25', 'P186', 14, 1000000, 0  FROM dual UNION ALL 
  select 'B4', 'P186', 20, 3100000, 0  FROM dual UNION ALL 
  select 'B32', 'P186', 12, 20000, 0  FROM dual UNION ALL 
  select 'B39', 'P186', 19, 250000, 0  FROM dual UNION ALL 
  select 'B17', 'P187', 1, 350000, 0  FROM dual UNION ALL 
  select 'B23', 'P187', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B42', 'P188', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P188', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P189', 16, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P189', 19, 400000, 0  FROM dual UNION ALL 
  select 'B17', 'P189', 13, 350000, 0  FROM dual UNION ALL 
  select 'B15', 'P189', 18, 4000, 0  FROM dual UNION ALL 
  select 'B3', 'P189', 20, 20000000, 0  FROM dual UNION ALL 
  select 'B9', 'P189', 12, 25000000, 0  FROM dual UNION ALL 
  select 'B27', 'P189', 17, 40000000, 0  FROM dual UNION ALL 
  select 'B37', 'P189', 18, 50000, 0  FROM dual UNION ALL 
  select 'B15', 'P189', 17, 4000, 0  FROM dual UNION ALL 
  select 'B40', 'P190', 1, 400000, 0  FROM dual UNION ALL 
  select 'B38', 'P191', 14, 250000, 0  FROM dual UNION ALL 
  select 'B32', 'P191', 17, 20000, 0  FROM dual UNION ALL 
  select 'B9', 'P191', 14, 25000000, 0  FROM dual UNION ALL 
  select 'B26', 'P191', 10, 100000000, 0  FROM dual UNION ALL 
  select 'B40', 'P191', 15, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P192', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P192', 1, 200000, 0  FROM dual UNION ALL 
  select 'B27', 'P193', 11, 40000000, 0  FROM dual UNION ALL 
  select 'B43', 'P193', 12, 200000, 0  FROM dual UNION ALL 
  select 'B23', 'P193', 20, 3000000, 0  FROM dual UNION ALL 
  select 'B26', 'P193', 15, 100000000, 0  FROM dual UNION ALL 
  select 'B11', 'P193', 19, 40000, 0  FROM dual UNION ALL 
  select 'B40', 'P193', 13, 400000, 0  FROM dual UNION ALL 
  select 'B39', 'P193', 16, 250000, 0  FROM dual UNION ALL 
  select 'B21', 'P194', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B17', 'P194', 1, 350000, 0  FROM dual UNION ALL 
  select 'B3', 'P195', 16, 20000000, 0  FROM dual UNION ALL 
  select 'B24', 'P195', 18, 475000, 0  FROM dual UNION ALL 
  select 'B21', 'P195', 20, 1200000, 0  FROM dual UNION ALL 
  select 'B39', 'P195', 19, 250000, 0  FROM dual UNION ALL 
  select 'B15', 'P195', 20, 4000, 0  FROM dual UNION ALL 
  select 'B31', 'P195', 17, 80000, 0  FROM dual UNION ALL 
  select 'B31', 'P195', 10, 80000, 0  FROM dual UNION ALL 
  select 'B31', 'P195', 19, 80000, 0  FROM dual UNION ALL 
  select 'B21', 'P195', 13, 1200000, 0  FROM dual UNION ALL 
  select 'B39', 'P195', 13, 250000, 0  FROM dual UNION ALL 
  select 'B26', 'P196', 10, 100000000, 0  FROM dual UNION ALL 
  select 'B28', 'P196', 20, 250000000, 0  FROM dual UNION ALL 
  select 'B41', 'P196', 13, 1000000, 0  FROM dual UNION ALL 
  select 'B5', 'P196', 18, 40000, 0  FROM dual UNION ALL 
  select 'B7', 'P196', 16, 12000000, 0  FROM dual UNION ALL 
  select 'B14', 'P196', 13, 4000, 0  FROM dual UNION ALL 
  select 'B42', 'P196', 17, 50000, 0  FROM dual UNION ALL 
  select 'B31', 'P196', 20, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P197', 15, 100000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B16', 'P197', 19, 4000, 0  FROM dual UNION ALL 
  select 'B23', 'P197', 13, 3000000, 0  FROM dual UNION ALL 
  select 'B13', 'P197', 12, 40000, 0  FROM dual UNION ALL 
  select 'B28', 'P197', 11, 250000000, 0  FROM dual UNION ALL 
  select 'B38', 'P198', 1, 250000, 0  FROM dual UNION ALL 
  select 'B17', 'P199', 1, 350000, 0  FROM dual UNION ALL 
  select 'B39', 'P199', 1, 250000, 0  FROM dual UNION ALL 
  select 'B7', 'P200', 19, 12000000, 0  FROM dual UNION ALL 
  select 'B38', 'P200', 14, 250000, 0  FROM dual UNION ALL 
  select 'B24', 'P200', 17, 475000, 0  FROM dual UNION ALL 
  select 'B17', 'P200', 20, 350000, 0  FROM dual UNION ALL 
  select 'B28', 'P200', 16, 250000000, 0  FROM dual UNION ALL 
  select 'B32', 'P200', 11, 20000, 0  FROM dual UNION ALL 
  select 'B3', 'P200', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B31', 'P200', 14, 80000, 0  FROM dual UNION ALL 
  select 'B36', 'P200', 14, 500000, 0  FROM dual UNION ALL 
  select 'B38', 'P200', 18, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P201', 14, 1000000, 0  FROM dual UNION ALL 
  select 'B14', 'P201', 12, 4000, 0  FROM dual UNION ALL 
  select 'B15', 'P201', 20, 4000, 0  FROM dual UNION ALL 
  select 'B6', 'P201', 15, 6000000, 0  FROM dual UNION ALL 
  select 'B40', 'P201', 17, 400000, 0  FROM dual UNION ALL 
  select 'B19', 'P201', 10, 300000, 0  FROM dual UNION ALL 
  select 'B35', 'P201', 17, 20000, 0  FROM dual UNION ALL 
  select 'B20', 'P202', 1, 350000, 0  FROM dual UNION ALL 
  select 'B25', 'P202', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B8', 'P203', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B28', 'P203', 13, 250000000, 0  FROM dual UNION ALL 
  select 'B4', 'P203', 11, 3100000, 0  FROM dual UNION ALL 
  select 'B29', 'P203', 17, 850000, 0  FROM dual UNION ALL 
  select 'B13', 'P203', 18, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P203', 12, 40000000, 0  FROM dual UNION ALL 
  select 'B11', 'P203', 16, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P203', 12, 450000, 0  FROM dual UNION ALL 
  select 'B43', 'P204', 1, 200000, 0  FROM dual UNION ALL 
  select 'B24', 'P204', 1, 475000, 0  FROM dual UNION ALL 
  select 'B43', 'P205', 1, 200000, 0  FROM dual UNION ALL 
  select 'B25', 'P205', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B18', 'P206', 1, 450000, 0  FROM dual UNION ALL 
  select 'B24', 'P207', 1, 475000, 0  FROM dual UNION ALL 
  select 'B37', 'P207', 1, 50000, 0  FROM dual UNION ALL 
  select 'B23', 'P208', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B24', 'P208', 1, 475000, 0  FROM dual UNION ALL 
  select 'B41', 'P209', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P210', 1, 400000, 0  FROM dual UNION ALL 
  select 'B39', 'P211', 1, 250000, 0  FROM dual UNION ALL 
  select 'B37', 'P211', 1, 50000, 0  FROM dual UNION ALL 
  select 'B34', 'P212', 17, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P212', 20, 80000, 0  FROM dual UNION ALL 
  select 'B43', 'P212', 17, 200000, 0  FROM dual UNION ALL 
  select 'B7', 'P212', 20, 12000000, 0  FROM dual UNION ALL 
  select 'B34', 'P212', 13, 20000, 0  FROM dual UNION ALL 
  select 'B43', 'P213', 1, 200000, 0  FROM dual UNION ALL 
  select 'B36', 'P213', 1, 500000, 0  FROM dual UNION ALL 
  select 'B17', 'P214', 1, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P215', 27, 1000000, 0  FROM dual UNION ALL 
  select 'B31', 'P215', 15, 80000, 0  FROM dual UNION ALL 
  select 'B24', 'P215', 27, 475000, 0  FROM dual UNION ALL 
  select 'B17', 'P215', 18, 350000, 0  FROM dual UNION ALL 
  select 'B24', 'P215', 30, 475000, 0  FROM dual UNION ALL 
  select 'B42', 'P216', 1, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P216', 1, 400000, 0  FROM dual UNION ALL 
  select 'B34', 'P217', 20, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P217', 18, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P217', 15, 100000, 0  FROM dual UNION ALL 
  select 'B36', 'P218', 1, 500000, 0  FROM dual UNION ALL 
  select 'B41', 'P218', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P219', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P219', 1, 50000, 0  FROM dual UNION ALL 
  select 'B35', 'P220', 15, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P220', 15, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P220', 10, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P220', 19, 20000, 0  FROM dual UNION ALL 
  select 'B22', 'P221', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B36', 'P222', 15, 500000, 0  FROM dual UNION ALL 
  select 'B16', 'P222', 24, 4000, 0  FROM dual UNION ALL 
  select 'B5', 'P222', 28, 40000, 0  FROM dual UNION ALL 
  select 'B7', 'P222', 18, 12000000, 0  FROM dual UNION ALL 
  select 'B27', 'P222', 29, 40000000, 0  FROM dual UNION ALL 
  select 'B41', 'P222', 19, 1000000, 0  FROM dual UNION ALL 
  select 'B3', 'P222', 15, 20000000, 0  FROM dual UNION ALL 
  select 'B18', 'P222', 25, 450000, 0  FROM dual UNION ALL 
  select 'B32', 'P223', 14, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P223', 10, 100000, 0  FROM dual UNION ALL 
  select 'B30', 'P223', 14, 100000, 0  FROM dual UNION ALL 
  select 'B29', 'P224', 20, 850000, 0  FROM dual UNION ALL 
  select 'B34', 'P224', 16, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P224', 12, 850000, 0  FROM dual UNION ALL 
  select 'B12', 'P225', 18, 40000, 0  FROM dual UNION ALL 
  select 'B17', 'P225', 16, 350000, 0  FROM dual UNION ALL 
  select 'B22', 'P225', 20, 2100000, 0  FROM dual UNION ALL 
  select 'B33', 'P225', 30, 10000, 0  FROM dual UNION ALL 
  select 'B34', 'P225', 21, 20000, 0  FROM dual UNION ALL 
  select 'B17', 'P225', 24, 350000, 0  FROM dual UNION ALL 
  select 'B1', 'P225', 30, 227500, 0  FROM dual UNION ALL 
  select 'B19', 'P225', 16, 300000, 0  FROM dual UNION ALL 
  select 'B12', 'P225', 15, 40000, 0  FROM dual UNION ALL 
  select 'B32', 'P226', 20, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P226', 10, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P226', 12, 80000, 0  FROM dual UNION ALL 
  select 'B31', 'P226', 10, 80000, 0  FROM dual UNION ALL 
  select 'B41', 'P227', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B18', 'P227', 1, 450000, 0  FROM dual UNION ALL 
  select 'B31', 'P228', 19, 80000, 0  FROM dual UNION ALL 
  select 'B17', 'P228', 12, 350000, 0  FROM dual UNION ALL 
  select 'B10', 'P228', 11, 40000, 0  FROM dual UNION ALL 
  select 'B38', 'P228', 18, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P228', 19, 500000, 0  FROM dual UNION ALL 
  select 'B25', 'P228', 12, 1000000, 0  FROM dual UNION ALL 
  select 'B13', 'P228', 11, 40000, 0  FROM dual UNION ALL 
  select 'B24', 'P228', 15, 475000, 0  FROM dual UNION ALL 
  select 'B37', 'P229', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P229', 1, 500000, 0  FROM dual UNION ALL 
  select 'B41', 'P230', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P230', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P231', 1, 200000, 0  FROM dual UNION ALL 
  select 'B18', 'P232', 1, 450000, 0  FROM dual UNION ALL 
  select 'B36', 'P232', 1, 500000, 0  FROM dual UNION ALL 
  select 'B43', 'P233', 18, 200000, 0  FROM dual UNION ALL 
  select 'B27', 'P233', 17, 40000000, 0  FROM dual UNION ALL 
  select 'B19', 'P233', 14, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P233', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B28', 'P233', 17, 250000000, 0  FROM dual UNION ALL 
  select 'B13', 'P233', 10, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P233', 18, 6000000, 0  FROM dual UNION ALL 
  select 'B37', 'P233', 19, 50000, 0  FROM dual UNION ALL 
  select 'B33', 'P233', 15, 10000, 0  FROM dual UNION ALL 
  select 'B40', 'P233', 11, 400000, 0  FROM dual UNION ALL 
  select 'B20', 'P234', 1, 350000, 0  FROM dual UNION ALL 
  select 'B34', 'P235', 22, 20000, 0  FROM dual UNION ALL 
  select 'B43', 'P235', 20, 200000, 0  FROM dual UNION ALL 
  select 'B33', 'P235', 18, 10000, 0  FROM dual UNION ALL 
  select 'B2', 'P235', 17, 3025000, 0  FROM dual UNION ALL 
  select 'B39', 'P235', 20, 250000, 0  FROM dual UNION ALL 
  select 'B24', 'P236', 1, 475000, 0  FROM dual UNION ALL 
  select 'B23', 'P236', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B38', 'P237', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P237', 1, 200000, 0  FROM dual UNION ALL 
  select 'B19', 'P238', 1, 300000, 0  FROM dual UNION ALL 
  select 'B43', 'P239', 1, 200000, 0  FROM dual UNION ALL 
  select 'B10', 'P240', 16, 40000, 0  FROM dual UNION ALL 
  select 'B2', 'P240', 13, 3025000, 0  FROM dual UNION ALL 
  select 'B23', 'P240', 10, 3000000, 0  FROM dual UNION ALL 
  select 'B5', 'P240', 16, 40000, 0  FROM dual UNION ALL 
  select 'B24', 'P240', 10, 475000, 0  FROM dual UNION ALL 
  select 'B41', 'P240', 10, 1000000, 0  FROM dual UNION ALL 
  select 'B20', 'P240', 12, 350000, 0  FROM dual UNION ALL 
  select 'B35', 'P240', 14, 20000, 0  FROM dual UNION ALL 
  select 'B10', 'P240', 17, 40000, 0  FROM dual UNION ALL 
  select 'B25', 'P240', 11, 1000000, 0  FROM dual UNION ALL 
  select 'B3', 'P241', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B30', 'P241', 20, 100000, 0  FROM dual UNION ALL 
  select 'B29', 'P241', 17, 850000, 0  FROM dual UNION ALL 
  select 'B11', 'P241', 17, 40000, 0  FROM dual UNION ALL 
  select 'B28', 'P241', 20, 250000000, 0  FROM dual UNION ALL 
  select 'B27', 'P241', 17, 40000000, 0  FROM dual UNION ALL 
  select 'B41', 'P242', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B6', 'P243', 27, 6000000, 0  FROM dual UNION ALL 
  select 'B16', 'P243', 27, 4000, 0  FROM dual UNION ALL 
  select 'B38', 'P243', 22, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P243', 23, 1000000, 0  FROM dual UNION ALL 
  select 'B19', 'P243', 17, 300000, 0  FROM dual UNION ALL 
  select 'B15', 'P243', 23, 4000, 0  FROM dual UNION ALL 
  select 'B6', 'P243', 20, 6000000, 0  FROM dual UNION ALL 
  select 'B39', 'P244', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P245', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B39', 'P245', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P246', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B18', 'P246', 1, 450000, 0  FROM dual UNION ALL 
  select 'B37', 'P247', 1, 50000, 0  FROM dual UNION ALL 
  select 'B14', 'P248', 13, 4000, 0  FROM dual UNION ALL 
  select 'B27', 'P248', 13, 40000000, 0  FROM dual UNION ALL 
  select 'B19', 'P248', 12, 300000, 0  FROM dual UNION ALL 
  select 'B42', 'P248', 10, 50000, 0  FROM dual UNION ALL 
  select 'B2', 'P248', 10, 3025000, 0  FROM dual UNION ALL 
  select 'B13', 'P248', 14, 40000, 0  FROM dual UNION ALL 
  select 'B8', 'P248', 12, 20000000, 0  FROM dual UNION ALL 
  select 'B32', 'P249', 19, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P249', 17, 850000, 0  FROM dual UNION ALL 
  select 'B31', 'P249', 17, 80000, 0  FROM dual UNION ALL 
  select 'B25', 'P250', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P250', 1, 475000, 0  FROM dual UNION ALL 
  select 'B38', 'P251', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P252', 1, 500000, 0  FROM dual UNION ALL 
  select 'B25', 'P253', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B20', 'P254', 1, 350000, 0  FROM dual UNION ALL 
  select 'B39', 'P255', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P256', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P256', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P257', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P257', 1, 50000, 0  FROM dual UNION ALL 
  select 'B11', 'P258', 14, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P258', 13, 6000000, 0  FROM dual UNION ALL 
  select 'B10', 'P258', 15, 40000, 0  FROM dual UNION ALL 
  select 'B17', 'P258', 18, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P258', 12, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P259', 1, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P259', 1, 400000, 0  FROM dual UNION ALL 
  select 'B18', 'P260', 1, 450000, 0  FROM dual UNION ALL 
  select 'B42', 'P260', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P261', 1, 50000, 0  FROM dual UNION ALL 
  select 'B34', 'P262', 13, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P262', 20, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P262', 12, 20000, 0  FROM dual UNION ALL 
  select 'B39', 'P263', 1, 250000, 0  FROM dual UNION ALL 
  select 'B38', 'P264', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P265', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P265', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P266', 1, 50000, 0  FROM dual UNION ALL 
  select 'B30', 'P267', 17, 100000, 0  FROM dual UNION ALL 
  select 'B13', 'P267', 17, 40000, 0  FROM dual UNION ALL 
  select 'B33', 'P267', 19, 10000, 0  FROM dual UNION ALL 
  select 'B3', 'P267', 15, 20000000, 0  FROM dual UNION ALL 
  select 'B20', 'P267', 15, 350000, 0  FROM dual UNION ALL 
  select 'B38', 'P268', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P268', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B5', 'P269', 23, 40000, 0  FROM dual UNION ALL 
  select 'B36', 'P269', 20, 500000, 0  FROM dual UNION ALL 
  select 'B27', 'P269', 19, 40000000, 0  FROM dual UNION ALL 
  select 'B24', 'P269', 21, 475000, 0  FROM dual UNION ALL 
  select 'B5', 'P269', 28, 40000, 0  FROM dual UNION ALL 
  select 'B32', 'P269', 18, 20000, 0  FROM dual UNION ALL 
  select 'B6', 'P269', 17, 6000000, 0  FROM dual UNION ALL 
  select 'B26', 'P269', 21, 100000000, 0  FROM dual UNION ALL 
  select 'B4', 'P269', 18, 3100000, 0  FROM dual UNION ALL 
  select 'B18', 'P270', 1, 450000, 0  FROM dual UNION ALL 
  select 'B22', 'P271', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B35', 'P272', 14, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P272', 14, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P272', 11, 80000, 0  FROM dual UNION ALL 
  select 'B35', 'P272', 14, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P272', 20, 20000, 0  FROM dual UNION ALL 
  select 'B37', 'P272', 14, 50000, 0  FROM dual UNION ALL 
  select 'B25', 'P272', 17, 1000000, 0  FROM dual UNION ALL 
  select 'B29', 'P272', 19, 850000, 0  FROM dual UNION ALL 
  select 'B25', 'P272', 12, 1000000, 0  FROM dual UNION ALL 
  select 'B11', 'P273', 12, 40000, 0  FROM dual UNION ALL 
  select 'B9', 'P273', 12, 25000000, 0  FROM dual UNION ALL 
  select 'B36', 'P273', 18, 500000, 0  FROM dual UNION ALL 
  select 'B6', 'P273', 20, 6000000, 0  FROM dual UNION ALL 
  select 'B35', 'P273', 13, 20000, 0  FROM dual UNION ALL 
  select 'B5', 'P273', 17, 40000, 0  FROM dual UNION ALL 
  select 'B40', 'P273', 11, 400000, 0  FROM dual UNION ALL 
  select 'B26', 'P273', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B12', 'P273', 18, 40000, 0  FROM dual UNION ALL 
  select 'B33', 'P273', 14, 10000, 0  FROM dual UNION ALL 
  select 'B39', 'P274', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P274', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P275', 1, 500000, 0  FROM dual UNION ALL 
  select 'B25', 'P275', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P276', 1, 400000, 0  FROM dual UNION ALL 
  select 'B24', 'P276', 1, 475000, 0  FROM dual UNION ALL 
  select 'B32', 'P277', 16, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P277', 12, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P277', 14, 100000, 0  FROM dual UNION ALL 
  select 'B31', 'P277', 17, 80000, 0  FROM dual UNION ALL 
  select 'B20', 'P278', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P278', 1, 400000, 0  FROM dual UNION ALL 
  select 'B5', 'P279', 10, 40000, 0  FROM dual UNION ALL 
  select 'B33', 'P279', 15, 10000, 0  FROM dual UNION ALL 
  select 'B3', 'P279', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B25', 'P279', 11, 1000000, 0  FROM dual UNION ALL 
  select 'B20', 'P279', 16, 350000, 0  FROM dual UNION ALL 
  select 'B22', 'P279', 20, 2100000, 0  FROM dual UNION ALL 
  select 'B42', 'P279', 16, 50000, 0  FROM dual UNION ALL 
  select 'B7', 'P279', 18, 12000000, 0  FROM dual UNION ALL 
  select 'B21', 'P279', 19, 1200000, 0  FROM dual UNION ALL 
  select 'B27', 'P279', 11, 40000000, 0  FROM dual UNION ALL 
  select 'B32', 'P280', 19, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P280', 10, 100000, 0  FROM dual UNION ALL 
  select 'B31', 'P280', 10, 80000, 0  FROM dual UNION ALL 
  select 'B32', 'P280', 20, 20000, 0  FROM dual UNION ALL 
  select 'B13', 'P281', 23, 40000, 0  FROM dual UNION ALL 
  select 'B26', 'P281', 23, 100000000, 0  FROM dual UNION ALL 
  select 'B16', 'P281', 16, 4000, 0  FROM dual UNION ALL 
  select 'B41', 'P281', 25, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P282', 1, 350000, 0  FROM dual UNION ALL 
  select 'B37', 'P283', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P284', 1, 500000, 0  FROM dual UNION ALL 
  select 'B36', 'P285', 1, 500000, 0  FROM dual UNION ALL 
  select 'B23', 'P286', 12, 3000000, 0  FROM dual UNION ALL 
  select 'B21', 'P286', 15, 1200000, 0  FROM dual UNION ALL 
  select 'B31', 'P286', 15, 80000, 0  FROM dual UNION ALL 
  select 'B7', 'P286', 19, 12000000, 0  FROM dual UNION ALL 
  select 'B23', 'P286', 12, 3000000, 0  FROM dual UNION ALL 
  select 'B5', 'P286', 11, 40000, 0  FROM dual UNION ALL 
  select 'B22', 'P286', 15, 2100000, 0  FROM dual UNION ALL 
  select 'B41', 'P286', 11, 1000000, 0  FROM dual UNION ALL 
  select 'B23', 'P287', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B27', 'P288', 28, 40000000, 0  FROM dual UNION ALL 
  select 'B37', 'P288', 24, 50000, 0  FROM dual UNION ALL 
  select 'B24', 'P288', 30, 475000, 0  FROM dual UNION ALL 
  select 'B15', 'P288', 28, 4000, 0  FROM dual UNION ALL 
  select 'B6', 'P288', 27, 6000000, 0  FROM dual UNION ALL 
  select 'B38', 'P288', 25, 250000, 0  FROM dual UNION ALL 
  select 'B5', 'P288', 15, 40000, 0  FROM dual UNION ALL 
  select 'B33', 'P288', 22, 10000, 0  FROM dual UNION ALL 
  select 'B19', 'P288', 21, 300000, 0  FROM dual UNION ALL 
  select 'B17', 'P289', 1, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P289', 1, 500000, 0  FROM dual UNION ALL 
  select 'B23', 'P290', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B37', 'P290', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P291', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P291', 1, 500000, 0  FROM dual UNION ALL 
  select 'B11', 'P292', 17, 40000, 0  FROM dual UNION ALL 
  select 'B35', 'P292', 16, 20000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B33', 'P292', 20, 10000, 0  FROM dual UNION ALL 
  select 'B22', 'P292', 18, 2100000, 0  FROM dual UNION ALL 
  select 'B24', 'P292', 13, 475000, 0  FROM dual UNION ALL 
  select 'B38', 'P292', 10, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P292', 12, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P293', 1, 200000, 0  FROM dual UNION ALL 
  select 'B41', 'P294', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P295', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P295', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B30', 'P296', 14, 100000, 0  FROM dual UNION ALL 
  select 'B27', 'P296', 13, 40000000, 0  FROM dual UNION ALL 
  select 'B4', 'P296', 16, 3100000, 0  FROM dual UNION ALL 
  select 'B25', 'P296', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B27', 'P296', 18, 40000000, 0  FROM dual UNION ALL 
  select 'B11', 'P296', 13, 40000, 0  FROM dual UNION ALL 
  select 'B30', 'P296', 16, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P296', 13, 20000, 0  FROM dual UNION ALL 
  select 'B21', 'P296', 19, 1200000, 0  FROM dual UNION ALL 
  select 'B41', 'P297', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B23', 'P297', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B43', 'P298', 1, 200000, 0  FROM dual UNION ALL 
  select 'B32', 'P299', 12, 20000, 0  FROM dual UNION ALL 
  select 'B24', 'P299', 17, 475000, 0  FROM dual UNION ALL 
  select 'B35', 'P299', 14, 20000, 0  FROM dual UNION ALL 
  select 'B19', 'P299', 14, 300000, 0  FROM dual UNION ALL 
  select 'B36', 'P299', 19, 500000, 0  FROM dual UNION ALL 
  select 'B5', 'P299', 16, 40000, 0  FROM dual UNION ALL 
  select 'B33', 'P299', 17, 10000, 0  FROM dual UNION ALL 
  select 'B41', 'P299', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B13', 'P299', 13, 40000, 0  FROM dual UNION ALL 
  select 'B28', 'P299', 19, 250000000, 0  FROM dual UNION ALL 
  select 'B40', 'P300', 1, 400000, 0  FROM dual UNION ALL 
  select 'B43', 'P300', 1, 200000, 0  FROM dual UNION ALL 
  select 'B41', 'P301', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B25', 'P302', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B8', 'P302', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B9', 'P302', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B37', 'P302', 19, 50000, 0  FROM dual UNION ALL 
  select 'B10', 'P302', 16, 40000, 0  FROM dual UNION ALL 
  select 'B34', 'P303', 10, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P303', 17, 80000, 0  FROM dual UNION ALL 
  select 'B32', 'P303', 17, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P303', 14, 850000, 0  FROM dual UNION ALL 
  select 'B24', 'P304', 1, 475000, 0  FROM dual UNION ALL 
  select 'B41', 'P304', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P305', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P305', 1, 500000, 0  FROM dual UNION ALL 
  select 'B39', 'P306', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P306', 1, 400000, 0  FROM dual UNION ALL 
  select 'B35', 'P307', 17, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P307', 14, 20000, 0  FROM dual UNION ALL 
  select 'B16', 'P307', 17, 4000, 0  FROM dual UNION ALL 
  select 'B37', 'P307', 18, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P307', 10, 300000, 0  FROM dual UNION ALL 
  select 'B5', 'P307', 10, 40000, 0  FROM dual UNION ALL 
  select 'B26', 'P307', 11, 100000000, 0  FROM dual UNION ALL 
  select 'B6', 'P307', 19, 6000000, 0  FROM dual UNION ALL 
  select 'B21', 'P307', 16, 1200000, 0  FROM dual UNION ALL 
  select 'B27', 'P308', 15, 40000000, 0  FROM dual UNION ALL 
  select 'B35', 'P308', 11, 20000, 0  FROM dual UNION ALL 
  select 'B33', 'P308', 15, 10000, 0  FROM dual UNION ALL 
  select 'B21', 'P308', 18, 1200000, 0  FROM dual UNION ALL 
  select 'B35', 'P308', 20, 20000, 0  FROM dual UNION ALL 
  select 'B11', 'P308', 12, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P308', 19, 250000, 0  FROM dual UNION ALL 
  select 'B21', 'P309', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B17', 'P309', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P310', 1, 400000, 0  FROM dual UNION ALL 
  select 'B18', 'P311', 1, 450000, 0  FROM dual UNION ALL 
  select 'B43', 'P311', 1, 200000, 0  FROM dual UNION ALL 
  select 'B22', 'P312', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B42', 'P313', 12, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P313', 12, 250000, 0  FROM dual UNION ALL 
  select 'B12', 'P313', 13, 40000, 0  FROM dual UNION ALL 
  select 'B43', 'P313', 18, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P313', 12, 250000, 0  FROM dual UNION ALL 
  select 'B10', 'P313', 13, 40000, 0  FROM dual UNION ALL 
  select 'B32', 'P313', 15, 20000, 0  FROM dual UNION ALL 
  select 'B41', 'P313', 10, 1000000, 0  FROM dual UNION ALL 
  select 'B19', 'P314', 1, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P314', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B41', 'P315', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B19', 'P315', 1, 300000, 0  FROM dual UNION ALL 
  select 'B21', 'P316', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B18', 'P316', 1, 450000, 0  FROM dual UNION ALL 
  select 'B42', 'P317', 1, 50000, 0  FROM dual UNION ALL 
  select 'B10', 'P318', 15, 40000, 0  FROM dual UNION ALL 
  select 'B10', 'P318', 15, 40000, 0  FROM dual UNION ALL 
  select 'B8', 'P318', 25, 20000000, 0  FROM dual UNION ALL 
  select 'B30', 'P318', 22, 100000, 0  FROM dual UNION ALL 
  select 'B43', 'P319', 1, 200000, 0  FROM dual UNION ALL 
  select 'B43', 'P320', 1, 200000, 0  FROM dual UNION ALL 
  select 'B20', 'P321', 1, 350000, 0  FROM dual UNION ALL 
  select 'B6', 'P322', 10, 6000000, 0  FROM dual UNION ALL 
  select 'B42', 'P322', 10, 50000, 0  FROM dual UNION ALL 
  select 'B11', 'P322', 12, 40000, 0  FROM dual UNION ALL 
  select 'B38', 'P322', 18, 250000, 0  FROM dual UNION ALL 
  select 'B3', 'P322', 11, 20000000, 0  FROM dual UNION ALL 
  select 'B36', 'P322', 15, 500000, 0  FROM dual UNION ALL 
  select 'B41', 'P322', 20, 1000000, 0  FROM dual UNION ALL 
  select 'B3', 'P322', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B41', 'P322', 10, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P323', 1, 400000, 0  FROM dual UNION ALL 
  select 'B37', 'P324', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P325', 1, 50000, 0  FROM dual UNION ALL 
  select 'B20', 'P326', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P327', 1, 200000, 0  FROM dual UNION ALL 
  select 'B19', 'P328', 1, 300000, 0  FROM dual UNION ALL 
  select 'B2', 'P329', 21, 3025000, 0  FROM dual UNION ALL 
  select 'B28', 'P329', 30, 250000000, 0  FROM dual UNION ALL 
  select 'B28', 'P329', 19, 250000000, 0  FROM dual UNION ALL 
  select 'B37', 'P329', 19, 50000, 0  FROM dual UNION ALL 
  select 'B11', 'P329', 19, 40000, 0  FROM dual UNION ALL 
  select 'B10', 'P329', 26, 40000, 0  FROM dual UNION ALL 
  select 'B1', 'P329', 28, 227500, 0  FROM dual UNION ALL 
  select 'B20', 'P329', 25, 350000, 0  FROM dual UNION ALL 
  select 'B23', 'P329', 19, 3000000, 0  FROM dual UNION ALL 
  select 'B36', 'P330', 1, 500000, 0  FROM dual UNION ALL 
  select 'B39', 'P330', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P331', 16, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P331', 16, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P331', 10, 400000, 0  FROM dual UNION ALL 
  select 'B10', 'P331', 18, 40000, 0  FROM dual UNION ALL 
  select 'B17', 'P331', 13, 350000, 0  FROM dual UNION ALL 
  select 'B33', 'P331', 16, 10000, 0  FROM dual UNION ALL 
  select 'B12', 'P331', 10, 40000, 0  FROM dual UNION ALL 
  select 'B22', 'P331', 13, 2100000, 0  FROM dual UNION ALL 
  select 'B41', 'P332', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P333', 1, 200000, 0  FROM dual UNION ALL 
  select 'B19', 'P333', 1, 300000, 0  FROM dual UNION ALL 
  select 'B10', 'P334', 10, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P334', 14, 40000000, 0  FROM dual UNION ALL 
  select 'B29', 'P334', 15, 850000, 0  FROM dual UNION ALL 
  select 'B15', 'P334', 14, 4000, 0  FROM dual UNION ALL 
  select 'B21', 'P334', 18, 1200000, 0  FROM dual UNION ALL 
  select 'B43', 'P335', 1, 200000, 0  FROM dual UNION ALL 
  select 'B20', 'P335', 1, 350000, 0  FROM dual UNION ALL 
  select 'B13', 'P336', 10, 40000, 0  FROM dual UNION ALL 
  select 'B16', 'P336', 15, 4000, 0  FROM dual UNION ALL 
  select 'B23', 'P336', 11, 3000000, 0  FROM dual UNION ALL 
  select 'B17', 'P336', 10, 350000, 0  FROM dual UNION ALL 
  select 'B20', 'P336', 14, 350000, 0  FROM dual UNION ALL 
  select 'B13', 'P336', 11, 40000, 0  FROM dual UNION ALL 
  select 'B32', 'P337', 14, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P337', 19, 100000, 0  FROM dual UNION ALL 
  select 'B34', 'P337', 17, 20000, 0  FROM dual UNION ALL 
  select 'B43', 'P338', 1, 200000, 0  FROM dual UNION ALL 
  select 'B19', 'P338', 1, 300000, 0  FROM dual UNION ALL 
  select 'B40', 'P339', 1, 400000, 0  FROM dual UNION ALL 
  select 'B19', 'P339', 1, 300000, 0  FROM dual UNION ALL 
  select 'B43', 'P340', 1, 200000, 0  FROM dual UNION ALL 
  select 'B39', 'P341', 1, 250000, 0  FROM dual UNION ALL 
  select 'B21', 'P342', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B42', 'P342', 1, 50000, 0  FROM dual UNION ALL 
  select 'B20', 'P343', 1, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P344', 1, 50000, 0  FROM dual UNION ALL 
  select 'B16', 'P345', 24, 4000, 0  FROM dual UNION ALL 
  select 'B3', 'P345', 27, 20000000, 0  FROM dual UNION ALL 
  select 'B2', 'P345', 27, 3025000, 0  FROM dual UNION ALL 
  select 'B37', 'P346', 1, 50000, 0  FROM dual UNION ALL 
  select 'B29', 'P347', 15, 850000, 0  FROM dual UNION ALL 
  select 'B16', 'P347', 14, 4000, 0  FROM dual UNION ALL 
  select 'B39', 'P347', 14, 250000, 0  FROM dual UNION ALL 
  select 'B7', 'P347', 16, 12000000, 0  FROM dual UNION ALL 
  select 'B21', 'P347', 15, 1200000, 0  FROM dual UNION ALL 
  select 'B43', 'P348', 1, 200000, 0  FROM dual UNION ALL 
  select 'B17', 'P349', 14, 350000, 0  FROM dual UNION ALL 
  select 'B25', 'P349', 12, 1000000, 0  FROM dual UNION ALL 
  select 'B33', 'P349', 11, 10000, 0  FROM dual UNION ALL 
  select 'B16', 'P349', 10, 4000, 0  FROM dual UNION ALL 
  select 'B18', 'P349', 16, 450000, 0  FROM dual UNION ALL 
  select 'B20', 'P349', 12, 350000, 0  FROM dual UNION ALL 
  select 'B23', 'P349', 11, 3000000, 0  FROM dual UNION ALL 
  select 'B32', 'P350', 11, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P350', 17, 850000, 0  FROM dual UNION ALL 
  select 'B35', 'P350', 19, 20000, 0  FROM dual UNION ALL 
  select 'B21', 'P351', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B18', 'P351', 1, 450000, 0  FROM dual UNION ALL 
  select 'B22', 'P352', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B43', 'P353', 1, 200000, 0  FROM dual UNION ALL 
  select 'B37', 'P353', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P354', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B21', 'P354', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B42', 'P355', 30, 50000, 0  FROM dual UNION ALL 
  select 'B33', 'P355', 23, 10000, 0  FROM dual UNION ALL 
  select 'B41', 'P355', 23, 1000000, 0  FROM dual UNION ALL 
  select 'B9', 'P355', 18, 25000000, 0  FROM dual UNION ALL 
  select 'B39', 'P356', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P356', 1, 250000, 0  FROM dual UNION ALL 
  select 'B34', 'P357', 11, 20000, 0  FROM dual UNION ALL 
  select 'B37', 'P357', 16, 50000, 0  FROM dual UNION ALL 
  select 'B6', 'P357', 16, 6000000, 0  FROM dual UNION ALL 
  select 'B41', 'P357', 10, 1000000, 0  FROM dual UNION ALL 
  select 'B27', 'P357', 10, 40000000, 0  FROM dual UNION ALL 
  select 'B35', 'P358', 19, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P358', 19, 850000, 0  FROM dual UNION ALL 
  select 'B30', 'P358', 13, 100000, 0  FROM dual UNION ALL 
  select 'B31', 'P358', 17, 80000, 0  FROM dual UNION ALL 
  select 'B38', 'P359', 1, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P359', 1, 450000, 0  FROM dual UNION ALL 
  select 'B42', 'P360', 1, 50000, 0  FROM dual UNION ALL 
  select 'B24', 'P361', 24, 475000, 0  FROM dual UNION ALL 
  select 'B17', 'P361', 28, 350000, 0  FROM dual UNION ALL 
  select 'B1', 'P361', 29, 227500, 0  FROM dual UNION ALL 
  select 'B39', 'P361', 18, 250000, 0  FROM dual UNION ALL 
  select 'B28', 'P361', 29, 250000000, 0  FROM dual UNION ALL 
  select 'B12', 'P361', 29, 40000, 0  FROM dual UNION ALL 
  select 'B14', 'P362', 17, 4000, 0  FROM dual UNION ALL 
  select 'B28', 'P362', 17, 250000000, 0  FROM dual UNION ALL 
  select 'B3', 'P362', 10, 20000000, 0  FROM dual UNION ALL 
  select 'B37', 'P362', 16, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P362', 16, 400000, 0  FROM dual UNION ALL 
  select 'B41', 'P362', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B34', 'P362', 20, 20000, 0  FROM dual UNION ALL 
  select 'B36', 'P362', 16, 500000, 0  FROM dual UNION ALL 
  select 'B6', 'P362', 16, 6000000, 0  FROM dual UNION ALL 
  select 'B20', 'P363', 1, 350000, 0  FROM dual UNION ALL 
  select 'B25', 'P363', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P364', 1, 475000, 0  FROM dual UNION ALL 
  select 'B24', 'P364', 1, 475000, 0  FROM dual UNION ALL 
  select 'B19', 'P365', 1, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P366', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P367', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P367', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P368', 1, 200000, 0  FROM dual UNION ALL 
  select 'B19', 'P369', 1, 300000, 0  FROM dual UNION ALL 
  select 'B23', 'P370', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B23', 'P370', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B32', 'P371', 11, 20000, 0  FROM dual UNION ALL 
  select 'B15', 'P371', 18, 4000, 0  FROM dual UNION ALL 
  select 'B33', 'P371', 14, 10000, 0  FROM dual UNION ALL 
  select 'B14', 'P371', 16, 4000, 0  FROM dual UNION ALL 
  select 'B5', 'P371', 17, 40000, 0  FROM dual UNION ALL 
  select 'B12', 'P371', 15, 40000, 0  FROM dual UNION ALL 
  select 'B19', 'P371', 14, 300000, 0  FROM dual UNION ALL 
  select 'B39', 'P372', 1, 250000, 0  FROM dual UNION ALL 
  select 'B38', 'P372', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P373', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P374', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P374', 1, 500000, 0  FROM dual UNION ALL 
  select 'B43', 'P375', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P375', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P376', 1, 500000, 0  FROM dual UNION ALL 
  select 'B40', 'P377', 1, 400000, 0  FROM dual UNION ALL 
  select 'B28', 'P378', 27, 250000000, 0  FROM dual UNION ALL 
  select 'B31', 'P378', 19, 80000, 0  FROM dual UNION ALL 
  select 'B25', 'P378', 15, 1000000, 0  FROM dual UNION ALL 
  select 'B21', 'P378', 24, 1200000, 0  FROM dual UNION ALL 
  select 'B13', 'P378', 18, 40000, 0  FROM dual UNION ALL 
  select 'B4', 'P378', 23, 3100000, 0  FROM dual UNION ALL 
  select 'B39', 'P378', 24, 250000, 0  FROM dual UNION ALL 
  select 'B11', 'P378', 25, 40000, 0  FROM dual UNION ALL 
  select 'B12', 'P378', 26, 40000, 0  FROM dual UNION ALL 
  select 'B32', 'P378', 22, 20000, 0  FROM dual UNION ALL 
  select 'B41', 'P379', 20, 1000000, 0  FROM dual UNION ALL 
  select 'B20', 'P379', 15, 350000, 0  FROM dual UNION ALL 
  select 'B38', 'P379', 19, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P379', 19, 2100000, 0  FROM dual UNION ALL 
  select 'B7', 'P379', 14, 12000000, 0  FROM dual UNION ALL 
  select 'B28', 'P379', 16, 250000000, 0  FROM dual UNION ALL 
  select 'B17', 'P379', 14, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P380', 1, 500000, 0  FROM dual UNION ALL 
  select 'B19', 'P380', 1, 300000, 0  FROM dual UNION ALL 
  select 'B36', 'P381', 1, 500000, 0  FROM dual UNION ALL 
  select 'B17', 'P381', 1, 350000, 0  FROM dual UNION ALL 
  select 'B31', 'P382', 10, 80000, 0  FROM dual UNION ALL 
  select 'B34', 'P382', 20, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P382', 17, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P382', 20, 100000, 0  FROM dual UNION ALL 
  select 'B34', 'P382', 19, 20000, 0  FROM dual UNION ALL 
  select 'B21', 'P383', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B25', 'P383', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P384', 15, 250000, 0  FROM dual UNION ALL 
  select 'B8', 'P384', 17, 20000000, 0  FROM dual UNION ALL 
  select 'B11', 'P384', 17, 40000, 0  FROM dual UNION ALL 
  select 'B35', 'P384', 12, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P384', 13, 20000, 0  FROM dual UNION ALL 
  select 'B16', 'P384', 15, 4000, 0  FROM dual UNION ALL 
  select 'B43', 'P384', 20, 200000, 0  FROM dual UNION ALL 
  select 'B30', 'P384', 11, 100000, 0  FROM dual UNION ALL 
  select 'B36', 'P384', 19, 500000, 0  FROM dual UNION ALL 
  select 'B24', 'P384', 20, 475000, 0  FROM dual UNION ALL 
  select 'B20', 'P385', 1, 350000, 0  FROM dual UNION ALL 
  select 'B25', 'P386', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P386', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P387', 1, 50000, 0  FROM dual UNION ALL 
  select 'B20', 'P388', 1, 350000, 0  FROM dual UNION ALL 
  select 'B31', 'P389', 11, 80000, 0  FROM dual UNION ALL 
  select 'B32', 'P389', 19, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P389', 10, 850000, 0  FROM dual UNION ALL 
  select 'B31', 'P389', 12, 80000, 0  FROM dual UNION ALL 
  select 'B29', 'P389', 16, 850000, 0  FROM dual UNION ALL 
  select 'B40', 'P390', 1, 400000, 0  FROM dual UNION ALL 
  select 'B38', 'P390', 1, 250000, 0  FROM dual UNION ALL 
  select 'B15', 'P391', 18, 4000, 0  FROM dual UNION ALL 
  select 'B30', 'P391', 12, 100000, 0  FROM dual UNION ALL 
  select 'B27', 'P391', 15, 40000000, 0  FROM dual UNION ALL 
  select 'B4', 'P391', 15, 3100000, 0  FROM dual UNION ALL 
  select 'B4', 'P391', 14, 3100000, 0  FROM dual UNION ALL 
  select 'B26', 'P391', 11, 100000000, 0  FROM dual UNION ALL 
  select 'B11', 'P392', 15, 40000, 0  FROM dual UNION ALL 
  select 'B2', 'P392', 13, 3025000, 0  FROM dual UNION ALL 
  select 'B13', 'P392', 19, 40000, 0  FROM dual UNION ALL 
  select 'B15', 'P392', 17, 4000, 0  FROM dual UNION ALL 
  select 'B40', 'P392', 18, 400000, 0  FROM dual UNION ALL 
  select 'B15', 'P392', 15, 4000, 0  FROM dual UNION ALL 
  select 'B15', 'P392', 12, 4000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B29', 'P392', 18, 850000, 0  FROM dual UNION ALL 
  select 'B18', 'P393', 1, 450000, 0  FROM dual UNION ALL 
  select 'B41', 'P393', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P394', 13, 250000, 0  FROM dual UNION ALL 
  select 'B20', 'P394', 10, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P394', 15, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P394', 14, 400000, 0  FROM dual UNION ALL 
  select 'B24', 'P394', 12, 475000, 0  FROM dual UNION ALL 
  select 'B5', 'P394', 11, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P394', 13, 250000, 0  FROM dual UNION ALL 
  select 'B23', 'P394', 11, 3000000, 0  FROM dual UNION ALL 
  select 'B17', 'P395', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P395', 1, 400000, 0  FROM dual UNION ALL 
  select 'B31', 'P396', 10, 80000, 0  FROM dual UNION ALL 
  select 'B32', 'P396', 13, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P396', 15, 100000, 0  FROM dual UNION ALL 
  select 'B29', 'P396', 14, 850000, 0  FROM dual UNION ALL 
  select 'B41', 'P397', 14, 1000000, 0  FROM dual UNION ALL 
  select 'B26', 'P397', 20, 100000000, 0  FROM dual UNION ALL 
  select 'B30', 'P397', 19, 100000, 0  FROM dual UNION ALL 
  select 'B25', 'P397', 17, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P397', 18, 250000, 0  FROM dual UNION ALL 
  select 'B37', 'P398', 13, 50000, 0  FROM dual UNION ALL 
  select 'B28', 'P398', 15, 250000000, 0  FROM dual UNION ALL 
  select 'B14', 'P398', 11, 4000, 0  FROM dual UNION ALL 
  select 'B21', 'P398', 14, 1200000, 0  FROM dual UNION ALL 
  select 'B39', 'P398', 19, 250000, 0  FROM dual UNION ALL 
  select 'B19', 'P398', 14, 300000, 0  FROM dual UNION ALL 
  select 'B6', 'P398', 20, 6000000, 0  FROM dual UNION ALL 
  select 'B19', 'P399', 1, 300000, 0  FROM dual UNION ALL 
  select 'B43', 'P399', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P400', 1, 400000, 0  FROM dual UNION ALL 
  select 'B39', 'P401', 1, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P401', 1, 450000, 0  FROM dual UNION ALL 
  select 'B42', 'P402', 12, 50000, 0  FROM dual UNION ALL 
  select 'B5', 'P402', 16, 40000, 0  FROM dual UNION ALL 
  select 'B33', 'P402', 19, 10000, 0  FROM dual UNION ALL 
  select 'B25', 'P402', 12, 1000000, 0  FROM dual UNION ALL 
  select 'B19', 'P402', 10, 300000, 0  FROM dual UNION ALL 
  select 'B42', 'P402', 10, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P402', 19, 500000, 0  FROM dual UNION ALL 
  select 'B40', 'P402', 11, 400000, 0  FROM dual UNION ALL 
  select 'B18', 'P402', 12, 450000, 0  FROM dual UNION ALL 
  select 'B19', 'P402', 20, 300000, 0  FROM dual UNION ALL 
  select 'B42', 'P403', 1, 50000, 0  FROM dual UNION ALL 
  select 'B22', 'P403', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B16', 'P404', 14, 4000, 0  FROM dual UNION ALL 
  select 'B14', 'P404', 18, 4000, 0  FROM dual UNION ALL 
  select 'B32', 'P404', 13, 20000, 0  FROM dual UNION ALL 
  select 'B38', 'P404', 14, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P404', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B28', 'P404', 20, 250000000, 0  FROM dual UNION ALL 
  select 'B31', 'P405', 18, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P405', 13, 100000, 0  FROM dual UNION ALL 
  select 'B31', 'P405', 14, 80000, 0  FROM dual UNION ALL 
  select 'B29', 'P405', 14, 850000, 0  FROM dual UNION ALL 
  select 'B35', 'P406', 11, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P406', 10, 100000, 0  FROM dual UNION ALL 
  select 'B29', 'P406', 10, 850000, 0  FROM dual UNION ALL 
  select 'B19', 'P407', 16, 300000, 0  FROM dual UNION ALL 
  select 'B10', 'P407', 17, 40000, 0  FROM dual UNION ALL 
  select 'B22', 'P407', 28, 2100000, 0  FROM dual UNION ALL 
  select 'B37', 'P407', 27, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P408', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P408', 1, 400000, 0  FROM dual UNION ALL 
  select 'B41', 'P409', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P409', 1, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P410', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P411', 1, 50000, 0  FROM dual UNION ALL 
  select 'B17', 'P412', 1, 350000, 0  FROM dual UNION ALL 
  select 'B17', 'P412', 1, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P413', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P413', 1, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P414', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B23', 'P414', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B43', 'P415', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P415', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P416', 1, 500000, 0  FROM dual UNION ALL 
  select 'B15', 'P417', 13, 4000, 0  FROM dual UNION ALL 
  select 'B18', 'P417', 17, 450000, 0  FROM dual UNION ALL 
  select 'B42', 'P417', 19, 50000, 0  FROM dual UNION ALL 
  select 'B22', 'P417', 13, 2100000, 0  FROM dual UNION ALL 
  select 'B43', 'P417', 19, 200000, 0  FROM dual UNION ALL 
  select 'B39', 'P418', 12, 250000, 0  FROM dual UNION ALL 
  select 'B8', 'P418', 13, 20000000, 0  FROM dual UNION ALL 
  select 'B33', 'P418', 12, 10000, 0  FROM dual UNION ALL 
  select 'B8', 'P418', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B5', 'P418', 14, 40000, 0  FROM dual UNION ALL 
  select 'B29', 'P418', 18, 850000, 0  FROM dual UNION ALL 
  select 'B40', 'P419', 1, 400000, 0  FROM dual UNION ALL 
  select 'B43', 'P419', 1, 200000, 0  FROM dual UNION ALL 
  select 'B36', 'P420', 1, 500000, 0  FROM dual UNION ALL 
  select 'B19', 'P420', 1, 300000, 0  FROM dual UNION ALL 
  select 'B27', 'P421', 14, 40000000, 0  FROM dual UNION ALL 
  select 'B18', 'P421', 14, 450000, 0  FROM dual UNION ALL 
  select 'B34', 'P421', 10, 20000, 0  FROM dual UNION ALL 
  select 'B17', 'P421', 12, 350000, 0  FROM dual UNION ALL 
  select 'B22', 'P421', 15, 2100000, 0  FROM dual UNION ALL 
  select 'B13', 'P421', 20, 40000, 0  FROM dual UNION ALL 
  select 'B34', 'P421', 16, 20000, 0  FROM dual UNION ALL 
  select 'B36', 'P422', 1, 500000, 0  FROM dual UNION ALL 
  select 'B43', 'P422', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P423', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P424', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P425', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P425', 1, 200000, 0  FROM dual UNION ALL 
  select 'B43', 'P426', 16, 200000, 0  FROM dual UNION ALL 
  select 'B27', 'P426', 14, 40000000, 0  FROM dual UNION ALL 
  select 'B37', 'P426', 14, 50000, 0  FROM dual UNION ALL 
  select 'B22', 'P426', 11, 2100000, 0  FROM dual UNION ALL 
  select 'B31', 'P426', 12, 80000, 0  FROM dual UNION ALL 
  select 'B2', 'P426', 15, 3025000, 0  FROM dual UNION ALL 
  select 'B5', 'P427', 11, 40000, 0  FROM dual UNION ALL 
  select 'B5', 'P427', 13, 40000, 0  FROM dual UNION ALL 
  select 'B34', 'P427', 19, 20000, 0  FROM dual UNION ALL 
  select 'B9', 'P427', 12, 25000000, 0  FROM dual UNION ALL 
  select 'B42', 'P427', 17, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P427', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P428', 1, 400000, 0  FROM dual UNION ALL 
  select 'B20', 'P428', 1, 350000, 0  FROM dual UNION ALL 
  select 'B15', 'P429', 21, 4000, 0  FROM dual UNION ALL 
  select 'B19', 'P429', 24, 300000, 0  FROM dual UNION ALL 
  select 'B27', 'P429', 28, 40000000, 0  FROM dual UNION ALL 
  select 'B21', 'P429', 22, 1200000, 0  FROM dual UNION ALL 
  select 'B42', 'P429', 30, 50000, 0  FROM dual UNION ALL 
  select 'B9', 'P429', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B1', 'P429', 19, 227500, 0  FROM dual UNION ALL 
  select 'B1', 'P429', 15, 227500, 0  FROM dual UNION ALL 
  select 'B31', 'P429', 22, 80000, 0  FROM dual UNION ALL 
  select 'B34', 'P429', 24, 20000, 0  FROM dual UNION ALL 
  select 'B40', 'P430', 1, 400000, 0  FROM dual UNION ALL 
  select 'B39', 'P431', 11, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P431', 16, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P431', 14, 50000, 0  FROM dual UNION ALL 
  select 'B31', 'P431', 18, 80000, 0  FROM dual UNION ALL 
  select 'B22', 'P431', 16, 2100000, 0  FROM dual UNION ALL 
  select 'B31', 'P431', 13, 80000, 0  FROM dual UNION ALL 
  select 'B26', 'P432', 20, 100000000, 0  FROM dual UNION ALL 
  select 'B28', 'P432', 14, 250000000, 0  FROM dual UNION ALL 
  select 'B13', 'P432', 12, 40000, 0  FROM dual UNION ALL 
  select 'B17', 'P432', 10, 350000, 0  FROM dual UNION ALL 
  select 'B20', 'P432', 15, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P432', 19, 200000, 0  FROM dual UNION ALL 
  select 'B18', 'P432', 14, 450000, 0  FROM dual UNION ALL 
  select 'B42', 'P432', 18, 50000, 0  FROM dual UNION ALL 
  select 'B5', 'P432', 15, 40000, 0  FROM dual UNION ALL 
  select 'B21', 'P432', 17, 1200000, 0  FROM dual UNION ALL 
  select 'B43', 'P433', 1, 200000, 0  FROM dual UNION ALL 
  select 'B25', 'P433', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P434', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P434', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P435', 14, 1000000, 0  FROM dual UNION ALL 
  select 'B9', 'P435', 16, 25000000, 0  FROM dual UNION ALL 
  select 'B16', 'P435', 16, 4000, 0  FROM dual UNION ALL 
  select 'B21', 'P435', 11, 1200000, 0  FROM dual UNION ALL 
  select 'B15', 'P435', 18, 4000, 0  FROM dual UNION ALL 
  select 'B34', 'P435', 18, 20000, 0  FROM dual UNION ALL 
  select 'B9', 'P435', 13, 25000000, 0  FROM dual UNION ALL 
  select 'B6', 'P435', 17, 6000000, 0  FROM dual UNION ALL 
  select 'B19', 'P435', 11, 300000, 0  FROM dual UNION ALL 
  select 'B40', 'P436', 1, 400000, 0  FROM dual UNION ALL 
  select 'B20', 'P436', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P437', 1, 400000, 0  FROM dual UNION ALL 
  select 'B18', 'P437', 1, 450000, 0  FROM dual UNION ALL 
  select 'B37', 'P438', 1, 50000, 0  FROM dual UNION ALL 
  select 'B23', 'P439', 11, 3000000, 0  FROM dual UNION ALL 
  select 'B33', 'P439', 10, 10000, 0  FROM dual UNION ALL 
  select 'B32', 'P439', 10, 20000, 0  FROM dual UNION ALL 
  select 'B26', 'P439', 17, 100000000, 0  FROM dual UNION ALL 
  select 'B6', 'P439', 13, 6000000, 0  FROM dual UNION ALL 
  select 'B17', 'P439', 14, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P439', 14, 400000, 0  FROM dual UNION ALL 
  select 'B9', 'P439', 20, 25000000, 0  FROM dual UNION ALL 
  select 'B27', 'P439', 15, 40000000, 0  FROM dual UNION ALL 
  select 'B19', 'P440', 1, 300000, 0  FROM dual UNION ALL 
  select 'B31', 'P441', 18, 80000, 0  FROM dual UNION ALL 
  select 'B31', 'P441', 16, 80000, 0  FROM dual UNION ALL 
  select 'B7', 'P441', 13, 12000000, 0  FROM dual UNION ALL 
  select 'B24', 'P441', 17, 475000, 0  FROM dual UNION ALL 
  select 'B28', 'P441', 12, 250000000, 0  FROM dual UNION ALL 
  select 'B16', 'P441', 19, 4000, 0  FROM dual UNION ALL 
  select 'B42', 'P441', 17, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P441', 18, 400000, 0  FROM dual UNION ALL 
  select 'B3', 'P441', 10, 20000000, 0  FROM dual UNION ALL 
  select 'B20', 'P441', 16, 350000, 0  FROM dual UNION ALL 
  select 'B39', 'P442', 1, 250000, 0  FROM dual UNION ALL 
  select 'B31', 'P443', 16, 80000, 0  FROM dual UNION ALL 
  select 'B16', 'P443', 19, 4000, 0  FROM dual UNION ALL 
  select 'B13', 'P443', 17, 40000, 0  FROM dual UNION ALL 
  select 'B24', 'P443', 18, 475000, 0  FROM dual UNION ALL 
  select 'B25', 'P443', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B25', 'P443', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B14', 'P443', 15, 4000, 0  FROM dual UNION ALL 
  select 'B31', 'P443', 20, 80000, 0  FROM dual UNION ALL 
  select 'B38', 'P443', 17, 250000, 0  FROM dual UNION ALL 
  select 'B19', 'P443', 15, 300000, 0  FROM dual UNION ALL 
  select 'B38', 'P444', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P444', 1, 500000, 0  FROM dual UNION ALL 
  select 'B40', 'P445', 1, 400000, 0  FROM dual UNION ALL 
  select 'B41', 'P445', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P446', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P447', 1, 200000, 0  FROM dual UNION ALL 
  select 'B24', 'P447', 1, 475000, 0  FROM dual UNION ALL 
  select 'B25', 'P448', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P449', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P450', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P451', 1, 200000, 0  FROM dual UNION ALL 
  select 'B41', 'P452', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P452', 1, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P453', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P454', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P454', 1, 300000, 0  FROM dual UNION ALL 
  select 'B35', 'P455', 10, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P455', 16, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P455', 12, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P455', 17, 100000, 0  FROM dual UNION ALL 
  select 'B18', 'P456', 1, 450000, 0  FROM dual UNION ALL 
  select 'B42', 'P457', 13, 50000, 0  FROM dual UNION ALL 
  select 'B8', 'P457', 17, 20000000, 0  FROM dual UNION ALL 
  select 'B40', 'P457', 20, 400000, 0  FROM dual UNION ALL 
  select 'B11', 'P457', 11, 40000, 0  FROM dual UNION ALL 
  select 'B11', 'P457', 20, 40000, 0  FROM dual UNION ALL 
  select 'B26', 'P457', 14, 100000000, 0  FROM dual UNION ALL 
  select 'B34', 'P457', 10, 20000, 0  FROM dual UNION ALL 
  select 'B5', 'P457', 18, 40000, 0  FROM dual UNION ALL 
  select 'B9', 'P457', 17, 25000000, 0  FROM dual UNION ALL 
  select 'B18', 'P458', 1, 450000, 0  FROM dual UNION ALL 
  select 'B40', 'P458', 1, 400000, 0  FROM dual UNION ALL 
  select 'B19', 'P459', 1, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P460', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P460', 1, 50000, 0  FROM dual UNION ALL 
  select 'B21', 'P461', 10, 1200000, 0  FROM dual UNION ALL 
  select 'B20', 'P461', 20, 350000, 0  FROM dual UNION ALL 
  select 'B30', 'P461', 18, 100000, 0  FROM dual UNION ALL 
  select 'B9', 'P461', 14, 25000000, 0  FROM dual UNION ALL 
  select 'B12', 'P461', 14, 40000, 0  FROM dual UNION ALL 
  select 'B21', 'P461', 12, 1200000, 0  FROM dual UNION ALL 
  select 'B19', 'P461', 10, 300000, 0  FROM dual UNION ALL 
  select 'B40', 'P462', 1, 400000, 0  FROM dual UNION ALL 
  select 'B41', 'P463', 20, 1000000, 0  FROM dual UNION ALL 
  select 'B30', 'P463', 12, 100000, 0  FROM dual UNION ALL 
  select 'B6', 'P463', 10, 6000000, 0  FROM dual UNION ALL 
  select 'B26', 'P463', 13, 100000000, 0  FROM dual UNION ALL 
  select 'B38', 'P463', 10, 250000, 0  FROM dual UNION ALL 
  select 'B31', 'P463', 14, 80000, 0  FROM dual UNION ALL 
  select 'B22', 'P463', 11, 2100000, 0  FROM dual UNION ALL 
  select 'B28', 'P463', 14, 250000000, 0  FROM dual UNION ALL 
  select 'B23', 'P463', 20, 3000000, 0  FROM dual UNION ALL 
  select 'B41', 'P463', 10, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P464', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P465', 1, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P465', 1, 450000, 0  FROM dual UNION ALL 
  select 'B41', 'P466', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P466', 1, 400000, 0  FROM dual UNION ALL 
  select 'B19', 'P467', 1, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P467', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P468', 1, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P469', 1, 400000, 0  FROM dual UNION ALL 
  select 'B34', 'P470', 20, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P470', 20, 100000, 0  FROM dual UNION ALL 
  select 'B32', 'P470', 18, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P470', 20, 850000, 0  FROM dual UNION ALL 
  select 'B31', 'P470', 15, 80000, 0  FROM dual UNION ALL 
  select 'B9', 'P471', 14, 25000000, 0  FROM dual UNION ALL 
  select 'B24', 'P471', 15, 475000, 0  FROM dual UNION ALL 
  select 'B37', 'P471', 18, 50000, 0  FROM dual UNION ALL 
  select 'B2', 'P471', 14, 3025000, 0  FROM dual UNION ALL 
  select 'B15', 'P471', 11, 4000, 0  FROM dual UNION ALL 
  select 'B39', 'P471', 20, 250000, 0  FROM dual UNION ALL 
  select 'B13', 'P471', 18, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P471', 18, 40000000, 0  FROM dual UNION ALL 
  select 'B19', 'P471', 14, 300000, 0  FROM dual UNION ALL 
  select 'B38', 'P472', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P472', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P473', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P474', 1, 400000, 0  FROM dual UNION ALL 
  select 'B5', 'P475', 17, 40000, 0  FROM dual UNION ALL 
  select 'B5', 'P475', 14, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P475', 10, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P475', 10, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P475', 11, 475000, 0  FROM dual UNION ALL 
  select 'B17', 'P475', 12, 350000, 0  FROM dual UNION ALL 
  select 'B35', 'P475', 18, 20000, 0  FROM dual UNION ALL 
  select 'B7', 'P475', 17, 12000000, 0  FROM dual UNION ALL 
  select 'B17', 'P475', 19, 350000, 0  FROM dual UNION ALL 
  select 'B11', 'P475', 15, 40000, 0  FROM dual UNION ALL 
  select 'B22', 'P476', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B36', 'P477', 1, 500000, 0  FROM dual UNION ALL 
  select 'B39', 'P477', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P478', 1, 400000, 0  FROM dual UNION ALL 
  select 'B25', 'P478', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P479', 1, 200000, 0  FROM dual UNION ALL 
  select 'B37', 'P479', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P480', 17, 1000000, 0  FROM dual UNION ALL 
  select 'B34', 'P480', 16, 20000, 0  FROM dual UNION ALL 
  select 'B24', 'P480', 13, 475000, 0  FROM dual UNION ALL 
  select 'B2', 'P480', 18, 3025000, 0  FROM dual UNION ALL 
  select 'B39', 'P480', 14, 250000, 0  FROM dual UNION ALL 
  select 'B3', 'P480', 18, 20000000, 0  FROM dual UNION ALL 
  select 'B13', 'P480', 13, 40000, 0  FROM dual UNION ALL 
  select 'B24', 'P481', 1, 475000, 0  FROM dual UNION ALL 
  select 'B43', 'P481', 1, 200000, 0  FROM dual UNION ALL 
  select 'B41', 'P482', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B22', 'P482', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B20', 'P483', 1, 350000, 0  FROM dual UNION ALL 
  select 'B23', 'P484', 11, 3000000, 0  FROM dual UNION ALL 
  select 'B7', 'P484', 14, 12000000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B27', 'P484', 14, 40000000, 0  FROM dual UNION ALL 
  select 'B29', 'P484', 15, 850000, 0  FROM dual UNION ALL 
  select 'B8', 'P484', 17, 20000000, 0  FROM dual UNION ALL 
  select 'B32', 'P484', 18, 20000, 0  FROM dual UNION ALL 
  select 'B16', 'P484', 17, 4000, 0  FROM dual UNION ALL 
  select 'B22', 'P485', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B23', 'P485', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B20', 'P486', 1, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P487', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P487', 1, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P488', 1, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P488', 1, 450000, 0  FROM dual UNION ALL 
  select 'B7', 'P489', 20, 12000000, 0  FROM dual UNION ALL 
  select 'B18', 'P489', 20, 450000, 0  FROM dual UNION ALL 
  select 'B18', 'P489', 24, 450000, 0  FROM dual UNION ALL 
  select 'B17', 'P489', 30, 350000, 0  FROM dual UNION ALL 
  select 'B33', 'P489', 23, 10000, 0  FROM dual UNION ALL 
  select 'B34', 'P489', 30, 20000, 0  FROM dual UNION ALL 
  select 'B33', 'P489', 18, 10000, 0  FROM dual UNION ALL 
  select 'B37', 'P489', 15, 50000, 0  FROM dual UNION ALL 
  select 'B3', 'P489', 30, 20000000, 0  FROM dual UNION ALL 
  select 'B39', 'P490', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P490', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P491', 1, 200000, 0  FROM dual UNION ALL 
  select 'B22', 'P491', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B38', 'P492', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P493', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P494', 1, 500000, 0  FROM dual UNION ALL 
  select 'B17', 'P495', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P496', 1, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P496', 1, 400000, 0  FROM dual UNION ALL 
  select 'B1', 'P497', 27, 227500, 0  FROM dual UNION ALL 
  select 'B7', 'P497', 26, 12000000, 0  FROM dual UNION ALL 
  select 'B43', 'P497', 26, 200000, 0  FROM dual UNION ALL 
  select 'B32', 'P497', 16, 20000, 0  FROM dual UNION ALL 
  select 'B3', 'P497', 22, 20000000, 0  FROM dual UNION ALL 
  select 'B24', 'P497', 26, 475000, 0  FROM dual UNION ALL 
  select 'B22', 'P498', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B37', 'P499', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P499', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P500', 11, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P500', 17, 250000, 0  FROM dual UNION ALL 
  select 'B16', 'P500', 15, 4000, 0  FROM dual UNION ALL 
  select 'B10', 'P500', 17, 40000, 0  FROM dual UNION ALL 
  select 'B14', 'P500', 16, 4000, 0  FROM dual UNION ALL 
  select 'B33', 'P500', 11, 10000, 0  FROM dual UNION ALL 
  select 'B29', 'P501', 18, 850000, 0  FROM dual UNION ALL 
  select 'B35', 'P501', 16, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P501', 19, 80000, 0  FROM dual UNION ALL 
  select 'B34', 'P501', 19, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P501', 18, 20000, 0  FROM dual UNION ALL 
  select 'B23', 'P502', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B39', 'P503', 1, 250000, 0  FROM dual UNION ALL 
  select 'B21', 'P503', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B38', 'P504', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P504', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P505', 28, 50000, 0  FROM dual UNION ALL 
  select 'B15', 'P505', 25, 4000, 0  FROM dual UNION ALL 
  select 'B30', 'P505', 30, 100000, 0  FROM dual UNION ALL 
  select 'B38', 'P506', 1, 250000, 0  FROM dual UNION ALL 
  select 'B24', 'P506', 1, 475000, 0  FROM dual UNION ALL 
  select 'B36', 'P507', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P507', 1, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P508', 1, 450000, 0  FROM dual UNION ALL 
  select 'B38', 'P509', 1, 250000, 0  FROM dual UNION ALL 
  select 'B20', 'P509', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P510', 1, 200000, 0  FROM dual UNION ALL 
  select 'B24', 'P511', 1, 475000, 0  FROM dual UNION ALL 
  select 'B41', 'P512', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P512', 22, 50000, 0  FROM dual UNION ALL 
  select 'B31', 'P512', 17, 80000, 0  FROM dual UNION ALL 
  select 'B9', 'P512', 15, 25000000, 0  FROM dual UNION ALL 
  select 'B32', 'P512', 28, 20000, 0  FROM dual UNION ALL 
  select 'B25', 'P512', 22, 1000000, 0  FROM dual UNION ALL 
  select 'B14', 'P512', 23, 4000, 0  FROM dual UNION ALL 
  select 'B16', 'P512', 18, 4000, 0  FROM dual UNION ALL 
  select 'B23', 'P512', 20, 3000000, 0  FROM dual UNION ALL 
  select 'B20', 'P512', 18, 350000, 0  FROM dual UNION ALL 
  select 'B24', 'P513', 18, 475000, 0  FROM dual UNION ALL 
  select 'B33', 'P513', 20, 10000, 0  FROM dual UNION ALL 
  select 'B38', 'P513', 10, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P513', 13, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P513', 20, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P513', 12, 350000, 0  FROM dual UNION ALL 
  select 'B32', 'P513', 19, 20000, 0  FROM dual UNION ALL 
  select 'B43', 'P514', 1, 200000, 0  FROM dual UNION ALL 
  select 'B22', 'P515', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B37', 'P515', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P516', 1, 50000, 0  FROM dual UNION ALL 
  select 'B23', 'P516', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B42', 'P517', 19, 50000, 0  FROM dual UNION ALL 
  select 'B3', 'P517', 11, 20000000, 0  FROM dual UNION ALL 
  select 'B7', 'P517', 14, 12000000, 0  FROM dual UNION ALL 
  select 'B30', 'P517', 11, 100000, 0  FROM dual UNION ALL 
  select 'B43', 'P517', 10, 200000, 0  FROM dual UNION ALL 
  select 'B20', 'P518', 22, 350000, 0  FROM dual UNION ALL 
  select 'B31', 'P518', 25, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P518', 26, 100000, 0  FROM dual UNION ALL 
  select 'B32', 'P518', 26, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P519', 20, 100000, 0  FROM dual UNION ALL 
  select 'B31', 'P519', 20, 80000, 0  FROM dual UNION ALL 
  select 'B29', 'P519', 18, 850000, 0  FROM dual UNION ALL 
  select 'B32', 'P519', 11, 20000, 0  FROM dual UNION ALL 
  select 'B18', 'P520', 1, 450000, 0  FROM dual UNION ALL 
  select 'B17', 'P521', 1, 350000, 0  FROM dual UNION ALL 
  select 'B23', 'P521', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B40', 'P522', 1, 400000, 0  FROM dual UNION ALL 
  select 'B37', 'P523', 1, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P524', 1, 450000, 0  FROM dual UNION ALL 
  select 'B24', 'P525', 1, 475000, 0  FROM dual UNION ALL 
  select 'B37', 'P526', 1, 50000, 0  FROM dual UNION ALL 
  select 'B29', 'P527', 18, 850000, 0  FROM dual UNION ALL 
  select 'B34', 'P527', 10, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P527', 14, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P527', 17, 100000, 0  FROM dual UNION ALL 
  select 'B31', 'P527', 20, 80000, 0  FROM dual UNION ALL 
  select 'B36', 'P528', 1, 500000, 0  FROM dual UNION ALL 
  select 'B42', 'P529', 1, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P529', 1, 450000, 0  FROM dual UNION ALL 
  select 'B36', 'P530', 1, 500000, 0  FROM dual UNION ALL 
  select 'B17', 'P531', 1, 350000, 0  FROM dual UNION ALL 
  select 'B22', 'P532', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B20', 'P533', 1, 350000, 0  FROM dual UNION ALL 
  select 'B35', 'P534', 20, 20000, 0  FROM dual UNION ALL 
  select 'B43', 'P534', 29, 200000, 0  FROM dual UNION ALL 
  select 'B35', 'P534', 23, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P534', 18, 20000, 0  FROM dual UNION ALL 
  select 'B6', 'P534', 28, 6000000, 0  FROM dual UNION ALL 
  select 'B19', 'P534', 16, 300000, 0  FROM dual UNION ALL 
  select 'B13', 'P534', 25, 40000, 0  FROM dual UNION ALL 
  select 'B7', 'P534', 22, 12000000, 0  FROM dual UNION ALL 
  select 'B23', 'P534', 28, 3000000, 0  FROM dual UNION ALL 
  select 'B32', 'P535', 11, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P535', 11, 20000, 0  FROM dual UNION ALL 
  select 'B38', 'P535', 14, 250000, 0  FROM dual UNION ALL 
  select 'B19', 'P535', 11, 300000, 0  FROM dual UNION ALL 
  select 'B25', 'P535', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B32', 'P535', 17, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P536', 13, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P536', 12, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P536', 12, 20000, 0  FROM dual UNION ALL 
  select 'B39', 'P537', 1, 250000, 0  FROM dual UNION ALL 
  select 'B38', 'P537', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P538', 1, 500000, 0  FROM dual UNION ALL 
  select 'B14', 'P539', 19, 4000, 0  FROM dual UNION ALL 
  select 'B24', 'P539', 16, 475000, 0  FROM dual UNION ALL 
  select 'B26', 'P539', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B24', 'P539', 20, 475000, 0  FROM dual UNION ALL 
  select 'B40', 'P539', 19, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P539', 12, 400000, 0  FROM dual UNION ALL 
  select 'B38', 'P540', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P540', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P541', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P541', 1, 300000, 0  FROM dual UNION ALL 
  select 'B22', 'P542', 25, 2100000, 0  FROM dual UNION ALL 
  select 'B25', 'P542', 30, 1000000, 0  FROM dual UNION ALL 
  select 'B5', 'P542', 28, 40000, 0  FROM dual UNION ALL 
  select 'B10', 'P542', 30, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P542', 22, 450000, 0  FROM dual UNION ALL 
  select 'B29', 'P542', 19, 850000, 0  FROM dual UNION ALL 
  select 'B16', 'P542', 15, 4000, 0  FROM dual UNION ALL 
  select 'B13', 'P543', 29, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P543', 19, 40000000, 0  FROM dual UNION ALL 
  select 'B42', 'P543', 26, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P543', 26, 50000, 0  FROM dual UNION ALL 
  select 'B13', 'P543', 22, 40000, 0  FROM dual UNION ALL 
  select 'B36', 'P543', 30, 500000, 0  FROM dual UNION ALL 
  select 'B13', 'P544', 19, 40000, 0  FROM dual UNION ALL 
  select 'B10', 'P544', 15, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P544', 13, 40000000, 0  FROM dual UNION ALL 
  select 'B23', 'P544', 15, 3000000, 0  FROM dual UNION ALL 
  select 'B7', 'P544', 17, 12000000, 0  FROM dual UNION ALL 
  select 'B28', 'P544', 19, 250000000, 0  FROM dual UNION ALL 
  select 'B11', 'P544', 16, 40000, 0  FROM dual UNION ALL 
  select 'B35', 'P544', 11, 20000, 0  FROM dual UNION ALL 
  select 'B41', 'P544', 14, 1000000, 0  FROM dual UNION ALL 
  select 'B18', 'P545', 1, 450000, 0  FROM dual UNION ALL 
  select 'B42', 'P545', 1, 50000, 0  FROM dual UNION ALL 
  select 'B5', 'P546', 25, 40000, 0  FROM dual UNION ALL 
  select 'B5', 'P546', 26, 40000, 0  FROM dual UNION ALL 
  select 'B43', 'P546', 20, 200000, 0  FROM dual UNION ALL 
  select 'B20', 'P547', 1, 350000, 0  FROM dual UNION ALL 
  select 'B23', 'P547', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B41', 'P548', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P548', 1, 400000, 0  FROM dual UNION ALL 
  select 'B30', 'P549', 20, 100000, 0  FROM dual UNION ALL 
  select 'B13', 'P549', 23, 40000, 0  FROM dual UNION ALL 
  select 'B3', 'P549', 29, 20000000, 0  FROM dual UNION ALL 
  select 'B6', 'P549', 19, 6000000, 0  FROM dual UNION ALL 
  select 'B5', 'P549', 30, 40000, 0  FROM dual UNION ALL 
  select 'B23', 'P549', 27, 3000000, 0  FROM dual UNION ALL 
  select 'B40', 'P549', 22, 400000, 0  FROM dual UNION ALL 
  select 'B29', 'P549', 26, 850000, 0  FROM dual UNION ALL 
  select 'B4', 'P550', 10, 3100000, 0  FROM dual UNION ALL 
  select 'B8', 'P550', 16, 20000000, 0  FROM dual UNION ALL 
  select 'B19', 'P550', 10, 300000, 0  FROM dual UNION ALL 
  select 'B21', 'P550', 16, 1200000, 0  FROM dual UNION ALL 
  select 'B23', 'P550', 16, 3000000, 0  FROM dual UNION ALL 
  select 'B21', 'P550', 16, 1200000, 0  FROM dual UNION ALL 
  select 'B42', 'P550', 17, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P551', 1, 450000, 0  FROM dual UNION ALL 
  select 'B23', 'P551', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B22', 'P552', 16, 2100000, 0  FROM dual UNION ALL 
  select 'B8', 'P552', 16, 20000000, 0  FROM dual UNION ALL 
  select 'B32', 'P552', 12, 20000, 0  FROM dual UNION ALL 
  select 'B39', 'P552', 14, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P552', 16, 200000, 0  FROM dual UNION ALL 
  select 'B9', 'P552', 20, 25000000, 0  FROM dual UNION ALL 
  select 'B25', 'P553', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P553', 1, 475000, 0  FROM dual UNION ALL 
  select 'B19', 'P554', 1, 300000, 0  FROM dual UNION ALL 
  select 'B17', 'P554', 1, 350000, 0  FROM dual UNION ALL 
  select 'B38', 'P555', 1, 250000, 0  FROM dual UNION ALL 
  select 'B19', 'P556', 28, 300000, 0  FROM dual UNION ALL 
  select 'B6', 'P556', 23, 6000000, 0  FROM dual UNION ALL 
  select 'B29', 'P556', 30, 850000, 0  FROM dual UNION ALL 
  select 'B42', 'P556', 15, 50000, 0  FROM dual UNION ALL 
  select 'B7', 'P556', 25, 12000000, 0  FROM dual UNION ALL 
  select 'B37', 'P556', 25, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P557', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B41', 'P558', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B25', 'P558', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B31', 'P559', 11, 80000, 0  FROM dual UNION ALL 
  select 'B35', 'P559', 18, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P559', 15, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P559', 20, 850000, 0  FROM dual UNION ALL 
  select 'B38', 'P560', 10, 250000, 0  FROM dual UNION ALL 
  select 'B35', 'P560', 20, 20000, 0  FROM dual UNION ALL 
  select 'B18', 'P560', 14, 450000, 0  FROM dual UNION ALL 
  select 'B5', 'P560', 11, 40000, 0  FROM dual UNION ALL 
  select 'B31', 'P560', 18, 80000, 0  FROM dual UNION ALL 
  select 'B2', 'P560', 10, 3025000, 0  FROM dual UNION ALL 
  select 'B8', 'P560', 13, 20000000, 0  FROM dual UNION ALL 
  select 'B35', 'P560', 17, 20000, 0  FROM dual UNION ALL 
  select 'B11', 'P561', 16, 40000, 0  FROM dual UNION ALL 
  select 'B33', 'P561', 19, 10000, 0  FROM dual UNION ALL 
  select 'B8', 'P561', 13, 20000000, 0  FROM dual UNION ALL 
  select 'B8', 'P561', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B7', 'P561', 14, 12000000, 0  FROM dual UNION ALL 
  select 'B27', 'P561', 18, 40000000, 0  FROM dual UNION ALL 
  select 'B14', 'P561', 18, 4000, 0  FROM dual UNION ALL 
  select 'B42', 'P561', 15, 50000, 0  FROM dual UNION ALL 
  select 'B31', 'P561', 19, 80000, 0  FROM dual UNION ALL 
  select 'B41', 'P562', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B10', 'P563', 20, 40000, 0  FROM dual UNION ALL 
  select 'B23', 'P563', 15, 3000000, 0  FROM dual UNION ALL 
  select 'B3', 'P563', 17, 20000000, 0  FROM dual UNION ALL 
  select 'B25', 'P563', 13, 1000000, 0  FROM dual UNION ALL 
  select 'B8', 'P563', 17, 20000000, 0  FROM dual UNION ALL 
  select 'B17', 'P563', 19, 350000, 0  FROM dual UNION ALL 
  select 'B29', 'P563', 20, 850000, 0  FROM dual UNION ALL 
  select 'B21', 'P563', 12, 1200000, 0  FROM dual UNION ALL 
  select 'B26', 'P563', 20, 100000000, 0  FROM dual UNION ALL 
  select 'B17', 'P563', 10, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P564', 1, 500000, 0  FROM dual UNION ALL 
  select 'B25', 'P564', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B22', 'P565', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B22', 'P566', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B19', 'P567', 1, 300000, 0  FROM dual UNION ALL 
  select 'B39', 'P568', 1, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P569', 13, 450000, 0  FROM dual UNION ALL 
  select 'B39', 'P569', 15, 250000, 0  FROM dual UNION ALL 
  select 'B2', 'P569', 18, 3025000, 0  FROM dual UNION ALL 
  select 'B18', 'P569', 10, 450000, 0  FROM dual UNION ALL 
  select 'B15', 'P569', 15, 4000, 0  FROM dual UNION ALL 
  select 'B38', 'P569', 12, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P569', 17, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P569', 18, 350000, 0  FROM dual UNION ALL 
  select 'B17', 'P570', 1, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P570', 1, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P571', 1, 400000, 0  FROM dual UNION ALL 
  select 'B17', 'P571', 1, 350000, 0  FROM dual UNION ALL 
  select 'B25', 'P572', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B30', 'P572', 11, 100000, 0  FROM dual UNION ALL 
  select 'B15', 'P572', 15, 4000, 0  FROM dual UNION ALL 
  select 'B41', 'P572', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P572', 15, 350000, 0  FROM dual UNION ALL 
  select 'B16', 'P572', 13, 4000, 0  FROM dual UNION ALL 
  select 'B25', 'P572', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P573', 17, 475000, 0  FROM dual UNION ALL 
  select 'B3', 'P573', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B9', 'P573', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B13', 'P573', 19, 40000, 0  FROM dual UNION ALL 
  select 'B31', 'P573', 18, 80000, 0  FROM dual UNION ALL 
  select 'B20', 'P574', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P574', 1, 400000, 0  FROM dual UNION ALL 
  select 'B31', 'P575', 17, 80000, 0  FROM dual UNION ALL 
  select 'B35', 'P575', 20, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P575', 19, 20000, 0  FROM dual UNION ALL 
  select 'B21', 'P576', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B36', 'P577', 1, 500000, 0  FROM dual UNION ALL 
  select 'B21', 'P577', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B37', 'P578', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P579', 1, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P580', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B41', 'P580', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B35', 'P581', 16, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P581', 19, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P581', 12, 100000, 0  FROM dual UNION ALL 
  select 'B31', 'P581', 10, 80000, 0  FROM dual UNION ALL 
  select 'B31', 'P581', 19, 80000, 0  FROM dual UNION ALL 
  select 'B40', 'P582', 1, 400000, 0  FROM dual UNION ALL 
  select 'B28', 'P583', 13, 250000000, 0  FROM dual UNION ALL 
  select 'B15', 'P583', 15, 4000, 0  FROM dual UNION ALL 
  select 'B40', 'P583', 20, 400000, 0  FROM dual UNION ALL 
  select 'B35', 'P583', 17, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P583', 10, 850000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B43', 'P583', 12, 200000, 0  FROM dual UNION ALL 
  select 'B33', 'P583', 11, 10000, 0  FROM dual UNION ALL 
  select 'B5', 'P583', 17, 40000, 0  FROM dual UNION ALL 
  select 'B42', 'P584', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P585', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P585', 1, 400000, 0  FROM dual UNION ALL 
  select 'B5', 'P586', 17, 40000, 0  FROM dual UNION ALL 
  select 'B9', 'P586', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B31', 'P586', 18, 80000, 0  FROM dual UNION ALL 
  select 'B7', 'P586', 11, 12000000, 0  FROM dual UNION ALL 
  select 'B28', 'P586', 10, 250000000, 0  FROM dual UNION ALL 
  select 'B29', 'P586', 14, 850000, 0  FROM dual UNION ALL 
  select 'B41', 'P586', 19, 1000000, 0  FROM dual UNION ALL 
  select 'B4', 'P586', 13, 3100000, 0  FROM dual UNION ALL 
  select 'B23', 'P586', 17, 3000000, 0  FROM dual UNION ALL 
  select 'B33', 'P587', 14, 10000, 0  FROM dual UNION ALL 
  select 'B29', 'P587', 17, 850000, 0  FROM dual UNION ALL 
  select 'B35', 'P587', 12, 20000, 0  FROM dual UNION ALL 
  select 'B24', 'P587', 11, 475000, 0  FROM dual UNION ALL 
  select 'B9', 'P587', 13, 25000000, 0  FROM dual UNION ALL 
  select 'B9', 'P587', 17, 25000000, 0  FROM dual UNION ALL 
  select 'B39', 'P587', 18, 250000, 0  FROM dual UNION ALL 
  select 'B2', 'P587', 16, 3025000, 0  FROM dual UNION ALL 
  select 'B40', 'P587', 17, 400000, 0  FROM dual UNION ALL 
  select 'B22', 'P587', 13, 2100000, 0  FROM dual UNION ALL 
  select 'B19', 'P588', 1, 300000, 0  FROM dual UNION ALL 
  select 'B24', 'P588', 1, 475000, 0  FROM dual UNION ALL 
  select 'B43', 'P589', 15, 200000, 0  FROM dual UNION ALL 
  select 'B28', 'P589', 15, 250000000, 0  FROM dual UNION ALL 
  select 'B12', 'P589', 18, 40000, 0  FROM dual UNION ALL 
  select 'B4', 'P589', 11, 3100000, 0  FROM dual UNION ALL 
  select 'B36', 'P589', 15, 500000, 0  FROM dual UNION ALL 
  select 'B19', 'P590', 1, 300000, 0  FROM dual UNION ALL 
  select 'B5', 'P591', 22, 40000, 0  FROM dual UNION ALL 
  select 'B11', 'P591', 22, 40000, 0  FROM dual UNION ALL 
  select 'B8', 'P591', 18, 20000000, 0  FROM dual UNION ALL 
  select 'B26', 'P591', 30, 100000000, 0  FROM dual UNION ALL 
  select 'B22', 'P592', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B40', 'P593', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P594', 1, 500000, 0  FROM dual UNION ALL 
  select 'B18', 'P595', 1, 450000, 0  FROM dual UNION ALL 
  select 'B25', 'P596', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P597', 1, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P597', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P598', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P598', 1, 250000, 0  FROM dual UNION ALL 
  select 'B17', 'P599', 10, 350000, 0  FROM dual UNION ALL 
  select 'B17', 'P599', 10, 350000, 0  FROM dual UNION ALL 
  select 'B27', 'P599', 13, 40000000, 0  FROM dual UNION ALL 
  select 'B42', 'P599', 13, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P599', 18, 50000, 0  FROM dual UNION ALL 
  select 'B9', 'P599', 17, 25000000, 0  FROM dual UNION ALL 
  select 'B37', 'P600', 1, 50000, 0  FROM dual UNION ALL 
  select 'B23', 'P600', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B23', 'P601', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B41', 'P602', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B29', 'P603', 20, 850000, 0  FROM dual UNION ALL 
  select 'B29', 'P603', 12, 850000, 0  FROM dual UNION ALL 
  select 'B30', 'P603', 20, 100000, 0  FROM dual UNION ALL 
  select 'B18', 'P604', 1, 450000, 0  FROM dual UNION ALL 
  select 'B43', 'P604', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P605', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P605', 1, 50000, 0  FROM dual UNION ALL 
  select 'B24', 'P606', 20, 475000, 0  FROM dual UNION ALL 
  select 'B33', 'P606', 14, 10000, 0  FROM dual UNION ALL 
  select 'B31', 'P606', 20, 80000, 0  FROM dual UNION ALL 
  select 'B25', 'P606', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B30', 'P606', 13, 100000, 0  FROM dual UNION ALL 
  select 'B7', 'P606', 16, 12000000, 0  FROM dual UNION ALL 
  select 'B30', 'P606', 13, 100000, 0  FROM dual UNION ALL 
  select 'B6', 'P606', 20, 6000000, 0  FROM dual UNION ALL 
  select 'B33', 'P606', 18, 10000, 0  FROM dual UNION ALL 
  select 'B31', 'P606', 17, 80000, 0  FROM dual UNION ALL 
  select 'B23', 'P607', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B19', 'P607', 1, 300000, 0  FROM dual UNION ALL 
  select 'B39', 'P608', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P608', 1, 250000, 0  FROM dual UNION ALL 
  select 'B19', 'P609', 1, 300000, 0  FROM dual UNION ALL 
  select 'B24', 'P609', 1, 475000, 0  FROM dual UNION ALL 
  select 'B38', 'P610', 19, 250000, 0  FROM dual UNION ALL 
  select 'B35', 'P610', 16, 20000, 0  FROM dual UNION ALL 
  select 'B23', 'P610', 25, 3000000, 0  FROM dual UNION ALL 
  select 'B13', 'P610', 22, 40000, 0  FROM dual UNION ALL 
  select 'B3', 'P611', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B18', 'P611', 17, 450000, 0  FROM dual UNION ALL 
  select 'B26', 'P611', 12, 100000000, 0  FROM dual UNION ALL 
  select 'B29', 'P611', 10, 850000, 0  FROM dual UNION ALL 
  select 'B13', 'P611', 13, 40000, 0  FROM dual UNION ALL 
  select 'B29', 'P611', 20, 850000, 0  FROM dual UNION ALL 
  select 'B25', 'P611', 19, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P612', 1, 200000, 0  FROM dual UNION ALL 
  select 'B25', 'P613', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P614', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P614', 1, 250000, 0  FROM dual UNION ALL 
  select 'B23', 'P615', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B41', 'P616', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P617', 1, 400000, 0  FROM dual UNION ALL 
  select 'B43', 'P617', 1, 200000, 0  FROM dual UNION ALL 
  select 'B16', 'P618', 26, 4000, 0  FROM dual UNION ALL 
  select 'B32', 'P618', 27, 20000, 0  FROM dual UNION ALL 
  select 'B43', 'P618', 20, 200000, 0  FROM dual UNION ALL 
  select 'B14', 'P618', 30, 4000, 0  FROM dual UNION ALL 
  select 'B10', 'P618', 26, 40000, 0  FROM dual UNION ALL 
  select 'B4', 'P618', 18, 3100000, 0  FROM dual UNION ALL 
  select 'B1', 'P618', 29, 227500, 0  FROM dual UNION ALL 
  select 'B42', 'P618', 19, 50000, 0  FROM dual UNION ALL 
  select 'B31', 'P618', 19, 80000, 0  FROM dual UNION ALL 
  select 'B19', 'P619', 10, 300000, 0  FROM dual UNION ALL 
  select 'B21', 'P619', 18, 1200000, 0  FROM dual UNION ALL 
  select 'B15', 'P619', 18, 4000, 0  FROM dual UNION ALL 
  select 'B7', 'P619', 17, 12000000, 0  FROM dual UNION ALL 
  select 'B26', 'P619', 11, 100000000, 0  FROM dual UNION ALL 
  select 'B30', 'P619', 17, 100000, 0  FROM dual UNION ALL 
  select 'B23', 'P619', 17, 3000000, 0  FROM dual UNION ALL 
  select 'B5', 'P619', 10, 40000, 0  FROM dual UNION ALL 
  select 'B43', 'P619', 13, 200000, 0  FROM dual UNION ALL 
  select 'B37', 'P620', 17, 50000, 0  FROM dual UNION ALL 
  select 'B17', 'P620', 15, 350000, 0  FROM dual UNION ALL 
  select 'B21', 'P620', 17, 1200000, 0  FROM dual UNION ALL 
  select 'B10', 'P620', 17, 40000, 0  FROM dual UNION ALL 
  select 'B5', 'P620', 14, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P620', 12, 6000000, 0  FROM dual UNION ALL 
  select 'B15', 'P620', 12, 4000, 0  FROM dual UNION ALL 
  select 'B28', 'P620', 14, 250000000, 0  FROM dual UNION ALL 
  select 'B3', 'P621', 22, 20000000, 0  FROM dual UNION ALL 
  select 'B43', 'P621', 15, 200000, 0  FROM dual UNION ALL 
  select 'B3', 'P621', 23, 20000000, 0  FROM dual UNION ALL 
  select 'B19', 'P621', 27, 300000, 0  FROM dual UNION ALL 
  select 'B37', 'P621', 19, 50000, 0  FROM dual UNION ALL 
  select 'B14', 'P621', 18, 4000, 0  FROM dual UNION ALL 
  select 'B28', 'P621', 30, 250000000, 0  FROM dual UNION ALL 
  select 'B39', 'P621', 19, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P622', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P622', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P623', 1, 500000, 0  FROM dual UNION ALL 
  select 'B43', 'P624', 1, 200000, 0  FROM dual UNION ALL 
  select 'B18', 'P625', 1, 450000, 0  FROM dual UNION ALL 
  select 'B25', 'P625', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B22', 'P626', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B22', 'P626', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B38', 'P627', 1, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P627', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B31', 'P628', 20, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P628', 13, 100000, 0  FROM dual UNION ALL 
  select 'B32', 'P628', 14, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P628', 15, 20000, 0  FROM dual UNION ALL 
  select 'B39', 'P629', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P630', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P630', 1, 50000, 0  FROM dual UNION ALL 
  select 'B24', 'P631', 1, 475000, 0  FROM dual UNION ALL 
  select 'B42', 'P631', 1, 50000, 0  FROM dual UNION ALL 
  select 'B35', 'P632', 14, 20000, 0  FROM dual UNION ALL 
  select 'B18', 'P632', 11, 450000, 0  FROM dual UNION ALL 
  select 'B31', 'P632', 19, 80000, 0  FROM dual UNION ALL 
  select 'B39', 'P632', 17, 250000, 0  FROM dual UNION ALL 
  select 'B35', 'P632', 13, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P633', 16, 20000, 0  FROM dual UNION ALL 
  select 'B14', 'P633', 20, 4000, 0  FROM dual UNION ALL 
  select 'B31', 'P633', 15, 80000, 0  FROM dual UNION ALL 
  select 'B18', 'P633', 11, 450000, 0  FROM dual UNION ALL 
  select 'B10', 'P633', 15, 40000, 0  FROM dual UNION ALL 
  select 'B29', 'P633', 14, 850000, 0  FROM dual UNION ALL 
  select 'B12', 'P633', 15, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P633', 11, 40000000, 0  FROM dual UNION ALL 
  select 'B36', 'P633', 11, 500000, 0  FROM dual UNION ALL 
  select 'B12', 'P633', 12, 40000, 0  FROM dual UNION ALL 
  select 'B26', 'P634', 15, 100000000, 0  FROM dual UNION ALL 
  select 'B4', 'P634', 13, 3100000, 0  FROM dual UNION ALL 
  select 'B39', 'P634', 11, 250000, 0  FROM dual UNION ALL 
  select 'B5', 'P634', 12, 40000, 0  FROM dual UNION ALL 
  select 'B7', 'P634', 13, 12000000, 0  FROM dual UNION ALL 
  select 'B31', 'P634', 13, 80000, 0  FROM dual UNION ALL 
  select 'B20', 'P635', 1, 350000, 0  FROM dual UNION ALL 
  select 'B34', 'P636', 15, 20000, 0  FROM dual UNION ALL 
  select 'B38', 'P636', 17, 250000, 0  FROM dual UNION ALL 
  select 'B12', 'P636', 14, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P636', 11, 6000000, 0  FROM dual UNION ALL 
  select 'B33', 'P636', 13, 10000, 0  FROM dual UNION ALL 
  select 'B16', 'P636', 15, 4000, 0  FROM dual UNION ALL 
  select 'B11', 'P636', 14, 40000, 0  FROM dual UNION ALL 
  select 'B12', 'P637', 15, 40000, 0  FROM dual UNION ALL 
  select 'B23', 'P637', 12, 3000000, 0  FROM dual UNION ALL 
  select 'B7', 'P637', 18, 12000000, 0  FROM dual UNION ALL 
  select 'B33', 'P637', 20, 10000, 0  FROM dual UNION ALL 
  select 'B18', 'P637', 17, 450000, 0  FROM dual UNION ALL 
  select 'B9', 'P637', 13, 25000000, 0  FROM dual UNION ALL 
  select 'B25', 'P637', 12, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P638', 1, 50000, 0  FROM dual UNION ALL 
  select 'B27', 'P639', 17, 40000000, 0  FROM dual UNION ALL 
  select 'B4', 'P639', 12, 3100000, 0  FROM dual UNION ALL 
  select 'B43', 'P639', 15, 200000, 0  FROM dual UNION ALL 
  select 'B27', 'P639', 17, 40000000, 0  FROM dual UNION ALL 
  select 'B33', 'P639', 15, 10000, 0  FROM dual UNION ALL 
  select 'B43', 'P640', 1, 200000, 0  FROM dual UNION ALL 
  select 'B36', 'P640', 1, 500000, 0  FROM dual UNION ALL 
  select 'B36', 'P641', 1, 500000, 0  FROM dual UNION ALL 
  select 'B24', 'P641', 1, 475000, 0  FROM dual UNION ALL 
  select 'B24', 'P642', 1, 475000, 0  FROM dual UNION ALL 
  select 'B24', 'P642', 1, 475000, 0  FROM dual UNION ALL 
  select 'B17', 'P643', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P643', 1, 200000, 0  FROM dual UNION ALL 
  select 'B18', 'P644', 1, 450000, 0  FROM dual UNION ALL 
  select 'B38', 'P644', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P645', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P646', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P646', 1, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P647', 1, 400000, 0  FROM dual UNION ALL 
  select 'B41', 'P647', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B29', 'P648', 12, 850000, 0  FROM dual UNION ALL 
  select 'B4', 'P648', 13, 3100000, 0  FROM dual UNION ALL 
  select 'B2', 'P648', 12, 3025000, 0  FROM dual UNION ALL 
  select 'B16', 'P648', 10, 4000, 0  FROM dual UNION ALL 
  select 'B31', 'P648', 11, 80000, 0  FROM dual UNION ALL 
  select 'B39', 'P648', 14, 250000, 0  FROM dual UNION ALL 
  select 'B10', 'P648', 20, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P648', 11, 6000000, 0  FROM dual UNION ALL 
  select 'B5', 'P648', 16, 40000, 0  FROM dual UNION ALL 
  select 'B11', 'P648', 11, 40000, 0  FROM dual UNION ALL 
  select 'B40', 'P649', 1, 400000, 0  FROM dual UNION ALL 
  select 'B8', 'P650', 10, 20000000, 0  FROM dual UNION ALL 
  select 'B39', 'P650', 15, 250000, 0  FROM dual UNION ALL 
  select 'B35', 'P650', 15, 20000, 0  FROM dual UNION ALL 
  select 'B40', 'P650', 10, 400000, 0  FROM dual UNION ALL 
  select 'B12', 'P650', 11, 40000, 0  FROM dual UNION ALL 
  select 'B22', 'P650', 14, 2100000, 0  FROM dual UNION ALL 
  select 'B14', 'P650', 10, 4000, 0  FROM dual UNION ALL 
  select 'B20', 'P650', 10, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P651', 1, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P651', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P652', 1, 500000, 0  FROM dual UNION ALL 
  select 'B43', 'P653', 1, 200000, 0  FROM dual UNION ALL 
  select 'B37', 'P653', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P654', 1, 50000, 0  FROM dual UNION ALL 
  select 'B17', 'P654', 1, 350000, 0  FROM dual UNION ALL 
  select 'B24', 'P655', 1, 475000, 0  FROM dual UNION ALL 
  select 'B17', 'P656', 23, 350000, 0  FROM dual UNION ALL 
  select 'B32', 'P656', 22, 20000, 0  FROM dual UNION ALL 
  select 'B25', 'P656', 27, 1000000, 0  FROM dual UNION ALL 
  select 'B13', 'P656', 18, 40000, 0  FROM dual UNION ALL 
  select 'B10', 'P656', 20, 40000, 0  FROM dual UNION ALL 
  select 'B13', 'P656', 28, 40000, 0  FROM dual UNION ALL 
  select 'B9', 'P656', 28, 25000000, 0  FROM dual UNION ALL 
  select 'B18', 'P657', 1, 450000, 0  FROM dual UNION ALL 
  select 'B22', 'P657', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B36', 'P658', 1, 500000, 0  FROM dual UNION ALL 
  select 'B18', 'P658', 1, 450000, 0  FROM dual UNION ALL 
  select 'B20', 'P659', 1, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P659', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P660', 15, 50000, 0  FROM dual UNION ALL 
  select 'B11', 'P660', 11, 40000, 0  FROM dual UNION ALL 
  select 'B43', 'P660', 18, 200000, 0  FROM dual UNION ALL 
  select 'B19', 'P660', 17, 300000, 0  FROM dual UNION ALL 
  select 'B12', 'P660', 13, 40000, 0  FROM dual UNION ALL 
  select 'B24', 'P660', 18, 475000, 0  FROM dual UNION ALL 
  select 'B37', 'P660', 18, 50000, 0  FROM dual UNION ALL 
  select 'B9', 'P660', 18, 25000000, 0  FROM dual UNION ALL 
  select 'B41', 'P660', 17, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P661', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P662', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P662', 1, 300000, 0  FROM dual UNION ALL 
  select 'B42', 'P663', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P663', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P664', 1, 200000, 0  FROM dual UNION ALL 
  select 'B22', 'P665', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B21', 'P665', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B42', 'P666', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P667', 1, 250000, 0  FROM dual UNION ALL 
  select 'B20', 'P668', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P668', 1, 200000, 0  FROM dual UNION ALL 
  select 'B32', 'P669', 14, 20000, 0  FROM dual UNION ALL 
  select 'B6', 'P669', 10, 6000000, 0  FROM dual UNION ALL 
  select 'B5', 'P669', 15, 40000, 0  FROM dual UNION ALL 
  select 'B12', 'P669', 10, 40000, 0  FROM dual UNION ALL 
  select 'B43', 'P669', 13, 200000, 0  FROM dual UNION ALL 
  select 'B22', 'P669', 13, 2100000, 0  FROM dual UNION ALL 
  select 'B8', 'P669', 16, 20000000, 0  FROM dual UNION ALL 
  select 'B42', 'P670', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P670', 1, 500000, 0  FROM dual UNION ALL 
  select 'B41', 'P671', 12, 1000000, 0  FROM dual UNION ALL 
  select 'B20', 'P671', 15, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P671', 14, 200000, 0  FROM dual UNION ALL 
  select 'B24', 'P671', 12, 475000, 0  FROM dual UNION ALL 
  select 'B14', 'P671', 20, 4000, 0  FROM dual UNION ALL 
  select 'B32', 'P671', 19, 20000, 0  FROM dual UNION ALL 
  select 'B19', 'P671', 20, 300000, 0  FROM dual UNION ALL 
  select 'B4', 'P671', 10, 3100000, 0  FROM dual UNION ALL 
  select 'B34', 'P672', 19, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P672', 16, 850000, 0  FROM dual UNION ALL 
  select 'B35', 'P672', 16, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P672', 13, 850000, 0  FROM dual UNION ALL 
  select 'B29', 'P672', 16, 850000, 0  FROM dual UNION ALL 
  select 'B36', 'P673', 1, 500000, 0  FROM dual UNION ALL 
  select 'B21', 'P673', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B40', 'P674', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P674', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P675', 1, 500000, 0  FROM dual UNION ALL 
  select 'B23', 'P675', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B18', 'P676', 1, 450000, 0  FROM dual UNION ALL 
  select 'B21', 'P677', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B40', 'P678', 1, 400000, 0  FROM dual UNION ALL 
  select 'B38', 'P679', 1, 250000, 0  FROM dual UNION ALL 
  select 'B24', 'P680', 1, 475000, 0  FROM dual UNION ALL 
  select 'B40', 'P681', 1, 400000, 0  FROM dual UNION ALL 
  select 'B43', 'P681', 1, 200000, 0  FROM dual UNION ALL 
  select 'B22', 'P682', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B26', 'P683', 14, 100000000, 0  FROM dual UNION ALL 
  select 'B27', 'P683', 16, 40000000, 0  FROM dual UNION ALL 
  select 'B16', 'P683', 12, 4000, 0  FROM dual UNION ALL 
  select 'B20', 'P683', 14, 350000, 0  FROM dual UNION ALL 
  select 'B15', 'P683', 10, 4000, 0  FROM dual UNION ALL 
  select 'B20', 'P683', 19, 350000, 0  FROM dual UNION ALL 
  select 'B28', 'P684', 26, 250000000, 0  FROM dual UNION ALL 
  select 'B8', 'P684', 29, 20000000, 0  FROM dual UNION ALL 
  select 'B12', 'P684', 29, 40000, 0  FROM dual UNION ALL 
  select 'B20', 'P684', 21, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P684', 20, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P684', 21, 500000, 0  FROM dual UNION ALL 
  select 'B23', 'P684', 22, 3000000, 0  FROM dual UNION ALL 
  select 'B29', 'P684', 30, 850000, 0  FROM dual UNION ALL 
  select 'B17', 'P684', 22, 350000, 0  FROM dual UNION ALL 
  select 'B23', 'P684', 21, 3000000, 0  FROM dual UNION ALL 
  select 'B39', 'P685', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P685', 1, 50000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B10', 'P686', 26, 40000, 0  FROM dual UNION ALL 
  select 'B4', 'P686', 17, 3100000, 0  FROM dual UNION ALL 
  select 'B9', 'P686', 21, 25000000, 0  FROM dual UNION ALL 
  select 'B42', 'P687', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P687', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B18', 'P688', 1, 450000, 0  FROM dual UNION ALL 
  select 'B39', 'P688', 1, 250000, 0  FROM dual UNION ALL 
  select 'B37', 'P689', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P689', 1, 200000, 0  FROM dual UNION ALL 
  select 'B21', 'P690', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B23', 'P690', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B36', 'P691', 1, 500000, 0  FROM dual UNION ALL 
  select 'B43', 'P692', 1, 200000, 0  FROM dual UNION ALL 
  select 'B25', 'P692', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B22', 'P693', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B42', 'P693', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P694', 1, 300000, 0  FROM dual UNION ALL 
  select 'B43', 'P694', 1, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P695', 1, 250000, 0  FROM dual UNION ALL 
  select 'B20', 'P696', 1, 350000, 0  FROM dual UNION ALL 
  select 'B38', 'P697', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P698', 10, 1000000, 0  FROM dual UNION ALL 
  select 'B36', 'P698', 11, 500000, 0  FROM dual UNION ALL 
  select 'B7', 'P698', 16, 12000000, 0  FROM dual UNION ALL 
  select 'B21', 'P698', 16, 1200000, 0  FROM dual UNION ALL 
  select 'B9', 'P698', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B24', 'P698', 16, 475000, 0  FROM dual UNION ALL 
  select 'B20', 'P698', 13, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P698', 12, 200000, 0  FROM dual UNION ALL 
  select 'B4', 'P698', 10, 3100000, 0  FROM dual UNION ALL 
  select 'B43', 'P698', 14, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P699', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P699', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P700', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P700', 1, 50000, 0  FROM dual UNION ALL 
  select 'B35', 'P701', 17, 20000, 0  FROM dual UNION ALL 
  select 'B39', 'P701', 20, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P701', 10, 200000, 0  FROM dual UNION ALL 
  select 'B28', 'P701', 18, 250000000, 0  FROM dual UNION ALL 
  select 'B12', 'P701', 19, 40000, 0  FROM dual UNION ALL 
  select 'B38', 'P702', 1, 250000, 0  FROM dual UNION ALL 
  select 'B17', 'P703', 1, 350000, 0  FROM dual UNION ALL 
  select 'B19', 'P704', 1, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P704', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P705', 1, 250000, 0  FROM dual UNION ALL 
  select 'B24', 'P706', 1, 475000, 0  FROM dual UNION ALL 
  select 'B38', 'P707', 1, 250000, 0  FROM dual UNION ALL 
  select 'B38', 'P708', 1, 250000, 0  FROM dual UNION ALL 
  select 'B37', 'P709', 12, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P709', 20, 450000, 0  FROM dual UNION ALL 
  select 'B31', 'P709', 10, 80000, 0  FROM dual UNION ALL 
  select 'B32', 'P709', 18, 20000, 0  FROM dual UNION ALL 
  select 'B5', 'P709', 15, 40000, 0  FROM dual UNION ALL 
  select 'B23', 'P709', 19, 3000000, 0  FROM dual UNION ALL 
  select 'B40', 'P710', 1, 400000, 0  FROM dual UNION ALL 
  select 'B18', 'P710', 1, 450000, 0  FROM dual UNION ALL 
  select 'B22', 'P711', 20, 2100000, 0  FROM dual UNION ALL 
  select 'B42', 'P711', 15, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P711', 11, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P711', 14, 400000, 0  FROM dual UNION ALL 
  select 'B19', 'P711', 20, 300000, 0  FROM dual UNION ALL 
  select 'B36', 'P712', 1, 500000, 0  FROM dual UNION ALL 
  select 'B19', 'P713', 20, 300000, 0  FROM dual UNION ALL 
  select 'B5', 'P713', 12, 40000, 0  FROM dual UNION ALL 
  select 'B16', 'P713', 13, 4000, 0  FROM dual UNION ALL 
  select 'B12', 'P713', 12, 40000, 0  FROM dual UNION ALL 
  select 'B29', 'P713', 18, 850000, 0  FROM dual UNION ALL 
  select 'B10', 'P713', 16, 40000, 0  FROM dual UNION ALL 
  select 'B30', 'P713', 18, 100000, 0  FROM dual UNION ALL 
  select 'B38', 'P714', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P714', 1, 200000, 0  FROM dual UNION ALL 
  select 'B39', 'P715', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P716', 1, 400000, 0  FROM dual UNION ALL 
  select 'B43', 'P716', 1, 200000, 0  FROM dual UNION ALL 
  select 'B9', 'P717', 21, 25000000, 0  FROM dual UNION ALL 
  select 'B13', 'P717', 16, 40000, 0  FROM dual UNION ALL 
  select 'B7', 'P717', 29, 12000000, 0  FROM dual UNION ALL 
  select 'B8', 'P717', 26, 20000000, 0  FROM dual UNION ALL 
  select 'B12', 'P718', 20, 40000, 0  FROM dual UNION ALL 
  select 'B15', 'P718', 12, 4000, 0  FROM dual UNION ALL 
  select 'B12', 'P718', 10, 40000, 0  FROM dual UNION ALL 
  select 'B5', 'P718', 12, 40000, 0  FROM dual UNION ALL 
  select 'B43', 'P718', 11, 200000, 0  FROM dual UNION ALL 
  select 'B13', 'P718', 12, 40000, 0  FROM dual UNION ALL 
  select 'B30', 'P718', 12, 100000, 0  FROM dual UNION ALL 
  select 'B6', 'P718', 13, 6000000, 0  FROM dual UNION ALL 
  select 'B5', 'P718', 12, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P718', 12, 450000, 0  FROM dual UNION ALL 
  select 'B31', 'P719', 12, 80000, 0  FROM dual UNION ALL 
  select 'B19', 'P719', 19, 300000, 0  FROM dual UNION ALL 
  select 'B19', 'P719', 15, 300000, 0  FROM dual UNION ALL 
  select 'B4', 'P719', 15, 3100000, 0  FROM dual UNION ALL 
  select 'B29', 'P719', 20, 850000, 0  FROM dual UNION ALL 
  select 'B24', 'P719', 14, 475000, 0  FROM dual UNION ALL 
  select 'B29', 'P719', 13, 850000, 0  FROM dual UNION ALL 
  select 'B36', 'P719', 20, 500000, 0  FROM dual UNION ALL 
  select 'B28', 'P719', 19, 250000000, 0  FROM dual UNION ALL 
  select 'B10', 'P719', 10, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P720', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P720', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B4', 'P721', 16, 3100000, 0  FROM dual UNION ALL 
  select 'B37', 'P721', 20, 50000, 0  FROM dual UNION ALL 
  select 'B35', 'P721', 14, 20000, 0  FROM dual UNION ALL 
  select 'B9', 'P721', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B2', 'P721', 15, 3025000, 0  FROM dual UNION ALL 
  select 'B22', 'P721', 11, 2100000, 0  FROM dual UNION ALL 
  select 'B21', 'P721', 15, 1200000, 0  FROM dual UNION ALL 
  select 'B4', 'P721', 14, 3100000, 0  FROM dual UNION ALL 
  select 'B37', 'P721', 19, 50000, 0  FROM dual UNION ALL 
  select 'B7', 'P721', 18, 12000000, 0  FROM dual UNION ALL 
  select 'B18', 'P722', 1, 450000, 0  FROM dual UNION ALL 
  select 'B39', 'P722', 1, 250000, 0  FROM dual UNION ALL 
  select 'B21', 'P723', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B43', 'P723', 1, 200000, 0  FROM dual UNION ALL 
  select 'B20', 'P724', 1, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P724', 1, 500000, 0  FROM dual UNION ALL 
  select 'B38', 'P725', 1, 250000, 0  FROM dual UNION ALL 
  select 'B31', 'P726', 19, 80000, 0  FROM dual UNION ALL 
  select 'B10', 'P726', 13, 40000, 0  FROM dual UNION ALL 
  select 'B20', 'P726', 14, 350000, 0  FROM dual UNION ALL 
  select 'B13', 'P726', 19, 40000, 0  FROM dual UNION ALL 
  select 'B19', 'P726', 12, 300000, 0  FROM dual UNION ALL 
  select 'B36', 'P726', 10, 500000, 0  FROM dual UNION ALL 
  select 'B17', 'P727', 10, 350000, 0  FROM dual UNION ALL 
  select 'B24', 'P727', 10, 475000, 0  FROM dual UNION ALL 
  select 'B34', 'P727', 17, 20000, 0  FROM dual UNION ALL 
  select 'B21', 'P727', 17, 1200000, 0  FROM dual UNION ALL 
  select 'B5', 'P727', 14, 40000, 0  FROM dual UNION ALL 
  select 'B3', 'P727', 20, 20000000, 0  FROM dual UNION ALL 
  select 'B30', 'P727', 19, 100000, 0  FROM dual UNION ALL 
  select 'B28', 'P727', 17, 250000000, 0  FROM dual UNION ALL 
  select 'B12', 'P727', 17, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P727', 17, 450000, 0  FROM dual UNION ALL 
  select 'B38', 'P728', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P728', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P729', 1, 50000, 0  FROM dual UNION ALL 
  select 'B21', 'P730', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B37', 'P731', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P731', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P732', 10, 350000, 0  FROM dual UNION ALL 
  select 'B31', 'P732', 16, 80000, 0  FROM dual UNION ALL 
  select 'B7', 'P732', 15, 12000000, 0  FROM dual UNION ALL 
  select 'B39', 'P732', 17, 250000, 0  FROM dual UNION ALL 
  select 'B32', 'P732', 13, 20000, 0  FROM dual UNION ALL 
  select 'B42', 'P733', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P734', 1, 500000, 0  FROM dual UNION ALL 
  select 'B21', 'P735', 21, 1200000, 0  FROM dual UNION ALL 
  select 'B1', 'P735', 20, 227500, 0  FROM dual UNION ALL 
  select 'B16', 'P735', 29, 4000, 0  FROM dual UNION ALL 
  select 'B17', 'P736', 1, 350000, 0  FROM dual UNION ALL 
  select 'B18', 'P737', 1, 450000, 0  FROM dual UNION ALL 
  select 'B11', 'P738', 20, 40000, 0  FROM dual UNION ALL 
  select 'B13', 'P738', 10, 40000, 0  FROM dual UNION ALL 
  select 'B37', 'P738', 10, 50000, 0  FROM dual UNION ALL 
  select 'B11', 'P738', 15, 40000, 0  FROM dual UNION ALL 
  select 'B12', 'P738', 10, 40000, 0  FROM dual UNION ALL 
  select 'B10', 'P738', 12, 40000, 0  FROM dual UNION ALL 
  select 'B32', 'P738', 13, 20000, 0  FROM dual UNION ALL 
  select 'B42', 'P738', 19, 50000, 0  FROM dual UNION ALL 
  select 'B30', 'P738', 20, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P738', 10, 20000, 0  FROM dual UNION ALL 
  select 'B24', 'P739', 1, 475000, 0  FROM dual UNION ALL 
  select 'B40', 'P739', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P740', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P740', 1, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P741', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P742', 1, 50000, 0  FROM dual UNION ALL 
  select 'B20', 'P743', 27, 350000, 0  FROM dual UNION ALL 
  select 'B26', 'P743', 27, 100000000, 0  FROM dual UNION ALL 
  select 'B12', 'P743', 19, 40000, 0  FROM dual UNION ALL 
  select 'B14', 'P743', 29, 4000, 0  FROM dual UNION ALL 
  select 'B2', 'P743', 28, 3025000, 0  FROM dual UNION ALL 
  select 'B8', 'P743', 28, 20000000, 0  FROM dual UNION ALL 
  select 'B1', 'P743', 25, 227500, 0  FROM dual UNION ALL 
  select 'B10', 'P743', 21, 40000, 0  FROM dual UNION ALL 
  select 'B42', 'P743', 16, 50000, 0  FROM dual UNION ALL 
  select 'B20', 'P744', 1, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P744', 1, 500000, 0  FROM dual UNION ALL 
  select 'B21', 'P745', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B36', 'P745', 1, 500000, 0  FROM dual UNION ALL 
  select 'B18', 'P746', 1, 450000, 0  FROM dual UNION ALL 
  select 'B18', 'P747', 21, 450000, 0  FROM dual UNION ALL 
  select 'B1', 'P747', 30, 227500, 0  FROM dual UNION ALL 
  select 'B11', 'P747', 24, 40000, 0  FROM dual UNION ALL 
  select 'B11', 'P747', 16, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P747', 17, 6000000, 0  FROM dual UNION ALL 
  select 'B21', 'P748', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B18', 'P749', 1, 450000, 0  FROM dual UNION ALL 
  select 'B31', 'P750', 13, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P750', 18, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P750', 19, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P750', 20, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P750', 10, 20000, 0  FROM dual UNION ALL 
  select 'B23', 'P751', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B42', 'P751', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P752', 1, 50000, 0  FROM dual UNION ALL 
  select 'B20', 'P753', 1, 350000, 0  FROM dual UNION ALL 
  select 'B25', 'P753', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B36', 'P754', 1, 500000, 0  FROM dual UNION ALL 
  select 'B40', 'P754', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P755', 1, 50000, 0  FROM dual UNION ALL 
  select 'B9', 'P756', 12, 25000000, 0  FROM dual UNION ALL 
  select 'B4', 'P756', 12, 3100000, 0  FROM dual UNION ALL 
  select 'B15', 'P756', 20, 4000, 0  FROM dual UNION ALL 
  select 'B37', 'P756', 10, 50000, 0  FROM dual UNION ALL 
  select 'B7', 'P756', 14, 12000000, 0  FROM dual UNION ALL 
  select 'B6', 'P756', 10, 6000000, 0  FROM dual UNION ALL 
  select 'B18', 'P756', 10, 450000, 0  FROM dual UNION ALL 
  select 'B14', 'P756', 18, 4000, 0  FROM dual UNION ALL 
  select 'B12', 'P756', 11, 40000, 0  FROM dual UNION ALL 
  select 'B35', 'P756', 14, 20000, 0  FROM dual UNION ALL 
  select 'B36', 'P757', 1, 500000, 0  FROM dual UNION ALL 
  select 'B41', 'P757', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B30', 'P758', 20, 100000, 0  FROM dual UNION ALL 
  select 'B31', 'P758', 10, 80000, 0  FROM dual UNION ALL 
  select 'B31', 'P758', 15, 80000, 0  FROM dual UNION ALL 
  select 'B42', 'P759', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P760', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P760', 1, 300000, 0  FROM dual UNION ALL 
  select 'B2', 'P761', 19, 3025000, 0  FROM dual UNION ALL 
  select 'B9', 'P761', 17, 25000000, 0  FROM dual UNION ALL 
  select 'B12', 'P761', 12, 40000, 0  FROM dual UNION ALL 
  select 'B20', 'P761', 14, 350000, 0  FROM dual UNION ALL 
  select 'B9', 'P761', 16, 25000000, 0  FROM dual UNION ALL 
  select 'B6', 'P761', 12, 6000000, 0  FROM dual UNION ALL 
  select 'B13', 'P761', 15, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P761', 10, 6000000, 0  FROM dual UNION ALL 
  select 'B21', 'P761', 16, 1200000, 0  FROM dual UNION ALL 
  select 'B41', 'P762', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B35', 'P763', 19, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P763', 13, 850000, 0  FROM dual UNION ALL 
  select 'B31', 'P763', 11, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P763', 11, 100000, 0  FROM dual UNION ALL 
  select 'B30', 'P763', 12, 100000, 0  FROM dual UNION ALL 
  select 'B37', 'P764', 1, 50000, 0  FROM dual UNION ALL 
  select 'B10', 'P765', 15, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P765', 12, 6000000, 0  FROM dual UNION ALL 
  select 'B17', 'P765', 19, 350000, 0  FROM dual UNION ALL 
  select 'B6', 'P765', 20, 6000000, 0  FROM dual UNION ALL 
  select 'B21', 'P765', 11, 1200000, 0  FROM dual UNION ALL 
  select 'B21', 'P765', 16, 1200000, 0  FROM dual UNION ALL 
  select 'B15', 'P766', 13, 4000, 0  FROM dual UNION ALL 
  select 'B35', 'P766', 10, 20000, 0  FROM dual UNION ALL 
  select 'B28', 'P766', 19, 250000000, 0  FROM dual UNION ALL 
  select 'B24', 'P766', 16, 475000, 0  FROM dual UNION ALL 
  select 'B8', 'P766', 15, 20000000, 0  FROM dual UNION ALL 
  select 'B37', 'P766', 14, 50000, 0  FROM dual UNION ALL 
  select 'B17', 'P766', 16, 350000, 0  FROM dual UNION ALL 
  select 'B7', 'P766', 16, 12000000, 0  FROM dual UNION ALL 
  select 'B3', 'P766', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B32', 'P766', 15, 20000, 0  FROM dual UNION ALL 
  select 'B41', 'P767', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B35', 'P768', 11, 20000, 0  FROM dual UNION ALL 
  select 'B7', 'P768', 11, 12000000, 0  FROM dual UNION ALL 
  select 'B26', 'P768', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B40', 'P768', 17, 400000, 0  FROM dual UNION ALL 
  select 'B28', 'P768', 19, 250000000, 0  FROM dual UNION ALL 
  select 'B18', 'P768', 10, 450000, 0  FROM dual UNION ALL 
  select 'B40', 'P769', 1, 400000, 0  FROM dual UNION ALL 
  select 'B38', 'P770', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P770', 1, 50000, 0  FROM dual UNION ALL 
  select 'B9', 'P771', 30, 25000000, 0  FROM dual UNION ALL 
  select 'B15', 'P771', 27, 4000, 0  FROM dual UNION ALL 
  select 'B31', 'P771', 25, 80000, 0  FROM dual UNION ALL 
  select 'B23', 'P771', 28, 3000000, 0  FROM dual UNION ALL 
  select 'B1', 'P771', 23, 227500, 0  FROM dual UNION ALL 
  select 'B37', 'P771', 22, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P771', 22, 200000, 0  FROM dual UNION ALL 
  select 'B32', 'P771', 25, 20000, 0  FROM dual UNION ALL 
  select 'B39', 'P771', 25, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P772', 1, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P772', 1, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P773', 1, 400000, 0  FROM dual UNION ALL 
  select 'B24', 'P774', 1, 475000, 0  FROM dual UNION ALL 
  select 'B23', 'P774', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B41', 'P775', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B19', 'P775', 1, 300000, 0  FROM dual UNION ALL 
  select 'B39', 'P776', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P776', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P777', 1, 400000, 0  FROM dual UNION ALL 
  select 'B22', 'P778', 25, 2100000, 0  FROM dual UNION ALL 
  select 'B12', 'P778', 15, 40000, 0  FROM dual UNION ALL 
  select 'B25', 'P778', 28, 1000000, 0  FROM dual UNION ALL 
  select 'B13', 'P779', 26, 40000, 0  FROM dual UNION ALL 
  select 'B25', 'P779', 27, 1000000, 0  FROM dual UNION ALL 
  select 'B23', 'P779', 26, 3000000, 0  FROM dual UNION ALL 
  select 'B12', 'P779', 30, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P780', 21, 6000000, 0  FROM dual UNION ALL 
  select 'B8', 'P780', 24, 20000000, 0  FROM dual UNION ALL 
  select 'B8', 'P780', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B20', 'P780', 17, 350000, 0  FROM dual UNION ALL 
  select 'B4', 'P780', 16, 3100000, 0  FROM dual UNION ALL 
  select 'B17', 'P780', 29, 350000, 0  FROM dual UNION ALL 
  select 'B18', 'P780', 15, 450000, 0  FROM dual UNION ALL 
  select 'B36', 'P780', 17, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P780', 22, 50000, 0  FROM dual UNION ALL 
  select 'B15', 'P780', 26, 4000, 0  FROM dual UNION ALL 
  select 'B42', 'P781', 1, 50000, 0  FROM dual UNION ALL 
  select 'B20', 'P782', 1, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P783', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P783', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P784', 1, 200000, 0  FROM dual UNION ALL 
  select 'B23', 'P785', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B21', 'P785', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B38', 'P786', 1, 250000, 0  FROM dual UNION ALL 
  select 'B24', 'P787', 1, 475000, 0  FROM dual UNION ALL 
  select 'B17', 'P787', 1, 350000, 0  FROM dual UNION ALL 
  select 'B17', 'P788', 19, 350000, 0  FROM dual UNION ALL 
  select 'B13', 'P788', 15, 40000, 0  FROM dual UNION ALL 
  select 'B26', 'P788', 24, 100000000, 0  FROM dual UNION ALL 
  select 'B13', 'P788', 20, 40000, 0  FROM dual UNION ALL 
  select 'B1', 'P788', 24, 227500, 0  FROM dual UNION ALL 
  select 'B24', 'P788', 18, 475000, 0  FROM dual UNION ALL 
  select 'B2', 'P788', 21, 3025000, 0  FROM dual UNION ALL 
  select 'B18', 'P788', 24, 450000, 0  FROM dual UNION ALL 
  select 'B27', 'P788', 15, 40000000, 0  FROM dual UNION ALL 
  select 'B30', 'P789', 13, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P789', 13, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P789', 11, 80000, 0  FROM dual UNION ALL 
  select 'B29', 'P789', 15, 850000, 0  FROM dual UNION ALL 
  select 'B24', 'P790', 1, 475000, 0  FROM dual UNION ALL 
  select 'B18', 'P791', 1, 450000, 0  FROM dual UNION ALL 
  select 'B19', 'P792', 1, 300000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B20', 'P792', 1, 350000, 0  FROM dual UNION ALL 
  select 'B20', 'P793', 1, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P793', 1, 50000, 0  FROM dual UNION ALL 
  select 'B32', 'P794', 13, 20000, 0  FROM dual UNION ALL 
  select 'B28', 'P794', 12, 250000000, 0  FROM dual UNION ALL 
  select 'B4', 'P794', 20, 3100000, 0  FROM dual UNION ALL 
  select 'B37', 'P794', 13, 50000, 0  FROM dual UNION ALL 
  select 'B14', 'P794', 14, 4000, 0  FROM dual UNION ALL 
  select 'B39', 'P794', 13, 250000, 0  FROM dual UNION ALL 
  select 'B35', 'P794', 12, 20000, 0  FROM dual UNION ALL 
  select 'B2', 'P794', 14, 3025000, 0  FROM dual UNION ALL 
  select 'B38', 'P795', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P796', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B10', 'P796', 20, 40000, 0  FROM dual UNION ALL 
  select 'B3', 'P796', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B6', 'P796', 24, 6000000, 0  FROM dual UNION ALL 
  select 'B39', 'P797', 19, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P797', 25, 50000, 0  FROM dual UNION ALL 
  select 'B16', 'P797', 24, 4000, 0  FROM dual UNION ALL 
  select 'B40', 'P797', 18, 400000, 0  FROM dual UNION ALL 
  select 'B16', 'P797', 30, 4000, 0  FROM dual UNION ALL 
  select 'B40', 'P797', 28, 400000, 0  FROM dual UNION ALL 
  select 'B29', 'P797', 20, 850000, 0  FROM dual UNION ALL 
  select 'B42', 'P797', 23, 50000, 0  FROM dual UNION ALL 
  select 'B3', 'P797', 18, 20000000, 0  FROM dual UNION ALL 
  select 'B19', 'P798', 1, 300000, 0  FROM dual UNION ALL 
  select 'B39', 'P799', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P799', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B22', 'P800', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B24', 'P801', 14, 475000, 0  FROM dual UNION ALL 
  select 'B31', 'P801', 17, 80000, 0  FROM dual UNION ALL 
  select 'B42', 'P801', 17, 50000, 0  FROM dual UNION ALL 
  select 'B4', 'P801', 14, 3100000, 0  FROM dual UNION ALL 
  select 'B6', 'P801', 13, 6000000, 0  FROM dual UNION ALL 
  select 'B17', 'P801', 17, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P801', 14, 1000000, 0  FROM dual UNION ALL 
  select 'B20', 'P802', 1, 350000, 0  FROM dual UNION ALL 
  select 'B18', 'P802', 1, 450000, 0  FROM dual UNION ALL 
  select 'B38', 'P803', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P803', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P804', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P804', 1, 250000, 0  FROM dual UNION ALL 
  select 'B26', 'P805', 16, 100000000, 0  FROM dual UNION ALL 
  select 'B12', 'P805', 17, 40000, 0  FROM dual UNION ALL 
  select 'B26', 'P805', 19, 100000000, 0  FROM dual UNION ALL 
  select 'B26', 'P805', 10, 100000000, 0  FROM dual UNION ALL 
  select 'B24', 'P805', 11, 475000, 0  FROM dual UNION ALL 
  select 'B6', 'P805', 17, 6000000, 0  FROM dual UNION ALL 
  select 'B29', 'P805', 12, 850000, 0  FROM dual UNION ALL 
  select 'B39', 'P806', 1, 250000, 0  FROM dual UNION ALL 
  select 'B20', 'P807', 10, 350000, 0  FROM dual UNION ALL 
  select 'B7', 'P807', 10, 12000000, 0  FROM dual UNION ALL 
  select 'B22', 'P807', 16, 2100000, 0  FROM dual UNION ALL 
  select 'B43', 'P807', 20, 200000, 0  FROM dual UNION ALL 
  select 'B7', 'P807', 11, 12000000, 0  FROM dual UNION ALL 
  select 'B9', 'P807', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B33', 'P807', 11, 10000, 0  FROM dual UNION ALL 
  select 'B7', 'P807', 17, 12000000, 0  FROM dual UNION ALL 
  select 'B42', 'P808', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P808', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P809', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P810', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P811', 16, 200000, 0  FROM dual UNION ALL 
  select 'B16', 'P811', 19, 4000, 0  FROM dual UNION ALL 
  select 'B35', 'P811', 16, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P811', 18, 20000, 0  FROM dual UNION ALL 
  select 'B13', 'P811', 10, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P811', 16, 6000000, 0  FROM dual UNION ALL 
  select 'B35', 'P811', 19, 20000, 0  FROM dual UNION ALL 
  select 'B25', 'P812', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P813', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P814', 23, 400000, 0  FROM dual UNION ALL 
  select 'B37', 'P814', 20, 50000, 0  FROM dual UNION ALL 
  select 'B30', 'P814', 22, 100000, 0  FROM dual UNION ALL 
  select 'B6', 'P814', 22, 6000000, 0  FROM dual UNION ALL 
  select 'B14', 'P815', 20, 4000, 0  FROM dual UNION ALL 
  select 'B8', 'P815', 11, 20000000, 0  FROM dual UNION ALL 
  select 'B10', 'P815', 17, 40000, 0  FROM dual UNION ALL 
  select 'B16', 'P815', 18, 4000, 0  FROM dual UNION ALL 
  select 'B41', 'P815', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B28', 'P815', 12, 250000000, 0  FROM dual UNION ALL 
  select 'B22', 'P816', 12, 2100000, 0  FROM dual UNION ALL 
  select 'B31', 'P816', 12, 80000, 0  FROM dual UNION ALL 
  select 'B33', 'P816', 19, 10000, 0  FROM dual UNION ALL 
  select 'B20', 'P816', 11, 350000, 0  FROM dual UNION ALL 
  select 'B9', 'P816', 17, 25000000, 0  FROM dual UNION ALL 
  select 'B12', 'P816', 10, 40000, 0  FROM dual UNION ALL 
  select 'B4', 'P817', 15, 3100000, 0  FROM dual UNION ALL 
  select 'B19', 'P817', 27, 300000, 0  FROM dual UNION ALL 
  select 'B3', 'P817', 25, 20000000, 0  FROM dual UNION ALL 
  select 'B35', 'P817', 16, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P817', 24, 100000, 0  FROM dual UNION ALL 
  select 'B20', 'P817', 25, 350000, 0  FROM dual UNION ALL 
  select 'B1', 'P817', 25, 227500, 0  FROM dual UNION ALL 
  select 'B6', 'P817', 18, 6000000, 0  FROM dual UNION ALL 
  select 'B43', 'P817', 24, 200000, 0  FROM dual UNION ALL 
  select 'B41', 'P818', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P818', 1, 50000, 0  FROM dual UNION ALL 
  select 'B22', 'P819', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B39', 'P820', 1, 250000, 0  FROM dual UNION ALL 
  select 'B9', 'P821', 22, 25000000, 0  FROM dual UNION ALL 
  select 'B37', 'P821', 30, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P821', 21, 250000, 0  FROM dual UNION ALL 
  select 'B14', 'P822', 29, 4000, 0  FROM dual UNION ALL 
  select 'B19', 'P822', 25, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P822', 21, 1000000, 0  FROM dual UNION ALL 
  select 'B3', 'P822', 27, 20000000, 0  FROM dual UNION ALL 
  select 'B21', 'P822', 25, 1200000, 0  FROM dual UNION ALL 
  select 'B2', 'P822', 16, 3025000, 0  FROM dual UNION ALL 
  select 'B33', 'P822', 24, 10000, 0  FROM dual UNION ALL 
  select 'B43', 'P823', 17, 200000, 0  FROM dual UNION ALL 
  select 'B33', 'P823', 14, 10000, 0  FROM dual UNION ALL 
  select 'B22', 'P823', 15, 2100000, 0  FROM dual UNION ALL 
  select 'B41', 'P823', 14, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P823', 16, 50000, 0  FROM dual UNION ALL 
  select 'B8', 'P823', 12, 20000000, 0  FROM dual UNION ALL 
  select 'B15', 'P823', 14, 4000, 0  FROM dual UNION ALL 
  select 'B15', 'P823', 20, 4000, 0  FROM dual UNION ALL 
  select 'B36', 'P824', 1, 500000, 0  FROM dual UNION ALL 
  select 'B17', 'P825', 1, 350000, 0  FROM dual UNION ALL 
  select 'B18', 'P825', 1, 450000, 0  FROM dual UNION ALL 
  select 'B42', 'P826', 1, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P827', 20, 450000, 0  FROM dual UNION ALL 
  select 'B9', 'P827', 18, 25000000, 0  FROM dual UNION ALL 
  select 'B20', 'P827', 14, 350000, 0  FROM dual UNION ALL 
  select 'B14', 'P827', 13, 4000, 0  FROM dual UNION ALL 
  select 'B34', 'P827', 16, 20000, 0  FROM dual UNION ALL 
  select 'B38', 'P827', 12, 250000, 0  FROM dual UNION ALL 
  select 'B14', 'P827', 10, 4000, 0  FROM dual UNION ALL 
  select 'B15', 'P827', 13, 4000, 0  FROM dual UNION ALL 
  select 'B5', 'P827', 10, 40000, 0  FROM dual UNION ALL 
  select 'B35', 'P827', 14, 20000, 0  FROM dual UNION ALL 
  select 'B19', 'P828', 1, 300000, 0  FROM dual UNION ALL 
  select 'B27', 'P829', 18, 40000000, 0  FROM dual UNION ALL 
  select 'B35', 'P829', 16, 20000, 0  FROM dual UNION ALL 
  select 'B11', 'P829', 20, 40000, 0  FROM dual UNION ALL 
  select 'B29', 'P829', 14, 850000, 0  FROM dual UNION ALL 
  select 'B13', 'P829', 18, 40000, 0  FROM dual UNION ALL 
  select 'B15', 'P829', 10, 4000, 0  FROM dual UNION ALL 
  select 'B20', 'P829', 17, 350000, 0  FROM dual UNION ALL 
  select 'B19', 'P829', 13, 300000, 0  FROM dual UNION ALL 
  select 'B24', 'P830', 1, 475000, 0  FROM dual UNION ALL 
  select 'B13', 'P831', 17, 40000, 0  FROM dual UNION ALL 
  select 'B22', 'P831', 12, 2100000, 0  FROM dual UNION ALL 
  select 'B33', 'P831', 18, 10000, 0  FROM dual UNION ALL 
  select 'B13', 'P831', 18, 40000, 0  FROM dual UNION ALL 
  select 'B11', 'P831', 11, 40000, 0  FROM dual UNION ALL 
  select 'B37', 'P831', 10, 50000, 0  FROM dual UNION ALL 
  select 'B21', 'P831', 12, 1200000, 0  FROM dual UNION ALL 
  select 'B43', 'P831', 18, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P831', 12, 50000, 0  FROM dual UNION ALL 
  select 'B3', 'P831', 15, 20000000, 0  FROM dual UNION ALL 
  select 'B42', 'P832', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P832', 1, 250000, 0  FROM dual UNION ALL 
  select 'B3', 'P833', 21, 20000000, 0  FROM dual UNION ALL 
  select 'B34', 'P833', 25, 20000, 0  FROM dual UNION ALL 
  select 'B36', 'P833', 18, 500000, 0  FROM dual UNION ALL 
  select 'B15', 'P833', 21, 4000, 0  FROM dual UNION ALL 
  select 'B24', 'P833', 17, 475000, 0  FROM dual UNION ALL 
  select 'B18', 'P833', 16, 450000, 0  FROM dual UNION ALL 
  select 'B4', 'P833', 21, 3100000, 0  FROM dual UNION ALL 
  select 'B13', 'P833', 25, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P834', 1, 450000, 0  FROM dual UNION ALL 
  select 'B21', 'P835', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B39', 'P835', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P836', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B29', 'P837', 16, 850000, 0  FROM dual UNION ALL 
  select 'B30', 'P837', 19, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P837', 19, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P837', 16, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P837', 10, 20000, 0  FROM dual UNION ALL 
  select 'B42', 'P838', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P839', 1, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P839', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P840', 1, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P840', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P841', 1, 500000, 0  FROM dual UNION ALL 
  select 'B22', 'P841', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B21', 'P842', 18, 1200000, 0  FROM dual UNION ALL 
  select 'B41', 'P842', 13, 1000000, 0  FROM dual UNION ALL 
  select 'B33', 'P842', 10, 10000, 0  FROM dual UNION ALL 
  select 'B43', 'P842', 18, 200000, 0  FROM dual UNION ALL 
  select 'B32', 'P842', 10, 20000, 0  FROM dual UNION ALL 
  select 'B24', 'P842', 16, 475000, 0  FROM dual UNION ALL 
  select 'B36', 'P842', 15, 500000, 0  FROM dual UNION ALL 
  select 'B23', 'P843', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B41', 'P843', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P844', 1, 400000, 0  FROM dual UNION ALL 
  select 'B25', 'P844', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B12', 'P845', 13, 40000, 0  FROM dual UNION ALL 
  select 'B4', 'P845', 20, 3100000, 0  FROM dual UNION ALL 
  select 'B4', 'P845', 10, 3100000, 0  FROM dual UNION ALL 
  select 'B21', 'P845', 10, 1200000, 0  FROM dual UNION ALL 
  select 'B43', 'P845', 16, 200000, 0  FROM dual UNION ALL 
  select 'B18', 'P845', 14, 450000, 0  FROM dual UNION ALL 
  select 'B36', 'P846', 1, 500000, 0  FROM dual UNION ALL 
  select 'B39', 'P846', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P847', 1, 200000, 0  FROM dual UNION ALL 
  select 'B41', 'P848', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B25', 'P848', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P849', 1, 250000, 0  FROM dual UNION ALL 
  select 'B37', 'P849', 1, 50000, 0  FROM dual UNION ALL 
  select 'B17', 'P850', 11, 350000, 0  FROM dual UNION ALL 
  select 'B30', 'P850', 15, 100000, 0  FROM dual UNION ALL 
  select 'B15', 'P850', 13, 4000, 0  FROM dual UNION ALL 
  select 'B41', 'P850', 19, 1000000, 0  FROM dual UNION ALL 
  select 'B35', 'P850', 18, 20000, 0  FROM dual UNION ALL 
  select 'B17', 'P850', 11, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P851', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B20', 'P852', 1, 350000, 0  FROM dual UNION ALL 
  select 'B39', 'P852', 1, 250000, 0  FROM dual UNION ALL 
  select 'B20', 'P853', 1, 350000, 0  FROM dual UNION ALL 
  select 'B37', 'P854', 1, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P854', 1, 400000, 0  FROM dual UNION ALL 
  select 'B37', 'P855', 12, 50000, 0  FROM dual UNION ALL 
  select 'B13', 'P855', 14, 40000, 0  FROM dual UNION ALL 
  select 'B28', 'P855', 10, 250000000, 0  FROM dual UNION ALL 
  select 'B19', 'P855', 16, 300000, 0  FROM dual UNION ALL 
  select 'B3', 'P855', 18, 20000000, 0  FROM dual UNION ALL 
  select 'B14', 'P855', 12, 4000, 0  FROM dual UNION ALL 
  select 'B23', 'P855', 14, 3000000, 0  FROM dual UNION ALL 
  select 'B35', 'P855', 17, 20000, 0  FROM dual UNION ALL 
  select 'B22', 'P855', 13, 2100000, 0  FROM dual UNION ALL 
  select 'B18', 'P855', 15, 450000, 0  FROM dual UNION ALL 
  select 'B43', 'P856', 1, 200000, 0  FROM dual UNION ALL 
  select 'B21', 'P857', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B22', 'P857', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B20', 'P858', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P859', 1, 400000, 0  FROM dual UNION ALL 
  select 'B20', 'P859', 1, 350000, 0  FROM dual UNION ALL 
  select 'B18', 'P860', 1, 450000, 0  FROM dual UNION ALL 
  select 'B36', 'P861', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P861', 1, 50000, 0  FROM dual UNION ALL 
  select 'B29', 'P862', 14, 850000, 0  FROM dual UNION ALL 
  select 'B29', 'P862', 13, 850000, 0  FROM dual UNION ALL 
  select 'B31', 'P862', 15, 80000, 0  FROM dual UNION ALL 
  select 'B29', 'P862', 20, 850000, 0  FROM dual UNION ALL 
  select 'B31', 'P862', 16, 80000, 0  FROM dual UNION ALL 
  select 'B18', 'P863', 1, 450000, 0  FROM dual UNION ALL 
  select 'B22', 'P863', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B25', 'P864', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B5', 'P865', 20, 40000, 0  FROM dual UNION ALL 
  select 'B30', 'P865', 23, 100000, 0  FROM dual UNION ALL 
  select 'B20', 'P865', 17, 350000, 0  FROM dual UNION ALL 
  select 'B7', 'P865', 30, 12000000, 0  FROM dual UNION ALL 
  select 'B5', 'P865', 26, 40000, 0  FROM dual UNION ALL 
  select 'B38', 'P865', 17, 250000, 0  FROM dual UNION ALL 
  select 'B29', 'P865', 26, 850000, 0  FROM dual UNION ALL 
  select 'B7', 'P865', 27, 12000000, 0  FROM dual UNION ALL 
  select 'B23', 'P865', 16, 3000000, 0  FROM dual UNION ALL 
  select 'B33', 'P865', 19, 10000, 0  FROM dual UNION ALL 
  select 'B42', 'P866', 1, 50000, 0  FROM dual UNION ALL 
  select 'B25', 'P866', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P867', 14, 50000, 0  FROM dual UNION ALL 
  select 'B33', 'P867', 13, 10000, 0  FROM dual UNION ALL 
  select 'B37', 'P867', 20, 50000, 0  FROM dual UNION ALL 
  select 'B34', 'P867', 12, 20000, 0  FROM dual UNION ALL 
  select 'B17', 'P867', 15, 350000, 0  FROM dual UNION ALL 
  select 'B21', 'P868', 18, 1200000, 0  FROM dual UNION ALL 
  select 'B7', 'P868', 12, 12000000, 0  FROM dual UNION ALL 
  select 'B15', 'P868', 11, 4000, 0  FROM dual UNION ALL 
  select 'B20', 'P868', 17, 350000, 0  FROM dual UNION ALL 
  select 'B15', 'P868', 19, 4000, 0  FROM dual UNION ALL 
  select 'B33', 'P868', 11, 10000, 0  FROM dual UNION ALL 
  select 'B2', 'P868', 20, 3025000, 0  FROM dual UNION ALL 
  select 'B20', 'P868', 10, 350000, 0  FROM dual UNION ALL 
  select 'B8', 'P868', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B11', 'P868', 13, 40000, 0  FROM dual UNION ALL 
  select 'B40', 'P869', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P869', 1, 500000, 0  FROM dual UNION ALL 
  select 'B31', 'P870', 13, 80000, 0  FROM dual UNION ALL 
  select 'B31', 'P870', 10, 80000, 0  FROM dual UNION ALL 
  select 'B29', 'P870', 14, 850000, 0  FROM dual UNION ALL 
  select 'B29', 'P870', 11, 850000, 0  FROM dual UNION ALL 
  select 'B35', 'P870', 16, 20000, 0  FROM dual UNION ALL 
  select 'B43', 'P871', 1, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P871', 1, 250000, 0  FROM dual UNION ALL 
  select 'B21', 'P872', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B36', 'P872', 1, 500000, 0  FROM dual UNION ALL 
  select 'B23', 'P873', 10, 3000000, 0  FROM dual UNION ALL 
  select 'B41', 'P873', 17, 1000000, 0  FROM dual UNION ALL 
  select 'B30', 'P873', 15, 100000, 0  FROM dual UNION ALL 
  select 'B5', 'P873', 17, 40000, 0  FROM dual UNION ALL 
  select 'B29', 'P873', 12, 850000, 0  FROM dual UNION ALL 
  select 'B32', 'P873', 12, 20000, 0  FROM dual UNION ALL 
  select 'B24', 'P873', 13, 475000, 0  FROM dual UNION ALL 
  select 'B34', 'P873', 14, 20000, 0  FROM dual UNION ALL 
  select 'B12', 'P873', 11, 40000, 0  FROM dual UNION ALL 
  select 'B11', 'P873', 19, 40000, 0  FROM dual UNION ALL 
  select 'B34', 'P874', 19, 20000, 0  FROM dual UNION ALL 
  select 'B17', 'P874', 14, 350000, 0  FROM dual UNION ALL 
  select 'B5', 'P874', 20, 40000, 0  FROM dual UNION ALL 
  select 'B19', 'P874', 15, 300000, 0  FROM dual UNION ALL 
  select 'B25', 'P874', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P874', 18, 200000, 0  FROM dual UNION ALL 
  select 'B12', 'P874', 12, 40000, 0  FROM dual UNION ALL 
  select 'B30', 'P874', 17, 100000, 0  FROM dual UNION ALL 
  select 'B10', 'P874', 10, 40000, 0  FROM dual UNION ALL 
  select 'B14', 'P874', 11, 4000, 0  FROM dual UNION ALL 
  select 'B37', 'P875', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P876', 1, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P876', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P877', 1, 250000, 0  FROM dual UNION ALL 
  select 'B15', 'P878', 19, 4000, 0  FROM dual UNION ALL 
  select 'B42', 'P878', 19, 50000, 0  FROM dual UNION ALL 
  select 'B8', 'P878', 16, 20000000, 0  FROM dual UNION ALL 
  select 'B24', 'P878', 18, 475000, 0  FROM dual UNION ALL 
  select 'B11', 'P878', 19, 40000, 0  FROM dual UNION ALL 
  select 'B37', 'P878', 15, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P878', 12, 400000, 0  FROM dual UNION ALL 
  select 'B5', 'P878', 18, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P879', 28, 40000000, 0  FROM dual UNION ALL 
  select 'B27', 'P879', 19, 40000000, 0  FROM dual UNION ALL 
  select 'B28', 'P879', 23, 250000000, 0  FROM dual UNION ALL 
  select 'B35', 'P879', 30, 20000, 0  FROM dual UNION ALL 
  select 'B13', 'P879', 19, 40000, 0  FROM dual UNION ALL 
  select 'B22', 'P879', 18, 2100000, 0  FROM dual UNION ALL 
  select 'B8', 'P879', 25, 20000000, 0  FROM dual UNION ALL 
  select 'B38', 'P880', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P880', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B21', 'P881', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B43', 'P882', 13, 200000, 0  FROM dual UNION ALL 
  select 'B14', 'P882', 20, 4000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B34', 'P882', 15, 20000, 0  FROM dual UNION ALL 
  select 'B16', 'P882', 19, 4000, 0  FROM dual UNION ALL 
  select 'B42', 'P882', 10, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P883', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P884', 1, 400000, 0  FROM dual UNION ALL 
  select 'B19', 'P884', 1, 300000, 0  FROM dual UNION ALL 
  select 'B38', 'P885', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P886', 1, 200000, 0  FROM dual UNION ALL 
  select 'B43', 'P887', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P887', 1, 50000, 0  FROM dual UNION ALL 
  select 'B21', 'P888', 14, 1200000, 0  FROM dual UNION ALL 
  select 'B20', 'P888', 18, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P888', 11, 1000000, 0  FROM dual UNION ALL 
  select 'B35', 'P888', 16, 20000, 0  FROM dual UNION ALL 
  select 'B28', 'P888', 20, 250000000, 0  FROM dual UNION ALL 
  select 'B38', 'P888', 20, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P888', 19, 450000, 0  FROM dual UNION ALL 
  select 'B19', 'P888', 15, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P889', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B18', 'P889', 1, 450000, 0  FROM dual UNION ALL 
  select 'B43', 'P890', 1, 200000, 0  FROM dual UNION ALL 
  select 'B22', 'P891', 16, 2100000, 0  FROM dual UNION ALL 
  select 'B9', 'P891', 25, 25000000, 0  FROM dual UNION ALL 
  select 'B40', 'P891', 25, 400000, 0  FROM dual UNION ALL 
  select 'B21', 'P892', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B35', 'P893', 17, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P893', 16, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P893', 15, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P893', 15, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P893', 20, 20000, 0  FROM dual UNION ALL 
  select 'B21', 'P894', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B42', 'P894', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P895', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P896', 10, 250000, 0  FROM dual UNION ALL 
  select 'B6', 'P896', 10, 6000000, 0  FROM dual UNION ALL 
  select 'B35', 'P896', 10, 20000, 0  FROM dual UNION ALL 
  select 'B43', 'P896', 18, 200000, 0  FROM dual UNION ALL 
  select 'B23', 'P896', 14, 3000000, 0  FROM dual UNION ALL 
  select 'B17', 'P897', 1, 350000, 0  FROM dual UNION ALL 
  select 'B20', 'P898', 1, 350000, 0  FROM dual UNION ALL 
  select 'B37', 'P899', 20, 50000, 0  FROM dual UNION ALL 
  select 'B32', 'P899', 11, 20000, 0  FROM dual UNION ALL 
  select 'B12', 'P899', 16, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P899', 19, 250000, 0  FROM dual UNION ALL 
  select 'B13', 'P899', 10, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P900', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P900', 1, 400000, 0  FROM dual UNION ALL 
  select 'B43', 'P901', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P902', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P902', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B7', 'P903', 23, 12000000, 0  FROM dual UNION ALL 
  select 'B24', 'P903', 30, 475000, 0  FROM dual UNION ALL 
  select 'B38', 'P903', 18, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P904', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B21', 'P905', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B23', 'P905', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B39', 'P906', 1, 250000, 0  FROM dual UNION ALL 
  select 'B38', 'P907', 1, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P907', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P908', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P908', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P909', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P910', 1, 500000, 0  FROM dual UNION ALL 
  select 'B38', 'P911', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P911', 1, 200000, 0  FROM dual UNION ALL 
  select 'B31', 'P912', 14, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P912', 18, 100000, 0  FROM dual UNION ALL 
  select 'B29', 'P912', 13, 850000, 0  FROM dual UNION ALL 
  select 'B34', 'P912', 16, 20000, 0  FROM dual UNION ALL 
  select 'B42', 'P913', 1, 50000, 0  FROM dual UNION ALL 
  select 'B24', 'P913', 1, 475000, 0  FROM dual UNION ALL 
  select 'B28', 'P914', 15, 250000000, 0  FROM dual UNION ALL 
  select 'B35', 'P914', 12, 20000, 0  FROM dual UNION ALL 
  select 'B19', 'P914', 14, 300000, 0  FROM dual UNION ALL 
  select 'B23', 'P914', 10, 3000000, 0  FROM dual UNION ALL 
  select 'B27', 'P914', 19, 40000000, 0  FROM dual UNION ALL 
  select 'B29', 'P914', 12, 850000, 0  FROM dual UNION ALL 
  select 'B36', 'P914', 13, 500000, 0  FROM dual UNION ALL 
  select 'B33', 'P914', 11, 10000, 0  FROM dual UNION ALL 
  select 'B38', 'P914', 10, 250000, 0  FROM dual UNION ALL 
  select 'B9', 'P914', 10, 25000000, 0  FROM dual UNION ALL 
  select 'B17', 'P915', 1, 350000, 0  FROM dual UNION ALL 
  select 'B18', 'P915', 1, 450000, 0  FROM dual UNION ALL 
  select 'B40', 'P916', 1, 400000, 0  FROM dual UNION ALL 
  select 'B38', 'P916', 1, 250000, 0  FROM dual UNION ALL 
  select 'B38', 'P917', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P917', 1, 250000, 0  FROM dual UNION ALL 
  select 'B20', 'P918', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P919', 1, 200000, 0  FROM dual UNION ALL 
  select 'B23', 'P920', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B19', 'P920', 1, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P921', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P921', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P922', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B40', 'P923', 1, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P923', 1, 400000, 0  FROM dual UNION ALL 
  select 'B31', 'P924', 14, 80000, 0  FROM dual UNION ALL 
  select 'B29', 'P924', 11, 850000, 0  FROM dual UNION ALL 
  select 'B35', 'P924', 17, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P924', 14, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P924', 16, 20000, 0  FROM dual UNION ALL 
  select 'B4', 'P925', 20, 3100000, 0  FROM dual UNION ALL 
  select 'B19', 'P925', 20, 300000, 0  FROM dual UNION ALL 
  select 'B36', 'P925', 17, 500000, 0  FROM dual UNION ALL 
  select 'B34', 'P925', 20, 20000, 0  FROM dual UNION ALL 
  select 'B19', 'P925', 10, 300000, 0  FROM dual UNION ALL 
  select 'B16', 'P925', 10, 4000, 0  FROM dual UNION ALL 
  select 'B36', 'P925', 15, 500000, 0  FROM dual UNION ALL 
  select 'B40', 'P925', 13, 400000, 0  FROM dual UNION ALL 
  select 'B7', 'P925', 11, 12000000, 0  FROM dual UNION ALL 
  select 'B25', 'P925', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B11', 'P926', 13, 40000, 0  FROM dual UNION ALL 
  select 'B25', 'P926', 13, 1000000, 0  FROM dual UNION ALL 
  select 'B21', 'P926', 17, 1200000, 0  FROM dual UNION ALL 
  select 'B14', 'P926', 16, 4000, 0  FROM dual UNION ALL 
  select 'B40', 'P926', 13, 400000, 0  FROM dual UNION ALL 
  select 'B33', 'P926', 13, 10000, 0  FROM dual UNION ALL 
  select 'B9', 'P926', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B40', 'P926', 15, 400000, 0  FROM dual UNION ALL 
  select 'B34', 'P926', 13, 20000, 0  FROM dual UNION ALL 
  select 'B36', 'P927', 1, 500000, 0  FROM dual UNION ALL 
  select 'B36', 'P927', 1, 500000, 0  FROM dual UNION ALL 
  select 'B20', 'P928', 1, 350000, 0  FROM dual UNION ALL 
  select 'B38', 'P929', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P929', 1, 400000, 0  FROM dual UNION ALL 
  select 'B2', 'P930', 18, 3025000, 0  FROM dual UNION ALL 
  select 'B22', 'P930', 13, 2100000, 0  FROM dual UNION ALL 
  select 'B34', 'P930', 15, 20000, 0  FROM dual UNION ALL 
  select 'B7', 'P930', 16, 12000000, 0  FROM dual UNION ALL 
  select 'B13', 'P930', 13, 40000, 0  FROM dual UNION ALL 
  select 'B41', 'P930', 17, 1000000, 0  FROM dual UNION ALL 
  select 'B15', 'P930', 17, 4000, 0  FROM dual UNION ALL 
  select 'B24', 'P930', 15, 475000, 0  FROM dual UNION ALL 
  select 'B13', 'P930', 14, 40000, 0  FROM dual UNION ALL 
  select 'B2', 'P930', 14, 3025000, 0  FROM dual UNION ALL 
  select 'B43', 'P931', 1, 200000, 0  FROM dual UNION ALL 
  select 'B36', 'P931', 1, 500000, 0  FROM dual UNION ALL 
  select 'B17', 'P932', 1, 350000, 0  FROM dual UNION ALL 
  select 'B37', 'P932', 1, 50000, 0  FROM dual UNION ALL 
  select 'B1', 'P933', 20, 227500, 0  FROM dual UNION ALL 
  select 'B17', 'P933', 19, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P933', 15, 500000, 0  FROM dual UNION ALL 
  select 'B34', 'P933', 19, 20000, 0  FROM dual UNION ALL 
  select 'B19', 'P934', 18, 300000, 0  FROM dual UNION ALL 
  select 'B12', 'P934', 18, 40000, 0  FROM dual UNION ALL 
  select 'B25', 'P934', 10, 1000000, 0  FROM dual UNION ALL 
  select 'B9', 'P934', 14, 25000000, 0  FROM dual UNION ALL 
  select 'B14', 'P934', 13, 4000, 0  FROM dual UNION ALL 
  select 'B26', 'P934', 19, 100000000, 0  FROM dual UNION ALL 
  select 'B33', 'P934', 14, 10000, 0  FROM dual UNION ALL 
  select 'B14', 'P934', 10, 4000, 0  FROM dual UNION ALL 
  select 'B34', 'P935', 19, 20000, 0  FROM dual UNION ALL 
  select 'B9', 'P935', 16, 25000000, 0  FROM dual UNION ALL 
  select 'B6', 'P935', 15, 6000000, 0  FROM dual UNION ALL 
  select 'B34', 'P935', 19, 20000, 0  FROM dual UNION ALL 
  select 'B28', 'P935', 17, 250000000, 0  FROM dual UNION ALL 
  select 'B40', 'P935', 10, 400000, 0  FROM dual UNION ALL 
  select 'B10', 'P935', 11, 40000, 0  FROM dual UNION ALL 
  select 'B26', 'P935', 19, 100000000, 0  FROM dual UNION ALL 
  select 'B16', 'P935', 20, 4000, 0  FROM dual UNION ALL 
  select 'B18', 'P936', 1, 450000, 0  FROM dual UNION ALL 
  select 'B18', 'P936', 1, 450000, 0  FROM dual UNION ALL 
  select 'B36', 'P937', 1, 500000, 0  FROM dual UNION ALL 
  select 'B39', 'P938', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P939', 1, 200000, 0  FROM dual UNION ALL 
  select 'B41', 'P940', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P940', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P941', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B24', 'P941', 1, 475000, 0  FROM dual UNION ALL 
  select 'B19', 'P942', 1, 300000, 0  FROM dual UNION ALL 
  select 'B42', 'P942', 1, 50000, 0  FROM dual UNION ALL 
  select 'B20', 'P943', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P944', 1, 200000, 0  FROM dual UNION ALL 
  select 'B17', 'P944', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P945', 1, 200000, 0  FROM dual UNION ALL 
  select 'B21', 'P946', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B37', 'P946', 1, 50000, 0  FROM dual UNION ALL 
  select 'B24', 'P947', 1, 475000, 0  FROM dual UNION ALL 
  select 'B37', 'P948', 1, 50000, 0  FROM dual UNION ALL 
  select 'B23', 'P949', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B43', 'P950', 1, 200000, 0  FROM dual UNION ALL 
  select 'B4', 'P951', 26, 3100000, 0  FROM dual UNION ALL 
  select 'B17', 'P951', 25, 350000, 0  FROM dual UNION ALL 
  select 'B15', 'P951', 22, 4000, 0  FROM dual UNION ALL 
  select 'B29', 'P951', 30, 850000, 0  FROM dual UNION ALL 
  select 'B6', 'P951', 25, 6000000, 0  FROM dual UNION ALL 
  select 'B38', 'P952', 1, 250000, 0  FROM dual UNION ALL 
  select 'B19', 'P953', 1, 300000, 0  FROM dual UNION ALL 
  select 'B42', 'P954', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P955', 1, 500000, 0  FROM dual UNION ALL 
  select 'B21', 'P955', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B36', 'P956', 18, 500000, 0  FROM dual UNION ALL 
  select 'B30', 'P956', 19, 100000, 0  FROM dual UNION ALL 
  select 'B12', 'P956', 15, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P956', 20, 250000, 0  FROM dual UNION ALL 
  select 'B23', 'P956', 10, 3000000, 0  FROM dual UNION ALL 
  select 'B25', 'P956', 14, 1000000, 0  FROM dual UNION ALL 
  select 'B34', 'P956', 16, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P957', 17, 850000, 0  FROM dual UNION ALL 
  select 'B22', 'P957', 13, 2100000, 0  FROM dual UNION ALL 
  select 'B27', 'P957', 15, 40000000, 0  FROM dual UNION ALL 
  select 'B39', 'P957', 13, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P957', 20, 450000, 0  FROM dual UNION ALL 
  select 'B32', 'P957', 18, 20000, 0  FROM dual UNION ALL 
  select 'B9', 'P957', 15, 25000000, 0  FROM dual UNION ALL 
  select 'B29', 'P958', 18, 850000, 0  FROM dual UNION ALL 
  select 'B7', 'P958', 20, 12000000, 0  FROM dual UNION ALL 
  select 'B25', 'P958', 19, 1000000, 0  FROM dual UNION ALL 
  select 'B4', 'P958', 13, 3100000, 0  FROM dual UNION ALL 
  select 'B26', 'P958', 17, 100000000, 0  FROM dual UNION ALL 
  select 'B33', 'P958', 16, 10000, 0  FROM dual UNION ALL 
  select 'B42', 'P959', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P959', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P960', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P960', 1, 400000, 0  FROM dual UNION ALL 
  select 'B18', 'P961', 1, 450000, 0  FROM dual UNION ALL 
  select 'B24', 'P961', 1, 475000, 0  FROM dual UNION ALL 
  select 'B38', 'P962', 1, 250000, 0  FROM dual UNION ALL 
  select 'B19', 'P962', 1, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P963', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P964', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P965', 1, 300000, 0  FROM dual UNION ALL 
  select 'B39', 'P965', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P966', 1, 200000, 0  FROM dual UNION ALL 
  select 'B43', 'P967', 1, 200000, 0  FROM dual UNION ALL 
  select 'B36', 'P967', 1, 500000, 0  FROM dual UNION ALL 
  select 'B20', 'P968', 17, 350000, 0  FROM dual UNION ALL 
  select 'B22', 'P968', 18, 2100000, 0  FROM dual UNION ALL 
  select 'B40', 'P968', 11, 400000, 0  FROM dual UNION ALL 
  select 'B6', 'P968', 15, 6000000, 0  FROM dual UNION ALL 
  select 'B16', 'P968', 15, 4000, 0  FROM dual UNION ALL 
  select 'B21', 'P968', 20, 1200000, 0  FROM dual UNION ALL 
  select 'B16', 'P968', 19, 4000, 0  FROM dual UNION ALL 
  select 'B13', 'P968', 19, 40000, 0  FROM dual UNION ALL 
  select 'B41', 'P969', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B41', 'P970', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P970', 1, 475000, 0  FROM dual UNION ALL 
  select 'B5', 'P971', 17, 40000, 0  FROM dual UNION ALL 
  select 'B2', 'P971', 14, 3025000, 0  FROM dual UNION ALL 
  select 'B31', 'P971', 18, 80000, 0  FROM dual UNION ALL 
  select 'B7', 'P971', 10, 12000000, 0  FROM dual UNION ALL 
  select 'B19', 'P971', 14, 300000, 0  FROM dual UNION ALL 
  select 'B19', 'P971', 19, 300000, 0  FROM dual UNION ALL 
  select 'B21', 'P972', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B39', 'P973', 1, 250000, 0  FROM dual UNION ALL 
  select 'B38', 'P974', 11, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P974', 10, 250000, 0  FROM dual UNION ALL 
  select 'B17', 'P974', 11, 350000, 0  FROM dual UNION ALL 
  select 'B4', 'P974', 16, 3100000, 0  FROM dual UNION ALL 
  select 'B31', 'P974', 13, 80000, 0  FROM dual UNION ALL 
  select 'B5', 'P974', 20, 40000, 0  FROM dual UNION ALL 
  select 'B34', 'P974', 20, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P974', 10, 20000, 0  FROM dual UNION ALL 
  select 'B9', 'P974', 15, 25000000, 0  FROM dual UNION ALL 
  select 'B37', 'P975', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P975', 1, 50000, 0  FROM dual UNION ALL 
  select 'B35', 'P976', 11, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P976', 16, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P976', 12, 80000, 0  FROM dual UNION ALL 
  select 'B41', 'P977', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P977', 1, 200000, 0  FROM dual UNION ALL 
  select 'B25', 'P978', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B10', 'P979', 10, 40000, 0  FROM dual UNION ALL 
  select 'B43', 'P979', 19, 200000, 0  FROM dual UNION ALL 
  select 'B8', 'P979', 12, 20000000, 0  FROM dual UNION ALL 
  select 'B26', 'P979', 13, 100000000, 0  FROM dual UNION ALL 
  select 'B39', 'P979', 16, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P980', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B37', 'P981', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P982', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P983', 11, 400000, 0  FROM dual UNION ALL 
  select 'B14', 'P983', 13, 4000, 0  FROM dual UNION ALL 
  select 'B19', 'P983', 11, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P983', 17, 1000000, 0  FROM dual UNION ALL 
  select 'B34', 'P983', 16, 20000, 0  FROM dual UNION ALL 
  select 'B26', 'P983', 14, 100000000, 0  FROM dual UNION ALL 
  select 'B3', 'P983', 17, 20000000, 0  FROM dual UNION ALL 
  select 'B43', 'P984', 1, 200000, 0  FROM dual UNION ALL 
  select 'B17', 'P985', 1, 350000, 0  FROM dual UNION ALL 
  select 'B6', 'P986', 10, 6000000, 0  FROM dual UNION ALL 
  select 'B30', 'P986', 15, 100000, 0  FROM dual UNION ALL 
  select 'B21', 'P986', 10, 1200000, 0  FROM dual UNION ALL 
  select 'B20', 'P986', 12, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P986', 14, 500000, 0  FROM dual UNION ALL 
  select 'B10', 'P986', 20, 40000, 0  FROM dual UNION ALL 
  select 'B30', 'P987', 28, 100000, 0  FROM dual UNION ALL 
  select 'B18', 'P987', 26, 450000, 0  FROM dual UNION ALL 
  select 'B34', 'P987', 18, 20000, 0  FROM dual UNION ALL 
  select 'B8', 'P987', 15, 20000000, 0  FROM dual UNION ALL 
  select 'B5', 'P987', 22, 40000, 0  FROM dual UNION ALL 
  select 'B19', 'P987', 25, 300000, 0  FROM dual UNION ALL 
  select 'B18', 'P987', 26, 450000, 0  FROM dual UNION ALL 
  select 'B7', 'P987', 16, 12000000, 0  FROM dual UNION ALL 
  select 'B5', 'P987', 27, 40000, 0  FROM dual UNION ALL 
  select 'B15', 'P987', 16, 4000, 0  FROM dual UNION ALL 
  select 'B17', 'P988', 14, 350000, 0  FROM dual UNION ALL 
  select 'B32', 'P988', 17, 20000, 0  FROM dual UNION ALL 
  select 'B24', 'P988', 16, 475000, 0  FROM dual UNION ALL 
  select 'B3', 'P988', 12, 20000000, 0  FROM dual UNION ALL 
  select 'B35', 'P988', 16, 20000, 0  FROM dual UNION ALL 
  select 'B22', 'P988', 14, 2100000, 0  FROM dual UNION ALL 
  select 'B35', 'P989', 16, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P989', 18, 80000, 0  FROM dual UNION ALL 
  select 'B32', 'P989', 16, 20000, 0  FROM dual UNION ALL 
  select 'B16', 'P989', 12, 4000, 0  FROM dual UNION ALL 
  select 'B8', 'P989', 10, 20000000, 0  FROM dual UNION ALL 
  select 'B24', 'P989', 15, 475000, 0  FROM dual UNION ALL 
  select 'B29', 'P990', 15, 850000, 0  FROM dual UNION ALL 
  select 'B15', 'P990', 16, 4000, 0  FROM dual UNION ALL 
  select 'B25', 'P990', 13, 1000000, 0  FROM dual UNION ALL 
  select 'B31', 'P990', 17, 80000, 0  FROM dual UNION ALL 
  select 'B22', 'P990', 17, 2100000, 0  FROM dual UNION ALL 
  select 'B26', 'P990', 19, 100000000, 0  FROM dual UNION ALL 
  select 'B3', 'P990', 18, 20000000, 0  FROM dual UNION ALL 
  select 'B17', 'P991', 1, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P991', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B41', 'P992', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B25', 'P993', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P993', 1, 200000, 0  FROM dual UNION ALL 
  select 'B36', 'P994', 12, 500000, 0  FROM dual UNION ALL 
  select 'B42', 'P994', 16, 50000, 0  FROM dual UNION ALL 
  select 'B7', 'P994', 13, 12000000, 0  FROM dual UNION ALL 
  select 'B42', 'P994', 19, 50000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B38', 'P994', 16, 250000, 0  FROM dual UNION ALL 
  select 'B12', 'P994', 19, 40000, 0  FROM dual UNION ALL 
  select 'B10', 'P994', 13, 40000, 0  FROM dual UNION ALL 
  select 'B40', 'P994', 12, 400000, 0  FROM dual UNION ALL 
  select 'B37', 'P995', 21, 50000, 0  FROM dual UNION ALL 
  select 'B23', 'P995', 19, 3000000, 0  FROM dual UNION ALL 
  select 'B30', 'P995', 23, 100000, 0  FROM dual UNION ALL 
  select 'B36', 'P995', 17, 500000, 0  FROM dual UNION ALL 
  select 'B5', 'P995', 19, 40000, 0  FROM dual UNION ALL 
  select 'B37', 'P996', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P996', 1, 250000, 0  FROM dual UNION ALL 
  select 'B28', 'P997', 11, 250000000, 0  FROM dual UNION ALL 
  select 'B24', 'P997', 10, 475000, 0  FROM dual UNION ALL 
  select 'B29', 'P997', 14, 850000, 0  FROM dual UNION ALL 
  select 'B30', 'P997', 10, 100000, 0  FROM dual UNION ALL 
  select 'B12', 'P997', 20, 40000, 0  FROM dual UNION ALL 
  select 'B12', 'P997', 13, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P997', 10, 6000000, 0  FROM dual UNION ALL 
  select 'B31', 'P997', 13, 80000, 0  FROM dual UNION ALL 
  select 'B39', 'P997', 13, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P997', 17, 400000, 0  FROM dual UNION ALL 
  select 'B35', 'P998', 12, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P998', 20, 80000, 0  FROM dual UNION ALL 
  select 'B34', 'P998', 15, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P998', 12, 850000, 0  FROM dual UNION ALL 
  select 'B29', 'P998', 12, 850000, 0  FROM dual UNION ALL 
  select 'B24', 'P999', 1, 475000, 0  FROM dual UNION ALL 
  select 'B19', 'P1000', 1, 300000, 0  FROM dual UNION ALL 
  select 'B17', 'P1001', 1, 350000, 0  FROM dual UNION ALL 
  select 'B31', 'P1002', 16, 80000, 0  FROM dual UNION ALL 
  select 'B3', 'P1002', 11, 20000000, 0  FROM dual UNION ALL 
  select 'B34', 'P1002', 12, 20000, 0  FROM dual UNION ALL 
  select 'B33', 'P1002', 17, 10000, 0  FROM dual UNION ALL 
  select 'B2', 'P1002', 19, 3025000, 0  FROM dual UNION ALL 
  select 'B22', 'P1002', 10, 2100000, 0  FROM dual UNION ALL 
  select 'B40', 'P1002', 20, 400000, 0  FROM dual UNION ALL 
  select 'B25', 'P1002', 12, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P1002', 10, 350000, 0  FROM dual UNION ALL 
  select 'B35', 'P1002', 17, 20000, 0  FROM dual UNION ALL 
  select 'B40', 'P1003', 1, 400000, 0  FROM dual UNION ALL 
  select 'B24', 'P1004', 1, 475000, 0  FROM dual UNION ALL 
  select 'B37', 'P1005', 1, 50000, 0  FROM dual UNION ALL 
  select 'B2', 'P1006', 13, 3025000, 0  FROM dual UNION ALL 
  select 'B42', 'P1006', 14, 50000, 0  FROM dual UNION ALL 
  select 'B6', 'P1006', 14, 6000000, 0  FROM dual UNION ALL 
  select 'B34', 'P1006', 10, 20000, 0  FROM dual UNION ALL 
  select 'B4', 'P1006', 15, 3100000, 0  FROM dual UNION ALL 
  select 'B21', 'P1006', 12, 1200000, 0  FROM dual UNION ALL 
  select 'B31', 'P1006', 19, 80000, 0  FROM dual UNION ALL 
  select 'B34', 'P1006', 10, 20000, 0  FROM dual UNION ALL 
  select 'B25', 'P1006', 11, 1000000, 0  FROM dual UNION ALL 
  select 'B27', 'P1007', 18, 40000000, 0  FROM dual UNION ALL 
  select 'B41', 'P1007', 20, 1000000, 0  FROM dual UNION ALL 
  select 'B23', 'P1007', 20, 3000000, 0  FROM dual UNION ALL 
  select 'B11', 'P1007', 17, 40000, 0  FROM dual UNION ALL 
  select 'B25', 'P1007', 12, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P1008', 1, 400000, 0  FROM dual UNION ALL 
  select 'B29', 'P1009', 20, 850000, 0  FROM dual UNION ALL 
  select 'B33', 'P1009', 11, 10000, 0  FROM dual UNION ALL 
  select 'B18', 'P1009', 13, 450000, 0  FROM dual UNION ALL 
  select 'B6', 'P1009', 20, 6000000, 0  FROM dual UNION ALL 
  select 'B24', 'P1009', 15, 475000, 0  FROM dual UNION ALL 
  select 'B42', 'P1010', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P1010', 1, 50000, 0  FROM dual UNION ALL 
  select 'B35', 'P1011', 16, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P1011', 18, 80000, 0  FROM dual UNION ALL 
  select 'B32', 'P1011', 13, 20000, 0  FROM dual UNION ALL 
  select 'B38', 'P1012', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P1013', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P1013', 1, 500000, 0  FROM dual UNION ALL 
  select 'B38', 'P1014', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P1014', 1, 200000, 0  FROM dual UNION ALL 
  select 'B22', 'P1015', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B23', 'P1015', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B21', 'P1016', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B36', 'P1016', 1, 500000, 0  FROM dual UNION ALL 
  select 'B21', 'P1017', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B17', 'P1017', 1, 350000, 0  FROM dual UNION ALL 
  select 'B3', 'P1018', 28, 20000000, 0  FROM dual UNION ALL 
  select 'B22', 'P1018', 23, 2100000, 0  FROM dual UNION ALL 
  select 'B39', 'P1018', 17, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P1018', 26, 500000, 0  FROM dual UNION ALL 
  select 'B11', 'P1018', 27, 40000, 0  FROM dual UNION ALL 
  select 'B1', 'P1018', 25, 227500, 0  FROM dual UNION ALL 
  select 'B21', 'P1018', 26, 1200000, 0  FROM dual UNION ALL 
  select 'B37', 'P1018', 29, 50000, 0  FROM dual UNION ALL 
  select 'B23', 'P1019', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B21', 'P1020', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B36', 'P1021', 1, 500000, 0  FROM dual UNION ALL 
  select 'B38', 'P1021', 1, 250000, 0  FROM dual UNION ALL 
  select 'B30', 'P1022', 13, 100000, 0  FROM dual UNION ALL 
  select 'B22', 'P1022', 14, 2100000, 0  FROM dual UNION ALL 
  select 'B43', 'P1022', 14, 200000, 0  FROM dual UNION ALL 
  select 'B17', 'P1022', 12, 350000, 0  FROM dual UNION ALL 
  select 'B31', 'P1022', 10, 80000, 0  FROM dual UNION ALL 
  select 'B43', 'P1022', 19, 200000, 0  FROM dual UNION ALL 
  select 'B32', 'P1022', 17, 20000, 0  FROM dual UNION ALL 
  select 'B9', 'P1022', 18, 25000000, 0  FROM dual UNION ALL 
  select 'B21', 'P1023', 16, 1200000, 0  FROM dual UNION ALL 
  select 'B20', 'P1023', 12, 350000, 0  FROM dual UNION ALL 
  select 'B17', 'P1023', 12, 350000, 0  FROM dual UNION ALL 
  select 'B10', 'P1023', 19, 40000, 0  FROM dual UNION ALL 
  select 'B19', 'P1023', 18, 300000, 0  FROM dual UNION ALL 
  select 'B25', 'P1023', 11, 1000000, 0  FROM dual UNION ALL 
  select 'B17', 'P1023', 15, 350000, 0  FROM dual UNION ALL 
  select 'B19', 'P1024', 28, 300000, 0  FROM dual UNION ALL 
  select 'B19', 'P1024', 16, 300000, 0  FROM dual UNION ALL 
  select 'B19', 'P1024', 20, 300000, 0  FROM dual UNION ALL 
  select 'B20', 'P1024', 30, 350000, 0  FROM dual UNION ALL 
  select 'B37', 'P1024', 17, 50000, 0  FROM dual UNION ALL 
  select 'B27', 'P1024', 21, 40000000, 0  FROM dual UNION ALL 
  select 'B24', 'P1024', 19, 475000, 0  FROM dual UNION ALL 
  select 'B4', 'P1024', 20, 3100000, 0  FROM dual UNION ALL 
  select 'B36', 'P1025', 1, 500000, 0  FROM dual UNION ALL 
  select 'B29', 'P1026', 13, 850000, 0  FROM dual UNION ALL 
  select 'B34', 'P1026', 14, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P1026', 20, 20000, 0  FROM dual UNION ALL 
  select 'B36', 'P1027', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P1027', 1, 50000, 0  FROM dual UNION ALL 
  select 'B12', 'P1028', 14, 40000, 0  FROM dual UNION ALL 
  select 'B19', 'P1028', 12, 300000, 0  FROM dual UNION ALL 
  select 'B33', 'P1028', 14, 10000, 0  FROM dual UNION ALL 
  select 'B24', 'P1028', 16, 475000, 0  FROM dual UNION ALL 
  select 'B12', 'P1028', 16, 40000, 0  FROM dual UNION ALL 
  select 'B40', 'P1029', 1, 400000, 0  FROM dual UNION ALL 
  select 'B37', 'P1030', 1, 50000, 0  FROM dual UNION ALL 
  select 'B34', 'P1031', 20, 20000, 0  FROM dual UNION ALL 
  select 'B15', 'P1031', 19, 4000, 0  FROM dual UNION ALL 
  select 'B42', 'P1031', 17, 50000, 0  FROM dual UNION ALL 
  select 'B28', 'P1031', 29, 250000000, 0  FROM dual UNION ALL 
  select 'B22', 'P1032', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B43', 'P1033', 1, 200000, 0  FROM dual UNION ALL 
  select 'B36', 'P1034', 1, 500000, 0  FROM dual UNION ALL 
  select 'B19', 'P1034', 1, 300000, 0  FROM dual UNION ALL 
  select 'B36', 'P1035', 16, 500000, 0  FROM dual UNION ALL 
  select 'B3', 'P1035', 20, 20000000, 0  FROM dual UNION ALL 
  select 'B3', 'P1035', 10, 20000000, 0  FROM dual UNION ALL 
  select 'B18', 'P1035', 14, 450000, 0  FROM dual UNION ALL 
  select 'B16', 'P1035', 11, 4000, 0  FROM dual UNION ALL 
  select 'B17', 'P1036', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P1037', 17, 400000, 0  FROM dual UNION ALL 
  select 'B13', 'P1037', 18, 40000, 0  FROM dual UNION ALL 
  select 'B35', 'P1037', 17, 20000, 0  FROM dual UNION ALL 
  select 'B40', 'P1037', 17, 400000, 0  FROM dual UNION ALL 
  select 'B25', 'P1037', 11, 1000000, 0  FROM dual UNION ALL 
  select 'B35', 'P1037', 17, 20000, 0  FROM dual UNION ALL 
  select 'B21', 'P1038', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B35', 'P1039', 21, 20000, 0  FROM dual UNION ALL 
  select 'B20', 'P1039', 30, 350000, 0  FROM dual UNION ALL 
  select 'B19', 'P1039', 21, 300000, 0  FROM dual UNION ALL 
  select 'B20', 'P1039', 24, 350000, 0  FROM dual UNION ALL 
  select 'B13', 'P1039', 22, 40000, 0  FROM dual UNION ALL 
  select 'B36', 'P1040', 1, 500000, 0  FROM dual UNION ALL 
  select 'B40', 'P1040', 1, 400000, 0  FROM dual UNION ALL 
  select 'B25', 'P1041', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P1041', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P1042', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B10', 'P1043', 10, 40000, 0  FROM dual UNION ALL 
  select 'B2', 'P1043', 12, 3025000, 0  FROM dual UNION ALL 
  select 'B16', 'P1043', 10, 4000, 0  FROM dual UNION ALL 
  select 'B7', 'P1043', 17, 12000000, 0  FROM dual UNION ALL 
  select 'B4', 'P1043', 11, 3100000, 0  FROM dual UNION ALL 
  select 'B5', 'P1043', 18, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P1043', 11, 6000000, 0  FROM dual UNION ALL 
  select 'B39', 'P1043', 18, 250000, 0  FROM dual UNION ALL 
  select 'B4', 'P1043', 12, 3100000, 0  FROM dual UNION ALL 
  select 'B24', 'P1043', 12, 475000, 0  FROM dual UNION ALL 
  select 'B28', 'P1044', 18, 250000000, 0  FROM dual UNION ALL 
  select 'B13', 'P1044', 10, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P1044', 14, 450000, 0  FROM dual UNION ALL 
  select 'B39', 'P1044', 10, 250000, 0  FROM dual UNION ALL 
  select 'B35', 'P1044', 13, 20000, 0  FROM dual UNION ALL 
  select 'B8', 'P1044', 18, 20000000, 0  FROM dual UNION ALL 
  select 'B21', 'P1044', 14, 1200000, 0  FROM dual UNION ALL 
  select 'B38', 'P1044', 14, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P1045', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P1046', 1, 200000, 0  FROM dual UNION ALL 
  select 'B18', 'P1046', 1, 450000, 0  FROM dual UNION ALL 
  select 'B23', 'P1047', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B39', 'P1048', 1, 250000, 0  FROM dual UNION ALL 
  select 'B4', 'P1049', 18, 3100000, 0  FROM dual UNION ALL 
  select 'B7', 'P1049', 17, 12000000, 0  FROM dual UNION ALL 
  select 'B22', 'P1049', 10, 2100000, 0  FROM dual UNION ALL 
  select 'B43', 'P1049', 11, 200000, 0  FROM dual UNION ALL 
  select 'B35', 'P1049', 18, 20000, 0  FROM dual UNION ALL 
  select 'B28', 'P1049', 11, 250000000, 0  FROM dual UNION ALL 
  select 'B16', 'P1049', 20, 4000, 0  FROM dual UNION ALL 
  select 'B22', 'P1049', 10, 2100000, 0  FROM dual UNION ALL 
  select 'B26', 'P1049', 11, 100000000, 0  FROM dual UNION ALL 
  select 'B13', 'P1049', 16, 40000, 0  FROM dual UNION ALL 
  select 'B22', 'P1050', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B38', 'P1050', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P1051', 16, 2100000, 0  FROM dual UNION ALL 
  select 'B7', 'P1051', 20, 12000000, 0  FROM dual UNION ALL 
  select 'B17', 'P1051', 16, 350000, 0  FROM dual UNION ALL 
  select 'B14', 'P1051', 15, 4000, 0  FROM dual UNION ALL 
  select 'B14', 'P1051', 17, 4000, 0  FROM dual UNION ALL 
  select 'B32', 'P1051', 16, 20000, 0  FROM dual UNION ALL 
  select 'B11', 'P1051', 14, 40000, 0  FROM dual UNION ALL 
  select 'B9', 'P1051', 11, 25000000, 0  FROM dual UNION ALL 
  select 'B29', 'P1051', 14, 850000, 0  FROM dual UNION ALL 
  select 'B7', 'P1051', 11, 12000000, 0  FROM dual UNION ALL 
  select 'B37', 'P1052', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P1052', 1, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P1053', 1, 450000, 0  FROM dual UNION ALL 
  select 'B37', 'P1053', 1, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P1054', 25, 400000, 0  FROM dual UNION ALL 
  select 'B18', 'P1054', 25, 450000, 0  FROM dual UNION ALL 
  select 'B41', 'P1054', 29, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P1054', 18, 475000, 0  FROM dual UNION ALL 
  select 'B30', 'P1054', 30, 100000, 0  FROM dual UNION ALL 
  select 'B33', 'P1054', 27, 10000, 0  FROM dual UNION ALL 
  select 'B35', 'P1054', 20, 20000, 0  FROM dual UNION ALL 
  select 'B24', 'P1055', 1, 475000, 0  FROM dual UNION ALL 
  select 'B43', 'P1056', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P1057', 1, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P1057', 1, 450000, 0  FROM dual UNION ALL 
  select 'B22', 'P1058', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B34', 'P1059', 16, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P1059', 15, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P1059', 11, 100000, 0  FROM dual UNION ALL 
  select 'B34', 'P1059', 10, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P1059', 19, 850000, 0  FROM dual UNION ALL 
  select 'B37', 'P1060', 1, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P1060', 1, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P1061', 1, 450000, 0  FROM dual UNION ALL 
  select 'B17', 'P1061', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P1062', 17, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P1062', 12, 400000, 0  FROM dual UNION ALL 
  select 'B16', 'P1062', 17, 4000, 0  FROM dual UNION ALL 
  select 'B6', 'P1062', 12, 6000000, 0  FROM dual UNION ALL 
  select 'B16', 'P1062', 20, 4000, 0  FROM dual UNION ALL 
  select 'B33', 'P1062', 14, 10000, 0  FROM dual UNION ALL 
  select 'B15', 'P1062', 15, 4000, 0  FROM dual UNION ALL 
  select 'B22', 'P1063', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B43', 'P1064', 1, 200000, 0  FROM dual UNION ALL 
  select 'B20', 'P1065', 1, 350000, 0  FROM dual UNION ALL 
  select 'B23', 'P1065', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B31', 'P1066', 16, 80000, 0  FROM dual UNION ALL 
  select 'B40', 'P1066', 20, 400000, 0  FROM dual UNION ALL 
  select 'B16', 'P1066', 13, 4000, 0  FROM dual UNION ALL 
  select 'B7', 'P1066', 17, 12000000, 0  FROM dual UNION ALL 
  select 'B18', 'P1066', 13, 450000, 0  FROM dual UNION ALL 
  select 'B28', 'P1066', 10, 250000000, 0  FROM dual UNION ALL 
  select 'B12', 'P1066', 17, 40000, 0  FROM dual UNION ALL 
  select 'B16', 'P1066', 11, 4000, 0  FROM dual UNION ALL 
  select 'B4', 'P1066', 17, 3100000, 0  FROM dual UNION ALL 
  select 'B8', 'P1066', 17, 20000000, 0  FROM dual UNION ALL 
  select 'B37', 'P1067', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P1068', 1, 300000, 0  FROM dual UNION ALL 
  select 'B36', 'P1068', 1, 500000, 0  FROM dual UNION ALL 
  select 'B20', 'P1069', 1, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P1070', 13, 50000, 0  FROM dual UNION ALL 
  select 'B9', 'P1070', 13, 25000000, 0  FROM dual UNION ALL 
  select 'B29', 'P1070', 19, 850000, 0  FROM dual UNION ALL 
  select 'B2', 'P1070', 19, 3025000, 0  FROM dual UNION ALL 
  select 'B24', 'P1070', 19, 475000, 0  FROM dual UNION ALL 
  select 'B24', 'P1070', 11, 475000, 0  FROM dual UNION ALL 
  select 'B38', 'P1071', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P1072', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P1073', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P1073', 1, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P1074', 1, 400000, 0  FROM dual UNION ALL 
  select 'B21', 'P1074', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B24', 'P1075', 1, 475000, 0  FROM dual UNION ALL 
  select 'B39', 'P1075', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P1076', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P1076', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B38', 'P1077', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P1078', 1, 250000, 0  FROM dual UNION ALL 
  select 'B15', 'P1079', 14, 4000, 0  FROM dual UNION ALL 
  select 'B13', 'P1079', 11, 40000, 0  FROM dual UNION ALL 
  select 'B30', 'P1079', 11, 100000, 0  FROM dual UNION ALL 
  select 'B30', 'P1079', 19, 100000, 0  FROM dual UNION ALL 
  select 'B5', 'P1079', 10, 40000, 0  FROM dual UNION ALL 
  select 'B10', 'P1079', 15, 40000, 0  FROM dual UNION ALL 
  select 'B31', 'P1079', 19, 80000, 0  FROM dual UNION ALL 
  select 'B30', 'P1079', 15, 100000, 0  FROM dual UNION ALL 
  select 'B36', 'P1079', 15, 500000, 0  FROM dual UNION ALL 
  select 'B20', 'P1079', 20, 350000, 0  FROM dual UNION ALL 
  select 'B41', 'P1080', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B23', 'P1081', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B17', 'P1081', 1, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P1082', 1, 50000, 0  FROM dual UNION ALL 
  select 'B20', 'P1082', 1, 350000, 0  FROM dual UNION ALL 
  select 'B17', 'P1083', 1, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P1083', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P1084', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P1085', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P1086', 1, 400000, 0  FROM dual UNION ALL 
  select 'B20', 'P1086', 1, 350000, 0  FROM dual UNION ALL 
  select 'B13', 'P1087', 16, 40000, 0  FROM dual UNION ALL 
  select 'B34', 'P1087', 29, 20000, 0  FROM dual UNION ALL 
  select 'B43', 'P1087', 24, 200000, 0  FROM dual UNION ALL 
  select 'B8', 'P1088', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B32', 'P1088', 15, 20000, 0  FROM dual UNION ALL 
  select 'B5', 'P1088', 12, 40000, 0  FROM dual UNION ALL 
  select 'B8', 'P1088', 13, 20000000, 0  FROM dual UNION ALL 
  select 'B12', 'P1088', 12, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P1088', 13, 40000000, 0  FROM dual UNION ALL 
  select 'B39', 'P1088', 12, 250000, 0  FROM dual UNION ALL 
  select 'B26', 'P1088', 14, 100000000, 0  FROM dual UNION ALL 
  select 'B5', 'P1088', 20, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P1089', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P1090', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P1090', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P1091', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P1091', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P1092', 1, 200000, 0  FROM dual UNION ALL 
  select 'B39', 'P1093', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P1094', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P1095', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P1096', 1, 250000, 0  FROM dual UNION ALL 
  select 'B23', 'P1097', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B42', 'P1097', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P1098', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P1098', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P1099', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P1099', 1, 400000, 0  FROM dual UNION ALL 
  select 'B20', 'P1100', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P1100', 1, 200000, 0  FROM dual UNION ALL 
  select 'B18', 'P1101', 1, 450000, 0  FROM dual UNION ALL 
  select 'B43', 'P1101', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P1102', 1, 400000, 0  FROM dual UNION ALL 
  select 'B37', 'P1102', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P1103', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B41', 'P1104', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P1104', 1, 200000, 0  FROM dual UNION ALL 
  select 'B36', 'P1105', 1, 500000, 0  FROM dual UNION ALL 
  select 'B24', 'P1105', 1, 475000, 0  FROM dual UNION ALL 
  select 'B42', 'P1106', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P1107', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P1108', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P1108', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B38', 'P1109', 1, 250000, 0  FROM dual UNION ALL 
  select 'B25', 'P1110', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P1110', 1, 400000, 0  FROM dual UNION ALL 
  select 'B35', 'P1111', 17, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P1111', 12, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P1111', 18, 850000, 0  FROM dual UNION ALL 
  select 'B22', 'P1112', 27, 2100000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B31', 'P1112', 15, 80000, 0  FROM dual UNION ALL 
  select 'B41', 'P1112', 22, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P1112', 23, 250000, 0  FROM dual UNION ALL 
  select 'B10', 'P1112', 24, 40000, 0  FROM dual UNION ALL 
  select 'B6', 'P1112', 22, 6000000, 0  FROM dual UNION ALL 
  select 'B9', 'P1112', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B1', 'P1112', 27, 227500, 0  FROM dual UNION ALL 
  select 'B42', 'P1113', 1, 50000, 0  FROM dual UNION ALL 
  select 'B22', 'P1113', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B20', 'P1114', 1, 350000, 0  FROM dual UNION ALL 
  select 'B20', 'P1114', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P1115', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P1116', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P1116', 1, 50000, 0  FROM dual UNION ALL 
  select 'B25', 'P1117', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B36', 'P1117', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P1118', 1, 50000, 0  FROM dual UNION ALL 
  select 'B23', 'P1119', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B37', 'P1119', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P1120', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P1120', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P1121', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P1121', 1, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P1122', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P1122', 1, 500000, 0  FROM dual UNION ALL 
  select 'B25', 'P1123', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B23', 'P1124', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B34', 'P1125', 10, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P1125', 18, 100000, 0  FROM dual UNION ALL 
  select 'B32', 'P1125', 18, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P1125', 17, 80000, 0  FROM dual UNION ALL 
  select 'B32', 'P1125', 17, 20000, 0  FROM dual UNION ALL 
  select 'B38', 'P1126', 13, 250000, 0  FROM dual UNION ALL 
  select 'B33', 'P1126', 18, 10000, 0  FROM dual UNION ALL 
  select 'B10', 'P1126', 18, 40000, 0  FROM dual UNION ALL 
  select 'B3', 'P1126', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B34', 'P1126', 19, 20000, 0  FROM dual UNION ALL 
  select 'B40', 'P1127', 1, 400000, 0  FROM dual UNION ALL 
  select 'B26', 'P1128', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B14', 'P1128', 15, 4000, 0  FROM dual UNION ALL 
  select 'B37', 'P1128', 11, 50000, 0  FROM dual UNION ALL 
  select 'B17', 'P1128', 19, 350000, 0  FROM dual UNION ALL 
  select 'B27', 'P1128', 18, 40000000, 0  FROM dual UNION ALL 
  select 'B7', 'P1128', 12, 12000000, 0  FROM dual UNION ALL 
  select 'B22', 'P1129', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B24', 'P1129', 1, 475000, 0  FROM dual UNION ALL 
  select 'B39', 'P1130', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P1130', 1, 200000, 0  FROM dual UNION ALL 
  select 'B43', 'P1131', 1, 200000, 0  FROM dual UNION ALL 
  select 'B20', 'P1131', 1, 350000, 0  FROM dual UNION ALL 
  select 'B11', 'P1132', 17, 40000, 0  FROM dual UNION ALL 
  select 'B35', 'P1132', 10, 20000, 0  FROM dual UNION ALL 
  select 'B41', 'P1132', 11, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P1132', 15, 50000, 0  FROM dual UNION ALL 
  select 'B4', 'P1132', 20, 3100000, 0  FROM dual UNION ALL 
  select 'B43', 'P1133', 1, 200000, 0  FROM dual UNION ALL 
  select 'B39', 'P1133', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P1134', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B36', 'P1135', 1, 500000, 0  FROM dual UNION ALL 
  select 'B36', 'P1135', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P1136', 1, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P1137', 1, 450000, 0  FROM dual UNION ALL 
  select 'B38', 'P1138', 1, 250000, 0  FROM dual UNION ALL 
  select 'B21', 'P1139', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B29', 'P1140', 15, 850000, 0  FROM dual UNION ALL 
  select 'B13', 'P1140', 18, 40000, 0  FROM dual UNION ALL 
  select 'B42', 'P1140', 20, 50000, 0  FROM dual UNION ALL 
  select 'B27', 'P1140', 16, 40000000, 0  FROM dual UNION ALL 
  select 'B18', 'P1140', 19, 450000, 0  FROM dual UNION ALL 
  select 'B43', 'P1141', 1, 200000, 0  FROM dual UNION ALL 
  select 'B25', 'P1141', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B21', 'P1142', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B25', 'P1142', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B35', 'P1143', 18, 20000, 0  FROM dual UNION ALL 
  select 'B40', 'P1143', 12, 400000, 0  FROM dual UNION ALL 
  select 'B7', 'P1143', 13, 12000000, 0  FROM dual UNION ALL 
  select 'B22', 'P1143', 13, 2100000, 0  FROM dual UNION ALL 
  select 'B24', 'P1143', 10, 475000, 0  FROM dual UNION ALL 
  select 'B40', 'P1143', 16, 400000, 0  FROM dual UNION ALL 
  select 'B7', 'P1143', 20, 12000000, 0  FROM dual UNION ALL 
  select 'B30', 'P1143', 13, 100000, 0  FROM dual UNION ALL 
  select 'B14', 'P1143', 16, 4000, 0  FROM dual UNION ALL 
  select 'B41', 'P1144', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P1144', 1, 50000, 0  FROM dual UNION ALL 
  select 'B28', 'P1145', 10, 250000000, 0  FROM dual UNION ALL 
  select 'B21', 'P1145', 19, 1200000, 0  FROM dual UNION ALL 
  select 'B16', 'P1145', 12, 4000, 0  FROM dual UNION ALL 
  select 'B34', 'P1145', 17, 20000, 0  FROM dual UNION ALL 
  select 'B2', 'P1145', 20, 3025000, 0  FROM dual UNION ALL 
  select 'B42', 'P1145', 16, 50000, 0  FROM dual UNION ALL 
  select 'B42', 'P1145', 13, 50000, 0  FROM dual UNION ALL 
  select 'B24', 'P1146', 1, 475000, 0  FROM dual UNION ALL 
  select 'B37', 'P1146', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P1147', 1, 500000, 0  FROM dual UNION ALL 
  select 'B21', 'P1148', 16, 1200000, 0  FROM dual UNION ALL 
  select 'B26', 'P1148', 16, 100000000, 0  FROM dual UNION ALL 
  select 'B20', 'P1148', 17, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P1148', 16, 500000, 0  FROM dual UNION ALL 
  select 'B35', 'P1148', 20, 20000, 0  FROM dual UNION ALL 
  select 'B42', 'P1149', 1, 50000, 0  FROM dual UNION ALL 
  select 'B13', 'P1150', 17, 40000, 0  FROM dual UNION ALL 
  select 'B35', 'P1150', 15, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P1150', 17, 20000, 0  FROM dual UNION ALL 
  select 'B8', 'P1150', 13, 20000000, 0  FROM dual UNION ALL 
  select 'B42', 'P1150', 19, 50000, 0  FROM dual UNION ALL 
  select 'B9', 'P1150', 15, 25000000, 0  FROM dual UNION ALL 
  select 'B3', 'P1150', 20, 20000000, 0  FROM dual UNION ALL 
  select 'B20', 'P1151', 1, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P1151', 1, 500000, 0  FROM dual UNION ALL 
  select 'B36', 'P1152', 1, 500000, 0  FROM dual UNION ALL 
  select 'B35', 'P1153', 19, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P1153', 19, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P1153', 13, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P1153', 15, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P1153', 20, 100000, 0  FROM dual UNION ALL 
  select 'B15', 'P1154', 10, 4000, 0  FROM dual UNION ALL 
  select 'B43', 'P1154', 17, 200000, 0  FROM dual UNION ALL 
  select 'B39', 'P1154', 14, 250000, 0  FROM dual UNION ALL 
  select 'B11', 'P1154', 19, 40000, 0  FROM dual UNION ALL 
  select 'B21', 'P1154', 16, 1200000, 0  FROM dual UNION ALL 
  select 'B36', 'P1154', 12, 500000, 0  FROM dual UNION ALL 
  select 'B11', 'P1155', 18, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P1155', 14, 40000000, 0  FROM dual UNION ALL 
  select 'B33', 'P1155', 10, 10000, 0  FROM dual UNION ALL 
  select 'B3', 'P1155', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B31', 'P1155', 18, 80000, 0  FROM dual UNION ALL 
  select 'B24', 'P1155', 11, 475000, 0  FROM dual UNION ALL 
  select 'B25', 'P1155', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P1155', 20, 250000, 0  FROM dual UNION ALL 
  select 'B8', 'P1156', 17, 20000000, 0  FROM dual UNION ALL 
  select 'B41', 'P1156', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B21', 'P1156', 22, 1200000, 0  FROM dual UNION ALL 
  select 'B5', 'P1156', 26, 40000, 0  FROM dual UNION ALL 
  select 'B28', 'P1156', 26, 250000000, 0  FROM dual UNION ALL 
  select 'B42', 'P1157', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P1158', 1, 300000, 0  FROM dual UNION ALL 
  select 'B42', 'P1158', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P1159', 18, 200000, 0  FROM dual UNION ALL 
  select 'B33', 'P1159', 15, 10000, 0  FROM dual UNION ALL 
  select 'B21', 'P1159', 14, 1200000, 0  FROM dual UNION ALL 
  select 'B38', 'P1159', 14, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P1159', 18, 450000, 0  FROM dual UNION ALL 
  select 'B40', 'P1160', 1, 400000, 0  FROM dual UNION ALL 
  select 'B19', 'P1160', 1, 300000, 0  FROM dual UNION ALL 
  select 'B39', 'P1161', 1, 250000, 0  FROM dual UNION ALL 
  select 'B41', 'P1162', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P1163', 1, 200000, 0  FROM dual UNION ALL 
  select 'B36', 'P1163', 1, 500000, 0  FROM dual UNION ALL 
  select 'B41', 'P1164', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B36', 'P1165', 1, 500000, 0  FROM dual UNION ALL 
  select 'B23', 'P1166', 13, 3000000, 0  FROM dual UNION ALL 
  select 'B9', 'P1166', 10, 25000000, 0  FROM dual UNION ALL 
  select 'B18', 'P1166', 19, 450000, 0  FROM dual UNION ALL 
  select 'B15', 'P1166', 16, 4000, 0  FROM dual UNION ALL 
  select 'B27', 'P1166', 15, 40000000, 0  FROM dual UNION ALL 
  select 'B13', 'P1167', 10, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P1167', 12, 40000000, 0  FROM dual UNION ALL 
  select 'B34', 'P1167', 15, 20000, 0  FROM dual UNION ALL 
  select 'B38', 'P1167', 14, 250000, 0  FROM dual UNION ALL 
  select 'B14', 'P1167', 17, 4000, 0  FROM dual UNION ALL 
  select 'B42', 'P1167', 17, 50000, 0  FROM dual UNION ALL 
  select 'B7', 'P1167', 13, 12000000, 0  FROM dual UNION ALL 
  select 'B33', 'P1167', 11, 10000, 0  FROM dual UNION ALL 
  select 'B29', 'P1168', 12, 850000, 0  FROM dual UNION ALL 
  select 'B13', 'P1168', 18, 40000, 0  FROM dual UNION ALL 
  select 'B24', 'P1168', 16, 475000, 0  FROM dual UNION ALL 
  select 'B36', 'P1168', 10, 500000, 0  FROM dual UNION ALL 
  select 'B15', 'P1168', 20, 4000, 0  FROM dual UNION ALL 
  select 'B32', 'P1169', 13, 20000, 0  FROM dual UNION ALL 
  select 'B29', 'P1169', 13, 850000, 0  FROM dual UNION ALL 
  select 'B35', 'P1169', 11, 20000, 0  FROM dual UNION ALL 
  select 'B23', 'P1170', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B43', 'P1171', 1, 200000, 0  FROM dual UNION ALL 
  select 'B20', 'P1172', 1, 350000, 0  FROM dual UNION ALL 
  select 'B22', 'P1172', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B25', 'P1173', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B23', 'P1173', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B29', 'P1174', 11, 850000, 0  FROM dual UNION ALL 
  select 'B31', 'P1174', 12, 80000, 0  FROM dual UNION ALL 
  select 'B35', 'P1174', 20, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P1174', 11, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P1174', 12, 100000, 0  FROM dual UNION ALL 
  select 'B31', 'P1175', 19, 80000, 0  FROM dual UNION ALL 
  select 'B35', 'P1175', 19, 20000, 0  FROM dual UNION ALL 
  select 'B23', 'P1175', 10, 3000000, 0  FROM dual UNION ALL 
  select 'B39', 'P1175', 12, 250000, 0  FROM dual UNION ALL 
  select 'B7', 'P1175', 13, 12000000, 0  FROM dual UNION ALL 
  select 'B14', 'P1175', 15, 4000, 0  FROM dual UNION ALL 
  select 'B14', 'P1176', 17, 4000, 0  FROM dual UNION ALL 
  select 'B5', 'P1176', 27, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P1176', 22, 250000, 0  FROM dual UNION ALL 
  select 'B8', 'P1176', 24, 20000000, 0  FROM dual UNION ALL 
  select 'B37', 'P1176', 17, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P1176', 19, 250000, 0  FROM dual UNION ALL 
  select 'B28', 'P1176', 30, 250000000, 0  FROM dual UNION ALL 
  select 'B21', 'P1176', 30, 1200000, 0  FROM dual UNION ALL 
  select 'B27', 'P1176', 21, 40000000, 0  FROM dual UNION ALL 
  select 'B18', 'P1176', 15, 450000, 0  FROM dual UNION ALL 
  select 'B38', 'P1177', 1, 250000, 0  FROM dual UNION ALL 
  select 'B28', 'P1178', 15, 250000000, 0  FROM dual UNION ALL 
  select 'B7', 'P1178', 15, 12000000, 0  FROM dual UNION ALL 
  select 'B29', 'P1178', 11, 850000, 0  FROM dual UNION ALL 
  select 'B39', 'P1178', 11, 250000, 0  FROM dual UNION ALL 
  select 'B18', 'P1178', 16, 450000, 0  FROM dual UNION ALL 
  select 'B30', 'P1178', 10, 100000, 0  FROM dual UNION ALL 
  select 'B5', 'P1178', 20, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P1178', 12, 40000000, 0  FROM dual UNION ALL 
  select 'B24', 'P1179', 1, 475000, 0  FROM dual UNION ALL 
  select 'B43', 'P1179', 1, 200000, 0  FROM dual UNION ALL 
  select 'B39', 'P1180', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P1181', 1, 50000, 0  FROM dual UNION ALL 
  select 'B26', 'P1182', 16, 100000000, 0  FROM dual UNION ALL 
  select 'B9', 'P1182', 18, 25000000, 0  FROM dual UNION ALL 
  select 'B39', 'P1182', 11, 250000, 0  FROM dual UNION ALL 
  select 'B30', 'P1182', 13, 100000, 0  FROM dual UNION ALL 
  select 'B26', 'P1182', 20, 100000000, 0  FROM dual UNION ALL 
  select 'B38', 'P1182', 18, 250000, 0  FROM dual UNION ALL 
  select 'B28', 'P1182', 16, 250000000, 0  FROM dual UNION ALL 
  select 'B28', 'P1182', 12, 250000000, 0  FROM dual UNION ALL 
  select 'B43', 'P1182', 13, 200000, 0  FROM dual UNION ALL 
  select 'B33', 'P1182', 15, 10000, 0  FROM dual UNION ALL 
  select 'B39', 'P1183', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P1184', 1, 250000, 0  FROM dual UNION ALL 
  select 'B17', 'P1185', 1, 350000, 0  FROM dual UNION ALL 
  select 'B25', 'P1186', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B39', 'P1187', 11, 250000, 0  FROM dual UNION ALL 
  select 'B21', 'P1187', 14, 1200000, 0  FROM dual UNION ALL 
  select 'B5', 'P1187', 18, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P1187', 15, 450000, 0  FROM dual UNION ALL 
  select 'B41', 'P1187', 15, 1000000, 0  FROM dual UNION ALL 
  select 'B14', 'P1187', 14, 4000, 0  FROM dual UNION ALL 
  select 'B30', 'P1187', 19, 100000, 0  FROM dual UNION ALL 
  select 'B29', 'P1187', 12, 850000, 0  FROM dual UNION ALL 
  select 'B29', 'P1187', 10, 850000, 0  FROM dual UNION ALL 
  select 'B23', 'P1188', 1, 3000000, 0  FROM dual UNION ALL 
  select 'B32', 'P1189', 14, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P1189', 10, 100000, 0  FROM dual UNION ALL 
  select 'B30', 'P1189', 14, 100000, 0  FROM dual UNION ALL 
  select 'B30', 'P1189', 17, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P1189', 17, 20000, 0  FROM dual UNION ALL 
  select 'B36', 'P1190', 1, 500000, 0  FROM dual UNION ALL 
  select 'B18', 'P1190', 1, 450000, 0  FROM dual UNION ALL 
  select 'B18', 'P1191', 1, 450000, 0  FROM dual UNION ALL 
  select 'B20', 'P1192', 1, 350000, 0  FROM dual UNION ALL 
  select 'B39', 'P1192', 1, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P1193', 1, 250000, 0  FROM dual UNION ALL 
  select 'B17', 'P1194', 1, 350000, 0  FROM dual UNION ALL 
  select 'B39', 'P1194', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P1195', 1, 500000, 0  FROM dual UNION ALL 
  select 'B22', 'P1195', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B20', 'P1196', 1, 350000, 0  FROM dual UNION ALL 
  select 'B38', 'P1197', 1, 250000, 0  FROM dual UNION ALL 
  select 'B38', 'P1197', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P1198', 1, 50000, 0  FROM dual UNION ALL 
  select 'B18', 'P1198', 1, 450000, 0  FROM dual UNION ALL 
  select 'B37', 'P1199', 1, 50000, 0  FROM dual UNION ALL 
  select 'B41', 'P1199', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B42', 'P1200', 1, 50000, 0  FROM dual UNION ALL 
  select 'B37', 'P1201', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P1201', 1, 250000, 0  FROM dual UNION ALL 
  select 'B7', 'P1202', 29, 12000000, 0  FROM dual UNION ALL 
  select 'B2', 'P1202', 26, 3025000, 0  FROM dual UNION ALL 
  select 'B19', 'P1202', 15, 300000, 0  FROM dual UNION ALL 
  select 'B6', 'P1202', 24, 6000000, 0  FROM dual UNION ALL 
  select 'B25', 'P1202', 19, 1000000, 0  FROM dual UNION ALL 
  select 'B18', 'P1202', 23, 450000, 0  FROM dual UNION ALL 
  select 'B15', 'P1202', 16, 4000, 0  FROM dual UNION ALL 
  select 'B36', 'P1203', 1, 500000, 0  FROM dual UNION ALL 
  select 'B4', 'P1204', 15, 3100000, 0  FROM dual UNION ALL 
  select 'B21', 'P1204', 13, 1200000, 0  FROM dual UNION ALL 
  select 'B28', 'P1204', 15, 250000000, 0  FROM dual UNION ALL 
  select 'B34', 'P1204', 17, 20000, 0  FROM dual;

INSERT INTO DETAIL_PEMESANAN (ID_BARANG, ID_PESANAN, KUANTITAS, SUBTOTAL, DISCOUNT_BARANG)  
  select 'B28', 'P1204', 11, 250000000, 0  FROM dual UNION ALL 
  select 'B17', 'P1204', 13, 350000, 0  FROM dual UNION ALL 
  select 'B6', 'P1204', 11, 6000000, 0  FROM dual UNION ALL 
  select 'B37', 'P1204', 17, 50000, 0  FROM dual UNION ALL 
  select 'B32', 'P1204', 10, 20000, 0  FROM dual UNION ALL 
  select 'B32', 'P1204', 11, 20000, 0  FROM dual UNION ALL 
  select 'B37', 'P1205', 1, 50000, 0  FROM dual UNION ALL 
  select 'B19', 'P1205', 1, 300000, 0  FROM dual UNION ALL 
  select 'B24', 'P1206', 15, 475000, 0  FROM dual UNION ALL 
  select 'B30', 'P1206', 13, 100000, 0  FROM dual UNION ALL 
  select 'B28', 'P1206', 12, 250000000, 0  FROM dual UNION ALL 
  select 'B41', 'P1206', 11, 1000000, 0  FROM dual UNION ALL 
  select 'B18', 'P1206', 20, 450000, 0  FROM dual UNION ALL 
  select 'B16', 'P1207', 16, 4000, 0  FROM dual UNION ALL 
  select 'B15', 'P1207', 29, 4000, 0  FROM dual UNION ALL 
  select 'B13', 'P1207', 21, 40000, 0  FROM dual UNION ALL 
  select 'B27', 'P1207', 24, 40000000, 0  FROM dual UNION ALL 
  select 'B40', 'P1207', 23, 400000, 0  FROM dual UNION ALL 
  select 'B32', 'P1207', 27, 20000, 0  FROM dual UNION ALL 
  select 'B19', 'P1208', 1, 300000, 0  FROM dual UNION ALL 
  select 'B36', 'P1208', 1, 500000, 0  FROM dual UNION ALL 
  select 'B19', 'P1209', 1, 300000, 0  FROM dual UNION ALL 
  select 'B41', 'P1209', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P1210', 1, 200000, 0  FROM dual UNION ALL 
  select 'B20', 'P1210', 1, 350000, 0  FROM dual UNION ALL 
  select 'B33', 'P1211', 16, 10000, 0  FROM dual UNION ALL 
  select 'B19', 'P1211', 16, 300000, 0  FROM dual UNION ALL 
  select 'B8', 'P1211', 15, 20000000, 0  FROM dual UNION ALL 
  select 'B20', 'P1211', 11, 350000, 0  FROM dual UNION ALL 
  select 'B38', 'P1211', 17, 250000, 0  FROM dual UNION ALL 
  select 'B27', 'P1211', 11, 40000000, 0  FROM dual UNION ALL 
  select 'B37', 'P1212', 1, 50000, 0  FROM dual UNION ALL 
  select 'B39', 'P1212', 1, 250000, 0  FROM dual UNION ALL 
  select 'B15', 'P1213', 11, 4000, 0  FROM dual UNION ALL 
  select 'B27', 'P1213', 11, 40000000, 0  FROM dual UNION ALL 
  select 'B35', 'P1213', 14, 20000, 0  FROM dual UNION ALL 
  select 'B2', 'P1213', 19, 3025000, 0  FROM dual UNION ALL 
  select 'B26', 'P1213', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B26', 'P1214', 17, 100000000, 0  FROM dual UNION ALL 
  select 'B4', 'P1214', 14, 3100000, 0  FROM dual UNION ALL 
  select 'B34', 'P1214', 20, 20000, 0  FROM dual UNION ALL 
  select 'B30', 'P1214', 16, 100000, 0  FROM dual UNION ALL 
  select 'B26', 'P1214', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B40', 'P1215', 1, 400000, 0  FROM dual UNION ALL 
  select 'B8', 'P1216', 19, 20000000, 0  FROM dual UNION ALL 
  select 'B36', 'P1216', 15, 500000, 0  FROM dual UNION ALL 
  select 'B3', 'P1216', 10, 20000000, 0  FROM dual UNION ALL 
  select 'B41', 'P1216', 17, 1000000, 0  FROM dual UNION ALL 
  select 'B30', 'P1216', 10, 100000, 0  FROM dual UNION ALL 
  select 'B22', 'P1216', 11, 2100000, 0  FROM dual UNION ALL 
  select 'B22', 'P1216', 15, 2100000, 0  FROM dual UNION ALL 
  select 'B13', 'P1216', 11, 40000, 0  FROM dual UNION ALL 
  select 'B34', 'P1216', 18, 20000, 0  FROM dual UNION ALL 
  select 'B10', 'P1216', 18, 40000, 0  FROM dual UNION ALL 
  select 'B39', 'P1217', 1, 250000, 0  FROM dual UNION ALL 
  select 'B17', 'P1217', 1, 350000, 0  FROM dual UNION ALL 
  select 'B40', 'P1218', 1, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P1218', 1, 400000, 0  FROM dual UNION ALL 
  select 'B21', 'P1219', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B21', 'P1220', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B41', 'P1220', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B8', 'P1221', 16, 20000000, 0  FROM dual UNION ALL 
  select 'B12', 'P1221', 20, 40000, 0  FROM dual UNION ALL 
  select 'B40', 'P1221', 16, 400000, 0  FROM dual UNION ALL 
  select 'B19', 'P1221', 20, 300000, 0  FROM dual UNION ALL 
  select 'B27', 'P1221', 24, 40000000, 0  FROM dual UNION ALL 
  select 'B43', 'P1222', 1, 200000, 0  FROM dual UNION ALL 
  select 'B22', 'P1223', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B43', 'P1224', 1, 200000, 0  FROM dual UNION ALL 
  select 'B38', 'P1225', 1, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P1225', 1, 50000, 0  FROM dual UNION ALL 
  select 'B38', 'P1226', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P1226', 1, 200000, 0  FROM dual UNION ALL 
  select 'B24', 'P1227', 1, 475000, 0  FROM dual UNION ALL 
  select 'B20', 'P1227', 1, 350000, 0  FROM dual UNION ALL 
  select 'B7', 'P1228', 14, 12000000, 0  FROM dual UNION ALL 
  select 'B24', 'P1228', 20, 475000, 0  FROM dual UNION ALL 
  select 'B24', 'P1228', 11, 475000, 0  FROM dual UNION ALL 
  select 'B17', 'P1228', 17, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P1228', 13, 500000, 0  FROM dual UNION ALL 
  select 'B30', 'P1228', 10, 100000, 0  FROM dual UNION ALL 
  select 'B14', 'P1228', 16, 4000, 0  FROM dual UNION ALL 
  select 'B28', 'P1228', 15, 250000000, 0  FROM dual UNION ALL 
  select 'B15', 'P1228', 14, 4000, 0  FROM dual UNION ALL 
  select 'B38', 'P1228', 15, 250000, 0  FROM dual UNION ALL 
  select 'B34', 'P1229', 20, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P1229', 16, 80000, 0  FROM dual UNION ALL 
  select 'B34', 'P1229', 20, 20000, 0  FROM dual UNION ALL 
  select 'B28', 'P1230', 16, 250000000, 0  FROM dual UNION ALL 
  select 'B35', 'P1230', 22, 20000, 0  FROM dual UNION ALL 
  select 'B23', 'P1230', 19, 3000000, 0  FROM dual UNION ALL 
  select 'B29', 'P1230', 21, 850000, 0  FROM dual UNION ALL 
  select 'B23', 'P1230', 16, 3000000, 0  FROM dual UNION ALL 
  select 'B14', 'P1230', 25, 4000, 0  FROM dual UNION ALL 
  select 'B33', 'P1230', 20, 10000, 0  FROM dual UNION ALL 
  select 'B36', 'P1230', 27, 500000, 0  FROM dual UNION ALL 
  select 'B22', 'P1230', 18, 2100000, 0  FROM dual UNION ALL 
  select 'B39', 'P1231', 1, 250000, 0  FROM dual UNION ALL 
  select 'B43', 'P1231', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P1232', 14, 400000, 0  FROM dual UNION ALL 
  select 'B29', 'P1232', 18, 850000, 0  FROM dual UNION ALL 
  select 'B39', 'P1232', 19, 250000, 0  FROM dual UNION ALL 
  select 'B42', 'P1232', 17, 50000, 0  FROM dual UNION ALL 
  select 'B9', 'P1232', 17, 25000000, 0  FROM dual UNION ALL 
  select 'B10', 'P1232', 13, 40000, 0  FROM dual UNION ALL 
  select 'B17', 'P1232', 15, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P1233', 1, 500000, 0  FROM dual UNION ALL 
  select 'B15', 'P1234', 26, 4000, 0  FROM dual UNION ALL 
  select 'B19', 'P1234', 26, 300000, 0  FROM dual UNION ALL 
  select 'B35', 'P1234', 23, 20000, 0  FROM dual UNION ALL 
  select 'B40', 'P1234', 17, 400000, 0  FROM dual UNION ALL 
  select 'B24', 'P1234', 30, 475000, 0  FROM dual UNION ALL 
  select 'B39', 'P1234', 19, 250000, 0  FROM dual UNION ALL 
  select 'B32', 'P1234', 18, 20000, 0  FROM dual UNION ALL 
  select 'B4', 'P1234', 18, 3100000, 0  FROM dual UNION ALL 
  select 'B3', 'P1234', 15, 20000000, 0  FROM dual UNION ALL 
  select 'B3', 'P1234', 16, 20000000, 0  FROM dual UNION ALL 
  select 'B41', 'P1235', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P1235', 1, 475000, 0  FROM dual UNION ALL 
  select 'B20', 'P1236', 1, 350000, 0  FROM dual UNION ALL 
  select 'B43', 'P1236', 1, 200000, 0  FROM dual UNION ALL 
  select 'B17', 'P1237', 1, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P1238', 1, 500000, 0  FROM dual UNION ALL 
  select 'B19', 'P1239', 1, 300000, 0  FROM dual UNION ALL 
  select 'B19', 'P1239', 1, 300000, 0  FROM dual UNION ALL 
  select 'B43', 'P1240', 20, 200000, 0  FROM dual UNION ALL 
  select 'B25', 'P1240', 18, 1000000, 0  FROM dual UNION ALL 
  select 'B12', 'P1240', 11, 40000, 0  FROM dual UNION ALL 
  select 'B32', 'P1240', 12, 20000, 0  FROM dual UNION ALL 
  select 'B9', 'P1240', 19, 25000000, 0  FROM dual UNION ALL 
  select 'B8', 'P1240', 10, 20000000, 0  FROM dual UNION ALL 
  select 'B17', 'P1241', 1, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P1241', 1, 500000, 0  FROM dual UNION ALL 
  select 'B14', 'P1242', 15, 4000, 0  FROM dual UNION ALL 
  select 'B14', 'P1242', 26, 4000, 0  FROM dual UNION ALL 
  select 'B31', 'P1242', 19, 80000, 0  FROM dual UNION ALL 
  select 'B6', 'P1242', 29, 6000000, 0  FROM dual UNION ALL 
  select 'B42', 'P1242', 18, 50000, 0  FROM dual UNION ALL 
  select 'B40', 'P1242', 22, 400000, 0  FROM dual UNION ALL 
  select 'B15', 'P1243', 27, 4000, 0  FROM dual UNION ALL 
  select 'B24', 'P1243', 27, 475000, 0  FROM dual UNION ALL 
  select 'B7', 'P1243', 23, 12000000, 0  FROM dual UNION ALL 
  select 'B42', 'P1243', 26, 50000, 0  FROM dual UNION ALL 
  select 'B22', 'P1243', 21, 2100000, 0  FROM dual UNION ALL 
  select 'B38', 'P1243', 25, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P1244', 1, 400000, 0  FROM dual UNION ALL 
  select 'B25', 'P1245', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P1245', 1, 200000, 0  FROM dual UNION ALL 
  select 'B39', 'P1246', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P1246', 1, 400000, 0  FROM dual UNION ALL 
  select 'B40', 'P1247', 1, 400000, 0  FROM dual UNION ALL 
  select 'B17', 'P1248', 1, 350000, 0  FROM dual UNION ALL 
  select 'B36', 'P1248', 1, 500000, 0  FROM dual UNION ALL 
  select 'B42', 'P1249', 1, 50000, 0  FROM dual UNION ALL 
  select 'B35', 'P1250', 18, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P1250', 14, 20000, 0  FROM dual UNION ALL 
  select 'B34', 'P1250', 14, 20000, 0  FROM dual UNION ALL 
  select 'B37', 'P1251', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P1251', 1, 500000, 0  FROM dual UNION ALL 
  select 'B30', 'P1252', 16, 100000, 0  FROM dual UNION ALL 
  select 'B30', 'P1252', 15, 100000, 0  FROM dual UNION ALL 
  select 'B35', 'P1252', 16, 20000, 0  FROM dual UNION ALL 
  select 'B40', 'P1253', 1, 400000, 0  FROM dual UNION ALL 
  select 'B24', 'P1253', 1, 475000, 0  FROM dual UNION ALL 
  select 'B39', 'P1254', 1, 250000, 0  FROM dual UNION ALL 
  select 'B22', 'P1254', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B36', 'P1255', 1, 500000, 0  FROM dual UNION ALL 
  select 'B30', 'P1256', 12, 100000, 0  FROM dual UNION ALL 
  select 'B40', 'P1256', 12, 400000, 0  FROM dual UNION ALL 
  select 'B30', 'P1256', 20, 100000, 0  FROM dual UNION ALL 
  select 'B26', 'P1256', 14, 100000000, 0  FROM dual UNION ALL 
  select 'B9', 'P1256', 15, 25000000, 0  FROM dual UNION ALL 
  select 'B30', 'P1256', 11, 100000, 0  FROM dual UNION ALL 
  select 'B17', 'P1257', 16, 350000, 0  FROM dual UNION ALL 
  select 'B3', 'P1257', 16, 20000000, 0  FROM dual UNION ALL 
  select 'B35', 'P1257', 19, 20000, 0  FROM dual UNION ALL 
  select 'B36', 'P1257', 24, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P1257', 17, 50000, 0  FROM dual UNION ALL 
  select 'B5', 'P1257', 30, 40000, 0  FROM dual UNION ALL 
  select 'B29', 'P1257', 25, 850000, 0  FROM dual UNION ALL 
  select 'B11', 'P1257', 28, 40000, 0  FROM dual UNION ALL 
  select 'B34', 'P1257', 22, 20000, 0  FROM dual UNION ALL 
  select 'B35', 'P1258', 14, 20000, 0  FROM dual UNION ALL 
  select 'B31', 'P1258', 11, 80000, 0  FROM dual UNION ALL 
  select 'B21', 'P1258', 12, 1200000, 0  FROM dual UNION ALL 
  select 'B40', 'P1258', 14, 400000, 0  FROM dual UNION ALL 
  select 'B34', 'P1258', 16, 20000, 0  FROM dual UNION ALL 
  select 'B36', 'P1258', 13, 500000, 0  FROM dual UNION ALL 
  select 'B41', 'P1258', 14, 1000000, 0  FROM dual UNION ALL 
  select 'B34', 'P1258', 20, 20000, 0  FROM dual UNION ALL 
  select 'B28', 'P1258', 12, 250000000, 0  FROM dual UNION ALL 
  select 'B12', 'P1258', 15, 40000, 0  FROM dual UNION ALL 
  select 'B40', 'P1259', 1, 400000, 0  FROM dual UNION ALL 
  select 'B39', 'P1260', 21, 250000, 0  FROM dual UNION ALL 
  select 'B28', 'P1260', 25, 250000000, 0  FROM dual UNION ALL 
  select 'B13', 'P1260', 22, 40000, 0  FROM dual UNION ALL 
  select 'B40', 'P1260', 17, 400000, 0  FROM dual UNION ALL 
  select 'B1', 'P1260', 18, 227500, 0  FROM dual UNION ALL 
  select 'B24', 'P1260', 24, 475000, 0  FROM dual UNION ALL 
  select 'B32', 'P1260', 17, 20000, 0  FROM dual UNION ALL 
  select 'B6', 'P1260', 30, 6000000, 0  FROM dual UNION ALL 
  select 'B27', 'P1260', 30, 40000000, 0  FROM dual UNION ALL 
  select 'B41', 'P1261', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B40', 'P1261', 1, 400000, 0  FROM dual UNION ALL 
  select 'B39', 'P1262', 1, 250000, 0  FROM dual UNION ALL 
  select 'B14', 'P1263', 14, 4000, 0  FROM dual UNION ALL 
  select 'B15', 'P1263', 11, 4000, 0  FROM dual UNION ALL 
  select 'B10', 'P1263', 10, 40000, 0  FROM dual UNION ALL 
  select 'B14', 'P1263', 18, 4000, 0  FROM dual UNION ALL 
  select 'B19', 'P1263', 11, 300000, 0  FROM dual UNION ALL 
  select 'B9', 'P1264', 14, 25000000, 0  FROM dual UNION ALL 
  select 'B29', 'P1264', 12, 850000, 0  FROM dual UNION ALL 
  select 'B36', 'P1264', 15, 500000, 0  FROM dual UNION ALL 
  select 'B11', 'P1264', 12, 40000, 0  FROM dual UNION ALL 
  select 'B10', 'P1264', 13, 40000, 0  FROM dual UNION ALL 
  select 'B18', 'P1264', 11, 450000, 0  FROM dual UNION ALL 
  select 'B19', 'P1264', 20, 300000, 0  FROM dual UNION ALL 
  select 'B6', 'P1264', 14, 6000000, 0  FROM dual UNION ALL 
  select 'B18', 'P1265', 1, 450000, 0  FROM dual UNION ALL 
  select 'B20', 'P1265', 1, 350000, 0  FROM dual UNION ALL 
  select 'B38', 'P1266', 1, 250000, 0  FROM dual UNION ALL 
  select 'B37', 'P1266', 1, 50000, 0  FROM dual UNION ALL 
  select 'B21', 'P1267', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B37', 'P1267', 1, 50000, 0  FROM dual UNION ALL 
  select 'B21', 'P1268', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B41', 'P1268', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P1269', 1, 250000, 0  FROM dual UNION ALL 
  select 'B40', 'P1270', 24, 400000, 0  FROM dual UNION ALL 
  select 'B5', 'P1270', 20, 40000, 0  FROM dual UNION ALL 
  select 'B12', 'P1270', 28, 40000, 0  FROM dual UNION ALL 
  select 'B43', 'P1270', 15, 200000, 0  FROM dual UNION ALL 
  select 'B26', 'P1270', 18, 100000000, 0  FROM dual UNION ALL 
  select 'B34', 'P1270', 20, 20000, 0  FROM dual UNION ALL 
  select 'B43', 'P1270', 18, 200000, 0  FROM dual UNION ALL 
  select 'B1', 'P1270', 29, 227500, 0  FROM dual UNION ALL 
  select 'B22', 'P1271', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B41', 'P1271', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P1272', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P1273', 1, 50000, 0  FROM dual UNION ALL 
  select 'B22', 'P1273', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B41', 'P1274', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B43', 'P1274', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P1275', 1, 400000, 0  FROM dual UNION ALL 
  select 'B24', 'P1276', 1, 475000, 0  FROM dual UNION ALL 
  select 'B41', 'P1276', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B38', 'P1277', 19, 250000, 0  FROM dual UNION ALL 
  select 'B7', 'P1277', 11, 12000000, 0  FROM dual UNION ALL 
  select 'B25', 'P1277', 15, 1000000, 0  FROM dual UNION ALL 
  select 'B11', 'P1277', 12, 40000, 0  FROM dual UNION ALL 
  select 'B8', 'P1277', 15, 20000000, 0  FROM dual UNION ALL 
  select 'B29', 'P1277', 19, 850000, 0  FROM dual UNION ALL 
  select 'B38', 'P1277', 12, 250000, 0  FROM dual UNION ALL 
  select 'B39', 'P1277', 18, 250000, 0  FROM dual UNION ALL 
  select 'B24', 'P1277', 18, 475000, 0  FROM dual UNION ALL 
  select 'B26', 'P1277', 20, 100000000, 0  FROM dual UNION ALL 
  select 'B19', 'P1278', 1, 300000, 0  FROM dual UNION ALL 
  select 'B29', 'P1279', 10, 850000, 0  FROM dual UNION ALL 
  select 'B31', 'P1279', 10, 80000, 0  FROM dual UNION ALL 
  select 'B29', 'P1279', 20, 850000, 0  FROM dual UNION ALL 
  select 'B19', 'P1280', 1, 300000, 0  FROM dual UNION ALL 
  select 'B40', 'P1280', 1, 400000, 0  FROM dual UNION ALL 
  select 'B37', 'P1281', 1, 50000, 0  FROM dual UNION ALL 
  select 'B21', 'P1281', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B25', 'P1282', 19, 1000000, 0  FROM dual UNION ALL 
  select 'B7', 'P1282', 13, 12000000, 0  FROM dual UNION ALL 
  select 'B32', 'P1282', 19, 20000, 0  FROM dual UNION ALL 
  select 'B15', 'P1282', 15, 4000, 0  FROM dual UNION ALL 
  select 'B17', 'P1282', 10, 350000, 0  FROM dual UNION ALL 
  select 'B32', 'P1282', 17, 20000, 0  FROM dual UNION ALL 
  select 'B42', 'P1282', 16, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P1283', 25, 500000, 0  FROM dual UNION ALL 
  select 'B9', 'P1283', 23, 25000000, 0  FROM dual UNION ALL 
  select 'B15', 'P1283', 25, 4000, 0  FROM dual UNION ALL 
  select 'B33', 'P1283', 17, 10000, 0  FROM dual UNION ALL 
  select 'B36', 'P1284', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P1284', 1, 50000, 0  FROM dual UNION ALL 
  select 'B43', 'P1285', 1, 200000, 0  FROM dual UNION ALL 
  select 'B42', 'P1285', 1, 50000, 0  FROM dual UNION ALL 
  select 'B21', 'P1286', 1, 1200000, 0  FROM dual UNION ALL 
  select 'B37', 'P1286', 1, 50000, 0  FROM dual UNION ALL 
  select 'B36', 'P1287', 1, 500000, 0  FROM dual UNION ALL 
  select 'B40', 'P1287', 1, 400000, 0  FROM dual UNION ALL 
  select 'B42', 'P1288', 1, 50000, 0  FROM dual UNION ALL 
  select 'B17', 'P1289', 1, 350000, 0  FROM dual UNION ALL 
  select 'B39', 'P1290', 1, 250000, 0  FROM dual UNION ALL 
  select 'B36', 'P1290', 1, 500000, 0  FROM dual UNION ALL 
  select 'B19', 'P1291', 1, 300000, 0  FROM dual UNION ALL 
  select 'B19', 'P1291', 1, 300000, 0  FROM dual UNION ALL 
  select 'B24', 'P1292', 1, 475000, 0  FROM dual UNION ALL 
  select 'B42', 'P1292', 1, 50000, 0  FROM dual UNION ALL 
  select 'B22', 'P1293', 1, 2100000, 0  FROM dual UNION ALL 
  select 'B40', 'P1293', 1, 400000, 0  FROM dual UNION ALL 
  select 'B36', 'P1294', 1, 500000, 0  FROM dual UNION ALL 
  select 'B37', 'P1295', 1, 50000, 0  FROM dual UNION ALL 
  select 'B24', 'P1295', 1, 475000, 0  FROM dual UNION ALL 
  select 'B43', 'P1296', 1, 200000, 0  FROM dual UNION ALL 
  select 'B40', 'P1296', 1, 400000, 0  FROM dual UNION ALL 
  select 'B23', 'P1297', 13, 3000000, 0  FROM dual UNION ALL 
  select 'B31', 'P1297', 19, 80000, 0  FROM dual UNION ALL 
  select 'B14', 'P1297', 12, 4000, 0  FROM dual UNION ALL 
  select 'B20', 'P1297', 17, 350000, 0  FROM dual UNION ALL 
  select 'B42', 'P1297', 11, 50000, 0  FROM dual UNION ALL 
  select 'B9', 'P1297', 18, 25000000, 0  FROM dual UNION ALL 
  select 'B35', 'P1297', 16, 20000, 0  FROM dual UNION ALL 
  select 'B24', 'P1297', 17, 475000, 0  FROM dual UNION ALL 
  select 'B13', 'P1297', 16, 40000, 0  FROM dual UNION ALL 
  select 'B12', 'P1297', 20, 40000, 0  FROM dual UNION ALL 
  select 'B33', 'P1298', 15, 10000, 0  FROM dual UNION ALL 
  select 'B31', 'P1298', 10, 80000, 0  FROM dual UNION ALL 
  select 'B33', 'P1298', 19, 10000, 0  FROM dual UNION ALL 
  select 'B15', 'P1298', 20, 4000, 0  FROM dual UNION ALL 
  select 'B31', 'P1298', 13, 80000, 0  FROM dual UNION ALL 
  select 'B26', 'P1298', 19, 100000000, 0  FROM dual UNION ALL 
  select 'B13', 'P1298', 11, 40000, 0  FROM dual UNION ALL 
  select 'B5', 'P1298', 19, 40000, 0  FROM dual UNION ALL 
  select 'B25', 'P1298', 16, 1000000, 0  FROM dual UNION ALL 
  select 'B24', 'P1299', 16, 475000, 0  FROM dual UNION ALL 
  select 'B40', 'P1299', 18, 400000, 0  FROM dual UNION ALL 
  select 'B32', 'P1299', 14, 20000, 0  FROM dual UNION ALL 
  select 'B28', 'P1299', 19, 250000000, 0  FROM dual UNION ALL 
  select 'B3', 'P1299', 14, 20000000, 0  FROM dual UNION ALL 
  select 'B24', 'P1299', 17, 475000, 0  FROM dual UNION ALL 
  select 'B41', 'P1300', 1, 1000000, 0  FROM dual UNION ALL 
  select 'B36', 'P1300', 1, 500000, 0  FROM dual;

INSERT INTO JENIS_PEMBAYARAN (ID_JENIS_PEMBAYARAN, NAMA_JENIS_PEMBAYARAN)  
  select 'JP1', 'OVO'  FROM dual UNION ALL 
  select 'JP2', 'GO-PAY'  FROM dual UNION ALL 
  select 'JP3', 'Mandiri'  FROM dual UNION ALL 
  select 'JP4', 'BCA'  FROM dual UNION ALL 
  select 'JP5', 'BNI'  FROM dual UNION ALL 
  select 'JP6', 'BRI'  FROM dual UNION ALL 
  select 'JP7', 'BTN'  FROM dual UNION ALL 
  select 'JP8', 'Cash'  FROM dual UNION ALL 
  select 'JP9', 'Other'  FROM dual;

INSERT INTO PEMBAYARAN (ID_PEMBAYARAN, ID_JENIS_PEMBAYARAN, ID_PESANAN, TANGGAL_PEMBAYARAN, JUMLAH_PEMBAYARAN, KEPERLUAN_PEMBAYARAN)  
  select 'PB1', 'JP8', 'P1', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 1158000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB2', 'JP1', 'P2', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB3', 'JP9', 'P3', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB4', 'JP4', 'P4', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB5', 'JP5', 'P5', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB6', 'JP1', 'P6', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 15550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB7', 'JP3', 'P7', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB8', 'JP5', 'P8', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB9', 'JP6', 'P9', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 1951118000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB10', 'JP9', 'P10', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB11', 'JP6', 'P11', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB12', 'JP3', 'P12', TO_DATE('03/08/2019', 'DD/MM/YYYY'), 950000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB13', 'JP6', 'P13', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB14', 'JP6', 'P14', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB15', 'JP1', 'P15', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB16', 'JP7', 'P16', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB17', 'JP2', 'P17', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 456300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB18', 'JP2', 'P18', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB19', 'JP2', 'P19', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB20', 'JP5', 'P20', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB21', 'JP1', 'P21', TO_DATE('04/08/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB22', 'JP8', 'P22', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 1450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB23', 'JP3', 'P23', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 3765900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB24', 'JP8', 'P24', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 5584842000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB25', 'JP9', 'P25', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 3050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB26', 'JP5', 'P26', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB27', 'JP1', 'P27', TO_DATE('05/08/2019', 'DD/MM/YYYY'), 2840000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB28', 'JP5', 'P28', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 525000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB29', 'JP8', 'P29', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB30', 'JP8', 'P30', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB31', 'JP3', 'P31', TO_DATE('06/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB32', 'JP1', 'P32', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB33', 'JP8', 'P33', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB34', 'JP7', 'P34', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 5059910000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB35', 'JP3', 'P35', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 59950000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB36', 'JP6', 'P36', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB37', 'JP1', 'P37', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 15480000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB38', 'JP6', 'P38', TO_DATE('07/08/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB39', 'JP1', 'P39', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 20230000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB40', 'JP4', 'P40', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB41', 'JP1', 'P41', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 4954610000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB42', 'JP4', 'P42', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 341712000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB43', 'JP8', 'P43', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB44', 'JP9', 'P44', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 292220000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB45', 'JP8', 'P45', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 1992600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB46', 'JP5', 'P46', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 2681747000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB47', 'JP8', 'P47', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB48', 'JP4', 'P48', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB49', 'JP2', 'P49', TO_DATE('08/08/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB50', 'JP7', 'P50', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB51', 'JP4', 'P51', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB52', 'JP6', 'P52', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB53', 'JP8', 'P53', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 1328210000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB54', 'JP2', 'P54', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB55', 'JP2', 'P55', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB56', 'JP9', 'P56', TO_DATE('09/08/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB57', 'JP4', 'P57', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB58', 'JP2', 'P58', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 288440000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB59', 'JP4', 'P59', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 1954090000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB60', 'JP7', 'P60', TO_DATE('10/08/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB61', 'JP8', 'P61', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 2150000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB62', 'JP9', 'P62', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB63', 'JP6', 'P63', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB64', 'JP1', 'P64', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 1475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB65', 'JP3', 'P65', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB66', 'JP2', 'P66', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB67', 'JP6', 'P67', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB68', 'JP4', 'P68', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB69', 'JP4', 'P69', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 661288000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB70', 'JP8', 'P70', TO_DATE('11/08/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB71', 'JP7', 'P71', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB72', 'JP2', 'P72', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB73', 'JP5', 'P73', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 3050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB74', 'JP9', 'P74', TO_DATE('12/08/2019', 'DD/MM/YYYY'), 914320000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB75', 'JP1', 'P75', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB76', 'JP6', 'P76', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB77', 'JP4', 'P77', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB78', 'JP1', 'P78', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB79', 'JP3', 'P79', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 12664000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB80', 'JP6', 'P80', TO_DATE('14/08/2019', 'DD/MM/YYYY'), 1500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB81', 'JP5', 'P81', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 81064000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB82', 'JP7', 'P82', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 37480000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB83', 'JP2', 'P83', TO_DATE('13/08/2019', 'DD/MM/YYYY'), 140677000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB84', 'JP6', 'P84', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 1322260000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB85', 'JP1', 'P85', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB86', 'JP9', 'P86', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB87', 'JP6', 'P87', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB88', 'JP8', 'P88', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB89', 'JP6', 'P89', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB90', 'JP8', 'P90', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 83505000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB91', 'JP1', 'P91', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 1700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB92', 'JP3', 'P92', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 1350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB93', 'JP7', 'P93', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 4740000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB94', 'JP5', 'P94', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB95', 'JP2', 'P95', TO_DATE('17/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB96', 'JP3', 'P96', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB97', 'JP7', 'P97', TO_DATE('15/08/2019', 'DD/MM/YYYY'), 525000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB98', 'JP3', 'P98', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 2000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB99', 'JP8', 'P99', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 1475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB100', 'JP5', 'P100', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB101', 'JP4', 'P101', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB102', 'JP9', 'P102', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB103', 'JP6', 'P103', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB104', 'JP4', 'P104', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 825000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB105', 'JP2', 'P105', TO_DATE('16/08/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB106', 'JP8', 'P106', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 248440000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB107', 'JP3', 'P107', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 3329185000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB108', 'JP3', 'P108', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB109', 'JP1', 'P109', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 394320000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB110', 'JP9', 'P110', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB111', 'JP9', 'P111', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 2000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB112', 'JP7', 'P112', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 3350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB113', 'JP5', 'P113', TO_DATE('18/08/2019', 'DD/MM/YYYY'), 150276000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB114', 'JP4', 'P114', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB115', 'JP6', 'P115', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB116', 'JP3', 'P116', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 4300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB117', 'JP7', 'P117', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB118', 'JP7', 'P118', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 1595900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB119', 'JP4', 'P119', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB120', 'JP2', 'P120', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB121', 'JP4', 'P121', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB122', 'JP6', 'P122', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 2409780000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB123', 'JP7', 'P123', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 45310000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB124', 'JP6', 'P124', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB125', 'JP6', 'P125', TO_DATE('19/08/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB126', 'JP4', 'P126', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB127', 'JP8', 'P127', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 2760000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB128', 'JP2', 'P128', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 3450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB129', 'JP7', 'P129', TO_DATE('20/08/2019', 'DD/MM/YYYY'), 2200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB130', 'JP8', 'P130', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB131', 'JP1', 'P131', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 5973400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB132', 'JP7', 'P132', TO_DATE('21/08/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB133', 'JP1', 'P133', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB134', 'JP1', 'P134', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB135', 'JP2', 'P135', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 57010000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB136', 'JP8', 'P136', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB137', 'JP3', 'P137', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB138', 'JP7', 'P138', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1059905000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB139', 'JP3', 'P139', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB140', 'JP1', 'P140', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB141', 'JP5', 'P141', TO_DATE('23/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB142', 'JP9', 'P142', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 112954000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB143', 'JP8', 'P143', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB144', 'JP2', 'P144', TO_DATE('22/08/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB145', 'JP6', 'P145', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1003910000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB146', 'JP7', 'P146', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1942490000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB147', 'JP7', 'P147', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB148', 'JP8', 'P148', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 5769642000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB149', 'JP5', 'P149', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB150', 'JP9', 'P150', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB151', 'JP1', 'P151', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB152', 'JP6', 'P152', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB153', 'JP5', 'P153', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB154', 'JP1', 'P154', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB155', 'JP7', 'P155', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB156', 'JP1', 'P156', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB157', 'JP3', 'P157', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 41780000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB158', 'JP9', 'P158', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 1475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB159', 'JP6', 'P159', TO_DATE('24/08/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB160', 'JP4', 'P160', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB161', 'JP9', 'P161', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB162', 'JP5', 'P162', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 113600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB163', 'JP8', 'P163', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 2300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB164', 'JP1', 'P164', TO_DATE('25/08/2019', 'DD/MM/YYYY'), 1288750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB165', 'JP8', 'P165', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB166', 'JP1', 'P166', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB167', 'JP1', 'P167', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 23550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB168', 'JP1', 'P168', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB169', 'JP7', 'P169', TO_DATE('26/08/2019', 'DD/MM/YYYY'), 1350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB170', 'JP9', 'P170', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB171', 'JP5', 'P171', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 27460000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB172', 'JP1', 'P172', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 59350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB173', 'JP7', 'P173', TO_DATE('27/08/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB174', 'JP5', 'P174', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB175', 'JP1', 'P175', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB176', 'JP8', 'P176', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB177', 'JP4', 'P177', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB178', 'JP5', 'P178', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 2600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB179', 'JP4', 'P179', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 4033000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB180', 'JP9', 'P180', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB181', 'JP9', 'P181', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB182', 'JP7', 'P182', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB183', 'JP9', 'P183', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 281908000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB184', 'JP6', 'P184', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 2500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB185', 'JP3', 'P185', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB186', 'JP3', 'P186', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 81590000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB187', 'JP7', 'P187', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 3350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB188', 'JP3', 'P188', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB189', 'JP2', 'P189', TO_DATE('28/08/2019', 'DD/MM/YYYY'), 1399590000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB190', 'JP7', 'P190', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB191', 'JP5', 'P191', TO_DATE('29/08/2019', 'DD/MM/YYYY'), 1359840000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB192', 'JP3', 'P192', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB193', 'JP2', 'P193', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 2012360000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB194', 'JP6', 'P194', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 1550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB195', 'JP9', 'P195', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 379910000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB196', 'JP6', 'P196', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 6208222000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB197', 'JP6', 'P197', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 2791056000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB198', 'JP3', 'P198', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB199', 'JP8', 'P199', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB200', 'JP2', 'P200', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 4539415000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB201', 'JP9', 'P201', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 114268000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB202', 'JP3', 'P202', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 1350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB203', 'JP2', 'P203', TO_DATE('30/08/2019', 'DD/MM/YYYY'), 4165310000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB204', 'JP3', 'P204', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 675000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB205', 'JP4', 'P205', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB206', 'JP1', 'P206', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB207', 'JP3', 'P207', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 525000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB208', 'JP6', 'P208', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 3475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB209', 'JP8', 'P209', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB210', 'JP3', 'P210', TO_DATE('31/08/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB211', 'JP3', 'P211', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB212', 'JP1', 'P212', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 245600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB213', 'JP4', 'P213', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB214', 'JP2', 'P214', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB215', 'JP9', 'P215', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 61575000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB216', 'JP4', 'P216', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB217', 'JP7', 'P217', TO_DATE('01/09/2019', 'DD/MM/YYYY'), 2260000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB218', 'JP7', 'P218', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 1500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB219', 'JP7', 'P219', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB220', 'JP4', 'P220', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 1180000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB221', 'JP3', 'P221', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB222', 'JP3', 'P222', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 1714966000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB223', 'JP6', 'P223', TO_DATE('02/09/2019', 'DD/MM/YYYY'), 2680000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB224', 'JP3', 'P224', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 27520000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB225', 'JP6', 'P225', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 69665000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB226', 'JP5', 'P226', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 2360000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB227', 'JP2', 'P227', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 1450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB228', 'JP5', 'P228', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 39725000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB229', 'JP4', 'P229', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB230', 'JP1', 'P230', TO_DATE('03/09/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB231', 'JP6', 'P231', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB232', 'JP5', 'P232', TO_DATE('04/09/2019', 'DD/MM/YYYY'), 950000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB233', 'JP1', 'P233', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 5067700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB234', 'JP2', 'P234', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB235', 'JP1', 'P235', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 61045000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB236', 'JP2', 'P236', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 3475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB237', 'JP3', 'P237', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB238', 'JP6', 'P238', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB239', 'JP5', 'P239', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB240', 'JP5', 'P240', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 101515000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB241', 'JP4', 'P241', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 6077130000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB242', 'JP4', 'P242', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB243', 'JP9', 'P243', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 315800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB244', 'JP1', 'P244', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB245', 'JP9', 'P245', TO_DATE('05/09/2019', 'DD/MM/YYYY'), 2350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB246', 'JP5', 'P246', TO_DATE('07/09/2019', 'DD/MM/YYYY'), 1450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB247', 'JP5', 'P247', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB248', 'JP8', 'P248', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 794962000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB249', 'JP8', 'P249', TO_DATE('07/09/2019', 'DD/MM/YYYY'), 16190000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB250', 'JP1', 'P250', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 1475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB251', 'JP6', 'P251', TO_DATE('06/09/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual;

INSERT INTO PEMBAYARAN (ID_PEMBAYARAN, ID_JENIS_PEMBAYARAN, ID_PESANAN, TANGGAL_PEMBAYARAN, JUMLAH_PEMBAYARAN, KEPERLUAN_PEMBAYARAN)  
  select 'PB252', 'JP6', 'P252', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB253', 'JP8', 'P253', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB254', 'JP2', 'P254', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB255', 'JP8', 'P255', TO_DATE('10/09/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB256', 'JP9', 'P256', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB257', 'JP2', 'P257', TO_DATE('07/09/2019', 'DD/MM/YYYY'), 100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB258', 'JP4', 'P258', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 86060000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB259', 'JP5', 'P259', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB260', 'JP2', 'P260', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB261', 'JP7', 'P261', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB262', 'JP7', 'P262', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB263', 'JP7', 'P263', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB264', 'JP7', 'P264', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB265', 'JP2', 'P265', TO_DATE('10/09/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB266', 'JP6', 'P266', TO_DATE('08/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB267', 'JP3', 'P267', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 307820000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB268', 'JP8', 'P268', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB269', 'JP5', 'P269', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 3040175000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB270', 'JP1', 'P270', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB271', 'JP6', 'P271', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB272', 'JP8', 'P272', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 47970000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB273', 'JP2', 'P273', TO_DATE('09/09/2019', 'DD/MM/YYYY'), 2235680000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB274', 'JP2', 'P274', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB275', 'JP2', 'P275', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 1500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB276', 'JP7', 'P276', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 875000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB277', 'JP5', 'P277', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 3320000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB278', 'JP6', 'P278', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB279', 'JP6', 'P279', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 1018750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB280', 'JP4', 'P280', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 2580000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB281', 'JP4', 'P281', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 2325984000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB282', 'JP6', 'P282', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB283', 'JP9', 'P283', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB284', 'JP4', 'P284', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB285', 'JP5', 'P285', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB286', 'JP3', 'P286', TO_DATE('11/09/2019', 'DD/MM/YYYY'), 362140000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB287', 'JP8', 'P287', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB288', 'JP6', 'P288', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 1310932000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB289', 'JP4', 'P289', TO_DATE('12/09/2019', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB290', 'JP4', 'P290', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 3050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB291', 'JP7', 'P291', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB292', 'JP3', 'P292', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 48275000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB293', 'JP2', 'P293', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB294', 'JP5', 'P294', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB295', 'JP1', 'P295', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB296', 'JP7', 'P296', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1334180000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB297', 'JP8', 'P297', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 4000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB298', 'JP5', 'P298', TO_DATE('13/09/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB299', 'JP5', 'P299', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 4789625000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB300', 'JP5', 'P300', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB301', 'JP9', 'P301', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB302', 'JP4', 'P302', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 872590000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB303', 'JP4', 'P303', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 13800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB304', 'JP4', 'P304', TO_DATE('14/09/2019', 'DD/MM/YYYY'), 1475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB305', 'JP2', 'P305', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB306', 'JP4', 'P306', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB307', 'JP1', 'P307', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 1238188000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB308', 'JP1', 'P308', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 627600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB309', 'JP6', 'P309', TO_DATE('15/09/2019', 'DD/MM/YYYY'), 1550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB310', 'JP8', 'P310', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB311', 'JP6', 'P311', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB312', 'JP5', 'P312', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB313', 'JP8', 'P313', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 21540000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB314', 'JP8', 'P314', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 1300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB315', 'JP2', 'P315', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 1300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB316', 'JP5', 'P316', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 1650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB317', 'JP4', 'P317', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB318', 'JP9', 'P318', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 503400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB319', 'JP6', 'P319', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB320', 'JP5', 'P320', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB321', 'JP8', 'P321', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB322', 'JP3', 'P322', TO_DATE('16/09/2019', 'DD/MM/YYYY'), 702980000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB323', 'JP4', 'P323', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB324', 'JP4', 'P324', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB325', 'JP5', 'P325', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB326', 'JP2', 'P326', TO_DATE('17/09/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB327', 'JP8', 'P327', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB328', 'JP5', 'P328', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB329', 'JP1', 'P329', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 12388395000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB330', 'JP9', 'P330', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB331', 'JP2', 'P331', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 41130000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB332', 'JP8', 'P332', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB333', 'JP2', 'P333', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB334', 'JP5', 'P334', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 594806000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB335', 'JP8', 'P335', TO_DATE('18/09/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB336', 'JP5', 'P336', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 42300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB337', 'JP9', 'P337', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 2520000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB338', 'JP7', 'P338', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB339', 'JP4', 'P339', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB340', 'JP2', 'P340', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB341', 'JP9', 'P341', TO_DATE('19/09/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB342', 'JP9', 'P342', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB343', 'JP9', 'P343', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB344', 'JP9', 'P344', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB345', 'JP3', 'P345', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 621771000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB346', 'JP1', 'P346', TO_DATE('24/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB347', 'JP9', 'P347', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 226306000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB348', 'JP7', 'P348', TO_DATE('20/09/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB349', 'JP1', 'P349', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 61450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB350', 'JP2', 'P350', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 15050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB351', 'JP8', 'P351', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 1650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB352', 'JP6', 'P352', TO_DATE('21/09/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB353', 'JP8', 'P353', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB354', 'JP3', 'P354', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 2200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB355', 'JP5', 'P355', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 474730000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB356', 'JP3', 'P356', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB357', 'JP6', 'P357', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 507020000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB358', 'JP9', 'P358', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 19190000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB359', 'JP9', 'P359', TO_DATE('22/09/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB360', 'JP8', 'P360', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB361', 'JP7', 'P361', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 7283457500, 'LUNAS'  FROM dual UNION ALL 
  select 'PB362', 'JP1', 'P362', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 4577668000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB363', 'JP1', 'P363', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 1350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB364', 'JP8', 'P364', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 950000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB365', 'JP5', 'P365', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB366', 'JP5', 'P366', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB367', 'JP1', 'P367', TO_DATE('24/09/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB368', 'JP1', 'P368', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB369', 'JP8', 'P369', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB370', 'JP2', 'P370', TO_DATE('24/09/2019', 'DD/MM/YYYY'), 6000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB371', 'JP6', 'P371', TO_DATE('23/09/2019', 'DD/MM/YYYY'), 5976000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB372', 'JP4', 'P372', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB373', 'JP6', 'P373', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB374', 'JP2', 'P374', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB375', 'JP4', 'P375', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB376', 'JP7', 'P376', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB377', 'JP8', 'P377', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB378', 'JP1', 'P378', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 6875820000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB379', 'JP9', 'P379', TO_DATE('29/09/2019', 'DD/MM/YYYY'), 4242800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB380', 'JP6', 'P380', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB381', 'JP8', 'P381', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB382', 'JP9', 'P382', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 3920000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB383', 'JP8', 'P383', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 2200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB384', 'JP9', 'P384', TO_DATE('25/09/2019', 'DD/MM/YYYY'), 369090000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB385', 'JP4', 'P385', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB386', 'JP6', 'P386', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB387', 'JP3', 'P387', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB388', 'JP7', 'P388', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB389', 'JP5', 'P389', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 24320000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB390', 'JP1', 'P390', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB391', 'JP8', 'P391', TO_DATE('26/09/2019', 'DD/MM/YYYY'), 1791172000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB392', 'JP4', 'P392', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 63361000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB393', 'JP6', 'P393', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 1450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB394', 'JP9', 'P394', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 57740000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB395', 'JP9', 'P395', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB396', 'JP1', 'P396', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 14460000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB397', 'JP5', 'P397', TO_DATE('28/09/2019', 'DD/MM/YYYY'), 2037400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB398', 'JP5', 'P398', TO_DATE('27/09/2019', 'DD/MM/YYYY'), 3896444000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB399', 'JP2', 'P399', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB400', 'JP7', 'P400', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB401', 'JP3', 'P401', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB402', 'JP1', 'P402', TO_DATE('29/09/2019', 'DD/MM/YYYY'), 42230000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB403', 'JP9', 'P403', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 2150000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB404', 'JP1', 'P404', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 5019888000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB405', 'JP7', 'P405', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 15760000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB406', 'JP1', 'P406', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 9720000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB407', 'JP2', 'P407', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 65630000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB408', 'JP6', 'P408', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB409', 'JP9', 'P409', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB410', 'JP3', 'P410', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB411', 'JP8', 'P411', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB412', 'JP8', 'P412', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB413', 'JP4', 'P413', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB414', 'JP8', 'P414', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 4000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB415', 'JP3', 'P415', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB416', 'JP2', 'P416', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB417', 'JP4', 'P417', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 39752000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB418', 'JP6', 'P418', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 558980000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB419', 'JP3', 'P419', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB420', 'JP9', 'P420', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB421', 'JP7', 'P421', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 603320000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB422', 'JP3', 'P422', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB423', 'JP9', 'P423', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB424', 'JP5', 'P424', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB425', 'JP2', 'P425', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB426', 'JP2', 'P426', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 633335000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB427', 'JP2', 'P427', TO_DATE('01/10/2019', 'DD/MM/YYYY'), 320190000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB428', 'JP5', 'P428', TO_DATE('02/10/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB429', 'JP5', 'P429', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 1640159000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB430', 'JP7', 'P430', TO_DATE('02/10/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB431', 'JP9', 'P431', TO_DATE('03/10/2019', 'DD/MM/YYYY'), 45930000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB432', 'JP6', 'P432', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 5541230000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB433', 'JP8', 'P433', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB434', 'JP4', 'P434', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB435', 'JP6', 'P435', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 857996000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB436', 'JP7', 'P436', TO_DATE('03/10/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB437', 'JP2', 'P437', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB438', 'JP4', 'P438', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB439', 'JP9', 'P439', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 2921800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB440', 'JP4', 'P440', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB441', 'JP7', 'P441', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 3380521000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB442', 'JP7', 'P442', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB443', 'JP8', 'P443', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 52996000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB444', 'JP1', 'P444', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB445', 'JP7', 'P445', TO_DATE('04/10/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB446', 'JP4', 'P446', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB447', 'JP3', 'P447', TO_DATE('04/10/2019', 'DD/MM/YYYY'), 675000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB448', 'JP7', 'P448', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB449', 'JP5', 'P449', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB450', 'JP8', 'P450', TO_DATE('09/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB451', 'JP8', 'P451', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB452', 'JP8', 'P452', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB453', 'JP7', 'P453', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB454', 'JP7', 'P454', TO_DATE('05/10/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB455', 'JP4', 'P455', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 3180000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB456', 'JP8', 'P456', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB457', 'JP2', 'P457', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 2175810000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB458', 'JP3', 'P458', TO_DATE('07/10/2019', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB459', 'JP3', 'P459', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB460', 'JP2', 'P460', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB461', 'JP9', 'P461', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 388760000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB462', 'JP6', 'P462', TO_DATE('06/10/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB463', 'JP4', 'P463', TO_DATE('09/10/2019', 'DD/MM/YYYY'), 4977920000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB464', 'JP9', 'P464', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB465', 'JP7', 'P465', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB466', 'JP6', 'P466', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB467', 'JP1', 'P467', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB468', 'JP6', 'P468', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB469', 'JP9', 'P469', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB470', 'JP9', 'P470', TO_DATE('09/10/2019', 'DD/MM/YYYY'), 20960000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB471', 'JP1', 'P471', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 1130339000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB472', 'JP5', 'P472', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB473', 'JP7', 'P473', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB474', 'JP1', 'P474', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB475', 'JP1', 'P475', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 234775000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB476', 'JP2', 'P476', TO_DATE('08/10/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB477', 'JP4', 'P477', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB478', 'JP7', 'P478', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB479', 'JP8', 'P479', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB480', 'JP8', 'P480', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 441965000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB481', 'JP2', 'P481', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 675000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB482', 'JP2', 'P482', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 3100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB483', 'JP7', 'P483', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB484', 'JP1', 'P484', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 1114178000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB485', 'JP6', 'P485', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 5100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB486', 'JP3', 'P486', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB487', 'JP6', 'P487', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB488', 'JP4', 'P488', TO_DATE('10/10/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB489', 'JP6', 'P489', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 872060000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB490', 'JP8', 'P490', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB491', 'JP5', 'P491', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 2300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB492', 'JP9', 'P492', TO_DATE('11/10/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB493', 'JP5', 'P493', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB494', 'JP5', 'P494', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB495', 'JP3', 'P495', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB496', 'JP7', 'P496', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB497', 'JP9', 'P497', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 776012500, 'LUNAS'  FROM dual UNION ALL 
  select 'PB498', 'JP7', 'P498', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB499', 'JP6', 'P499', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB500', 'JP3', 'P500', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 7914000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB501', 'JP3', 'P501', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 17880000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB502', 'JP3', 'P502', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual;

INSERT INTO PEMBAYARAN (ID_PEMBAYARAN, ID_JENIS_PEMBAYARAN, ID_PESANAN, TANGGAL_PEMBAYARAN, JUMLAH_PEMBAYARAN, KEPERLUAN_PEMBAYARAN)  
  select 'PB503', 'JP4', 'P503', TO_DATE('12/10/2019', 'DD/MM/YYYY'), 1450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB504', 'JP3', 'P504', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB505', 'JP6', 'P505', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 4500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB506', 'JP3', 'P506', TO_DATE('13/10/2019', 'DD/MM/YYYY'), 725000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB507', 'JP5', 'P507', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB508', 'JP9', 'P508', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB509', 'JP9', 'P509', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB510', 'JP8', 'P510', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB511', 'JP4', 'P511', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB512', 'JP5', 'P512', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 482484000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB513', 'JP3', 'P513', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 39080000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB514', 'JP8', 'P514', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB515', 'JP1', 'P515', TO_DATE('14/10/2019', 'DD/MM/YYYY'), 2150000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB516', 'JP3', 'P516', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 3050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB517', 'JP2', 'P517', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 392050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB518', 'JP3', 'P518', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 12820000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB519', 'JP6', 'P519', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 19120000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB520', 'JP9', 'P520', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB521', 'JP6', 'P521', TO_DATE('15/10/2019', 'DD/MM/YYYY'), 3350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB522', 'JP6', 'P522', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB523', 'JP9', 'P523', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB524', 'JP8', 'P524', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB525', 'JP4', 'P525', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB526', 'JP4', 'P526', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB527', 'JP2', 'P527', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 19920000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB528', 'JP9', 'P528', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB529', 'JP5', 'P529', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB530', 'JP1', 'P530', TO_DATE('16/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB531', 'JP2', 'P531', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB532', 'JP5', 'P532', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB533', 'JP3', 'P533', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB534', 'JP9', 'P534', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 528820000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB535', 'JP3', 'P535', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 25580000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB536', 'JP2', 'P536', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 740000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB537', 'JP5', 'P537', TO_DATE('17/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB538', 'JP7', 'P538', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB539', 'JP9', 'P539', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 1829576000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB540', 'JP3', 'P540', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB541', 'JP3', 'P541', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB542', 'JP5', 'P542', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 110930000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB543', 'JP8', 'P543', TO_DATE('18/10/2019', 'DD/MM/YYYY'), 779640000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB544', 'JP8', 'P544', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 5535220000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB545', 'JP2', 'P545', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB546', 'JP9', 'P546', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 6040000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB547', 'JP2', 'P547', TO_DATE('22/10/2019', 'DD/MM/YYYY'), 3350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB548', 'JP2', 'P548', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB549', 'JP2', 'P549', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 810020000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB550', 'JP3', 'P550', TO_DATE('22/10/2019', 'DD/MM/YYYY'), 441250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB551', 'JP6', 'P551', TO_DATE('19/10/2019', 'DD/MM/YYYY'), 3450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB552', 'JP3', 'P552', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 860540000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB553', 'JP6', 'P553', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 1475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB554', 'JP1', 'P554', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB555', 'JP8', 'P555', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB556', 'JP5', 'P556', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 473900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB557', 'JP8', 'P557', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB558', 'JP7', 'P558', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 2000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB559', 'JP9', 'P559', TO_DATE('20/10/2019', 'DD/MM/YYYY'), 18540000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB560', 'JP3', 'P560', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 301670000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB561', 'JP3', 'P561', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 1531172000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB562', 'JP2', 'P562', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB563', 'JP3', 'P563', TO_DATE('21/10/2019', 'DD/MM/YYYY'), 2780350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB564', 'JP1', 'P564', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 1500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB565', 'JP5', 'P565', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB566', 'JP1', 'P566', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB567', 'JP1', 'P567', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB568', 'JP5', 'P568', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB569', 'JP9', 'P569', TO_DATE('22/10/2019', 'DD/MM/YYYY'), 94910000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB570', 'JP2', 'P570', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB571', 'JP3', 'P571', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB572', 'JP4', 'P572', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 58462000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB573', 'JP8', 'P573', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 765275000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB574', 'JP5', 'P574', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB575', 'JP2', 'P575', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 2140000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB576', 'JP8', 'P576', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB577', 'JP5', 'P577', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 1700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB578', 'JP8', 'P578', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB579', 'JP6', 'P579', TO_DATE('23/10/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB580', 'JP7', 'P580', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 2000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB581', 'JP5', 'P581', TO_DATE('24/10/2019', 'DD/MM/YYYY'), 5360000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB582', 'JP1', 'P582', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB583', 'JP4', 'P583', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 3270090000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB584', 'JP9', 'P584', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB585', 'JP3', 'P585', TO_DATE('25/10/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB586', 'JP3', 'P586', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 3231320000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB587', 'JP5', 'P587', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 857055000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB588', 'JP7', 'P588', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 775000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB589', 'JP9', 'P589', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 3795320000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB590', 'JP7', 'P590', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB591', 'JP9', 'P591', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 3361760000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB592', 'JP3', 'P592', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB593', 'JP6', 'P593', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB594', 'JP4', 'P594', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB595', 'JP3', 'P595', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB596', 'JP2', 'P596', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB597', 'JP5', 'P597', TO_DATE('26/10/2019', 'DD/MM/YYYY'), 1350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB598', 'JP3', 'P598', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB599', 'JP2', 'P599', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 953550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB600', 'JP1', 'P600', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 3050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB601', 'JP5', 'P601', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB602', 'JP2', 'P602', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB603', 'JP1', 'P603', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 29200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB604', 'JP3', 'P604', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB605', 'JP1', 'P605', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB606', 'JP7', 'P606', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 345380000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB607', 'JP3', 'P607', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 3300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB608', 'JP9', 'P608', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB609', 'JP4', 'P609', TO_DATE('27/10/2019', 'DD/MM/YYYY'), 775000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB610', 'JP3', 'P610', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 80950000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB611', 'JP6', 'P611', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 1532670000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB612', 'JP5', 'P612', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB613', 'JP4', 'P613', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB614', 'JP5', 'P614', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB615', 'JP3', 'P615', TO_DATE('28/10/2019', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB616', 'JP8', 'P616', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB617', 'JP6', 'P617', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB618', 'JP1', 'P618', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 70671500, 'LUNAS'  FROM dual UNION ALL 
  select 'PB619', 'JP4', 'P619', TO_DATE('29/10/2019', 'DD/MM/YYYY'), 1384372000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB620', 'JP2', 'P620', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 3599788000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB621', 'JP6', 'P621', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 8416872000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB622', 'JP6', 'P622', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB623', 'JP6', 'P623', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB624', 'JP9', 'P624', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB625', 'JP2', 'P625', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB626', 'JP9', 'P626', TO_DATE('30/10/2019', 'DD/MM/YYYY'), 4200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB627', 'JP2', 'P627', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB628', 'JP2', 'P628', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 3480000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB629', 'JP1', 'P629', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB630', 'JP3', 'P630', TO_DATE('31/10/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB631', 'JP8', 'P631', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 525000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB632', 'JP4', 'P632', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 11260000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB633', 'JP2', 'P633', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 465630000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB634', 'JP8', 'P634', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1700570000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB635', 'JP5', 'P635', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB636', 'JP8', 'P636', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 71860000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB637', 'JP5', 'P637', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 597450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB638', 'JP1', 'P638', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB639', 'JP8', 'P639', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 1400350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB640', 'JP3', 'P640', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB641', 'JP2', 'P641', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 975000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB642', 'JP3', 'P642', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 950000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB643', 'JP7', 'P643', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB644', 'JP4', 'P644', TO_DATE('01/11/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB645', 'JP9', 'P645', TO_DATE('03/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB646', 'JP8', 'P646', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB647', 'JP6', 'P647', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB648', 'JP8', 'P648', TO_DATE('03/11/2019', 'DD/MM/YYYY'), 159100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB649', 'JP9', 'P649', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB650', 'JP3', 'P650', TO_DATE('02/11/2019', 'DD/MM/YYYY'), 241430000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB651', 'JP2', 'P651', TO_DATE('02/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB652', 'JP9', 'P652', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB653', 'JP9', 'P653', TO_DATE('04/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB654', 'JP3', 'P654', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB655', 'JP9', 'P655', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB656', 'JP8', 'P656', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 738130000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB657', 'JP1', 'P657', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 2550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB658', 'JP3', 'P658', TO_DATE('03/11/2019', 'DD/MM/YYYY'), 950000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB659', 'JP1', 'P659', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 1350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB660', 'JP7', 'P660', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 486860000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB661', 'JP6', 'P661', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB662', 'JP8', 'P662', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB663', 'JP3', 'P663', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB664', 'JP6', 'P664', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB665', 'JP7', 'P665', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 3300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB666', 'JP3', 'P666', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB667', 'JP4', 'P667', TO_DATE('05/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB668', 'JP9', 'P668', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB669', 'JP4', 'P669', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 411180000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB670', 'JP2', 'P670', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB671', 'JP9', 'P671', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 63210000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB672', 'JP6', 'P672', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 38950000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB673', 'JP2', 'P673', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 1700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB674', 'JP8', 'P674', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB675', 'JP8', 'P675', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 3500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB676', 'JP1', 'P676', TO_DATE('07/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB677', 'JP1', 'P677', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB678', 'JP8', 'P678', TO_DATE('06/11/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB679', 'JP9', 'P679', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB680', 'JP9', 'P680', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB681', 'JP6', 'P681', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB682', 'JP8', 'P682', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB683', 'JP4', 'P683', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 2051638000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB684', 'JP2', 'P684', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 7262210000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB685', 'JP3', 'P685', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB686', 'JP7', 'P686', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 578740000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB687', 'JP7', 'P687', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB688', 'JP5', 'P688', TO_DATE('08/11/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB689', 'JP6', 'P689', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB690', 'JP4', 'P690', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 4200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB691', 'JP6', 'P691', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB692', 'JP1', 'P692', TO_DATE('12/11/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB693', 'JP7', 'P693', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 2150000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB694', 'JP4', 'P694', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB695', 'JP8', 'P695', TO_DATE('12/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB696', 'JP9', 'P696', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB697', 'JP5', 'P697', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB698', 'JP7', 'P698', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 750050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB699', 'JP5', 'P699', TO_DATE('09/11/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB700', 'JP1', 'P700', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB701', 'JP9', 'P701', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 4508100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB702', 'JP5', 'P702', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB703', 'JP9', 'P703', TO_DATE('12/11/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB704', 'JP7', 'P704', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 1300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB705', 'JP4', 'P705', TO_DATE('10/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB706', 'JP2', 'P706', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB707', 'JP1', 'P707', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB708', 'JP5', 'P708', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB709', 'JP4', 'P709', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 68360000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB710', 'JP1', 'P710', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB711', 'JP2', 'P711', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 54900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB712', 'JP4', 'P712', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB713', 'JP4', 'P713', TO_DATE('11/11/2019', 'DD/MM/YYYY'), 24752000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB714', 'JP6', 'P714', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB715', 'JP8', 'P715', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB716', 'JP9', 'P716', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB717', 'JP3', 'P717', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 1393640000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB718', 'JP9', 'P718', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 89488000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB719', 'JP1', 'P719', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 4852760000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB720', 'JP2', 'P720', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 2350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB721', 'JP8', 'P721', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 872705000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB722', 'JP4', 'P722', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB723', 'JP4', 'P723', TO_DATE('13/11/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB724', 'JP6', 'P724', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB725', 'JP9', 'P725', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB726', 'JP6', 'P726', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 16300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB727', 'JP8', 'P727', TO_DATE('14/11/2019', 'DD/MM/YYYY'), 4689780000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB728', 'JP9', 'P728', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB729', 'JP1', 'P729', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB730', 'JP8', 'P730', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB731', 'JP5', 'P731', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB732', 'JP7', 'P732', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 189290000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB733', 'JP7', 'P733', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB734', 'JP5', 'P734', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB735', 'JP5', 'P735', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 29866000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB736', 'JP7', 'P736', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB737', 'JP1', 'P737', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB738', 'JP5', 'P738', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 6590000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB739', 'JP6', 'P739', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 875000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB740', 'JP6', 'P740', TO_DATE('16/11/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB741', 'JP3', 'P741', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB742', 'JP9', 'P742', TO_DATE('15/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB743', 'JP4', 'P743', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 3362353500, 'LUNAS'  FROM dual UNION ALL 
  select 'PB744', 'JP3', 'P744', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB745', 'JP4', 'P745', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 1700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB746', 'JP6', 'P746', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB747', 'JP3', 'P747', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 119875000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB748', 'JP1', 'P748', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB749', 'JP8', 'P749', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB750', 'JP9', 'P750', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 3820000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB751', 'JP7', 'P751', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 3050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB752', 'JP8', 'P752', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB753', 'JP4', 'P753', TO_DATE('17/11/2019', 'DD/MM/YYYY'), 1350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB754', 'JP4', 'P754', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 900000, 'LUNAS'  FROM dual;

INSERT INTO PEMBAYARAN (ID_PEMBAYARAN, ID_JENIS_PEMBAYARAN, ID_PESANAN, TANGGAL_PEMBAYARAN, JUMLAH_PEMBAYARAN, KEPERLUAN_PEMBAYARAN)  
  select 'PB755', 'JP4', 'P755', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB756', 'JP8', 'P756', TO_DATE('18/11/2019', 'DD/MM/YYYY'), 571072000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB757', 'JP2', 'P757', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB758', 'JP9', 'P758', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 4000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB759', 'JP8', 'P759', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB760', 'JP5', 'P760', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB761', 'JP2', 'P761', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1039655000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB762', 'JP1', 'P762', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB763', 'JP9', 'P763', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 14610000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB764', 'JP8', 'P764', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB765', 'JP8', 'P765', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 231650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB766', 'JP3', 'P766', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 5636452000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB767', 'JP1', 'P767', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB768', 'JP5', 'P768', TO_DATE('19/11/2019', 'DD/MM/YYYY'), 6693520000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB769', 'JP3', 'P769', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB770', 'JP7', 'P770', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB771', 'JP7', 'P771', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 853590500, 'LUNAS'  FROM dual UNION ALL 
  select 'PB772', 'JP8', 'P772', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB773', 'JP3', 'P773', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB774', 'JP1', 'P774', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 3475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB775', 'JP6', 'P775', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 1300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB776', 'JP3', 'P776', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB777', 'JP2', 'P777', TO_DATE('20/11/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB778', 'JP7', 'P778', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 81100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB779', 'JP9', 'P779', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 107240000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB780', 'JP2', 'P780', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1068154000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB781', 'JP9', 'P781', TO_DATE('21/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB782', 'JP3', 'P782', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB783', 'JP7', 'P783', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB784', 'JP3', 'P784', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB785', 'JP3', 'P785', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 4200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB786', 'JP7', 'P786', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB787', 'JP7', 'P787', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 825000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB788', 'JP9', 'P788', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 3096385000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB789', 'JP9', 'P789', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 15190000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB790', 'JP7', 'P790', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB791', 'JP6', 'P791', TO_DATE('22/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB792', 'JP6', 'P792', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB793', 'JP9', 'P793', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB794', 'JP2', 'P794', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 3108806000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB795', 'JP8', 'P795', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB796', 'JP9', 'P796', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 542800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB797', 'JP8', 'P797', TO_DATE('23/11/2019', 'DD/MM/YYYY'), 402766000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB798', 'JP9', 'P798', TO_DATE('26/11/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB799', 'JP3', 'P799', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 2350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB800', 'JP1', 'P800', TO_DATE('24/11/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB801', 'JP5', 'P801', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 150210000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB802', 'JP4', 'P802', TO_DATE('26/11/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB803', 'JP2', 'P803', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB804', 'JP2', 'P804', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB805', 'JP4', 'P805', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 4618105000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB806', 'JP3', 'P806', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB807', 'JP5', 'P807', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 972210000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB808', 'JP4', 'P808', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB809', 'JP4', 'P809', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB810', 'JP4', 'P810', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB811', 'JP8', 'P811', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 100736000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB812', 'JP7', 'P812', TO_DATE('25/11/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB813', 'JP9', 'P813', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB814', 'JP7', 'P814', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 144400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB815', 'JP9', 'P815', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 3238832000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB816', 'JP5', 'P816', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 455600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB817', 'JP5', 'P817', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 684557500, 'LUNAS'  FROM dual UNION ALL 
  select 'PB818', 'JP5', 'P818', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB819', 'JP9', 'P819', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB820', 'JP8', 'P820', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB821', 'JP7', 'P821', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 556750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB822', 'JP4', 'P822', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 647256000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB823', 'JP5', 'P823', TO_DATE('27/11/2019', 'DD/MM/YYYY'), 289976000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB824', 'JP8', 'P824', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB825', 'JP1', 'P825', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB826', 'JP8', 'P826', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB827', 'JP8', 'P827', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 468044000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB828', 'JP6', 'P828', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB829', 'JP6', 'P829', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 743630000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB830', 'JP3', 'P830', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB831', 'JP3', 'P831', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 346320000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB832', 'JP9', 'P832', TO_DATE('28/11/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB833', 'JP3', 'P833', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 510959000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB834', 'JP1', 'P834', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB835', 'JP2', 'P835', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 1450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB836', 'JP5', 'P836', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB837', 'JP6', 'P837', TO_DATE('30/11/2019', 'DD/MM/YYYY'), 17680000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB838', 'JP6', 'P838', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB839', 'JP3', 'P839', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB840', 'JP1', 'P840', TO_DATE('29/11/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB841', 'JP2', 'P841', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 2600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB842', 'JP6', 'P842', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 53600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB843', 'JP1', 'P843', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 4000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB844', 'JP1', 'P844', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB845', 'JP1', 'P845', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 115020000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB846', 'JP9', 'P846', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB847', 'JP4', 'P847', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB848', 'JP2', 'P848', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 2000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB849', 'JP7', 'P849', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB850', 'JP1', 'P850', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 28612000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB851', 'JP4', 'P851', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB852', 'JP6', 'P852', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB853', 'JP6', 'P853', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB854', 'JP2', 'P854', TO_DATE('01/12/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB855', 'JP5', 'P855', TO_DATE('02/12/2019', 'DD/MM/YYYY'), 2942398000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB856', 'JP1', 'P856', TO_DATE('02/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB857', 'JP5', 'P857', TO_DATE('02/12/2019', 'DD/MM/YYYY'), 3300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB858', 'JP4', 'P858', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB859', 'JP1', 'P859', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB860', 'JP4', 'P860', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB861', 'JP5', 'P861', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB862', 'JP8', 'P862', TO_DATE('03/12/2019', 'DD/MM/YYYY'), 42430000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB863', 'JP4', 'P863', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 2550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB864', 'JP2', 'P864', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB865', 'JP3', 'P865', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 768630000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB866', 'JP7', 'P866', TO_DATE('03/12/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB867', 'JP6', 'P867', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 7320000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB868', 'JP2', 'P868', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 616300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB869', 'JP5', 'P869', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB870', 'JP8', 'P870', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 23410000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB871', 'JP7', 'P871', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB872', 'JP3', 'P872', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 1700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB873', 'JP7', 'P873', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 67275000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB874', 'JP5', 'P874', TO_DATE('04/12/2019', 'DD/MM/YYYY'), 32804000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB875', 'JP6', 'P875', TO_DATE('05/12/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB876', 'JP5', 'P876', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB877', 'JP7', 'P877', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB878', 'JP2', 'P878', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 336606000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB879', 'JP2', 'P879', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 8169160000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB880', 'JP9', 'P880', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB881', 'JP2', 'P881', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB882', 'JP7', 'P882', TO_DATE('06/12/2019', 'DD/MM/YYYY'), 3556000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB883', 'JP4', 'P883', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB884', 'JP9', 'P884', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB885', 'JP5', 'P885', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB886', 'JP4', 'P886', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB887', 'JP5', 'P887', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB888', 'JP6', 'P888', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 5052470000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB889', 'JP3', 'P889', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 1450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB890', 'JP7', 'P890', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB891', 'JP8', 'P891', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 668600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB892', 'JP2', 'P892', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB893', 'JP6', 'P893', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 1660000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB894', 'JP1', 'P894', TO_DATE('07/12/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB895', 'JP1', 'P895', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB896', 'JP1', 'P896', TO_DATE('08/12/2019', 'DD/MM/YYYY'), 108300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB897', 'JP1', 'P897', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB898', 'JP9', 'P898', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB899', 'JP4', 'P899', TO_DATE('09/12/2019', 'DD/MM/YYYY'), 7010000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB900', 'JP5', 'P900', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB901', 'JP4', 'P901', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB902', 'JP5', 'P902', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB903', 'JP8', 'P903', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 294750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB904', 'JP6', 'P904', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB905', 'JP4', 'P905', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 4200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB906', 'JP4', 'P906', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB907', 'JP3', 'P907', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB908', 'JP2', 'P908', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB909', 'JP1', 'P909', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB910', 'JP7', 'P910', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB911', 'JP5', 'P911', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB912', 'JP5', 'P912', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 14290000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB913', 'JP2', 'P913', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 525000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB914', 'JP1', 'P914', TO_DATE('10/12/2019', 'DD/MM/YYYY'), 4813750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB915', 'JP4', 'P915', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB916', 'JP2', 'P916', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB917', 'JP3', 'P917', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB918', 'JP1', 'P918', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB919', 'JP6', 'P919', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB920', 'JP1', 'P920', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 3300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB921', 'JP2', 'P921', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB922', 'JP5', 'P922', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB923', 'JP2', 'P923', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB924', 'JP4', 'P924', TO_DATE('11/12/2019', 'DD/MM/YYYY'), 11410000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB925', 'JP3', 'P925', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 240640000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB926', 'JP8', 'P926', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 520574000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB927', 'JP2', 'P927', TO_DATE('12/12/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB928', 'JP8', 'P928', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB929', 'JP4', 'P929', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB930', 'JP4', 'P930', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 341673000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB931', 'JP5', 'P931', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB932', 'JP5', 'P932', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB933', 'JP7', 'P933', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 19080000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB934', 'JP3', 'P934', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 2266352000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB935', 'JP1', 'P935', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 6645280000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB936', 'JP6', 'P936', TO_DATE('13/12/2019', 'DD/MM/YYYY'), 900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB937', 'JP8', 'P937', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB938', 'JP2', 'P938', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB939', 'JP4', 'P939', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB940', 'JP3', 'P940', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB941', 'JP7', 'P941', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 2575000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB942', 'JP1', 'P942', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB943', 'JP9', 'P943', TO_DATE('14/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB944', 'JP1', 'P944', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB945', 'JP3', 'P945', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB946', 'JP3', 'P946', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB947', 'JP8', 'P947', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB948', 'JP8', 'P948', TO_DATE('15/12/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB949', 'JP9', 'P949', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB950', 'JP1', 'P950', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB951', 'JP7', 'P951', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 264938000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB952', 'JP9', 'P952', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB953', 'JP7', 'P953', TO_DATE('16/12/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB954', 'JP4', 'P954', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB955', 'JP5', 'P955', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 1700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB956', 'JP5', 'P956', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 60820000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB957', 'JP6', 'P957', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1029360000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB958', 'JP5', 'P958', TO_DATE('20/12/2019', 'DD/MM/YYYY'), 2014760000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB959', 'JP1', 'P959', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB960', 'JP1', 'P960', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB961', 'JP3', 'P961', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 925000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB962', 'JP1', 'P962', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB963', 'JP5', 'P963', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB964', 'JP2', 'P964', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB965', 'JP1', 'P965', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB966', 'JP9', 'P966', TO_DATE('17/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB967', 'JP5', 'P967', TO_DATE('18/12/2019', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB968', 'JP5', 'P968', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 163046000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB969', 'JP2', 'P969', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB970', 'JP9', 'P970', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 1475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB971', 'JP1', 'P971', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 174370000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB972', 'JP6', 'P972', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB973', 'JP8', 'P973', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB974', 'JP8', 'P974', TO_DATE('20/12/2019', 'DD/MM/YYYY'), 436140000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB975', 'JP1', 'P975', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB976', 'JP4', 'P976', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 1500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB977', 'JP2', 'P977', TO_DATE('19/12/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB978', 'JP2', 'P978', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB979', 'JP8', 'P979', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1548200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB980', 'JP6', 'P980', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB981', 'JP4', 'P981', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB982', 'JP9', 'P982', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB983', 'JP8', 'P983', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1765072000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB984', 'JP7', 'P984', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB985', 'JP2', 'P985', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB986', 'JP4', 'P986', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 85500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB987', 'JP4', 'P987', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 528084000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB988', 'JP4', 'P988', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 282560000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB989', 'JP5', 'P989', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 209253000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB990', 'JP8', 'P990', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 2322874000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB991', 'JP4', 'P991', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 1350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB992', 'JP1', 'P992', TO_DATE('25/12/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB993', 'JP7', 'P993', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB994', 'JP3', 'P994', TO_DATE('21/12/2019', 'DD/MM/YYYY'), 173830000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB995', 'JP5', 'P995', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 69610000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB996', 'JP5', 'P996', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB997', 'JP3', 'P997', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 2840060000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB998', 'JP2', 'P998', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 22540000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB999', 'JP5', 'P999', TO_DATE('25/12/2019', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1000', 'JP1', 'P1000', TO_DATE('22/12/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1001', 'JP7', 'P1001', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1002', 'JP1', 'P1002', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 324005000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1003', 'JP2', 'P1003', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1004', 'JP2', 'P1004', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1005', 'JP2', 'P1005', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1006', 'JP6', 'P1006', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 197845000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1007', 'JP4', 'P1007', TO_DATE('24/12/2019', 'DD/MM/YYYY'), 812680000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1008', 'JP6', 'P1008', TO_DATE('23/12/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1009', 'JP6', 'P1009', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 150085000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1010', 'JP8', 'P1010', TO_DATE('28/12/2019', 'DD/MM/YYYY'), 100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1011', 'JP2', 'P1011', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 2020000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1012', 'JP8', 'P1012', TO_DATE('28/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1013', 'JP1', 'P1013', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1014', 'JP9', 'P1014', TO_DATE('25/12/2019', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1015', 'JP5', 'P1015', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 5100000, 'LUNAS'  FROM dual;

INSERT INTO PEMBAYARAN (ID_PEMBAYARAN, ID_JENIS_PEMBAYARAN, ID_PESANAN, TANGGAL_PEMBAYARAN, JUMLAH_PEMBAYARAN, KEPERLUAN_PEMBAYARAN)  
  select 'PB1016', 'JP3', 'P1016', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 1700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1017', 'JP6', 'P1017', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 1550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1018', 'JP7', 'P1018', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 664967500, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1019', 'JP9', 'P1019', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1020', 'JP9', 'P1020', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1021', 'JP2', 'P1021', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1022', 'JP7', 'P1022', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 492640000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1023', 'JP6', 'P1023', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 50010000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1024', 'JP4', 'P1024', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 941575000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1025', 'JP2', 'P1025', TO_DATE('26/12/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1026', 'JP3', 'P1026', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 11730000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1027', 'JP7', 'P1027', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1028', 'JP1', 'P1028', TO_DATE('27/12/2019', 'DD/MM/YYYY'), 12540000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1029', 'JP8', 'P1029', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1030', 'JP6', 'P1030', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1031', 'JP6', 'P1031', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 7251326000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1032', 'JP2', 'P1032', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1033', 'JP6', 'P1033', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1034', 'JP4', 'P1034', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1035', 'JP2', 'P1035', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 614344000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1036', 'JP2', 'P1036', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1037', 'JP3', 'P1037', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 26000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1038', 'JP3', 'P1038', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1039', 'JP2', 'P1039', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 26500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1040', 'JP4', 'P1040', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1041', 'JP3', 'P1041', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1042', 'JP4', 'P1042', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1043', 'JP5', 'P1043', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 388960000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1044', 'JP4', 'P1044', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 4889760000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1045', 'JP7', 'P1045', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1046', 'JP4', 'P1046', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1047', 'JP3', 'P1047', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1048', 'JP9', 'P1048', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1049', 'JP5', 'P1049', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 4155080000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1050', 'JP7', 'P1050', TO_DATE('29/12/2019', 'DD/MM/YYYY'), 2350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1051', 'JP4', 'P1051', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 699108000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1052', 'JP9', 'P1052', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1053', 'JP7', 'P1053', TO_DATE('30/12/2019', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1054', 'JP5', 'P1054', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 62470000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1055', 'JP9', 'P1055', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 475000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1056', 'JP3', 'P1056', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1057', 'JP9', 'P1057', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1058', 'JP6', 'P1058', TO_DATE('31/12/2019', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1059', 'JP7', 'P1059', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 18070000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1060', 'JP2', 'P1060', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1061', 'JP6', 'P1061', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1062', 'JP6', 'P1062', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 83948000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1063', 'JP6', 'P1063', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 2100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1064', 'JP3', 'P1064', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1065', 'JP4', 'P1065', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 3350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1066', 'JP9', 'P1066', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 3112606000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1067', 'JP5', 'P1067', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1068', 'JP7', 'P1068', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 800000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1069', 'JP6', 'P1069', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1070', 'JP8', 'P1070', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 413525000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1071', 'JP7', 'P1071', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1072', 'JP4', 'P1072', TO_DATE('02/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1073', 'JP5', 'P1073', TO_DATE('02/01/2020', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1074', 'JP1', 'P1074', TO_DATE('03/01/2020', 'DD/MM/YYYY'), 1600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1075', 'JP3', 'P1075', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 725000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1076', 'JP2', 'P1076', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 2350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1077', 'JP9', 'P1077', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1078', 'JP6', 'P1078', TO_DATE('03/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1079', 'JP8', 'P1079', TO_DATE('03/01/2020', 'DD/MM/YYYY'), 22016000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1080', 'JP2', 'P1080', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1081', 'JP9', 'P1081', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 3350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1082', 'JP7', 'P1082', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1083', 'JP5', 'P1083', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1084', 'JP6', 'P1084', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1085', 'JP7', 'P1085', TO_DATE('07/01/2020', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1086', 'JP9', 'P1086', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1087', 'JP4', 'P1087', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 6020000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1088', 'JP7', 'P1088', TO_DATE('07/01/2020', 'DD/MM/YYYY'), 2465060000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1089', 'JP7', 'P1089', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1090', 'JP4', 'P1090', TO_DATE('04/01/2020', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1091', 'JP6', 'P1091', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 1250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1092', 'JP3', 'P1092', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1093', 'JP1', 'P1093', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1094', 'JP1', 'P1094', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1095', 'JP5', 'P1095', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1096', 'JP2', 'P1096', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1097', 'JP4', 'P1097', TO_DATE('05/01/2020', 'DD/MM/YYYY'), 3050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1098', 'JP8', 'P1098', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1099', 'JP6', 'P1099', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1100', 'JP6', 'P1100', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1101', 'JP5', 'P1101', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 650000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1102', 'JP4', 'P1102', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1103', 'JP3', 'P1103', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1104', 'JP6', 'P1104', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1105', 'JP9', 'P1105', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 975000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1106', 'JP9', 'P1106', TO_DATE('06/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1107', 'JP2', 'P1107', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1108', 'JP3', 'P1108', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 2350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1109', 'JP6', 'P1109', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1110', 'JP5', 'P1110', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1111', 'JP5', 'P1111', TO_DATE('07/01/2020', 'DD/MM/YYYY'), 15880000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1112', 'JP3', 'P1112', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 699752500, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1113', 'JP5', 'P1113', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 2150000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1114', 'JP8', 'P1114', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1115', 'JP8', 'P1115', TO_DATE('08/01/2020', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1116', 'JP6', 'P1116', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1117', 'JP1', 'P1117', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 1500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1118', 'JP1', 'P1118', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1119', 'JP8', 'P1119', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 3050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1120', 'JP4', 'P1120', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1121', 'JP1', 'P1121', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1122', 'JP9', 'P1122', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 750000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1123', 'JP4', 'P1123', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1124', 'JP2', 'P1124', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1125', 'JP1', 'P1125', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 4060000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1126', 'JP5', 'P1126', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 384530000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1127', 'JP8', 'P1127', TO_DATE('09/01/2020', 'DD/MM/YYYY'), 400000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1128', 'JP4', 'P1128', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 2671260000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1129', 'JP5', 'P1129', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 2575000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1130', 'JP5', 'P1130', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1131', 'JP6', 'P1131', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1132', 'JP3', 'P1132', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 74630000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1133', 'JP6', 'P1133', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1134', 'JP6', 'P1134', TO_DATE('10/01/2020', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1135', 'JP1', 'P1135', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1136', 'JP6', 'P1136', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1137', 'JP9', 'P1137', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1138', 'JP9', 'P1138', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1139', 'JP9', 'P1139', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1140', 'JP1', 'P1140', TO_DATE('11/01/2020', 'DD/MM/YYYY'), 663020000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1141', 'JP3', 'P1141', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 1200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1142', 'JP9', 'P1142', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 2200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1143', 'JP5', 'P1143', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 440974000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1144', 'JP3', 'P1144', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1145', 'JP7', 'P1145', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 2585138000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1146', 'JP4', 'P1146', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 525000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1147', 'JP8', 'P1147', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1148', 'JP7', 'P1148', TO_DATE('13/01/2020', 'DD/MM/YYYY'), 1633550000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1149', 'JP5', 'P1149', TO_DATE('14/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1150', 'JP1', 'P1150', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 1037270000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1151', 'JP8', 'P1151', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 850000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1152', 'JP4', 'P1152', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1153', 'JP3', 'P1153', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 4360000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1154', 'JP8', 'P1154', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 32900000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1155', 'JP6', 'P1155', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 870485000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1156', 'JP1', 'P1156', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 6885440000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1157', 'JP9', 'P1157', TO_DATE('18/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1158', 'JP9', 'P1158', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1159', 'JP8', 'P1159', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 32150000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1160', 'JP8', 'P1160', TO_DATE('18/01/2020', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1161', 'JP8', 'P1161', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1162', 'JP8', 'P1162', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1163', 'JP5', 'P1163', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 700000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1164', 'JP5', 'P1164', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1165', 'JP5', 'P1165', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1166', 'JP1', 'P1166', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 897614000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1167', 'JP1', 'P1167', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 641228000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1168', 'JP1', 'P1168', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 23600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1169', 'JP7', 'P1169', TO_DATE('15/01/2020', 'DD/MM/YYYY'), 11530000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1170', 'JP1', 'P1170', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1171', 'JP7', 'P1171', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 200000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1172', 'JP6', 'P1172', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 2450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1173', 'JP1', 'P1173', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 4000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1174', 'JP9', 'P1174', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 12130000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1175', 'JP5', 'P1175', TO_DATE('16/01/2020', 'DD/MM/YYYY'), 190960000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1176', 'JP6', 'P1176', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 8874998000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1177', 'JP7', 'P1177', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1178', 'JP6', 'P1178', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 4431100000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1179', 'JP5', 'P1179', TO_DATE('17/01/2020', 'DD/MM/YYYY'), 675000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1180', 'JP4', 'P1180', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1181', 'JP9', 'P1181', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1182', 'JP9', 'P1182', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 11061300000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1183', 'JP7', 'P1183', TO_DATE('18/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1184', 'JP8', 'P1184', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1185', 'JP3', 'P1185', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1186', 'JP1', 'P1186', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 1000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1187', 'JP1', 'P1187', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 62676000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1188', 'JP4', 'P1188', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 3000000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1189', 'JP4', 'P1189', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 4720000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1190', 'JP2', 'P1190', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 950000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1191', 'JP1', 'P1191', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 450000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1192', 'JP9', 'P1192', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1193', 'JP8', 'P1193', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 250000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1194', 'JP6', 'P1194', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1195', 'JP4', 'P1195', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 2600000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1196', 'JP8', 'P1196', TO_DATE('19/01/2020', 'DD/MM/YYYY'), 350000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1197', 'JP1', 'P1197', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1198', 'JP7', 'P1198', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 500000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1199', 'JP7', 'P1199', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 1050000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1200', 'JP8', 'P1200', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 50000, 'LUNAS'  FROM dual UNION ALL 
  select 'PB1201', 'JP3', 'P1201', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 150000, 'DP'  FROM dual UNION ALL 
  select 'PB1202', 'JP5', 'P1202', TO_DATE('20/01/2020', 'DD/MM/YYYY'), 302282000, 'DP'  FROM dual UNION ALL 
  select 'PB1203', 'JP5', 'P1203', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 250000, 'DP'  FROM dual UNION ALL 
  select 'PB1204', 'JP4', 'P1204', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 3317130000, 'DP'  FROM dual UNION ALL 
  select 'PB1205', 'JP2', 'P1205', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 175000, 'DP'  FROM dual UNION ALL 
  select 'PB1206', 'JP1', 'P1206', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 1514212500, 'DP'  FROM dual UNION ALL 
  select 'PB1207', 'JP7', 'P1207', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 485380000, 'DP'  FROM dual UNION ALL 
  select 'PB1208', 'JP6', 'P1208', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 400000, 'DP'  FROM dual UNION ALL 
  select 'PB1209', 'JP6', 'P1209', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 650000, 'DP'  FROM dual UNION ALL 
  select 'PB1210', 'JP4', 'P1210', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 275000, 'DP'  FROM dual UNION ALL 
  select 'PB1211', 'JP4', 'P1211', TO_DATE('21/01/2020', 'DD/MM/YYYY'), 376530000, 'DP'  FROM dual UNION ALL 
  select 'PB1212', 'JP4', 'P1212', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 150000, 'DP'  FROM dual UNION ALL 
  select 'PB1213', 'JP7', 'P1213', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 1148899500, 'DP'  FROM dual UNION ALL 
  select 'PB1214', 'JP1', 'P1214', TO_DATE('22/01/2020', 'DD/MM/YYYY'), 1772700000, 'DP'  FROM dual UNION ALL 
  select 'PB1215', 'JP4', 'P1215', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 200000, 'DP'  FROM dual UNION ALL 
  select 'PB1216', 'JP6', 'P1216', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 330810000, 'DP'  FROM dual UNION ALL 
  select 'PB1217', 'JP3', 'P1217', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 300000, 'DP'  FROM dual UNION ALL 
  select 'PB1218', 'JP9', 'P1218', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 400000, 'DP'  FROM dual UNION ALL 
  select 'PB1219', 'JP4', 'P1219', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 600000, 'DP'  FROM dual UNION ALL 
  select 'PB1220', 'JP3', 'P1220', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 1100000, 'DP'  FROM dual UNION ALL 
  select 'PB1221', 'JP9', 'P1221', TO_DATE('23/01/2020', 'DD/MM/YYYY'), 646600000, 'DP'  FROM dual UNION ALL 
  select 'PB1222', 'JP3', 'P1222', TO_DATE('25/01/2020', 'DD/MM/YYYY'), 100000, 'DP'  FROM dual UNION ALL 
  select 'PB1223', 'JP3', 'P1223', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 1050000, 'DP'  FROM dual UNION ALL 
  select 'PB1224', 'JP6', 'P1224', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 100000, 'DP'  FROM dual UNION ALL 
  select 'PB1225', 'JP4', 'P1225', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 150000, 'DP'  FROM dual UNION ALL 
  select 'PB1226', 'JP1', 'P1226', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 225000, 'DP'  FROM dual UNION ALL 
  select 'PB1227', 'JP1', 'P1227', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 412500, 'DP'  FROM dual UNION ALL 
  select 'PB1228', 'JP2', 'P1228', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 1975022500, 'DP'  FROM dual UNION ALL 
  select 'PB1229', 'JP1', 'P1229', TO_DATE('24/01/2020', 'DD/MM/YYYY'), 1040000, 'DP'  FROM dual UNION ALL 
  select 'PB1230', 'JP6', 'P1230', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 2087445000, 'DP'  FROM dual UNION ALL 
  select 'PB1231', 'JP5', 'P1231', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 225000, 'DP'  FROM dual UNION ALL 
  select 'PB1232', 'JP9', 'P1232', TO_DATE('25/01/2020', 'DD/MM/YYYY'), 228635000, 'DP'  FROM dual UNION ALL 
  select 'PB1233', 'JP5', 'P1233', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 250000, 'DP'  FROM dual UNION ALL 
  select 'PB1234', 'JP4', 'P1234', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 355162000, 'DP'  FROM dual UNION ALL 
  select 'PB1235', 'JP9', 'P1235', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 737500, 'DP'  FROM dual UNION ALL 
  select 'PB1236', 'JP6', 'P1236', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 275000, 'DP'  FROM dual UNION ALL 
  select 'PB1237', 'JP3', 'P1237', TO_DATE('25/01/2020', 'DD/MM/YYYY'), 175000, 'DP'  FROM dual UNION ALL 
  select 'PB1238', 'JP3', 'P1238', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 250000, 'DP'  FROM dual UNION ALL 
  select 'PB1239', 'JP4', 'P1239', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 300000, 'DP'  FROM dual UNION ALL 
  select 'PB1240', 'JP4', 'P1240', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 348840000, 'DP'  FROM dual UNION ALL 
  select 'PB1241', 'JP9', 'P1241', TO_DATE('26/01/2020', 'DD/MM/YYYY'), 425000, 'DP'  FROM dual UNION ALL 
  select 'PB1242', 'JP8', 'P1242', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 92692000, 'DP'  FROM dual UNION ALL 
  select 'PB1243', 'JP7', 'P1243', TO_DATE('27/01/2020', 'DD/MM/YYYY'), 170291500, 'DP'  FROM dual UNION ALL 
  select 'PB1244', 'JP3', 'P1244', TO_DATE('30/01/2020', 'DD/MM/YYYY'), 200000, 'DP'  FROM dual UNION ALL 
  select 'PB1245', 'JP4', 'P1245', TO_DATE('30/01/2020', 'DD/MM/YYYY'), 600000, 'DP'  FROM dual UNION ALL 
  select 'PB1246', 'JP3', 'P1246', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 325000, 'DP'  FROM dual UNION ALL 
  select 'PB1247', 'JP7', 'P1247', TO_DATE('29/01/2020', 'DD/MM/YYYY'), 200000, 'DP'  FROM dual UNION ALL 
  select 'PB1248', 'JP2', 'P1248', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 425000, 'DP'  FROM dual UNION ALL 
  select 'PB1249', 'JP8', 'P1249', TO_DATE('28/01/2020', 'DD/MM/YYYY'), 25000, 'DP'  FROM dual UNION ALL 
  select 'PB1250', 'JP3', 'P1250', TO_DATE('30/01/2020', 'DD/MM/YYYY'), 460000, 'DP'  FROM dual;

INSERT INTO PENGIRIMAN (ID_PENGIRIMAN, ID_PESANAN, ID_EKSPEDISI, TANGGAL_MENGIRIM, KODE_RESI) 
  select 'PG1','P1','JE5',TO_DATE('08/08/2019', 'DD/MM/YYYY'),'5201908081'  FROM dual UNION ALL 
  select 'PG2','P2','JE5',TO_DATE('08/08/2019', 'DD/MM/YYYY'),'5201908082'  FROM dual UNION ALL 
  select 'PG3','P3','JE2',TO_DATE('08/08/2019', 'DD/MM/YYYY'),'2201908083'  FROM dual UNION ALL 
  select 'PG4','P4','JE1',TO_DATE('08/08/2019', 'DD/MM/YYYY'),'1201908084'  FROM dual UNION ALL 
  select 'PG5','P5','JE6',TO_DATE('08/08/2019', 'DD/MM/YYYY'),'6201908085'  FROM dual UNION ALL 
  select 'PG6','P6','JE5',TO_DATE('08/08/2019', 'DD/MM/YYYY'),'5201908086'  FROM dual UNION ALL 
  select 'PG7','P7','JE1',TO_DATE('08/08/2019', 'DD/MM/YYYY'),'1201908087'  FROM dual UNION ALL 
  select 'PG8','P8','JE5',TO_DATE('09/08/2019', 'DD/MM/YYYY'),'5201908091'  FROM dual UNION ALL 
  select 'PG9','P9','JE1',TO_DATE('09/08/2019', 'DD/MM/YYYY'),'1201908092'  FROM dual UNION ALL 
  select 'PG10','P10','JE6',TO_DATE('09/08/2019', 'DD/MM/YYYY'),'6201908093'  FROM dual UNION ALL 
  select 'PG11','P11','JE3',TO_DATE('09/08/2019', 'DD/MM/YYYY'),'3201908094'  FROM dual UNION ALL 
  select 'PG12','P12','JE7',TO_DATE('09/08/2019', 'DD/MM/YYYY'),'7201908095'  FROM dual UNION ALL 
  select 'PG13','P13','JE4',TO_DATE('09/08/2019', 'DD/MM/YYYY'),'4201908096'  FROM dual UNION ALL 
  select 'PG14','P14','JE5',TO_DATE('09/08/2019', 'DD/MM/YYYY'),'5201908097'  FROM dual UNION ALL 
  select 'PG15','P15','JE2',TO_DATE('10/08/2019', 'DD/MM/YYYY'),'2201908101'  FROM dual UNION ALL 
  select 'PG16','P16','JE5',TO_DATE('10/08/2019', 'DD/MM/YYYY'),'5201908102'  FROM dual UNION ALL 
  select 'PG17','P17','JE1',TO_DATE('10/08/2019', 'DD/MM/YYYY'),'1201908103'  FROM dual UNION ALL 
  select 'PG18','P18','JE3',TO_DATE('10/08/2019', 'DD/MM/YYYY'),'3201908104'  FROM dual UNION ALL 
  select 'PG19','P19','JE5',TO_DATE('10/08/2019', 'DD/MM/YYYY'),'5201908105'  FROM dual UNION ALL 
  select 'PG20','P20','JE2',TO_DATE('10/08/2019', 'DD/MM/YYYY'),'2201908106'  FROM dual UNION ALL 
  select 'PG21','P21','JE6',TO_DATE('10/08/2019', 'DD/MM/YYYY'),'6201908107'  FROM dual UNION ALL 
  select 'PG22','P22','JE3',TO_DATE('11/08/2019', 'DD/MM/YYYY'),'3201908111'  FROM dual UNION ALL 
  select 'PG23','P23','JE6',TO_DATE('11/08/2019', 'DD/MM/YYYY'),'6201908112'  FROM dual UNION ALL 
  select 'PG24','P24','JE1',TO_DATE('11/08/2019', 'DD/MM/YYYY'),'1201908113'  FROM dual UNION ALL 
  select 'PG25','P25','JE4',TO_DATE('11/08/2019', 'DD/MM/YYYY'),'4201908114'  FROM dual UNION ALL 
  select 'PG26','P26','JE6',TO_DATE('11/08/2019', 'DD/MM/YYYY'),'6201908115'  FROM dual UNION ALL 
  select 'PG27','P27','JE5',TO_DATE('11/08/2019', 'DD/MM/YYYY'),'5201908116'  FROM dual UNION ALL 
  select 'PG28','P28','JE1',TO_DATE('11/08/2019', 'DD/MM/YYYY'),'1201908117'  FROM dual UNION ALL 
  select 'PG29','P29','JE4',TO_DATE('12/08/2019', 'DD/MM/YYYY'),'4201908121'  FROM dual UNION ALL 
  select 'PG30','P30','JE1',TO_DATE('12/08/2019', 'DD/MM/YYYY'),'1201908122'  FROM dual UNION ALL 
  select 'PG31','P31','JE1',TO_DATE('12/08/2019', 'DD/MM/YYYY'),'1201908123'  FROM dual UNION ALL 
  select 'PG32','P32','JE2',TO_DATE('12/08/2019', 'DD/MM/YYYY'),'2201908124'  FROM dual UNION ALL 
  select 'PG33','P33','JE7',TO_DATE('12/08/2019', 'DD/MM/YYYY'),'7201908125'  FROM dual UNION ALL 
  select 'PG34','P34','JE3',TO_DATE('12/08/2019', 'DD/MM/YYYY'),'3201908126'  FROM dual UNION ALL 
  select 'PG35','P35','JE7',TO_DATE('12/08/2019', 'DD/MM/YYYY'),'7201908127'  FROM dual UNION ALL 
  select 'PG36','P36','JE7',TO_DATE('13/08/2019', 'DD/MM/YYYY'),'7201908131'  FROM dual UNION ALL 
  select 'PG37','P37','JE3',TO_DATE('13/08/2019', 'DD/MM/YYYY'),'3201908132'  FROM dual UNION ALL 
  select 'PG38','P38','JE1',TO_DATE('13/08/2019', 'DD/MM/YYYY'),'1201908133'  FROM dual UNION ALL 
  select 'PG39','P39','JE6',TO_DATE('13/08/2019', 'DD/MM/YYYY'),'6201908134'  FROM dual UNION ALL 
  select 'PG40','P40','JE7',TO_DATE('13/08/2019', 'DD/MM/YYYY'),'7201908135'  FROM dual UNION ALL 
  select 'PG41','P41','JE6',TO_DATE('13/08/2019', 'DD/MM/YYYY'),'6201908136'  FROM dual UNION ALL 
  select 'PG42','P42','JE2',TO_DATE('13/08/2019', 'DD/MM/YYYY'),'2201908137'  FROM dual UNION ALL 
  select 'PG43','P43','JE6',TO_DATE('14/08/2019', 'DD/MM/YYYY'),'6201908141'  FROM dual UNION ALL 
  select 'PG44','P44','JE4',TO_DATE('14/08/2019', 'DD/MM/YYYY'),'4201908142'  FROM dual UNION ALL 
  select 'PG45','P45','JE3',TO_DATE('14/08/2019', 'DD/MM/YYYY'),'3201908143'  FROM dual UNION ALL 
  select 'PG46','P46','JE7',TO_DATE('14/08/2019', 'DD/MM/YYYY'),'7201908144'  FROM dual UNION ALL 
  select 'PG47','P47','JE1',TO_DATE('14/08/2019', 'DD/MM/YYYY'),'1201908145'  FROM dual UNION ALL 
  select 'PG48','P48','JE4',TO_DATE('14/08/2019', 'DD/MM/YYYY'),'4201908146'  FROM dual UNION ALL 
  select 'PG49','P49','JE3',TO_DATE('14/08/2019', 'DD/MM/YYYY'),'3201908147'  FROM dual UNION ALL 
  select 'PG50','P50','JE6',TO_DATE('15/08/2019', 'DD/MM/YYYY'),'6201908151'  FROM dual UNION ALL 
  select 'PG51','P51','JE3',TO_DATE('15/08/2019', 'DD/MM/YYYY'),'3201908152'  FROM dual UNION ALL 
  select 'PG52','P52','JE1',TO_DATE('15/08/2019', 'DD/MM/YYYY'),'1201908153'  FROM dual UNION ALL 
  select 'PG53','P53','JE2',TO_DATE('15/08/2019', 'DD/MM/YYYY'),'2201908154'  FROM dual UNION ALL 
  select 'PG54','P54','JE4',TO_DATE('15/08/2019', 'DD/MM/YYYY'),'4201908155'  FROM dual UNION ALL 
  select 'PG55','P55','JE2',TO_DATE('15/08/2019', 'DD/MM/YYYY'),'2201908156'  FROM dual UNION ALL 
  select 'PG56','P56','JE2',TO_DATE('15/08/2019', 'DD/MM/YYYY'),'2201908157'  FROM dual UNION ALL 
  select 'PG57','P57','JE3',TO_DATE('16/08/2019', 'DD/MM/YYYY'),'3201908161'  FROM dual UNION ALL 
  select 'PG58','P58','JE2',TO_DATE('16/08/2019', 'DD/MM/YYYY'),'2201908162'  FROM dual UNION ALL 
  select 'PG59','P59','JE2',TO_DATE('16/08/2019', 'DD/MM/YYYY'),'2201908163'  FROM dual UNION ALL 
  select 'PG60','P60','JE2',TO_DATE('16/08/2019', 'DD/MM/YYYY'),'2201908164'  FROM dual UNION ALL 
  select 'PG61','P61','JE5',TO_DATE('16/08/2019', 'DD/MM/YYYY'),'5201908165'  FROM dual UNION ALL 
  select 'PG62','P62','JE2',TO_DATE('16/08/2019', 'DD/MM/YYYY'),'2201908166'  FROM dual UNION ALL 
  select 'PG63','P63','JE2',TO_DATE('16/08/2019', 'DD/MM/YYYY'),'2201908167'  FROM dual UNION ALL 
  select 'PG64','P64','JE3',TO_DATE('17/08/2019', 'DD/MM/YYYY'),'3201908171'  FROM dual UNION ALL 
  select 'PG65','P65','JE6',TO_DATE('17/08/2019', 'DD/MM/YYYY'),'6201908172'  FROM dual UNION ALL 
  select 'PG66','P66','JE6',TO_DATE('17/08/2019', 'DD/MM/YYYY'),'6201908173'  FROM dual UNION ALL 
  select 'PG67','P67','JE5',TO_DATE('17/08/2019', 'DD/MM/YYYY'),'5201908174'  FROM dual UNION ALL 
  select 'PG68','P68','JE7',TO_DATE('17/08/2019', 'DD/MM/YYYY'),'7201908175'  FROM dual UNION ALL 
  select 'PG69','P69','JE3',TO_DATE('17/08/2019', 'DD/MM/YYYY'),'3201908176'  FROM dual UNION ALL 
  select 'PG70','P70','JE7',TO_DATE('17/08/2019', 'DD/MM/YYYY'),'7201908177'  FROM dual UNION ALL 
  select 'PG71','P71','JE3',TO_DATE('18/08/2019', 'DD/MM/YYYY'),'3201908181'  FROM dual UNION ALL 
  select 'PG72','P72','JE7',TO_DATE('18/08/2019', 'DD/MM/YYYY'),'7201908182'  FROM dual UNION ALL 
  select 'PG73','P73','JE3',TO_DATE('18/08/2019', 'DD/MM/YYYY'),'3201908183'  FROM dual UNION ALL 
  select 'PG74','P74','JE4',TO_DATE('18/08/2019', 'DD/MM/YYYY'),'4201908184'  FROM dual UNION ALL 
  select 'PG75','P75','JE7',TO_DATE('18/08/2019', 'DD/MM/YYYY'),'7201908185'  FROM dual UNION ALL 
  select 'PG76','P76','JE2',TO_DATE('18/08/2019', 'DD/MM/YYYY'),'2201908186'  FROM dual UNION ALL 
  select 'PG77','P77','JE5',TO_DATE('18/08/2019', 'DD/MM/YYYY'),'5201908187'  FROM dual UNION ALL 
  select 'PG78','P78','JE2',TO_DATE('19/08/2019', 'DD/MM/YYYY'),'2201908191'  FROM dual UNION ALL 
  select 'PG79','P79','JE5',TO_DATE('19/08/2019', 'DD/MM/YYYY'),'5201908192'  FROM dual UNION ALL 
  select 'PG80','P80','JE6',TO_DATE('19/08/2019', 'DD/MM/YYYY'),'6201908193'  FROM dual UNION ALL 
  select 'PG81','P81','JE6',TO_DATE('19/08/2019', 'DD/MM/YYYY'),'6201908194'  FROM dual UNION ALL 
  select 'PG82','P82','JE3',TO_DATE('19/08/2019', 'DD/MM/YYYY'),'3201908195'  FROM dual UNION ALL 
  select 'PG83','P83','JE3',TO_DATE('19/08/2019', 'DD/MM/YYYY'),'3201908196'  FROM dual UNION ALL 
  select 'PG84','P84','JE1',TO_DATE('19/08/2019', 'DD/MM/YYYY'),'1201908197'  FROM dual UNION ALL 
  select 'PG85','P85','JE1',TO_DATE('20/08/2019', 'DD/MM/YYYY'),'1201908201'  FROM dual UNION ALL 
  select 'PG86','P86','JE4',TO_DATE('20/08/2019', 'DD/MM/YYYY'),'4201908202'  FROM dual UNION ALL 
  select 'PG87','P87','JE5',TO_DATE('20/08/2019', 'DD/MM/YYYY'),'5201908203'  FROM dual UNION ALL 
  select 'PG88','P88','JE6',TO_DATE('20/08/2019', 'DD/MM/YYYY'),'6201908204'  FROM dual UNION ALL 
  select 'PG89','P89','JE1',TO_DATE('20/08/2019', 'DD/MM/YYYY'),'1201908205'  FROM dual UNION ALL 
  select 'PG90','P90','JE4',TO_DATE('20/08/2019', 'DD/MM/YYYY'),'4201908206'  FROM dual UNION ALL 
  select 'PG91','P91','JE6',TO_DATE('20/08/2019', 'DD/MM/YYYY'),'6201908207'  FROM dual UNION ALL 
  select 'PG92','P92','JE2',TO_DATE('21/08/2019', 'DD/MM/YYYY'),'2201908211'  FROM dual UNION ALL 
  select 'PG93','P93','JE3',TO_DATE('21/08/2019', 'DD/MM/YYYY'),'3201908212'  FROM dual UNION ALL 
  select 'PG94','P94','JE5',TO_DATE('21/08/2019', 'DD/MM/YYYY'),'5201908213'  FROM dual UNION ALL 
  select 'PG95','P95','JE6',TO_DATE('21/08/2019', 'DD/MM/YYYY'),'6201908214'  FROM dual UNION ALL 
  select 'PG96','P96','JE6',TO_DATE('21/08/2019', 'DD/MM/YYYY'),'6201908215'  FROM dual UNION ALL 
  select 'PG97','P97','JE6',TO_DATE('21/08/2019', 'DD/MM/YYYY'),'6201908216'  FROM dual UNION ALL 
  select 'PG98','P98','JE2',TO_DATE('21/08/2019', 'DD/MM/YYYY'),'2201908217'  FROM dual UNION ALL 
  select 'PG99','P99','JE2',TO_DATE('22/08/2019', 'DD/MM/YYYY'),'2201908221'  FROM dual UNION ALL 
  select 'PG100','P100','JE2',TO_DATE('22/08/2019', 'DD/MM/YYYY'),'2201908222'  FROM dual UNION ALL 
  select 'PG101','P101','JE1',TO_DATE('22/08/2019', 'DD/MM/YYYY'),'1201908223'  FROM dual UNION ALL 
  select 'PG102','P102','JE7',TO_DATE('22/08/2019', 'DD/MM/YYYY'),'7201908224'  FROM dual UNION ALL 
  select 'PG103','P103','JE4',TO_DATE('22/08/2019', 'DD/MM/YYYY'),'4201908225'  FROM dual UNION ALL 
  select 'PG104','P104','JE3',TO_DATE('22/08/2019', 'DD/MM/YYYY'),'3201908226'  FROM dual UNION ALL 
  select 'PG105','P105','JE6',TO_DATE('22/08/2019', 'DD/MM/YYYY'),'6201908227'  FROM dual UNION ALL 
  select 'PG106','P106','JE4',TO_DATE('23/08/2019', 'DD/MM/YYYY'),'4201908231'  FROM dual UNION ALL 
  select 'PG107','P107','JE5',TO_DATE('23/08/2019', 'DD/MM/YYYY'),'5201908232'  FROM dual UNION ALL 
  select 'PG108','P108','JE6',TO_DATE('23/08/2019', 'DD/MM/YYYY'),'6201908233'  FROM dual UNION ALL 
  select 'PG109','P109','JE4',TO_DATE('23/08/2019', 'DD/MM/YYYY'),'4201908234'  FROM dual UNION ALL 
  select 'PG110','P110','JE1',TO_DATE('23/08/2019', 'DD/MM/YYYY'),'1201908235'  FROM dual UNION ALL 
  select 'PG111','P111','JE3',TO_DATE('23/08/2019', 'DD/MM/YYYY'),'3201908236'  FROM dual UNION ALL 
  select 'PG112','P112','JE1',TO_DATE('23/08/2019', 'DD/MM/YYYY'),'1201908237'  FROM dual UNION ALL 
  select 'PG113','P113','JE1',TO_DATE('24/08/2019', 'DD/MM/YYYY'),'1201908241'  FROM dual UNION ALL 
  select 'PG114','P114','JE7',TO_DATE('24/08/2019', 'DD/MM/YYYY'),'7201908242'  FROM dual UNION ALL 
  select 'PG115','P115','JE4',TO_DATE('24/08/2019', 'DD/MM/YYYY'),'4201908243'  FROM dual UNION ALL 
  select 'PG116','P116','JE1',TO_DATE('24/08/2019', 'DD/MM/YYYY'),'1201908244'  FROM dual UNION ALL 
  select 'PG117','P117','JE6',TO_DATE('24/08/2019', 'DD/MM/YYYY'),'6201908245'  FROM dual UNION ALL 
  select 'PG118','P118','JE7',TO_DATE('24/08/2019', 'DD/MM/YYYY'),'7201908246'  FROM dual UNION ALL 
  select 'PG119','P119','JE5',TO_DATE('24/08/2019', 'DD/MM/YYYY'),'5201908247'  FROM dual UNION ALL 
  select 'PG120','P120','JE2',TO_DATE('25/08/2019', 'DD/MM/YYYY'),'2201908251'  FROM dual UNION ALL 
  select 'PG121','P121','JE6',TO_DATE('25/08/2019', 'DD/MM/YYYY'),'6201908252'  FROM dual UNION ALL 
  select 'PG122','P122','JE5',TO_DATE('25/08/2019', 'DD/MM/YYYY'),'5201908253'  FROM dual UNION ALL 
  select 'PG123','P123','JE1',TO_DATE('25/08/2019', 'DD/MM/YYYY'),'1201908254'  FROM dual UNION ALL 
  select 'PG124','P124','JE5',TO_DATE('25/08/2019', 'DD/MM/YYYY'),'5201908255'  FROM dual UNION ALL 
  select 'PG125','P125','JE3',TO_DATE('25/08/2019', 'DD/MM/YYYY'),'3201908256'  FROM dual UNION ALL 
  select 'PG126','P126','JE2',TO_DATE('25/08/2019', 'DD/MM/YYYY'),'2201908257'  FROM dual UNION ALL 
  select 'PG127','P127','JE5',TO_DATE('26/08/2019', 'DD/MM/YYYY'),'5201908261'  FROM dual UNION ALL 
  select 'PG128','P128','JE3',TO_DATE('26/08/2019', 'DD/MM/YYYY'),'3201908262'  FROM dual UNION ALL 
  select 'PG129','P129','JE5',TO_DATE('26/08/2019', 'DD/MM/YYYY'),'5201908263'  FROM dual UNION ALL 
  select 'PG130','P130','JE7',TO_DATE('26/08/2019', 'DD/MM/YYYY'),'7201908264'  FROM dual UNION ALL 
  select 'PG131','P131','JE2',TO_DATE('26/08/2019', 'DD/MM/YYYY'),'2201908265'  FROM dual UNION ALL 
  select 'PG132','P132','JE7',TO_DATE('26/08/2019', 'DD/MM/YYYY'),'7201908266'  FROM dual UNION ALL 
  select 'PG133','P133','JE6',TO_DATE('26/08/2019', 'DD/MM/YYYY'),'6201908267'  FROM dual UNION ALL 
  select 'PG134','P134','JE3',TO_DATE('27/08/2019', 'DD/MM/YYYY'),'3201908271'  FROM dual UNION ALL 
  select 'PG135','P135','JE4',TO_DATE('27/08/2019', 'DD/MM/YYYY'),'4201908272'  FROM dual UNION ALL 
  select 'PG136','P136','JE6',TO_DATE('27/08/2019', 'DD/MM/YYYY'),'6201908273'  FROM dual UNION ALL 
  select 'PG137','P137','JE5',TO_DATE('27/08/2019', 'DD/MM/YYYY'),'5201908274'  FROM dual UNION ALL 
  select 'PG138','P138','JE3',TO_DATE('27/08/2019', 'DD/MM/YYYY'),'3201908275'  FROM dual UNION ALL 
  select 'PG139','P139','JE2',TO_DATE('27/08/2019', 'DD/MM/YYYY'),'2201908276'  FROM dual UNION ALL 
  select 'PG140','P140','JE4',TO_DATE('27/08/2019', 'DD/MM/YYYY'),'4201908277'  FROM dual UNION ALL 
  select 'PG141','P141','JE1',TO_DATE('28/08/2019', 'DD/MM/YYYY'),'1201908281'  FROM dual UNION ALL 
  select 'PG142','P142','JE1',TO_DATE('28/08/2019', 'DD/MM/YYYY'),'1201908282'  FROM dual UNION ALL 
  select 'PG143','P143','JE7',TO_DATE('28/08/2019', 'DD/MM/YYYY'),'7201908283'  FROM dual UNION ALL 
  select 'PG144','P144','JE3',TO_DATE('28/08/2019', 'DD/MM/YYYY'),'3201908284'  FROM dual UNION ALL 
  select 'PG145','P145','JE1',TO_DATE('28/08/2019', 'DD/MM/YYYY'),'1201908285'  FROM dual UNION ALL 
  select 'PG146','P146','JE4',TO_DATE('28/08/2019', 'DD/MM/YYYY'),'4201908286'  FROM dual UNION ALL 
  select 'PG147','P147','JE1',TO_DATE('28/08/2019', 'DD/MM/YYYY'),'1201908287'  FROM dual UNION ALL 
  select 'PG148','P148','JE1',TO_DATE('29/08/2019', 'DD/MM/YYYY'),'1201908291'  FROM dual UNION ALL 
  select 'PG149','P149','JE5',TO_DATE('29/08/2019', 'DD/MM/YYYY'),'5201908292'  FROM dual UNION ALL 
  select 'PG150','P150','JE2',TO_DATE('29/08/2019', 'DD/MM/YYYY'),'2201908293'  FROM dual UNION ALL 
  select 'PG151','P151','JE4',TO_DATE('29/08/2019', 'DD/MM/YYYY'),'4201908294'  FROM dual UNION ALL 
  select 'PG152','P152','JE4',TO_DATE('29/08/2019', 'DD/MM/YYYY'),'4201908295'  FROM dual UNION ALL 
  select 'PG153','P153','JE5',TO_DATE('29/08/2019', 'DD/MM/YYYY'),'5201908296'  FROM dual UNION ALL 
  select 'PG154','P154','JE2',TO_DATE('29/08/2019', 'DD/MM/YYYY'),'2201908297'  FROM dual UNION ALL 
  select 'PG155','P155','JE2',TO_DATE('30/08/2019', 'DD/MM/YYYY'),'2201908301'  FROM dual UNION ALL 
  select 'PG156','P156','JE1',TO_DATE('30/08/2019', 'DD/MM/YYYY'),'1201908302'  FROM dual UNION ALL 
  select 'PG157','P157','JE2',TO_DATE('30/08/2019', 'DD/MM/YYYY'),'2201908303'  FROM dual UNION ALL 
  select 'PG158','P158','JE2',TO_DATE('30/08/2019', 'DD/MM/YYYY'),'2201908304'  FROM dual UNION ALL 
  select 'PG159','P159','JE7',TO_DATE('30/08/2019', 'DD/MM/YYYY'),'7201908305'  FROM dual UNION ALL 
  select 'PG160','P160','JE2',TO_DATE('30/08/2019', 'DD/MM/YYYY'),'2201908306'  FROM dual UNION ALL 
  select 'PG161','P161','JE1',TO_DATE('30/08/2019', 'DD/MM/YYYY'),'1201908307'  FROM dual UNION ALL 
  select 'PG162','P162','JE2',TO_DATE('31/08/2019', 'DD/MM/YYYY'),'2201908311'  FROM dual UNION ALL 
  select 'PG163','P163','JE7',TO_DATE('31/08/2019', 'DD/MM/YYYY'),'7201908312'  FROM dual UNION ALL 
  select 'PG164','P164','JE3',TO_DATE('31/08/2019', 'DD/MM/YYYY'),'3201908313'  FROM dual UNION ALL 
  select 'PG165','P165','JE3',TO_DATE('31/08/2019', 'DD/MM/YYYY'),'3201908314'  FROM dual UNION ALL 
  select 'PG166','P166','JE1',TO_DATE('31/08/2019', 'DD/MM/YYYY'),'1201908315'  FROM dual UNION ALL 
  select 'PG167','P167','JE3',TO_DATE('31/08/2019', 'DD/MM/YYYY'),'3201908316'  FROM dual UNION ALL 
  select 'PG168','P168','JE3',TO_DATE('31/08/2019', 'DD/MM/YYYY'),'3201908317'  FROM dual UNION ALL 
  select 'PG169','P169','JE4',TO_DATE('01/09/2019', 'DD/MM/YYYY'),'4201909011'  FROM dual UNION ALL 
  select 'PG170','P170','JE7',TO_DATE('01/09/2019', 'DD/MM/YYYY'),'7201909012'  FROM dual UNION ALL 
  select 'PG171','P171','JE6',TO_DATE('01/09/2019', 'DD/MM/YYYY'),'6201909013'  FROM dual UNION ALL 
  select 'PG172','P172','JE6',TO_DATE('01/09/2019', 'DD/MM/YYYY'),'6201909014'  FROM dual UNION ALL 
  select 'PG173','P173','JE7',TO_DATE('01/09/2019', 'DD/MM/YYYY'),'7201909015'  FROM dual UNION ALL 
  select 'PG174','P174','JE2',TO_DATE('01/09/2019', 'DD/MM/YYYY'),'2201909016'  FROM dual UNION ALL 
  select 'PG175','P175','JE5',TO_DATE('01/09/2019', 'DD/MM/YYYY'),'5201909017'  FROM dual UNION ALL 
  select 'PG176','P176','JE7',TO_DATE('02/09/2019', 'DD/MM/YYYY'),'7201909021'  FROM dual UNION ALL 
  select 'PG177','P177','JE7',TO_DATE('02/09/2019', 'DD/MM/YYYY'),'7201909022'  FROM dual UNION ALL 
  select 'PG178','P178','JE6',TO_DATE('02/09/2019', 'DD/MM/YYYY'),'6201909023'  FROM dual UNION ALL 
  select 'PG179','P179','JE4',TO_DATE('02/09/2019', 'DD/MM/YYYY'),'4201909024'  FROM dual UNION ALL 
  select 'PG180','P180','JE3',TO_DATE('02/09/2019', 'DD/MM/YYYY'),'3201909025'  FROM dual UNION ALL 
  select 'PG181','P181','JE3',TO_DATE('02/09/2019', 'DD/MM/YYYY'),'3201909026'  FROM dual UNION ALL 
  select 'PG182','P182','JE3',TO_DATE('02/09/2019', 'DD/MM/YYYY'),'3201909027'  FROM dual UNION ALL 
  select 'PG183','P183','JE1',TO_DATE('03/09/2019', 'DD/MM/YYYY'),'1201909031'  FROM dual UNION ALL 
  select 'PG184','P184','JE4',TO_DATE('03/09/2019', 'DD/MM/YYYY'),'4201909032'  FROM dual UNION ALL 
  select 'PG185','P185','JE6',TO_DATE('03/09/2019', 'DD/MM/YYYY'),'6201909033'  FROM dual UNION ALL 
  select 'PG186','P186','JE7',TO_DATE('03/09/2019', 'DD/MM/YYYY'),'7201909034'  FROM dual UNION ALL 
  select 'PG187','P187','JE5',TO_DATE('03/09/2019', 'DD/MM/YYYY'),'5201909035'  FROM dual UNION ALL 
  select 'PG188','P188','JE7',TO_DATE('03/09/2019', 'DD/MM/YYYY'),'7201909036'  FROM dual UNION ALL 
  select 'PG189','P189','JE1',TO_DATE('03/09/2019', 'DD/MM/YYYY'),'1201909037'  FROM dual UNION ALL 
  select 'PG190','P190','JE2',TO_DATE('04/09/2019', 'DD/MM/YYYY'),'2201909041'  FROM dual UNION ALL 
  select 'PG191','P191','JE1',TO_DATE('04/09/2019', 'DD/MM/YYYY'),'1201909042'  FROM dual UNION ALL 
  select 'PG192','P192','JE2',TO_DATE('04/09/2019', 'DD/MM/YYYY'),'2201909043'  FROM dual UNION ALL 
  select 'PG193','P193','JE7',TO_DATE('04/09/2019', 'DD/MM/YYYY'),'7201909044'  FROM dual UNION ALL 
  select 'PG194','P194','JE1',TO_DATE('04/09/2019', 'DD/MM/YYYY'),'1201909045'  FROM dual UNION ALL 
  select 'PG195','P195','JE6',TO_DATE('04/09/2019', 'DD/MM/YYYY'),'6201909046'  FROM dual UNION ALL 
  select 'PG196','P196','JE3',TO_DATE('04/09/2019', 'DD/MM/YYYY'),'3201909047'  FROM dual UNION ALL 
  select 'PG197','P197','JE4',TO_DATE('05/09/2019', 'DD/MM/YYYY'),'4201909051'  FROM dual UNION ALL 
  select 'PG198','P198','JE4',TO_DATE('05/09/2019', 'DD/MM/YYYY'),'4201909052'  FROM dual UNION ALL 
  select 'PG199','P199','JE6',TO_DATE('05/09/2019', 'DD/MM/YYYY'),'6201909053'  FROM dual UNION ALL 
  select 'PG200','P200','JE5',TO_DATE('05/09/2019', 'DD/MM/YYYY'),'5201909054'  FROM dual UNION ALL 
  select 'PG201','P201','JE5',TO_DATE('05/09/2019', 'DD/MM/YYYY'),'5201909055'  FROM dual UNION ALL 
  select 'PG202','P202','JE2',TO_DATE('05/09/2019', 'DD/MM/YYYY'),'2201909056'  FROM dual UNION ALL 
  select 'PG203','P203','JE3',TO_DATE('05/09/2019', 'DD/MM/YYYY'),'3201909057'  FROM dual UNION ALL 
  select 'PG204','P204','JE3',TO_DATE('06/09/2019', 'DD/MM/YYYY'),'3201909061'  FROM dual UNION ALL 
  select 'PG205','P205','JE2',TO_DATE('06/09/2019', 'DD/MM/YYYY'),'2201909062'  FROM dual UNION ALL 
  select 'PG206','P206','JE4',TO_DATE('06/09/2019', 'DD/MM/YYYY'),'4201909063'  FROM dual UNION ALL 
  select 'PG207','P207','JE5',TO_DATE('06/09/2019', 'DD/MM/YYYY'),'5201909064'  FROM dual UNION ALL 
  select 'PG208','P208','JE3',TO_DATE('06/09/2019', 'DD/MM/YYYY'),'3201909065'  FROM dual UNION ALL 
  select 'PG209','P209','JE1',TO_DATE('06/09/2019', 'DD/MM/YYYY'),'1201909066'  FROM dual UNION ALL 
  select 'PG210','P210','JE1',TO_DATE('06/09/2019', 'DD/MM/YYYY'),'1201909067'  FROM dual UNION ALL 
  select 'PG211','P211','JE6',TO_DATE('07/09/2019', 'DD/MM/YYYY'),'6201909071'  FROM dual UNION ALL 
  select 'PG212','P212','JE1',TO_DATE('07/09/2019', 'DD/MM/YYYY'),'1201909072'  FROM dual UNION ALL 
  select 'PG213','P213','JE6',TO_DATE('07/09/2019', 'DD/MM/YYYY'),'6201909073'  FROM dual UNION ALL 
  select 'PG214','P214','JE2',TO_DATE('07/09/2019', 'DD/MM/YYYY'),'2201909074'  FROM dual UNION ALL 
  select 'PG215','P215','JE4',TO_DATE('07/09/2019', 'DD/MM/YYYY'),'4201909075'  FROM dual UNION ALL 
  select 'PG216','P216','JE1',TO_DATE('07/09/2019', 'DD/MM/YYYY'),'1201909076'  FROM dual UNION ALL 
  select 'PG217','P217','JE3',TO_DATE('07/09/2019', 'DD/MM/YYYY'),'3201909077'  FROM dual UNION ALL 
  select 'PG218','P218','JE4',TO_DATE('08/09/2019', 'DD/MM/YYYY'),'4201909081'  FROM dual UNION ALL 
  select 'PG219','P219','JE6',TO_DATE('08/09/2019', 'DD/MM/YYYY'),'6201909082'  FROM dual UNION ALL 
  select 'PG220','P220','JE5',TO_DATE('08/09/2019', 'DD/MM/YYYY'),'5201909083'  FROM dual UNION ALL 
  select 'PG221','P221','JE3',TO_DATE('08/09/2019', 'DD/MM/YYYY'),'3201909084'  FROM dual UNION ALL 
  select 'PG222','P222','JE1',TO_DATE('08/09/2019', 'DD/MM/YYYY'),'1201909085'  FROM dual UNION ALL 
  select 'PG223','P223','JE5',TO_DATE('08/09/2019', 'DD/MM/YYYY'),'5201909086'  FROM dual UNION ALL 
  select 'PG224','P224','JE5',TO_DATE('08/09/2019', 'DD/MM/YYYY'),'5201909087'  FROM dual UNION ALL 
  select 'PG225','P225','JE4',TO_DATE('09/09/2019', 'DD/MM/YYYY'),'4201909091'  FROM dual UNION ALL 
  select 'PG226','P226','JE4',TO_DATE('09/09/2019', 'DD/MM/YYYY'),'4201909092'  FROM dual UNION ALL 
  select 'PG227','P227','JE2',TO_DATE('09/09/2019', 'DD/MM/YYYY'),'2201909093'  FROM dual UNION ALL 
  select 'PG228','P228','JE1',TO_DATE('09/09/2019', 'DD/MM/YYYY'),'1201909094'  FROM dual UNION ALL 
  select 'PG229','P229','JE4',TO_DATE('09/09/2019', 'DD/MM/YYYY'),'4201909095'  FROM dual UNION ALL 
  select 'PG230','P230','JE7',TO_DATE('09/09/2019', 'DD/MM/YYYY'),'7201909096'  FROM dual UNION ALL 
  select 'PG231','P231','JE7',TO_DATE('09/09/2019', 'DD/MM/YYYY'),'7201909097'  FROM dual UNION ALL 
  select 'PG232','P232','JE2',TO_DATE('10/09/2019', 'DD/MM/YYYY'),'2201909101'  FROM dual UNION ALL 
  select 'PG233','P233','JE5',TO_DATE('10/09/2019', 'DD/MM/YYYY'),'5201909102'  FROM dual UNION ALL 
  select 'PG234','P234','JE7',TO_DATE('10/09/2019', 'DD/MM/YYYY'),'7201909103'  FROM dual UNION ALL 
  select 'PG235','P235','JE6',TO_DATE('10/09/2019', 'DD/MM/YYYY'),'6201909104'  FROM dual UNION ALL 
  select 'PG236','P236','JE7',TO_DATE('10/09/2019', 'DD/MM/YYYY'),'7201909105'  FROM dual UNION ALL 
  select 'PG237','P237','JE3',TO_DATE('10/09/2019', 'DD/MM/YYYY'),'3201909106'  FROM dual UNION ALL 
  select 'PG238','P238','JE4',TO_DATE('10/09/2019', 'DD/MM/YYYY'),'4201909107'  FROM dual UNION ALL 
  select 'PG239','P239','JE5',TO_DATE('11/09/2019', 'DD/MM/YYYY'),'5201909111'  FROM dual UNION ALL 
  select 'PG240','P240','JE4',TO_DATE('11/09/2019', 'DD/MM/YYYY'),'4201909112'  FROM dual UNION ALL 
  select 'PG241','P241','JE3',TO_DATE('11/09/2019', 'DD/MM/YYYY'),'3201909113'  FROM dual UNION ALL 
  select 'PG242','P242','JE4',TO_DATE('11/09/2019', 'DD/MM/YYYY'),'4201909114'  FROM dual UNION ALL 
  select 'PG243','P243','JE5',TO_DATE('11/09/2019', 'DD/MM/YYYY'),'5201909115'  FROM dual UNION ALL 
  select 'PG244','P244','JE1',TO_DATE('11/09/2019', 'DD/MM/YYYY'),'1201909116'  FROM dual UNION ALL 
  select 'PG245','P245','JE1',TO_DATE('11/09/2019', 'DD/MM/YYYY'),'1201909117'  FROM dual UNION ALL 
  select 'PG246','P246','JE5',TO_DATE('12/09/2019', 'DD/MM/YYYY'),'5201909121'  FROM dual UNION ALL 
  select 'PG247','P247','JE1',TO_DATE('12/09/2019', 'DD/MM/YYYY'),'1201909122'  FROM dual UNION ALL 
  select 'PG248','P248','JE6',TO_DATE('12/09/2019', 'DD/MM/YYYY'),'6201909123'  FROM dual UNION ALL 
  select 'PG249','P249','JE7',TO_DATE('12/09/2019', 'DD/MM/YYYY'),'7201909124'  FROM dual UNION ALL 
  select 'PG250','P250','JE1',TO_DATE('12/09/2019', 'DD/MM/YYYY'),'1201909125'  FROM dual UNION ALL 
  select 'PG251','P251','JE6',TO_DATE('12/09/2019', 'DD/MM/YYYY'),'6201909126'  FROM dual;

INSERT INTO PENGIRIMAN (ID_PENGIRIMAN, ID_PESANAN, ID_EKSPEDISI, TANGGAL_MENGIRIM, KODE_RESI) 
  select 'PG252','P252','JE7',TO_DATE('12/09/2019', 'DD/MM/YYYY'),'7201909127'  FROM dual UNION ALL 
  select 'PG253','P253','JE2',TO_DATE('13/09/2019', 'DD/MM/YYYY'),'2201909131'  FROM dual UNION ALL 
  select 'PG254','P254','JE4',TO_DATE('13/09/2019', 'DD/MM/YYYY'),'4201909132'  FROM dual UNION ALL 
  select 'PG255','P255','JE5',TO_DATE('13/09/2019', 'DD/MM/YYYY'),'5201909133'  FROM dual UNION ALL 
  select 'PG256','P256','JE6',TO_DATE('13/09/2019', 'DD/MM/YYYY'),'6201909134'  FROM dual UNION ALL 
  select 'PG257','P257','JE1',TO_DATE('13/09/2019', 'DD/MM/YYYY'),'1201909135'  FROM dual UNION ALL 
  select 'PG258','P258','JE5',TO_DATE('13/09/2019', 'DD/MM/YYYY'),'5201909136'  FROM dual UNION ALL 
  select 'PG259','P259','JE5',TO_DATE('13/09/2019', 'DD/MM/YYYY'),'5201909137'  FROM dual UNION ALL 
  select 'PG260','P260','JE6',TO_DATE('14/09/2019', 'DD/MM/YYYY'),'6201909141'  FROM dual UNION ALL 
  select 'PG261','P261','JE2',TO_DATE('14/09/2019', 'DD/MM/YYYY'),'2201909142'  FROM dual UNION ALL 
  select 'PG262','P262','JE3',TO_DATE('14/09/2019', 'DD/MM/YYYY'),'3201909143'  FROM dual UNION ALL 
  select 'PG263','P263','JE3',TO_DATE('14/09/2019', 'DD/MM/YYYY'),'3201909144'  FROM dual UNION ALL 
  select 'PG264','P264','JE1',TO_DATE('14/09/2019', 'DD/MM/YYYY'),'1201909145'  FROM dual UNION ALL 
  select 'PG265','P265','JE2',TO_DATE('14/09/2019', 'DD/MM/YYYY'),'2201909146'  FROM dual UNION ALL 
  select 'PG266','P266','JE5',TO_DATE('14/09/2019', 'DD/MM/YYYY'),'5201909147'  FROM dual UNION ALL 
  select 'PG267','P267','JE4',TO_DATE('15/09/2019', 'DD/MM/YYYY'),'4201909151'  FROM dual UNION ALL 
  select 'PG268','P268','JE1',TO_DATE('15/09/2019', 'DD/MM/YYYY'),'1201909152'  FROM dual UNION ALL 
  select 'PG269','P269','JE5',TO_DATE('15/09/2019', 'DD/MM/YYYY'),'5201909153'  FROM dual UNION ALL 
  select 'PG270','P270','JE4',TO_DATE('15/09/2019', 'DD/MM/YYYY'),'4201909154'  FROM dual UNION ALL 
  select 'PG271','P271','JE4',TO_DATE('15/09/2019', 'DD/MM/YYYY'),'4201909155'  FROM dual UNION ALL 
  select 'PG272','P272','JE5',TO_DATE('15/09/2019', 'DD/MM/YYYY'),'5201909156'  FROM dual UNION ALL 
  select 'PG273','P273','JE2',TO_DATE('15/09/2019', 'DD/MM/YYYY'),'2201909157'  FROM dual UNION ALL 
  select 'PG274','P274','JE2',TO_DATE('16/09/2019', 'DD/MM/YYYY'),'2201909161'  FROM dual UNION ALL 
  select 'PG275','P275','JE7',TO_DATE('16/09/2019', 'DD/MM/YYYY'),'7201909162'  FROM dual UNION ALL 
  select 'PG276','P276','JE5',TO_DATE('16/09/2019', 'DD/MM/YYYY'),'5201909163'  FROM dual UNION ALL 
  select 'PG277','P277','JE2',TO_DATE('16/09/2019', 'DD/MM/YYYY'),'2201909164'  FROM dual UNION ALL 
  select 'PG278','P278','JE2',TO_DATE('16/09/2019', 'DD/MM/YYYY'),'2201909165'  FROM dual UNION ALL 
  select 'PG279','P279','JE3',TO_DATE('16/09/2019', 'DD/MM/YYYY'),'3201909166'  FROM dual UNION ALL 
  select 'PG280','P280','JE7',TO_DATE('16/09/2019', 'DD/MM/YYYY'),'7201909167'  FROM dual UNION ALL 
  select 'PG281','P281','JE3',TO_DATE('17/09/2019', 'DD/MM/YYYY'),'3201909171'  FROM dual UNION ALL 
  select 'PG282','P282','JE1',TO_DATE('17/09/2019', 'DD/MM/YYYY'),'1201909172'  FROM dual UNION ALL 
  select 'PG283','P283','JE4',TO_DATE('17/09/2019', 'DD/MM/YYYY'),'4201909173'  FROM dual UNION ALL 
  select 'PG284','P284','JE7',TO_DATE('17/09/2019', 'DD/MM/YYYY'),'7201909174'  FROM dual UNION ALL 
  select 'PG285','P285','JE4',TO_DATE('17/09/2019', 'DD/MM/YYYY'),'4201909175'  FROM dual UNION ALL 
  select 'PG286','P286','JE7',TO_DATE('17/09/2019', 'DD/MM/YYYY'),'7201909176'  FROM dual UNION ALL 
  select 'PG287','P287','JE4',TO_DATE('17/09/2019', 'DD/MM/YYYY'),'4201909177'  FROM dual UNION ALL 
  select 'PG288','P288','JE5',TO_DATE('18/09/2019', 'DD/MM/YYYY'),'5201909181'  FROM dual UNION ALL 
  select 'PG289','P289','JE2',TO_DATE('18/09/2019', 'DD/MM/YYYY'),'2201909182'  FROM dual UNION ALL 
  select 'PG290','P290','JE1',TO_DATE('18/09/2019', 'DD/MM/YYYY'),'1201909183'  FROM dual UNION ALL 
  select 'PG291','P291','JE7',TO_DATE('18/09/2019', 'DD/MM/YYYY'),'7201909184'  FROM dual UNION ALL 
  select 'PG292','P292','JE2',TO_DATE('18/09/2019', 'DD/MM/YYYY'),'2201909185'  FROM dual UNION ALL 
  select 'PG293','P293','JE3',TO_DATE('18/09/2019', 'DD/MM/YYYY'),'3201909186'  FROM dual UNION ALL 
  select 'PG294','P294','JE4',TO_DATE('18/09/2019', 'DD/MM/YYYY'),'4201909187'  FROM dual UNION ALL 
  select 'PG295','P295','JE6',TO_DATE('19/09/2019', 'DD/MM/YYYY'),'6201909191'  FROM dual UNION ALL 
  select 'PG296','P296','JE7',TO_DATE('19/09/2019', 'DD/MM/YYYY'),'7201909192'  FROM dual UNION ALL 
  select 'PG297','P297','JE5',TO_DATE('19/09/2019', 'DD/MM/YYYY'),'5201909193'  FROM dual UNION ALL 
  select 'PG298','P298','JE6',TO_DATE('19/09/2019', 'DD/MM/YYYY'),'6201909194'  FROM dual UNION ALL 
  select 'PG299','P299','JE6',TO_DATE('19/09/2019', 'DD/MM/YYYY'),'6201909195'  FROM dual UNION ALL 
  select 'PG300','P300','JE1',TO_DATE('19/09/2019', 'DD/MM/YYYY'),'1201909196'  FROM dual UNION ALL 
  select 'PG301','P301','JE5',TO_DATE('19/09/2019', 'DD/MM/YYYY'),'5201909197'  FROM dual UNION ALL 
  select 'PG302','P302','JE5',TO_DATE('20/09/2019', 'DD/MM/YYYY'),'5201909201'  FROM dual UNION ALL 
  select 'PG303','P303','JE4',TO_DATE('20/09/2019', 'DD/MM/YYYY'),'4201909202'  FROM dual UNION ALL 
  select 'PG304','P304','JE3',TO_DATE('20/09/2019', 'DD/MM/YYYY'),'3201909203'  FROM dual UNION ALL 
  select 'PG305','P305','JE7',TO_DATE('20/09/2019', 'DD/MM/YYYY'),'7201909204'  FROM dual UNION ALL 
  select 'PG306','P306','JE2',TO_DATE('20/09/2019', 'DD/MM/YYYY'),'2201909205'  FROM dual UNION ALL 
  select 'PG307','P307','JE5',TO_DATE('20/09/2019', 'DD/MM/YYYY'),'5201909206'  FROM dual UNION ALL 
  select 'PG308','P308','JE7',TO_DATE('20/09/2019', 'DD/MM/YYYY'),'7201909207'  FROM dual UNION ALL 
  select 'PG309','P309','JE3',TO_DATE('21/09/2019', 'DD/MM/YYYY'),'3201909211'  FROM dual UNION ALL 
  select 'PG310','P310','JE4',TO_DATE('21/09/2019', 'DD/MM/YYYY'),'4201909212'  FROM dual UNION ALL 
  select 'PG311','P311','JE2',TO_DATE('21/09/2019', 'DD/MM/YYYY'),'2201909213'  FROM dual UNION ALL 
  select 'PG312','P312','JE7',TO_DATE('21/09/2019', 'DD/MM/YYYY'),'7201909214'  FROM dual UNION ALL 
  select 'PG313','P313','JE4',TO_DATE('21/09/2019', 'DD/MM/YYYY'),'4201909215'  FROM dual UNION ALL 
  select 'PG314','P314','JE1',TO_DATE('21/09/2019', 'DD/MM/YYYY'),'1201909216'  FROM dual UNION ALL 
  select 'PG315','P315','JE6',TO_DATE('21/09/2019', 'DD/MM/YYYY'),'6201909217'  FROM dual UNION ALL 
  select 'PG316','P316','JE1',TO_DATE('22/09/2019', 'DD/MM/YYYY'),'1201909221'  FROM dual UNION ALL 
  select 'PG317','P317','JE1',TO_DATE('22/09/2019', 'DD/MM/YYYY'),'1201909222'  FROM dual UNION ALL 
  select 'PG318','P318','JE7',TO_DATE('22/09/2019', 'DD/MM/YYYY'),'7201909223'  FROM dual UNION ALL 
  select 'PG319','P319','JE2',TO_DATE('22/09/2019', 'DD/MM/YYYY'),'2201909224'  FROM dual UNION ALL 
  select 'PG320','P320','JE5',TO_DATE('22/09/2019', 'DD/MM/YYYY'),'5201909225'  FROM dual UNION ALL 
  select 'PG321','P321','JE6',TO_DATE('22/09/2019', 'DD/MM/YYYY'),'6201909226'  FROM dual UNION ALL 
  select 'PG322','P322','JE7',TO_DATE('22/09/2019', 'DD/MM/YYYY'),'7201909227'  FROM dual UNION ALL 
  select 'PG323','P323','JE5',TO_DATE('23/09/2019', 'DD/MM/YYYY'),'5201909231'  FROM dual UNION ALL 
  select 'PG324','P324','JE5',TO_DATE('23/09/2019', 'DD/MM/YYYY'),'5201909232'  FROM dual UNION ALL 
  select 'PG325','P325','JE5',TO_DATE('23/09/2019', 'DD/MM/YYYY'),'5201909233'  FROM dual UNION ALL 
  select 'PG326','P326','JE7',TO_DATE('23/09/2019', 'DD/MM/YYYY'),'7201909234'  FROM dual UNION ALL 
  select 'PG327','P327','JE3',TO_DATE('23/09/2019', 'DD/MM/YYYY'),'3201909235'  FROM dual UNION ALL 
  select 'PG328','P328','JE2',TO_DATE('23/09/2019', 'DD/MM/YYYY'),'2201909236'  FROM dual UNION ALL 
  select 'PG329','P329','JE6',TO_DATE('23/09/2019', 'DD/MM/YYYY'),'6201909237'  FROM dual UNION ALL 
  select 'PG330','P330','JE2',TO_DATE('24/09/2019', 'DD/MM/YYYY'),'2201909241'  FROM dual UNION ALL 
  select 'PG331','P331','JE7',TO_DATE('24/09/2019', 'DD/MM/YYYY'),'7201909242'  FROM dual UNION ALL 
  select 'PG332','P332','JE1',TO_DATE('24/09/2019', 'DD/MM/YYYY'),'1201909243'  FROM dual UNION ALL 
  select 'PG333','P333','JE4',TO_DATE('24/09/2019', 'DD/MM/YYYY'),'4201909244'  FROM dual UNION ALL 
  select 'PG334','P334','JE6',TO_DATE('24/09/2019', 'DD/MM/YYYY'),'6201909245'  FROM dual UNION ALL 
  select 'PG335','P335','JE3',TO_DATE('24/09/2019', 'DD/MM/YYYY'),'3201909246'  FROM dual UNION ALL 
  select 'PG336','P336','JE5',TO_DATE('24/09/2019', 'DD/MM/YYYY'),'5201909247'  FROM dual UNION ALL 
  select 'PG337','P337','JE4',TO_DATE('25/09/2019', 'DD/MM/YYYY'),'4201909251'  FROM dual UNION ALL 
  select 'PG338','P338','JE5',TO_DATE('25/09/2019', 'DD/MM/YYYY'),'5201909252'  FROM dual UNION ALL 
  select 'PG339','P339','JE3',TO_DATE('25/09/2019', 'DD/MM/YYYY'),'3201909253'  FROM dual UNION ALL 
  select 'PG340','P340','JE5',TO_DATE('25/09/2019', 'DD/MM/YYYY'),'5201909254'  FROM dual UNION ALL 
  select 'PG341','P341','JE2',TO_DATE('25/09/2019', 'DD/MM/YYYY'),'2201909255'  FROM dual UNION ALL 
  select 'PG342','P342','JE3',TO_DATE('25/09/2019', 'DD/MM/YYYY'),'3201909256'  FROM dual UNION ALL 
  select 'PG343','P343','JE7',TO_DATE('25/09/2019', 'DD/MM/YYYY'),'7201909257'  FROM dual UNION ALL 
  select 'PG344','P344','JE5',TO_DATE('26/09/2019', 'DD/MM/YYYY'),'5201909261'  FROM dual UNION ALL 
  select 'PG345','P345','JE2',TO_DATE('26/09/2019', 'DD/MM/YYYY'),'2201909262'  FROM dual UNION ALL 
  select 'PG346','P346','JE7',TO_DATE('26/09/2019', 'DD/MM/YYYY'),'7201909263'  FROM dual UNION ALL 
  select 'PG347','P347','JE7',TO_DATE('26/09/2019', 'DD/MM/YYYY'),'7201909264'  FROM dual UNION ALL 
  select 'PG348','P348','JE1',TO_DATE('26/09/2019', 'DD/MM/YYYY'),'1201909265'  FROM dual UNION ALL 
  select 'PG349','P349','JE7',TO_DATE('26/09/2019', 'DD/MM/YYYY'),'7201909266'  FROM dual UNION ALL 
  select 'PG350','P350','JE6',TO_DATE('26/09/2019', 'DD/MM/YYYY'),'6201909267'  FROM dual UNION ALL 
  select 'PG351','P351','JE7',TO_DATE('27/09/2019', 'DD/MM/YYYY'),'7201909271'  FROM dual UNION ALL 
  select 'PG352','P352','JE4',TO_DATE('27/09/2019', 'DD/MM/YYYY'),'4201909272'  FROM dual UNION ALL 
  select 'PG353','P353','JE4',TO_DATE('27/09/2019', 'DD/MM/YYYY'),'4201909273'  FROM dual UNION ALL 
  select 'PG354','P354','JE2',TO_DATE('27/09/2019', 'DD/MM/YYYY'),'2201909274'  FROM dual UNION ALL 
  select 'PG355','P355','JE7',TO_DATE('27/09/2019', 'DD/MM/YYYY'),'7201909275'  FROM dual UNION ALL 
  select 'PG356','P356','JE3',TO_DATE('27/09/2019', 'DD/MM/YYYY'),'3201909276'  FROM dual UNION ALL 
  select 'PG357','P357','JE5',TO_DATE('27/09/2019', 'DD/MM/YYYY'),'5201909277'  FROM dual UNION ALL 
  select 'PG358','P358','JE7',TO_DATE('28/09/2019', 'DD/MM/YYYY'),'7201909281'  FROM dual UNION ALL 
  select 'PG359','P359','JE3',TO_DATE('28/09/2019', 'DD/MM/YYYY'),'3201909282'  FROM dual UNION ALL 
  select 'PG360','P360','JE1',TO_DATE('28/09/2019', 'DD/MM/YYYY'),'1201909283'  FROM dual UNION ALL 
  select 'PG361','P361','JE6',TO_DATE('28/09/2019', 'DD/MM/YYYY'),'6201909284'  FROM dual UNION ALL 
  select 'PG362','P362','JE7',TO_DATE('28/09/2019', 'DD/MM/YYYY'),'7201909285'  FROM dual UNION ALL 
  select 'PG363','P363','JE5',TO_DATE('28/09/2019', 'DD/MM/YYYY'),'5201909286'  FROM dual UNION ALL 
  select 'PG364','P364','JE3',TO_DATE('28/09/2019', 'DD/MM/YYYY'),'3201909287'  FROM dual UNION ALL 
  select 'PG365','P365','JE1',TO_DATE('29/09/2019', 'DD/MM/YYYY'),'1201909291'  FROM dual UNION ALL 
  select 'PG366','P366','JE6',TO_DATE('29/09/2019', 'DD/MM/YYYY'),'6201909292'  FROM dual UNION ALL 
  select 'PG367','P367','JE3',TO_DATE('29/09/2019', 'DD/MM/YYYY'),'3201909293'  FROM dual UNION ALL 
  select 'PG368','P368','JE2',TO_DATE('29/09/2019', 'DD/MM/YYYY'),'2201909294'  FROM dual UNION ALL 
  select 'PG369','P369','JE2',TO_DATE('29/09/2019', 'DD/MM/YYYY'),'2201909295'  FROM dual UNION ALL 
  select 'PG370','P370','JE1',TO_DATE('29/09/2019', 'DD/MM/YYYY'),'1201909296'  FROM dual UNION ALL 
  select 'PG371','P371','JE6',TO_DATE('29/09/2019', 'DD/MM/YYYY'),'6201909297'  FROM dual UNION ALL 
  select 'PG372','P372','JE1',TO_DATE('30/09/2019', 'DD/MM/YYYY'),'1201909301'  FROM dual UNION ALL 
  select 'PG373','P373','JE2',TO_DATE('30/09/2019', 'DD/MM/YYYY'),'2201909302'  FROM dual UNION ALL 
  select 'PG374','P374','JE6',TO_DATE('30/09/2019', 'DD/MM/YYYY'),'6201909303'  FROM dual UNION ALL 
  select 'PG375','P375','JE6',TO_DATE('30/09/2019', 'DD/MM/YYYY'),'6201909304'  FROM dual UNION ALL 
  select 'PG376','P376','JE7',TO_DATE('30/09/2019', 'DD/MM/YYYY'),'7201909305'  FROM dual UNION ALL 
  select 'PG377','P377','JE3',TO_DATE('30/09/2019', 'DD/MM/YYYY'),'3201909306'  FROM dual UNION ALL 
  select 'PG378','P378','JE7',TO_DATE('30/09/2019', 'DD/MM/YYYY'),'7201909307'  FROM dual UNION ALL 
  select 'PG379','P379','JE3',TO_DATE('01/10/2019', 'DD/MM/YYYY'),'3201910011'  FROM dual UNION ALL 
  select 'PG380','P380','JE4',TO_DATE('01/10/2019', 'DD/MM/YYYY'),'4201910012'  FROM dual UNION ALL 
  select 'PG381','P381','JE2',TO_DATE('01/10/2019', 'DD/MM/YYYY'),'2201910013'  FROM dual UNION ALL 
  select 'PG382','P382','JE7',TO_DATE('01/10/2019', 'DD/MM/YYYY'),'7201910014'  FROM dual UNION ALL 
  select 'PG383','P383','JE1',TO_DATE('01/10/2019', 'DD/MM/YYYY'),'1201910015'  FROM dual UNION ALL 
  select 'PG384','P384','JE4',TO_DATE('01/10/2019', 'DD/MM/YYYY'),'4201910016'  FROM dual UNION ALL 
  select 'PG385','P385','JE5',TO_DATE('01/10/2019', 'DD/MM/YYYY'),'5201910017'  FROM dual UNION ALL 
  select 'PG386','P386','JE1',TO_DATE('02/10/2019', 'DD/MM/YYYY'),'1201910021'  FROM dual UNION ALL 
  select 'PG387','P387','JE4',TO_DATE('02/10/2019', 'DD/MM/YYYY'),'4201910022'  FROM dual UNION ALL 
  select 'PG388','P388','JE7',TO_DATE('02/10/2019', 'DD/MM/YYYY'),'7201910023'  FROM dual UNION ALL 
  select 'PG389','P389','JE5',TO_DATE('02/10/2019', 'DD/MM/YYYY'),'5201910024'  FROM dual UNION ALL 
  select 'PG390','P390','JE2',TO_DATE('02/10/2019', 'DD/MM/YYYY'),'2201910025'  FROM dual UNION ALL 
  select 'PG391','P391','JE2',TO_DATE('02/10/2019', 'DD/MM/YYYY'),'2201910026'  FROM dual UNION ALL 
  select 'PG392','P392','JE6',TO_DATE('02/10/2019', 'DD/MM/YYYY'),'6201910027'  FROM dual UNION ALL 
  select 'PG393','P393','JE6',TO_DATE('03/10/2019', 'DD/MM/YYYY'),'6201910031'  FROM dual UNION ALL 
  select 'PG394','P394','JE3',TO_DATE('03/10/2019', 'DD/MM/YYYY'),'3201910032'  FROM dual UNION ALL 
  select 'PG395','P395','JE5',TO_DATE('03/10/2019', 'DD/MM/YYYY'),'5201910033'  FROM dual UNION ALL 
  select 'PG396','P396','JE3',TO_DATE('03/10/2019', 'DD/MM/YYYY'),'3201910034'  FROM dual UNION ALL 
  select 'PG397','P397','JE4',TO_DATE('03/10/2019', 'DD/MM/YYYY'),'4201910035'  FROM dual UNION ALL 
  select 'PG398','P398','JE2',TO_DATE('03/10/2019', 'DD/MM/YYYY'),'2201910036'  FROM dual UNION ALL 
  select 'PG399','P399','JE6',TO_DATE('03/10/2019', 'DD/MM/YYYY'),'6201910037'  FROM dual UNION ALL 
  select 'PG400','P400','JE3',TO_DATE('04/10/2019', 'DD/MM/YYYY'),'3201910041'  FROM dual UNION ALL 
  select 'PG401','P401','JE7',TO_DATE('04/10/2019', 'DD/MM/YYYY'),'7201910042'  FROM dual UNION ALL 
  select 'PG402','P402','JE5',TO_DATE('04/10/2019', 'DD/MM/YYYY'),'5201910043'  FROM dual UNION ALL 
  select 'PG403','P403','JE6',TO_DATE('04/10/2019', 'DD/MM/YYYY'),'6201910044'  FROM dual UNION ALL 
  select 'PG404','P404','JE3',TO_DATE('04/10/2019', 'DD/MM/YYYY'),'3201910045'  FROM dual UNION ALL 
  select 'PG405','P405','JE4',TO_DATE('04/10/2019', 'DD/MM/YYYY'),'4201910046'  FROM dual UNION ALL 
  select 'PG406','P406','JE6',TO_DATE('04/10/2019', 'DD/MM/YYYY'),'6201910047'  FROM dual UNION ALL 
  select 'PG407','P407','JE6',TO_DATE('05/10/2019', 'DD/MM/YYYY'),'6201910051'  FROM dual UNION ALL 
  select 'PG408','P408','JE5',TO_DATE('05/10/2019', 'DD/MM/YYYY'),'5201910052'  FROM dual UNION ALL 
  select 'PG409','P409','JE7',TO_DATE('05/10/2019', 'DD/MM/YYYY'),'7201910053'  FROM dual UNION ALL 
  select 'PG410','P410','JE5',TO_DATE('05/10/2019', 'DD/MM/YYYY'),'5201910054'  FROM dual UNION ALL 
  select 'PG411','P411','JE1',TO_DATE('05/10/2019', 'DD/MM/YYYY'),'1201910055'  FROM dual UNION ALL 
  select 'PG412','P412','JE7',TO_DATE('05/10/2019', 'DD/MM/YYYY'),'7201910056'  FROM dual UNION ALL 
  select 'PG413','P413','JE5',TO_DATE('05/10/2019', 'DD/MM/YYYY'),'5201910057'  FROM dual UNION ALL 
  select 'PG414','P414','JE4',TO_DATE('06/10/2019', 'DD/MM/YYYY'),'4201910061'  FROM dual UNION ALL 
  select 'PG415','P415','JE2',TO_DATE('06/10/2019', 'DD/MM/YYYY'),'2201910062'  FROM dual UNION ALL 
  select 'PG416','P416','JE6',TO_DATE('06/10/2019', 'DD/MM/YYYY'),'6201910063'  FROM dual UNION ALL 
  select 'PG417','P417','JE5',TO_DATE('06/10/2019', 'DD/MM/YYYY'),'5201910064'  FROM dual UNION ALL 
  select 'PG418','P418','JE6',TO_DATE('06/10/2019', 'DD/MM/YYYY'),'6201910065'  FROM dual UNION ALL 
  select 'PG419','P419','JE7',TO_DATE('06/10/2019', 'DD/MM/YYYY'),'7201910066'  FROM dual UNION ALL 
  select 'PG420','P420','JE4',TO_DATE('06/10/2019', 'DD/MM/YYYY'),'4201910067'  FROM dual UNION ALL 
  select 'PG421','P421','JE6',TO_DATE('07/10/2019', 'DD/MM/YYYY'),'6201910071'  FROM dual UNION ALL 
  select 'PG422','P422','JE5',TO_DATE('07/10/2019', 'DD/MM/YYYY'),'5201910072'  FROM dual UNION ALL 
  select 'PG423','P423','JE6',TO_DATE('07/10/2019', 'DD/MM/YYYY'),'6201910073'  FROM dual UNION ALL 
  select 'PG424','P424','JE3',TO_DATE('07/10/2019', 'DD/MM/YYYY'),'3201910074'  FROM dual UNION ALL 
  select 'PG425','P425','JE3',TO_DATE('07/10/2019', 'DD/MM/YYYY'),'3201910075'  FROM dual UNION ALL 
  select 'PG426','P426','JE5',TO_DATE('07/10/2019', 'DD/MM/YYYY'),'5201910076'  FROM dual UNION ALL 
  select 'PG427','P427','JE5',TO_DATE('07/10/2019', 'DD/MM/YYYY'),'5201910077'  FROM dual UNION ALL 
  select 'PG428','P428','JE1',TO_DATE('08/10/2019', 'DD/MM/YYYY'),'1201910081'  FROM dual UNION ALL 
  select 'PG429','P429','JE5',TO_DATE('08/10/2019', 'DD/MM/YYYY'),'5201910082'  FROM dual UNION ALL 
  select 'PG430','P430','JE7',TO_DATE('08/10/2019', 'DD/MM/YYYY'),'7201910083'  FROM dual UNION ALL 
  select 'PG431','P431','JE7',TO_DATE('08/10/2019', 'DD/MM/YYYY'),'7201910084'  FROM dual UNION ALL 
  select 'PG432','P432','JE3',TO_DATE('08/10/2019', 'DD/MM/YYYY'),'3201910085'  FROM dual UNION ALL 
  select 'PG433','P433','JE3',TO_DATE('08/10/2019', 'DD/MM/YYYY'),'3201910086'  FROM dual UNION ALL 
  select 'PG434','P434','JE5',TO_DATE('08/10/2019', 'DD/MM/YYYY'),'5201910087'  FROM dual UNION ALL 
  select 'PG435','P435','JE7',TO_DATE('09/10/2019', 'DD/MM/YYYY'),'7201910091'  FROM dual UNION ALL 
  select 'PG436','P436','JE2',TO_DATE('09/10/2019', 'DD/MM/YYYY'),'2201910092'  FROM dual UNION ALL 
  select 'PG437','P437','JE1',TO_DATE('09/10/2019', 'DD/MM/YYYY'),'1201910093'  FROM dual UNION ALL 
  select 'PG438','P438','JE5',TO_DATE('09/10/2019', 'DD/MM/YYYY'),'5201910094'  FROM dual UNION ALL 
  select 'PG439','P439','JE6',TO_DATE('09/10/2019', 'DD/MM/YYYY'),'6201910095'  FROM dual UNION ALL 
  select 'PG440','P440','JE3',TO_DATE('09/10/2019', 'DD/MM/YYYY'),'3201910096'  FROM dual UNION ALL 
  select 'PG441','P441','JE6',TO_DATE('09/10/2019', 'DD/MM/YYYY'),'6201910097'  FROM dual UNION ALL 
  select 'PG442','P442','JE3',TO_DATE('10/10/2019', 'DD/MM/YYYY'),'3201910101'  FROM dual UNION ALL 
  select 'PG443','P443','JE1',TO_DATE('10/10/2019', 'DD/MM/YYYY'),'1201910102'  FROM dual UNION ALL 
  select 'PG444','P444','JE4',TO_DATE('10/10/2019', 'DD/MM/YYYY'),'4201910103'  FROM dual UNION ALL 
  select 'PG445','P445','JE4',TO_DATE('10/10/2019', 'DD/MM/YYYY'),'4201910104'  FROM dual UNION ALL 
  select 'PG446','P446','JE3',TO_DATE('10/10/2019', 'DD/MM/YYYY'),'3201910105'  FROM dual UNION ALL 
  select 'PG447','P447','JE3',TO_DATE('10/10/2019', 'DD/MM/YYYY'),'3201910106'  FROM dual UNION ALL 
  select 'PG448','P448','JE5',TO_DATE('10/10/2019', 'DD/MM/YYYY'),'5201910107'  FROM dual UNION ALL 
  select 'PG449','P449','JE7',TO_DATE('11/10/2019', 'DD/MM/YYYY'),'7201910111'  FROM dual UNION ALL 
  select 'PG450','P450','JE3',TO_DATE('11/10/2019', 'DD/MM/YYYY'),'3201910112'  FROM dual UNION ALL 
  select 'PG451','P451','JE7',TO_DATE('11/10/2019', 'DD/MM/YYYY'),'7201910113'  FROM dual UNION ALL 
  select 'PG452','P452','JE4',TO_DATE('11/10/2019', 'DD/MM/YYYY'),'4201910114'  FROM dual UNION ALL 
  select 'PG453','P453','JE2',TO_DATE('11/10/2019', 'DD/MM/YYYY'),'2201910115'  FROM dual UNION ALL 
  select 'PG454','P454','JE7',TO_DATE('11/10/2019', 'DD/MM/YYYY'),'7201910116'  FROM dual UNION ALL 
  select 'PG455','P455','JE5',TO_DATE('11/10/2019', 'DD/MM/YYYY'),'5201910117'  FROM dual UNION ALL 
  select 'PG456','P456','JE3',TO_DATE('12/10/2019', 'DD/MM/YYYY'),'3201910121'  FROM dual UNION ALL 
  select 'PG457','P457','JE2',TO_DATE('12/10/2019', 'DD/MM/YYYY'),'2201910122'  FROM dual UNION ALL 
  select 'PG458','P458','JE1',TO_DATE('12/10/2019', 'DD/MM/YYYY'),'1201910123'  FROM dual UNION ALL 
  select 'PG459','P459','JE3',TO_DATE('12/10/2019', 'DD/MM/YYYY'),'3201910124'  FROM dual UNION ALL 
  select 'PG460','P460','JE7',TO_DATE('12/10/2019', 'DD/MM/YYYY'),'7201910125'  FROM dual UNION ALL 
  select 'PG461','P461','JE7',TO_DATE('12/10/2019', 'DD/MM/YYYY'),'7201910126'  FROM dual UNION ALL 
  select 'PG462','P462','JE3',TO_DATE('12/10/2019', 'DD/MM/YYYY'),'3201910127'  FROM dual UNION ALL 
  select 'PG463','P463','JE5',TO_DATE('13/10/2019', 'DD/MM/YYYY'),'5201910131'  FROM dual UNION ALL 
  select 'PG464','P464','JE4',TO_DATE('13/10/2019', 'DD/MM/YYYY'),'4201910132'  FROM dual UNION ALL 
  select 'PG465','P465','JE2',TO_DATE('13/10/2019', 'DD/MM/YYYY'),'2201910133'  FROM dual UNION ALL 
  select 'PG466','P466','JE5',TO_DATE('13/10/2019', 'DD/MM/YYYY'),'5201910134'  FROM dual UNION ALL 
  select 'PG467','P467','JE3',TO_DATE('13/10/2019', 'DD/MM/YYYY'),'3201910135'  FROM dual UNION ALL 
  select 'PG468','P468','JE7',TO_DATE('13/10/2019', 'DD/MM/YYYY'),'7201910136'  FROM dual UNION ALL 
  select 'PG469','P469','JE2',TO_DATE('13/10/2019', 'DD/MM/YYYY'),'2201910137'  FROM dual UNION ALL 
  select 'PG470','P470','JE2',TO_DATE('14/10/2019', 'DD/MM/YYYY'),'2201910141'  FROM dual UNION ALL 
  select 'PG471','P471','JE1',TO_DATE('14/10/2019', 'DD/MM/YYYY'),'1201910142'  FROM dual UNION ALL 
  select 'PG472','P472','JE7',TO_DATE('14/10/2019', 'DD/MM/YYYY'),'7201910143'  FROM dual UNION ALL 
  select 'PG473','P473','JE1',TO_DATE('14/10/2019', 'DD/MM/YYYY'),'1201910144'  FROM dual UNION ALL 
  select 'PG474','P474','JE6',TO_DATE('14/10/2019', 'DD/MM/YYYY'),'6201910145'  FROM dual UNION ALL 
  select 'PG475','P475','JE5',TO_DATE('14/10/2019', 'DD/MM/YYYY'),'5201910146'  FROM dual UNION ALL 
  select 'PG476','P476','JE5',TO_DATE('14/10/2019', 'DD/MM/YYYY'),'5201910147'  FROM dual UNION ALL 
  select 'PG477','P477','JE5',TO_DATE('15/10/2019', 'DD/MM/YYYY'),'5201910151'  FROM dual UNION ALL 
  select 'PG478','P478','JE7',TO_DATE('15/10/2019', 'DD/MM/YYYY'),'7201910152'  FROM dual UNION ALL 
  select 'PG479','P479','JE5',TO_DATE('15/10/2019', 'DD/MM/YYYY'),'5201910153'  FROM dual UNION ALL 
  select 'PG480','P480','JE5',TO_DATE('15/10/2019', 'DD/MM/YYYY'),'5201910154'  FROM dual UNION ALL 
  select 'PG481','P481','JE3',TO_DATE('15/10/2019', 'DD/MM/YYYY'),'3201910155'  FROM dual UNION ALL 
  select 'PG482','P482','JE5',TO_DATE('15/10/2019', 'DD/MM/YYYY'),'5201910156'  FROM dual UNION ALL 
  select 'PG483','P483','JE2',TO_DATE('15/10/2019', 'DD/MM/YYYY'),'2201910157'  FROM dual UNION ALL 
  select 'PG484','P484','JE3',TO_DATE('16/10/2019', 'DD/MM/YYYY'),'3201910161'  FROM dual UNION ALL 
  select 'PG485','P485','JE2',TO_DATE('16/10/2019', 'DD/MM/YYYY'),'2201910162'  FROM dual UNION ALL 
  select 'PG486','P486','JE5',TO_DATE('16/10/2019', 'DD/MM/YYYY'),'5201910163'  FROM dual UNION ALL 
  select 'PG487','P487','JE7',TO_DATE('16/10/2019', 'DD/MM/YYYY'),'7201910164'  FROM dual UNION ALL 
  select 'PG488','P488','JE4',TO_DATE('16/10/2019', 'DD/MM/YYYY'),'4201910165'  FROM dual UNION ALL 
  select 'PG489','P489','JE1',TO_DATE('16/10/2019', 'DD/MM/YYYY'),'1201910166'  FROM dual UNION ALL 
  select 'PG490','P490','JE2',TO_DATE('16/10/2019', 'DD/MM/YYYY'),'2201910167'  FROM dual UNION ALL 
  select 'PG491','P491','JE2',TO_DATE('17/10/2019', 'DD/MM/YYYY'),'2201910171'  FROM dual UNION ALL 
  select 'PG492','P492','JE1',TO_DATE('17/10/2019', 'DD/MM/YYYY'),'1201910172'  FROM dual UNION ALL 
  select 'PG493','P493','JE7',TO_DATE('17/10/2019', 'DD/MM/YYYY'),'7201910173'  FROM dual UNION ALL 
  select 'PG494','P494','JE7',TO_DATE('17/10/2019', 'DD/MM/YYYY'),'7201910174'  FROM dual UNION ALL 
  select 'PG495','P495','JE3',TO_DATE('17/10/2019', 'DD/MM/YYYY'),'3201910175'  FROM dual UNION ALL 
  select 'PG496','P496','JE4',TO_DATE('17/10/2019', 'DD/MM/YYYY'),'4201910176'  FROM dual UNION ALL 
  select 'PG497','P497','JE1',TO_DATE('17/10/2019', 'DD/MM/YYYY'),'1201910177'  FROM dual UNION ALL 
  select 'PG498','P498','JE3',TO_DATE('18/10/2019', 'DD/MM/YYYY'),'3201910181'  FROM dual UNION ALL 
  select 'PG499','P499','JE1',TO_DATE('18/10/2019', 'DD/MM/YYYY'),'1201910182'  FROM dual UNION ALL 
  select 'PG500','P500','JE4',TO_DATE('18/10/2019', 'DD/MM/YYYY'),'4201910183'  FROM dual UNION ALL 
  select 'PG501','P501','JE1',TO_DATE('18/10/2019', 'DD/MM/YYYY'),'1201910184'  FROM dual UNION ALL 
  select 'PG502','P502','JE2',TO_DATE('18/10/2019', 'DD/MM/YYYY'),'2201910185'  FROM dual;

INSERT INTO PENGIRIMAN (ID_PENGIRIMAN, ID_PESANAN, ID_EKSPEDISI, TANGGAL_MENGIRIM, KODE_RESI) 
  select 'PG503','P503','JE3',TO_DATE('18/10/2019', 'DD/MM/YYYY'),'3201910186'  FROM dual UNION ALL 
  select 'PG504','P504','JE2',TO_DATE('18/10/2019', 'DD/MM/YYYY'),'2201910187'  FROM dual UNION ALL 
  select 'PG505','P505','JE4',TO_DATE('19/10/2019', 'DD/MM/YYYY'),'4201910191'  FROM dual UNION ALL 
  select 'PG506','P506','JE5',TO_DATE('19/10/2019', 'DD/MM/YYYY'),'5201910192'  FROM dual UNION ALL 
  select 'PG507','P507','JE4',TO_DATE('19/10/2019', 'DD/MM/YYYY'),'4201910193'  FROM dual UNION ALL 
  select 'PG508','P508','JE2',TO_DATE('19/10/2019', 'DD/MM/YYYY'),'2201910194'  FROM dual UNION ALL 
  select 'PG509','P509','JE4',TO_DATE('19/10/2019', 'DD/MM/YYYY'),'4201910195'  FROM dual UNION ALL 
  select 'PG510','P510','JE6',TO_DATE('19/10/2019', 'DD/MM/YYYY'),'6201910196'  FROM dual UNION ALL 
  select 'PG511','P511','JE6',TO_DATE('19/10/2019', 'DD/MM/YYYY'),'6201910197'  FROM dual UNION ALL 
  select 'PG512','P512','JE3',TO_DATE('20/10/2019', 'DD/MM/YYYY'),'3201910201'  FROM dual UNION ALL 
  select 'PG513','P513','JE6',TO_DATE('20/10/2019', 'DD/MM/YYYY'),'6201910202'  FROM dual UNION ALL 
  select 'PG514','P514','JE4',TO_DATE('20/10/2019', 'DD/MM/YYYY'),'4201910203'  FROM dual UNION ALL 
  select 'PG515','P515','JE2',TO_DATE('20/10/2019', 'DD/MM/YYYY'),'2201910204'  FROM dual UNION ALL 
  select 'PG516','P516','JE4',TO_DATE('20/10/2019', 'DD/MM/YYYY'),'4201910205'  FROM dual UNION ALL 
  select 'PG517','P517','JE1',TO_DATE('20/10/2019', 'DD/MM/YYYY'),'1201910206'  FROM dual UNION ALL 
  select 'PG518','P518','JE2',TO_DATE('20/10/2019', 'DD/MM/YYYY'),'2201910207'  FROM dual UNION ALL 
  select 'PG519','P519','JE2',TO_DATE('21/10/2019', 'DD/MM/YYYY'),'2201910211'  FROM dual UNION ALL 
  select 'PG520','P520','JE2',TO_DATE('21/10/2019', 'DD/MM/YYYY'),'2201910212'  FROM dual UNION ALL 
  select 'PG521','P521','JE5',TO_DATE('21/10/2019', 'DD/MM/YYYY'),'5201910213'  FROM dual UNION ALL 
  select 'PG522','P522','JE4',TO_DATE('21/10/2019', 'DD/MM/YYYY'),'4201910214'  FROM dual UNION ALL 
  select 'PG523','P523','JE6',TO_DATE('21/10/2019', 'DD/MM/YYYY'),'6201910215'  FROM dual UNION ALL 
  select 'PG524','P524','JE5',TO_DATE('21/10/2019', 'DD/MM/YYYY'),'5201910216'  FROM dual UNION ALL 
  select 'PG525','P525','JE2',TO_DATE('21/10/2019', 'DD/MM/YYYY'),'2201910217'  FROM dual UNION ALL 
  select 'PG526','P526','JE1',TO_DATE('22/10/2019', 'DD/MM/YYYY'),'1201910221'  FROM dual UNION ALL 
  select 'PG527','P527','JE5',TO_DATE('22/10/2019', 'DD/MM/YYYY'),'5201910222'  FROM dual UNION ALL 
  select 'PG528','P528','JE6',TO_DATE('22/10/2019', 'DD/MM/YYYY'),'6201910223'  FROM dual UNION ALL 
  select 'PG529','P529','JE1',TO_DATE('22/10/2019', 'DD/MM/YYYY'),'1201910224'  FROM dual UNION ALL 
  select 'PG530','P530','JE7',TO_DATE('22/10/2019', 'DD/MM/YYYY'),'7201910225'  FROM dual UNION ALL 
  select 'PG531','P531','JE3',TO_DATE('22/10/2019', 'DD/MM/YYYY'),'3201910226'  FROM dual UNION ALL 
  select 'PG532','P532','JE5',TO_DATE('22/10/2019', 'DD/MM/YYYY'),'5201910227'  FROM dual UNION ALL 
  select 'PG533','P533','JE1',TO_DATE('23/10/2019', 'DD/MM/YYYY'),'1201910231'  FROM dual UNION ALL 
  select 'PG534','P534','JE1',TO_DATE('23/10/2019', 'DD/MM/YYYY'),'1201910232'  FROM dual UNION ALL 
  select 'PG535','P535','JE4',TO_DATE('23/10/2019', 'DD/MM/YYYY'),'4201910233'  FROM dual UNION ALL 
  select 'PG536','P536','JE7',TO_DATE('23/10/2019', 'DD/MM/YYYY'),'7201910234'  FROM dual UNION ALL 
  select 'PG537','P537','JE4',TO_DATE('23/10/2019', 'DD/MM/YYYY'),'4201910235'  FROM dual UNION ALL 
  select 'PG538','P538','JE3',TO_DATE('23/10/2019', 'DD/MM/YYYY'),'3201910236'  FROM dual UNION ALL 
  select 'PG539','P539','JE6',TO_DATE('23/10/2019', 'DD/MM/YYYY'),'6201910237'  FROM dual UNION ALL 
  select 'PG540','P540','JE6',TO_DATE('24/10/2019', 'DD/MM/YYYY'),'6201910241'  FROM dual UNION ALL 
  select 'PG541','P541','JE7',TO_DATE('24/10/2019', 'DD/MM/YYYY'),'7201910242'  FROM dual UNION ALL 
  select 'PG542','P542','JE6',TO_DATE('24/10/2019', 'DD/MM/YYYY'),'6201910243'  FROM dual UNION ALL 
  select 'PG543','P543','JE5',TO_DATE('24/10/2019', 'DD/MM/YYYY'),'5201910244'  FROM dual UNION ALL 
  select 'PG544','P544','JE6',TO_DATE('24/10/2019', 'DD/MM/YYYY'),'6201910245'  FROM dual UNION ALL 
  select 'PG545','P545','JE2',TO_DATE('24/10/2019', 'DD/MM/YYYY'),'2201910246'  FROM dual UNION ALL 
  select 'PG546','P546','JE7',TO_DATE('24/10/2019', 'DD/MM/YYYY'),'7201910247'  FROM dual UNION ALL 
  select 'PG547','P547','JE4',TO_DATE('25/10/2019', 'DD/MM/YYYY'),'4201910251'  FROM dual UNION ALL 
  select 'PG548','P548','JE7',TO_DATE('25/10/2019', 'DD/MM/YYYY'),'7201910252'  FROM dual UNION ALL 
  select 'PG549','P549','JE7',TO_DATE('25/10/2019', 'DD/MM/YYYY'),'7201910253'  FROM dual UNION ALL 
  select 'PG550','P550','JE2',TO_DATE('25/10/2019', 'DD/MM/YYYY'),'2201910254'  FROM dual UNION ALL 
  select 'PG551','P551','JE7',TO_DATE('25/10/2019', 'DD/MM/YYYY'),'7201910255'  FROM dual UNION ALL 
  select 'PG552','P552','JE4',TO_DATE('25/10/2019', 'DD/MM/YYYY'),'4201910256'  FROM dual UNION ALL 
  select 'PG553','P553','JE6',TO_DATE('25/10/2019', 'DD/MM/YYYY'),'6201910257'  FROM dual UNION ALL 
  select 'PG554','P554','JE3',TO_DATE('26/10/2019', 'DD/MM/YYYY'),'3201910261'  FROM dual UNION ALL 
  select 'PG555','P555','JE6',TO_DATE('26/10/2019', 'DD/MM/YYYY'),'6201910262'  FROM dual UNION ALL 
  select 'PG556','P556','JE7',TO_DATE('26/10/2019', 'DD/MM/YYYY'),'7201910263'  FROM dual UNION ALL 
  select 'PG557','P557','JE4',TO_DATE('26/10/2019', 'DD/MM/YYYY'),'4201910264'  FROM dual UNION ALL 
  select 'PG558','P558','JE2',TO_DATE('26/10/2019', 'DD/MM/YYYY'),'2201910265'  FROM dual UNION ALL 
  select 'PG559','P559','JE5',TO_DATE('26/10/2019', 'DD/MM/YYYY'),'5201910266'  FROM dual UNION ALL 
  select 'PG560','P560','JE5',TO_DATE('26/10/2019', 'DD/MM/YYYY'),'5201910267'  FROM dual UNION ALL 
  select 'PG561','P561','JE5',TO_DATE('27/10/2019', 'DD/MM/YYYY'),'5201910271'  FROM dual UNION ALL 
  select 'PG562','P562','JE1',TO_DATE('27/10/2019', 'DD/MM/YYYY'),'1201910272'  FROM dual UNION ALL 
  select 'PG563','P563','JE3',TO_DATE('27/10/2019', 'DD/MM/YYYY'),'3201910273'  FROM dual UNION ALL 
  select 'PG564','P564','JE5',TO_DATE('27/10/2019', 'DD/MM/YYYY'),'5201910274'  FROM dual UNION ALL 
  select 'PG565','P565','JE4',TO_DATE('27/10/2019', 'DD/MM/YYYY'),'4201910275'  FROM dual UNION ALL 
  select 'PG566','P566','JE1',TO_DATE('27/10/2019', 'DD/MM/YYYY'),'1201910276'  FROM dual UNION ALL 
  select 'PG567','P567','JE3',TO_DATE('27/10/2019', 'DD/MM/YYYY'),'3201910277'  FROM dual UNION ALL 
  select 'PG568','P568','JE3',TO_DATE('28/10/2019', 'DD/MM/YYYY'),'3201910281'  FROM dual UNION ALL 
  select 'PG569','P569','JE6',TO_DATE('28/10/2019', 'DD/MM/YYYY'),'6201910282'  FROM dual UNION ALL 
  select 'PG570','P570','JE4',TO_DATE('28/10/2019', 'DD/MM/YYYY'),'4201910283'  FROM dual UNION ALL 
  select 'PG571','P571','JE2',TO_DATE('28/10/2019', 'DD/MM/YYYY'),'2201910284'  FROM dual UNION ALL 
  select 'PG572','P572','JE1',TO_DATE('28/10/2019', 'DD/MM/YYYY'),'1201910285'  FROM dual UNION ALL 
  select 'PG573','P573','JE2',TO_DATE('28/10/2019', 'DD/MM/YYYY'),'2201910286'  FROM dual UNION ALL 
  select 'PG574','P574','JE5',TO_DATE('28/10/2019', 'DD/MM/YYYY'),'5201910287'  FROM dual UNION ALL 
  select 'PG575','P575','JE2',TO_DATE('29/10/2019', 'DD/MM/YYYY'),'2201910291'  FROM dual UNION ALL 
  select 'PG576','P576','JE5',TO_DATE('29/10/2019', 'DD/MM/YYYY'),'5201910292'  FROM dual UNION ALL 
  select 'PG577','P577','JE1',TO_DATE('29/10/2019', 'DD/MM/YYYY'),'1201910293'  FROM dual UNION ALL 
  select 'PG578','P578','JE2',TO_DATE('29/10/2019', 'DD/MM/YYYY'),'2201910294'  FROM dual UNION ALL 
  select 'PG579','P579','JE4',TO_DATE('29/10/2019', 'DD/MM/YYYY'),'4201910295'  FROM dual UNION ALL 
  select 'PG580','P580','JE1',TO_DATE('29/10/2019', 'DD/MM/YYYY'),'1201910296'  FROM dual UNION ALL 
  select 'PG581','P581','JE3',TO_DATE('29/10/2019', 'DD/MM/YYYY'),'3201910297'  FROM dual UNION ALL 
  select 'PG582','P582','JE7',TO_DATE('30/10/2019', 'DD/MM/YYYY'),'7201910301'  FROM dual UNION ALL 
  select 'PG583','P583','JE1',TO_DATE('30/10/2019', 'DD/MM/YYYY'),'1201910302'  FROM dual UNION ALL 
  select 'PG584','P584','JE6',TO_DATE('30/10/2019', 'DD/MM/YYYY'),'6201910303'  FROM dual UNION ALL 
  select 'PG585','P585','JE5',TO_DATE('30/10/2019', 'DD/MM/YYYY'),'5201910304'  FROM dual UNION ALL 
  select 'PG586','P586','JE5',TO_DATE('30/10/2019', 'DD/MM/YYYY'),'5201910305'  FROM dual UNION ALL 
  select 'PG587','P587','JE4',TO_DATE('30/10/2019', 'DD/MM/YYYY'),'4201910306'  FROM dual UNION ALL 
  select 'PG588','P588','JE1',TO_DATE('30/10/2019', 'DD/MM/YYYY'),'1201910307'  FROM dual UNION ALL 
  select 'PG589','P589','JE5',TO_DATE('31/10/2019', 'DD/MM/YYYY'),'5201910311'  FROM dual UNION ALL 
  select 'PG590','P590','JE1',TO_DATE('31/10/2019', 'DD/MM/YYYY'),'1201910312'  FROM dual UNION ALL 
  select 'PG591','P591','JE3',TO_DATE('31/10/2019', 'DD/MM/YYYY'),'3201910313'  FROM dual UNION ALL 
  select 'PG592','P592','JE2',TO_DATE('31/10/2019', 'DD/MM/YYYY'),'2201910314'  FROM dual UNION ALL 
  select 'PG593','P593','JE7',TO_DATE('31/10/2019', 'DD/MM/YYYY'),'7201910315'  FROM dual UNION ALL 
  select 'PG594','P594','JE3',TO_DATE('31/10/2019', 'DD/MM/YYYY'),'3201910316'  FROM dual UNION ALL 
  select 'PG595','P595','JE7',TO_DATE('31/10/2019', 'DD/MM/YYYY'),'7201910317'  FROM dual UNION ALL 
  select 'PG596','P596','JE3',TO_DATE('01/11/2019', 'DD/MM/YYYY'),'3201911011'  FROM dual UNION ALL 
  select 'PG597','P597','JE4',TO_DATE('01/11/2019', 'DD/MM/YYYY'),'4201911012'  FROM dual UNION ALL 
  select 'PG598','P598','JE3',TO_DATE('01/11/2019', 'DD/MM/YYYY'),'3201911013'  FROM dual UNION ALL 
  select 'PG599','P599','JE5',TO_DATE('01/11/2019', 'DD/MM/YYYY'),'5201911014'  FROM dual UNION ALL 
  select 'PG600','P600','JE7',TO_DATE('01/11/2019', 'DD/MM/YYYY'),'7201911015'  FROM dual UNION ALL 
  select 'PG601','P601','JE5',TO_DATE('01/11/2019', 'DD/MM/YYYY'),'5201911016'  FROM dual UNION ALL 
  select 'PG602','P602','JE5',TO_DATE('01/11/2019', 'DD/MM/YYYY'),'5201911017'  FROM dual UNION ALL 
  select 'PG603','P603','JE7',TO_DATE('02/11/2019', 'DD/MM/YYYY'),'7201911021'  FROM dual UNION ALL 
  select 'PG604','P604','JE7',TO_DATE('02/11/2019', 'DD/MM/YYYY'),'7201911022'  FROM dual UNION ALL 
  select 'PG605','P605','JE6',TO_DATE('02/11/2019', 'DD/MM/YYYY'),'6201911023'  FROM dual UNION ALL 
  select 'PG606','P606','JE1',TO_DATE('02/11/2019', 'DD/MM/YYYY'),'1201911024'  FROM dual UNION ALL 
  select 'PG607','P607','JE6',TO_DATE('02/11/2019', 'DD/MM/YYYY'),'6201911025'  FROM dual UNION ALL 
  select 'PG608','P608','JE2',TO_DATE('02/11/2019', 'DD/MM/YYYY'),'2201911026'  FROM dual UNION ALL 
  select 'PG609','P609','JE2',TO_DATE('02/11/2019', 'DD/MM/YYYY'),'2201911027'  FROM dual UNION ALL 
  select 'PG610','P610','JE7',TO_DATE('03/11/2019', 'DD/MM/YYYY'),'7201911031'  FROM dual UNION ALL 
  select 'PG611','P611','JE5',TO_DATE('03/11/2019', 'DD/MM/YYYY'),'5201911032'  FROM dual UNION ALL 
  select 'PG612','P612','JE4',TO_DATE('03/11/2019', 'DD/MM/YYYY'),'4201911033'  FROM dual UNION ALL 
  select 'PG613','P613','JE3',TO_DATE('03/11/2019', 'DD/MM/YYYY'),'3201911034'  FROM dual UNION ALL 
  select 'PG614','P614','JE3',TO_DATE('03/11/2019', 'DD/MM/YYYY'),'3201911035'  FROM dual UNION ALL 
  select 'PG615','P615','JE2',TO_DATE('03/11/2019', 'DD/MM/YYYY'),'2201911036'  FROM dual UNION ALL 
  select 'PG616','P616','JE5',TO_DATE('03/11/2019', 'DD/MM/YYYY'),'5201911037'  FROM dual UNION ALL 
  select 'PG617','P617','JE4',TO_DATE('04/11/2019', 'DD/MM/YYYY'),'4201911041'  FROM dual UNION ALL 
  select 'PG618','P618','JE6',TO_DATE('04/11/2019', 'DD/MM/YYYY'),'6201911042'  FROM dual UNION ALL 
  select 'PG619','P619','JE7',TO_DATE('04/11/2019', 'DD/MM/YYYY'),'7201911043'  FROM dual UNION ALL 
  select 'PG620','P620','JE2',TO_DATE('04/11/2019', 'DD/MM/YYYY'),'2201911044'  FROM dual UNION ALL 
  select 'PG621','P621','JE2',TO_DATE('04/11/2019', 'DD/MM/YYYY'),'2201911045'  FROM dual UNION ALL 
  select 'PG622','P622','JE2',TO_DATE('04/11/2019', 'DD/MM/YYYY'),'2201911046'  FROM dual UNION ALL 
  select 'PG623','P623','JE5',TO_DATE('04/11/2019', 'DD/MM/YYYY'),'5201911047'  FROM dual UNION ALL 
  select 'PG624','P624','JE1',TO_DATE('05/11/2019', 'DD/MM/YYYY'),'1201911051'  FROM dual UNION ALL 
  select 'PG625','P625','JE5',TO_DATE('05/11/2019', 'DD/MM/YYYY'),'5201911052'  FROM dual UNION ALL 
  select 'PG626','P626','JE4',TO_DATE('05/11/2019', 'DD/MM/YYYY'),'4201911053'  FROM dual UNION ALL 
  select 'PG627','P627','JE6',TO_DATE('05/11/2019', 'DD/MM/YYYY'),'6201911054'  FROM dual UNION ALL 
  select 'PG628','P628','JE5',TO_DATE('05/11/2019', 'DD/MM/YYYY'),'5201911055'  FROM dual UNION ALL 
  select 'PG629','P629','JE4',TO_DATE('05/11/2019', 'DD/MM/YYYY'),'4201911056'  FROM dual UNION ALL 
  select 'PG630','P630','JE3',TO_DATE('05/11/2019', 'DD/MM/YYYY'),'3201911057'  FROM dual UNION ALL 
  select 'PG631','P631','JE1',TO_DATE('06/11/2019', 'DD/MM/YYYY'),'1201911061'  FROM dual UNION ALL 
  select 'PG632','P632','JE4',TO_DATE('06/11/2019', 'DD/MM/YYYY'),'4201911062'  FROM dual UNION ALL 
  select 'PG633','P633','JE2',TO_DATE('06/11/2019', 'DD/MM/YYYY'),'2201911063'  FROM dual UNION ALL 
  select 'PG634','P634','JE1',TO_DATE('06/11/2019', 'DD/MM/YYYY'),'1201911064'  FROM dual UNION ALL 
  select 'PG635','P635','JE1',TO_DATE('06/11/2019', 'DD/MM/YYYY'),'1201911065'  FROM dual UNION ALL 
  select 'PG636','P636','JE6',TO_DATE('06/11/2019', 'DD/MM/YYYY'),'6201911066'  FROM dual UNION ALL 
  select 'PG637','P637','JE3',TO_DATE('06/11/2019', 'DD/MM/YYYY'),'3201911067'  FROM dual UNION ALL 
  select 'PG638','P638','JE5',TO_DATE('07/11/2019', 'DD/MM/YYYY'),'5201911071'  FROM dual UNION ALL 
  select 'PG639','P639','JE2',TO_DATE('07/11/2019', 'DD/MM/YYYY'),'2201911072'  FROM dual UNION ALL 
  select 'PG640','P640','JE6',TO_DATE('07/11/2019', 'DD/MM/YYYY'),'6201911073'  FROM dual UNION ALL 
  select 'PG641','P641','JE1',TO_DATE('07/11/2019', 'DD/MM/YYYY'),'1201911074'  FROM dual UNION ALL 
  select 'PG642','P642','JE1',TO_DATE('07/11/2019', 'DD/MM/YYYY'),'1201911075'  FROM dual UNION ALL 
  select 'PG643','P643','JE1',TO_DATE('07/11/2019', 'DD/MM/YYYY'),'1201911076'  FROM dual UNION ALL 
  select 'PG644','P644','JE2',TO_DATE('07/11/2019', 'DD/MM/YYYY'),'2201911077'  FROM dual UNION ALL 
  select 'PG645','P645','JE3',TO_DATE('08/11/2019', 'DD/MM/YYYY'),'3201911081'  FROM dual UNION ALL 
  select 'PG646','P646','JE1',TO_DATE('08/11/2019', 'DD/MM/YYYY'),'1201911082'  FROM dual UNION ALL 
  select 'PG647','P647','JE2',TO_DATE('08/11/2019', 'DD/MM/YYYY'),'2201911083'  FROM dual UNION ALL 
  select 'PG648','P648','JE5',TO_DATE('08/11/2019', 'DD/MM/YYYY'),'5201911084'  FROM dual UNION ALL 
  select 'PG649','P649','JE5',TO_DATE('08/11/2019', 'DD/MM/YYYY'),'5201911085'  FROM dual UNION ALL 
  select 'PG650','P650','JE5',TO_DATE('08/11/2019', 'DD/MM/YYYY'),'5201911086'  FROM dual UNION ALL 
  select 'PG651','P651','JE3',TO_DATE('08/11/2019', 'DD/MM/YYYY'),'3201911087'  FROM dual UNION ALL 
  select 'PG652','P652','JE3',TO_DATE('09/11/2019', 'DD/MM/YYYY'),'3201911091'  FROM dual UNION ALL 
  select 'PG653','P653','JE6',TO_DATE('09/11/2019', 'DD/MM/YYYY'),'6201911092'  FROM dual UNION ALL 
  select 'PG654','P654','JE3',TO_DATE('09/11/2019', 'DD/MM/YYYY'),'3201911093'  FROM dual UNION ALL 
  select 'PG655','P655','JE7',TO_DATE('09/11/2019', 'DD/MM/YYYY'),'7201911094'  FROM dual UNION ALL 
  select 'PG656','P656','JE2',TO_DATE('09/11/2019', 'DD/MM/YYYY'),'2201911095'  FROM dual UNION ALL 
  select 'PG657','P657','JE7',TO_DATE('09/11/2019', 'DD/MM/YYYY'),'7201911096'  FROM dual UNION ALL 
  select 'PG658','P658','JE6',TO_DATE('09/11/2019', 'DD/MM/YYYY'),'6201911097'  FROM dual UNION ALL 
  select 'PG659','P659','JE4',TO_DATE('10/11/2019', 'DD/MM/YYYY'),'4201911101'  FROM dual UNION ALL 
  select 'PG660','P660','JE6',TO_DATE('10/11/2019', 'DD/MM/YYYY'),'6201911102'  FROM dual UNION ALL 
  select 'PG661','P661','JE7',TO_DATE('10/11/2019', 'DD/MM/YYYY'),'7201911103'  FROM dual UNION ALL 
  select 'PG662','P662','JE1',TO_DATE('10/11/2019', 'DD/MM/YYYY'),'1201911104'  FROM dual UNION ALL 
  select 'PG663','P663','JE4',TO_DATE('10/11/2019', 'DD/MM/YYYY'),'4201911105'  FROM dual UNION ALL 
  select 'PG664','P664','JE5',TO_DATE('10/11/2019', 'DD/MM/YYYY'),'5201911106'  FROM dual UNION ALL 
  select 'PG665','P665','JE6',TO_DATE('10/11/2019', 'DD/MM/YYYY'),'6201911107'  FROM dual UNION ALL 
  select 'PG666','P666','JE6',TO_DATE('11/11/2019', 'DD/MM/YYYY'),'6201911111'  FROM dual UNION ALL 
  select 'PG667','P667','JE1',TO_DATE('11/11/2019', 'DD/MM/YYYY'),'1201911112'  FROM dual UNION ALL 
  select 'PG668','P668','JE4',TO_DATE('11/11/2019', 'DD/MM/YYYY'),'4201911113'  FROM dual UNION ALL 
  select 'PG669','P669','JE6',TO_DATE('11/11/2019', 'DD/MM/YYYY'),'6201911114'  FROM dual UNION ALL 
  select 'PG670','P670','JE6',TO_DATE('11/11/2019', 'DD/MM/YYYY'),'6201911115'  FROM dual UNION ALL 
  select 'PG671','P671','JE2',TO_DATE('11/11/2019', 'DD/MM/YYYY'),'2201911116'  FROM dual UNION ALL 
  select 'PG672','P672','JE5',TO_DATE('11/11/2019', 'DD/MM/YYYY'),'5201911117'  FROM dual UNION ALL 
  select 'PG673','P673','JE3',TO_DATE('12/11/2019', 'DD/MM/YYYY'),'3201911121'  FROM dual UNION ALL 
  select 'PG674','P674','JE3',TO_DATE('12/11/2019', 'DD/MM/YYYY'),'3201911122'  FROM dual UNION ALL 
  select 'PG675','P675','JE4',TO_DATE('12/11/2019', 'DD/MM/YYYY'),'4201911123'  FROM dual UNION ALL 
  select 'PG676','P676','JE4',TO_DATE('12/11/2019', 'DD/MM/YYYY'),'4201911124'  FROM dual UNION ALL 
  select 'PG677','P677','JE1',TO_DATE('12/11/2019', 'DD/MM/YYYY'),'1201911125'  FROM dual UNION ALL 
  select 'PG678','P678','JE6',TO_DATE('12/11/2019', 'DD/MM/YYYY'),'6201911126'  FROM dual UNION ALL 
  select 'PG679','P679','JE3',TO_DATE('12/11/2019', 'DD/MM/YYYY'),'3201911127'  FROM dual UNION ALL 
  select 'PG680','P680','JE6',TO_DATE('13/11/2019', 'DD/MM/YYYY'),'6201911131'  FROM dual UNION ALL 
  select 'PG681','P681','JE7',TO_DATE('13/11/2019', 'DD/MM/YYYY'),'7201911132'  FROM dual UNION ALL 
  select 'PG682','P682','JE3',TO_DATE('13/11/2019', 'DD/MM/YYYY'),'3201911133'  FROM dual UNION ALL 
  select 'PG683','P683','JE2',TO_DATE('13/11/2019', 'DD/MM/YYYY'),'2201911134'  FROM dual UNION ALL 
  select 'PG684','P684','JE2',TO_DATE('13/11/2019', 'DD/MM/YYYY'),'2201911135'  FROM dual UNION ALL 
  select 'PG685','P685','JE4',TO_DATE('13/11/2019', 'DD/MM/YYYY'),'4201911136'  FROM dual UNION ALL 
  select 'PG686','P686','JE2',TO_DATE('13/11/2019', 'DD/MM/YYYY'),'2201911137'  FROM dual UNION ALL 
  select 'PG687','P687','JE5',TO_DATE('14/11/2019', 'DD/MM/YYYY'),'5201911141'  FROM dual UNION ALL 
  select 'PG688','P688','JE6',TO_DATE('14/11/2019', 'DD/MM/YYYY'),'6201911142'  FROM dual UNION ALL 
  select 'PG689','P689','JE3',TO_DATE('14/11/2019', 'DD/MM/YYYY'),'3201911143'  FROM dual UNION ALL 
  select 'PG690','P690','JE7',TO_DATE('14/11/2019', 'DD/MM/YYYY'),'7201911144'  FROM dual UNION ALL 
  select 'PG691','P691','JE4',TO_DATE('14/11/2019', 'DD/MM/YYYY'),'4201911145'  FROM dual UNION ALL 
  select 'PG692','P692','JE3',TO_DATE('14/11/2019', 'DD/MM/YYYY'),'3201911146'  FROM dual UNION ALL 
  select 'PG693','P693','JE2',TO_DATE('14/11/2019', 'DD/MM/YYYY'),'2201911147'  FROM dual UNION ALL 
  select 'PG694','P694','JE3',TO_DATE('15/11/2019', 'DD/MM/YYYY'),'3201911151'  FROM dual UNION ALL 
  select 'PG695','P695','JE3',TO_DATE('15/11/2019', 'DD/MM/YYYY'),'3201911152'  FROM dual UNION ALL 
  select 'PG696','P696','JE5',TO_DATE('15/11/2019', 'DD/MM/YYYY'),'5201911153'  FROM dual UNION ALL 
  select 'PG697','P697','JE3',TO_DATE('15/11/2019', 'DD/MM/YYYY'),'3201911154'  FROM dual UNION ALL 
  select 'PG698','P698','JE3',TO_DATE('15/11/2019', 'DD/MM/YYYY'),'3201911155'  FROM dual UNION ALL 
  select 'PG699','P699','JE2',TO_DATE('15/11/2019', 'DD/MM/YYYY'),'2201911156'  FROM dual UNION ALL 
  select 'PG700','P700','JE5',TO_DATE('15/11/2019', 'DD/MM/YYYY'),'5201911157'  FROM dual UNION ALL 
  select 'PG701','P701','JE7',TO_DATE('16/11/2019', 'DD/MM/YYYY'),'7201911161'  FROM dual UNION ALL 
  select 'PG702','P702','JE5',TO_DATE('16/11/2019', 'DD/MM/YYYY'),'5201911162'  FROM dual UNION ALL 
  select 'PG703','P703','JE1',TO_DATE('16/11/2019', 'DD/MM/YYYY'),'1201911163'  FROM dual UNION ALL 
  select 'PG704','P704','JE5',TO_DATE('16/11/2019', 'DD/MM/YYYY'),'5201911164'  FROM dual UNION ALL 
  select 'PG705','P705','JE5',TO_DATE('16/11/2019', 'DD/MM/YYYY'),'5201911165'  FROM dual UNION ALL 
  select 'PG706','P706','JE2',TO_DATE('16/11/2019', 'DD/MM/YYYY'),'2201911166'  FROM dual UNION ALL 
  select 'PG707','P707','JE6',TO_DATE('16/11/2019', 'DD/MM/YYYY'),'6201911167'  FROM dual UNION ALL 
  select 'PG708','P708','JE7',TO_DATE('17/11/2019', 'DD/MM/YYYY'),'7201911171'  FROM dual UNION ALL 
  select 'PG709','P709','JE4',TO_DATE('17/11/2019', 'DD/MM/YYYY'),'4201911172'  FROM dual UNION ALL 
  select 'PG710','P710','JE4',TO_DATE('17/11/2019', 'DD/MM/YYYY'),'4201911173'  FROM dual UNION ALL 
  select 'PG711','P711','JE7',TO_DATE('17/11/2019', 'DD/MM/YYYY'),'7201911174'  FROM dual UNION ALL 
  select 'PG712','P712','JE1',TO_DATE('17/11/2019', 'DD/MM/YYYY'),'1201911175'  FROM dual UNION ALL 
  select 'PG713','P713','JE4',TO_DATE('17/11/2019', 'DD/MM/YYYY'),'4201911176'  FROM dual UNION ALL 
  select 'PG714','P714','JE5',TO_DATE('17/11/2019', 'DD/MM/YYYY'),'5201911177'  FROM dual UNION ALL 
  select 'PG715','P715','JE7',TO_DATE('18/11/2019', 'DD/MM/YYYY'),'7201911181'  FROM dual UNION ALL 
  select 'PG716','P716','JE2',TO_DATE('18/11/2019', 'DD/MM/YYYY'),'2201911182'  FROM dual UNION ALL 
  select 'PG717','P717','JE7',TO_DATE('18/11/2019', 'DD/MM/YYYY'),'7201911183'  FROM dual UNION ALL 
  select 'PG718','P718','JE1',TO_DATE('18/11/2019', 'DD/MM/YYYY'),'1201911184'  FROM dual UNION ALL 
  select 'PG719','P719','JE6',TO_DATE('18/11/2019', 'DD/MM/YYYY'),'6201911185'  FROM dual UNION ALL 
  select 'PG720','P720','JE5',TO_DATE('18/11/2019', 'DD/MM/YYYY'),'5201911186'  FROM dual UNION ALL 
  select 'PG721','P721','JE3',TO_DATE('18/11/2019', 'DD/MM/YYYY'),'3201911187'  FROM dual UNION ALL 
  select 'PG722','P722','JE1',TO_DATE('19/11/2019', 'DD/MM/YYYY'),'1201911191'  FROM dual UNION ALL 
  select 'PG723','P723','JE2',TO_DATE('19/11/2019', 'DD/MM/YYYY'),'2201911192'  FROM dual UNION ALL 
  select 'PG724','P724','JE4',TO_DATE('19/11/2019', 'DD/MM/YYYY'),'4201911193'  FROM dual UNION ALL 
  select 'PG725','P725','JE6',TO_DATE('19/11/2019', 'DD/MM/YYYY'),'6201911194'  FROM dual UNION ALL 
  select 'PG726','P726','JE2',TO_DATE('19/11/2019', 'DD/MM/YYYY'),'2201911195'  FROM dual UNION ALL 
  select 'PG727','P727','JE1',TO_DATE('19/11/2019', 'DD/MM/YYYY'),'1201911196'  FROM dual UNION ALL 
  select 'PG728','P728','JE7',TO_DATE('19/11/2019', 'DD/MM/YYYY'),'7201911197'  FROM dual UNION ALL 
  select 'PG729','P729','JE3',TO_DATE('20/11/2019', 'DD/MM/YYYY'),'3201911201'  FROM dual UNION ALL 
  select 'PG730','P730','JE4',TO_DATE('20/11/2019', 'DD/MM/YYYY'),'4201911202'  FROM dual UNION ALL 
  select 'PG731','P731','JE1',TO_DATE('20/11/2019', 'DD/MM/YYYY'),'1201911203'  FROM dual UNION ALL 
  select 'PG732','P732','JE7',TO_DATE('20/11/2019', 'DD/MM/YYYY'),'7201911204'  FROM dual UNION ALL 
  select 'PG733','P733','JE4',TO_DATE('20/11/2019', 'DD/MM/YYYY'),'4201911205'  FROM dual UNION ALL 
  select 'PG734','P734','JE5',TO_DATE('20/11/2019', 'DD/MM/YYYY'),'5201911206'  FROM dual UNION ALL 
  select 'PG735','P735','JE2',TO_DATE('20/11/2019', 'DD/MM/YYYY'),'2201911207'  FROM dual UNION ALL 
  select 'PG736','P736','JE2',TO_DATE('21/11/2019', 'DD/MM/YYYY'),'2201911211'  FROM dual UNION ALL 
  select 'PG737','P737','JE1',TO_DATE('21/11/2019', 'DD/MM/YYYY'),'1201911212'  FROM dual UNION ALL 
  select 'PG738','P738','JE3',TO_DATE('21/11/2019', 'DD/MM/YYYY'),'3201911213'  FROM dual UNION ALL 
  select 'PG739','P739','JE1',TO_DATE('21/11/2019', 'DD/MM/YYYY'),'1201911214'  FROM dual UNION ALL 
  select 'PG740','P740','JE3',TO_DATE('21/11/2019', 'DD/MM/YYYY'),'3201911215'  FROM dual UNION ALL 
  select 'PG741','P741','JE5',TO_DATE('21/11/2019', 'DD/MM/YYYY'),'5201911216'  FROM dual UNION ALL 
  select 'PG742','P742','JE7',TO_DATE('21/11/2019', 'DD/MM/YYYY'),'7201911217'  FROM dual UNION ALL 
  select 'PG743','P743','JE5',TO_DATE('22/11/2019', 'DD/MM/YYYY'),'5201911221'  FROM dual UNION ALL 
  select 'PG744','P744','JE5',TO_DATE('22/11/2019', 'DD/MM/YYYY'),'5201911222'  FROM dual UNION ALL 
  select 'PG745','P745','JE2',TO_DATE('22/11/2019', 'DD/MM/YYYY'),'2201911223'  FROM dual UNION ALL 
  select 'PG746','P746','JE2',TO_DATE('22/11/2019', 'DD/MM/YYYY'),'2201911224'  FROM dual UNION ALL 
  select 'PG747','P747','JE7',TO_DATE('22/11/2019', 'DD/MM/YYYY'),'7201911225'  FROM dual UNION ALL 
  select 'PG748','P748','JE1',TO_DATE('22/11/2019', 'DD/MM/YYYY'),'1201911226'  FROM dual UNION ALL 
  select 'PG749','P749','JE2',TO_DATE('22/11/2019', 'DD/MM/YYYY'),'2201911227'  FROM dual UNION ALL 
  select 'PG750','P750','JE3',TO_DATE('23/11/2019', 'DD/MM/YYYY'),'3201911231'  FROM dual UNION ALL 
  select 'PG751','P751','JE3',TO_DATE('23/11/2019', 'DD/MM/YYYY'),'3201911232'  FROM dual UNION ALL 
  select 'PG752','P752','JE5',TO_DATE('23/11/2019', 'DD/MM/YYYY'),'5201911233'  FROM dual UNION ALL 
  select 'PG753','P753','JE3',TO_DATE('23/11/2019', 'DD/MM/YYYY'),'3201911234'  FROM dual;

INSERT INTO PENGIRIMAN (ID_PENGIRIMAN, ID_PESANAN, ID_EKSPEDISI, TANGGAL_MENGIRIM, KODE_RESI) 
  select 'PG754','P754','JE3',TO_DATE('23/11/2019', 'DD/MM/YYYY'),'3201911235'  FROM dual UNION ALL 
  select 'PG755','P755','JE3',TO_DATE('23/11/2019', 'DD/MM/YYYY'),'3201911236'  FROM dual UNION ALL 
  select 'PG756','P756','JE1',TO_DATE('23/11/2019', 'DD/MM/YYYY'),'1201911237'  FROM dual UNION ALL 
  select 'PG757','P757','JE3',TO_DATE('24/11/2019', 'DD/MM/YYYY'),'3201911241'  FROM dual UNION ALL 
  select 'PG758','P758','JE5',TO_DATE('24/11/2019', 'DD/MM/YYYY'),'5201911242'  FROM dual UNION ALL 
  select 'PG759','P759','JE4',TO_DATE('24/11/2019', 'DD/MM/YYYY'),'4201911243'  FROM dual UNION ALL 
  select 'PG760','P760','JE3',TO_DATE('24/11/2019', 'DD/MM/YYYY'),'3201911244'  FROM dual UNION ALL 
  select 'PG761','P761','JE6',TO_DATE('24/11/2019', 'DD/MM/YYYY'),'6201911245'  FROM dual UNION ALL 
  select 'PG762','P762','JE2',TO_DATE('24/11/2019', 'DD/MM/YYYY'),'2201911246'  FROM dual UNION ALL 
  select 'PG763','P763','JE5',TO_DATE('24/11/2019', 'DD/MM/YYYY'),'5201911247'  FROM dual UNION ALL 
  select 'PG764','P764','JE5',TO_DATE('25/11/2019', 'DD/MM/YYYY'),'5201911251'  FROM dual UNION ALL 
  select 'PG765','P765','JE3',TO_DATE('25/11/2019', 'DD/MM/YYYY'),'3201911252'  FROM dual UNION ALL 
  select 'PG766','P766','JE7',TO_DATE('25/11/2019', 'DD/MM/YYYY'),'7201911253'  FROM dual UNION ALL 
  select 'PG767','P767','JE6',TO_DATE('25/11/2019', 'DD/MM/YYYY'),'6201911254'  FROM dual UNION ALL 
  select 'PG768','P768','JE5',TO_DATE('25/11/2019', 'DD/MM/YYYY'),'5201911255'  FROM dual UNION ALL 
  select 'PG769','P769','JE1',TO_DATE('25/11/2019', 'DD/MM/YYYY'),'1201911256'  FROM dual UNION ALL 
  select 'PG770','P770','JE1',TO_DATE('25/11/2019', 'DD/MM/YYYY'),'1201911257'  FROM dual UNION ALL 
  select 'PG771','P771','JE1',TO_DATE('26/11/2019', 'DD/MM/YYYY'),'1201911261'  FROM dual UNION ALL 
  select 'PG772','P772','JE2',TO_DATE('26/11/2019', 'DD/MM/YYYY'),'2201911262'  FROM dual UNION ALL 
  select 'PG773','P773','JE3',TO_DATE('26/11/2019', 'DD/MM/YYYY'),'3201911263'  FROM dual UNION ALL 
  select 'PG774','P774','JE1',TO_DATE('26/11/2019', 'DD/MM/YYYY'),'1201911264'  FROM dual UNION ALL 
  select 'PG775','P775','JE4',TO_DATE('26/11/2019', 'DD/MM/YYYY'),'4201911265'  FROM dual UNION ALL 
  select 'PG776','P776','JE6',TO_DATE('26/11/2019', 'DD/MM/YYYY'),'6201911266'  FROM dual UNION ALL 
  select 'PG777','P777','JE1',TO_DATE('26/11/2019', 'DD/MM/YYYY'),'1201911267'  FROM dual UNION ALL 
  select 'PG778','P778','JE5',TO_DATE('27/11/2019', 'DD/MM/YYYY'),'5201911271'  FROM dual UNION ALL 
  select 'PG779','P779','JE1',TO_DATE('27/11/2019', 'DD/MM/YYYY'),'1201911272'  FROM dual UNION ALL 
  select 'PG780','P780','JE5',TO_DATE('27/11/2019', 'DD/MM/YYYY'),'5201911273'  FROM dual UNION ALL 
  select 'PG781','P781','JE7',TO_DATE('27/11/2019', 'DD/MM/YYYY'),'7201911274'  FROM dual UNION ALL 
  select 'PG782','P782','JE5',TO_DATE('27/11/2019', 'DD/MM/YYYY'),'5201911275'  FROM dual UNION ALL 
  select 'PG783','P783','JE7',TO_DATE('27/11/2019', 'DD/MM/YYYY'),'7201911276'  FROM dual UNION ALL 
  select 'PG784','P784','JE4',TO_DATE('27/11/2019', 'DD/MM/YYYY'),'4201911277'  FROM dual UNION ALL 
  select 'PG785','P785','JE1',TO_DATE('28/11/2019', 'DD/MM/YYYY'),'1201911281'  FROM dual UNION ALL 
  select 'PG786','P786','JE2',TO_DATE('28/11/2019', 'DD/MM/YYYY'),'2201911282'  FROM dual UNION ALL 
  select 'PG787','P787','JE5',TO_DATE('28/11/2019', 'DD/MM/YYYY'),'5201911283'  FROM dual UNION ALL 
  select 'PG788','P788','JE7',TO_DATE('28/11/2019', 'DD/MM/YYYY'),'7201911284'  FROM dual UNION ALL 
  select 'PG789','P789','JE7',TO_DATE('28/11/2019', 'DD/MM/YYYY'),'7201911285'  FROM dual UNION ALL 
  select 'PG790','P790','JE1',TO_DATE('28/11/2019', 'DD/MM/YYYY'),'1201911286'  FROM dual UNION ALL 
  select 'PG791','P791','JE5',TO_DATE('28/11/2019', 'DD/MM/YYYY'),'5201911287'  FROM dual UNION ALL 
  select 'PG792','P792','JE1',TO_DATE('29/11/2019', 'DD/MM/YYYY'),'1201911291'  FROM dual UNION ALL 
  select 'PG793','P793','JE2',TO_DATE('29/11/2019', 'DD/MM/YYYY'),'2201911292'  FROM dual UNION ALL 
  select 'PG794','P794','JE2',TO_DATE('29/11/2019', 'DD/MM/YYYY'),'2201911293'  FROM dual UNION ALL 
  select 'PG795','P795','JE7',TO_DATE('29/11/2019', 'DD/MM/YYYY'),'7201911294'  FROM dual UNION ALL 
  select 'PG796','P796','JE7',TO_DATE('29/11/2019', 'DD/MM/YYYY'),'7201911295'  FROM dual UNION ALL 
  select 'PG797','P797','JE3',TO_DATE('29/11/2019', 'DD/MM/YYYY'),'3201911296'  FROM dual UNION ALL 
  select 'PG798','P798','JE4',TO_DATE('29/11/2019', 'DD/MM/YYYY'),'4201911297'  FROM dual UNION ALL 
  select 'PG799','P799','JE3',TO_DATE('30/11/2019', 'DD/MM/YYYY'),'3201911301'  FROM dual UNION ALL 
  select 'PG800','P800','JE5',TO_DATE('30/11/2019', 'DD/MM/YYYY'),'5201911302'  FROM dual UNION ALL 
  select 'PG801','P801','JE5',TO_DATE('30/11/2019', 'DD/MM/YYYY'),'5201911303'  FROM dual UNION ALL 
  select 'PG802','P802','JE6',TO_DATE('30/11/2019', 'DD/MM/YYYY'),'6201911304'  FROM dual UNION ALL 
  select 'PG803','P803','JE3',TO_DATE('30/11/2019', 'DD/MM/YYYY'),'3201911305'  FROM dual UNION ALL 
  select 'PG804','P804','JE1',TO_DATE('30/11/2019', 'DD/MM/YYYY'),'1201911306'  FROM dual UNION ALL 
  select 'PG805','P805','JE5',TO_DATE('30/11/2019', 'DD/MM/YYYY'),'5201911307'  FROM dual UNION ALL 
  select 'PG806','P806','JE4',TO_DATE('01/12/2019', 'DD/MM/YYYY'),'4201912011'  FROM dual UNION ALL 
  select 'PG807','P807','JE6',TO_DATE('01/12/2019', 'DD/MM/YYYY'),'6201912012'  FROM dual UNION ALL 
  select 'PG808','P808','JE1',TO_DATE('01/12/2019', 'DD/MM/YYYY'),'1201912013'  FROM dual UNION ALL 
  select 'PG809','P809','JE7',TO_DATE('01/12/2019', 'DD/MM/YYYY'),'7201912014'  FROM dual UNION ALL 
  select 'PG810','P810','JE6',TO_DATE('01/12/2019', 'DD/MM/YYYY'),'6201912015'  FROM dual UNION ALL 
  select 'PG811','P811','JE3',TO_DATE('01/12/2019', 'DD/MM/YYYY'),'3201912016'  FROM dual UNION ALL 
  select 'PG812','P812','JE7',TO_DATE('01/12/2019', 'DD/MM/YYYY'),'7201912017'  FROM dual UNION ALL 
  select 'PG813','P813','JE7',TO_DATE('02/12/2019', 'DD/MM/YYYY'),'7201912021'  FROM dual UNION ALL 
  select 'PG814','P814','JE4',TO_DATE('02/12/2019', 'DD/MM/YYYY'),'4201912022'  FROM dual UNION ALL 
  select 'PG815','P815','JE1',TO_DATE('02/12/2019', 'DD/MM/YYYY'),'1201912023'  FROM dual UNION ALL 
  select 'PG816','P816','JE6',TO_DATE('02/12/2019', 'DD/MM/YYYY'),'6201912024'  FROM dual UNION ALL 
  select 'PG817','P817','JE2',TO_DATE('02/12/2019', 'DD/MM/YYYY'),'2201912025'  FROM dual UNION ALL 
  select 'PG818','P818','JE3',TO_DATE('02/12/2019', 'DD/MM/YYYY'),'3201912026'  FROM dual UNION ALL 
  select 'PG819','P819','JE1',TO_DATE('02/12/2019', 'DD/MM/YYYY'),'1201912027'  FROM dual UNION ALL 
  select 'PG820','P820','JE1',TO_DATE('03/12/2019', 'DD/MM/YYYY'),'1201912031'  FROM dual UNION ALL 
  select 'PG821','P821','JE3',TO_DATE('03/12/2019', 'DD/MM/YYYY'),'3201912032'  FROM dual UNION ALL 
  select 'PG822','P822','JE1',TO_DATE('03/12/2019', 'DD/MM/YYYY'),'1201912033'  FROM dual UNION ALL 
  select 'PG823','P823','JE3',TO_DATE('03/12/2019', 'DD/MM/YYYY'),'3201912034'  FROM dual UNION ALL 
  select 'PG824','P824','JE5',TO_DATE('03/12/2019', 'DD/MM/YYYY'),'5201912035'  FROM dual UNION ALL 
  select 'PG825','P825','JE6',TO_DATE('03/12/2019', 'DD/MM/YYYY'),'6201912036'  FROM dual UNION ALL 
  select 'PG826','P826','JE5',TO_DATE('03/12/2019', 'DD/MM/YYYY'),'5201912037'  FROM dual UNION ALL 
  select 'PG827','P827','JE3',TO_DATE('04/12/2019', 'DD/MM/YYYY'),'3201912041'  FROM dual UNION ALL 
  select 'PG828','P828','JE1',TO_DATE('04/12/2019', 'DD/MM/YYYY'),'1201912042'  FROM dual UNION ALL 
  select 'PG829','P829','JE6',TO_DATE('04/12/2019', 'DD/MM/YYYY'),'6201912043'  FROM dual UNION ALL 
  select 'PG830','P830','JE4',TO_DATE('04/12/2019', 'DD/MM/YYYY'),'4201912044'  FROM dual UNION ALL 
  select 'PG831','P831','JE5',TO_DATE('04/12/2019', 'DD/MM/YYYY'),'5201912045'  FROM dual UNION ALL 
  select 'PG832','P832','JE5',TO_DATE('04/12/2019', 'DD/MM/YYYY'),'5201912046'  FROM dual UNION ALL 
  select 'PG833','P833','JE3',TO_DATE('04/12/2019', 'DD/MM/YYYY'),'3201912047'  FROM dual UNION ALL 
  select 'PG834','P834','JE7',TO_DATE('05/12/2019', 'DD/MM/YYYY'),'7201912051'  FROM dual UNION ALL 
  select 'PG835','P835','JE5',TO_DATE('05/12/2019', 'DD/MM/YYYY'),'5201912052'  FROM dual UNION ALL 
  select 'PG836','P836','JE4',TO_DATE('05/12/2019', 'DD/MM/YYYY'),'4201912053'  FROM dual UNION ALL 
  select 'PG837','P837','JE7',TO_DATE('05/12/2019', 'DD/MM/YYYY'),'7201912054'  FROM dual UNION ALL 
  select 'PG838','P838','JE1',TO_DATE('05/12/2019', 'DD/MM/YYYY'),'1201912055'  FROM dual UNION ALL 
  select 'PG839','P839','JE7',TO_DATE('05/12/2019', 'DD/MM/YYYY'),'7201912056'  FROM dual UNION ALL 
  select 'PG840','P840','JE7',TO_DATE('05/12/2019', 'DD/MM/YYYY'),'7201912057'  FROM dual UNION ALL 
  select 'PG841','P841','JE4',TO_DATE('06/12/2019', 'DD/MM/YYYY'),'4201912061'  FROM dual UNION ALL 
  select 'PG842','P842','JE6',TO_DATE('06/12/2019', 'DD/MM/YYYY'),'6201912062'  FROM dual UNION ALL 
  select 'PG843','P843','JE3',TO_DATE('06/12/2019', 'DD/MM/YYYY'),'3201912063'  FROM dual UNION ALL 
  select 'PG844','P844','JE3',TO_DATE('06/12/2019', 'DD/MM/YYYY'),'3201912064'  FROM dual UNION ALL 
  select 'PG845','P845','JE3',TO_DATE('06/12/2019', 'DD/MM/YYYY'),'3201912065'  FROM dual UNION ALL 
  select 'PG846','P846','JE2',TO_DATE('06/12/2019', 'DD/MM/YYYY'),'2201912066'  FROM dual UNION ALL 
  select 'PG847','P847','JE5',TO_DATE('06/12/2019', 'DD/MM/YYYY'),'5201912067'  FROM dual UNION ALL 
  select 'PG848','P848','JE3',TO_DATE('07/12/2019', 'DD/MM/YYYY'),'3201912071'  FROM dual UNION ALL 
  select 'PG849','P849','JE6',TO_DATE('07/12/2019', 'DD/MM/YYYY'),'6201912072'  FROM dual UNION ALL 
  select 'PG850','P850','JE7',TO_DATE('07/12/2019', 'DD/MM/YYYY'),'7201912073'  FROM dual UNION ALL 
  select 'PG851','P851','JE5',TO_DATE('07/12/2019', 'DD/MM/YYYY'),'5201912074'  FROM dual UNION ALL 
  select 'PG852','P852','JE3',TO_DATE('07/12/2019', 'DD/MM/YYYY'),'3201912075'  FROM dual UNION ALL 
  select 'PG853','P853','JE2',TO_DATE('07/12/2019', 'DD/MM/YYYY'),'2201912076'  FROM dual UNION ALL 
  select 'PG854','P854','JE4',TO_DATE('07/12/2019', 'DD/MM/YYYY'),'4201912077'  FROM dual UNION ALL 
  select 'PG855','P855','JE5',TO_DATE('08/12/2019', 'DD/MM/YYYY'),'5201912081'  FROM dual UNION ALL 
  select 'PG856','P856','JE6',TO_DATE('08/12/2019', 'DD/MM/YYYY'),'6201912082'  FROM dual UNION ALL 
  select 'PG857','P857','JE2',TO_DATE('08/12/2019', 'DD/MM/YYYY'),'2201912083'  FROM dual UNION ALL 
  select 'PG858','P858','JE7',TO_DATE('08/12/2019', 'DD/MM/YYYY'),'7201912084'  FROM dual UNION ALL 
  select 'PG859','P859','JE2',TO_DATE('08/12/2019', 'DD/MM/YYYY'),'2201912085'  FROM dual UNION ALL 
  select 'PG860','P860','JE5',TO_DATE('08/12/2019', 'DD/MM/YYYY'),'5201912086'  FROM dual UNION ALL 
  select 'PG861','P861','JE1',TO_DATE('08/12/2019', 'DD/MM/YYYY'),'1201912087'  FROM dual UNION ALL 
  select 'PG862','P862','JE4',TO_DATE('09/12/2019', 'DD/MM/YYYY'),'4201912091'  FROM dual UNION ALL 
  select 'PG863','P863','JE1',TO_DATE('09/12/2019', 'DD/MM/YYYY'),'1201912092'  FROM dual UNION ALL 
  select 'PG864','P864','JE7',TO_DATE('09/12/2019', 'DD/MM/YYYY'),'7201912093'  FROM dual UNION ALL 
  select 'PG865','P865','JE4',TO_DATE('09/12/2019', 'DD/MM/YYYY'),'4201912094'  FROM dual UNION ALL 
  select 'PG866','P866','JE2',TO_DATE('09/12/2019', 'DD/MM/YYYY'),'2201912095'  FROM dual UNION ALL 
  select 'PG867','P867','JE7',TO_DATE('09/12/2019', 'DD/MM/YYYY'),'7201912096'  FROM dual UNION ALL 
  select 'PG868','P868','JE1',TO_DATE('09/12/2019', 'DD/MM/YYYY'),'1201912097'  FROM dual UNION ALL 
  select 'PG869','P869','JE7',TO_DATE('10/12/2019', 'DD/MM/YYYY'),'7201912101'  FROM dual UNION ALL 
  select 'PG870','P870','JE5',TO_DATE('10/12/2019', 'DD/MM/YYYY'),'5201912102'  FROM dual UNION ALL 
  select 'PG871','P871','JE6',TO_DATE('10/12/2019', 'DD/MM/YYYY'),'6201912103'  FROM dual UNION ALL 
  select 'PG872','P872','JE3',TO_DATE('10/12/2019', 'DD/MM/YYYY'),'3201912104'  FROM dual UNION ALL 
  select 'PG873','P873','JE3',TO_DATE('10/12/2019', 'DD/MM/YYYY'),'3201912105'  FROM dual UNION ALL 
  select 'PG874','P874','JE3',TO_DATE('10/12/2019', 'DD/MM/YYYY'),'3201912106'  FROM dual UNION ALL 
  select 'PG875','P875','JE4',TO_DATE('10/12/2019', 'DD/MM/YYYY'),'4201912107'  FROM dual UNION ALL 
  select 'PG876','P876','JE7',TO_DATE('11/12/2019', 'DD/MM/YYYY'),'7201912111'  FROM dual UNION ALL 
  select 'PG877','P877','JE3',TO_DATE('11/12/2019', 'DD/MM/YYYY'),'3201912112'  FROM dual UNION ALL 
  select 'PG878','P878','JE4',TO_DATE('11/12/2019', 'DD/MM/YYYY'),'4201912113'  FROM dual UNION ALL 
  select 'PG879','P879','JE2',TO_DATE('11/12/2019', 'DD/MM/YYYY'),'2201912114'  FROM dual UNION ALL 
  select 'PG880','P880','JE7',TO_DATE('11/12/2019', 'DD/MM/YYYY'),'7201912115'  FROM dual UNION ALL 
  select 'PG881','P881','JE1',TO_DATE('11/12/2019', 'DD/MM/YYYY'),'1201912116'  FROM dual UNION ALL 
  select 'PG882','P882','JE5',TO_DATE('11/12/2019', 'DD/MM/YYYY'),'5201912117'  FROM dual UNION ALL 
  select 'PG883','P883','JE4',TO_DATE('12/12/2019', 'DD/MM/YYYY'),'4201912121'  FROM dual UNION ALL 
  select 'PG884','P884','JE7',TO_DATE('12/12/2019', 'DD/MM/YYYY'),'7201912122'  FROM dual UNION ALL 
  select 'PG885','P885','JE2',TO_DATE('12/12/2019', 'DD/MM/YYYY'),'2201912123'  FROM dual UNION ALL 
  select 'PG886','P886','JE4',TO_DATE('12/12/2019', 'DD/MM/YYYY'),'4201912124'  FROM dual UNION ALL 
  select 'PG887','P887','JE7',TO_DATE('12/12/2019', 'DD/MM/YYYY'),'7201912125'  FROM dual UNION ALL 
  select 'PG888','P888','JE5',TO_DATE('12/12/2019', 'DD/MM/YYYY'),'5201912126'  FROM dual UNION ALL 
  select 'PG889','P889','JE2',TO_DATE('12/12/2019', 'DD/MM/YYYY'),'2201912127'  FROM dual UNION ALL 
  select 'PG890','P890','JE4',TO_DATE('13/12/2019', 'DD/MM/YYYY'),'4201912131'  FROM dual UNION ALL 
  select 'PG891','P891','JE6',TO_DATE('13/12/2019', 'DD/MM/YYYY'),'6201912132'  FROM dual UNION ALL 
  select 'PG892','P892','JE2',TO_DATE('13/12/2019', 'DD/MM/YYYY'),'2201912133'  FROM dual UNION ALL 
  select 'PG893','P893','JE5',TO_DATE('13/12/2019', 'DD/MM/YYYY'),'5201912134'  FROM dual UNION ALL 
  select 'PG894','P894','JE4',TO_DATE('13/12/2019', 'DD/MM/YYYY'),'4201912135'  FROM dual UNION ALL 
  select 'PG895','P895','JE4',TO_DATE('13/12/2019', 'DD/MM/YYYY'),'4201912136'  FROM dual UNION ALL 
  select 'PG896','P896','JE1',TO_DATE('13/12/2019', 'DD/MM/YYYY'),'1201912137'  FROM dual UNION ALL 
  select 'PG897','P897','JE4',TO_DATE('14/12/2019', 'DD/MM/YYYY'),'4201912141'  FROM dual UNION ALL 
  select 'PG898','P898','JE7',TO_DATE('14/12/2019', 'DD/MM/YYYY'),'7201912142'  FROM dual UNION ALL 
  select 'PG899','P899','JE3',TO_DATE('14/12/2019', 'DD/MM/YYYY'),'3201912143'  FROM dual UNION ALL 
  select 'PG900','P900','JE2',TO_DATE('14/12/2019', 'DD/MM/YYYY'),'2201912144'  FROM dual UNION ALL 
  select 'PG901','P901','JE7',TO_DATE('14/12/2019', 'DD/MM/YYYY'),'7201912145'  FROM dual UNION ALL 
  select 'PG902','P902','JE7',TO_DATE('14/12/2019', 'DD/MM/YYYY'),'7201912146'  FROM dual UNION ALL 
  select 'PG903','P903','JE4',TO_DATE('14/12/2019', 'DD/MM/YYYY'),'4201912147'  FROM dual UNION ALL 
  select 'PG904','P904','JE2',TO_DATE('15/12/2019', 'DD/MM/YYYY'),'2201912151'  FROM dual UNION ALL 
  select 'PG905','P905','JE6',TO_DATE('15/12/2019', 'DD/MM/YYYY'),'6201912152'  FROM dual UNION ALL 
  select 'PG906','P906','JE2',TO_DATE('15/12/2019', 'DD/MM/YYYY'),'2201912153'  FROM dual UNION ALL 
  select 'PG907','P907','JE6',TO_DATE('15/12/2019', 'DD/MM/YYYY'),'6201912154'  FROM dual UNION ALL 
  select 'PG908','P908','JE4',TO_DATE('15/12/2019', 'DD/MM/YYYY'),'4201912155'  FROM dual UNION ALL 
  select 'PG909','P909','JE4',TO_DATE('15/12/2019', 'DD/MM/YYYY'),'4201912156'  FROM dual UNION ALL 
  select 'PG910','P910','JE1',TO_DATE('15/12/2019', 'DD/MM/YYYY'),'1201912157'  FROM dual UNION ALL 
  select 'PG911','P911','JE2',TO_DATE('16/12/2019', 'DD/MM/YYYY'),'2201912161'  FROM dual UNION ALL 
  select 'PG912','P912','JE7',TO_DATE('16/12/2019', 'DD/MM/YYYY'),'7201912162'  FROM dual UNION ALL 
  select 'PG913','P913','JE3',TO_DATE('16/12/2019', 'DD/MM/YYYY'),'3201912163'  FROM dual UNION ALL 
  select 'PG914','P914','JE4',TO_DATE('16/12/2019', 'DD/MM/YYYY'),'4201912164'  FROM dual UNION ALL 
  select 'PG915','P915','JE7',TO_DATE('16/12/2019', 'DD/MM/YYYY'),'7201912165'  FROM dual UNION ALL 
  select 'PG916','P916','JE1',TO_DATE('16/12/2019', 'DD/MM/YYYY'),'1201912166'  FROM dual UNION ALL 
  select 'PG917','P917','JE6',TO_DATE('16/12/2019', 'DD/MM/YYYY'),'6201912167'  FROM dual UNION ALL 
  select 'PG918','P918','JE5',TO_DATE('17/12/2019', 'DD/MM/YYYY'),'5201912171'  FROM dual UNION ALL 
  select 'PG919','P919','JE3',TO_DATE('17/12/2019', 'DD/MM/YYYY'),'3201912172'  FROM dual UNION ALL 
  select 'PG920','P920','JE4',TO_DATE('17/12/2019', 'DD/MM/YYYY'),'4201912173'  FROM dual UNION ALL 
  select 'PG921','P921','JE6',TO_DATE('17/12/2019', 'DD/MM/YYYY'),'6201912174'  FROM dual UNION ALL 
  select 'PG922','P922','JE2',TO_DATE('17/12/2019', 'DD/MM/YYYY'),'2201912175'  FROM dual UNION ALL 
  select 'PG923','P923','JE7',TO_DATE('17/12/2019', 'DD/MM/YYYY'),'7201912176'  FROM dual UNION ALL 
  select 'PG924','P924','JE6',TO_DATE('17/12/2019', 'DD/MM/YYYY'),'6201912177'  FROM dual UNION ALL 
  select 'PG925','P925','JE2',TO_DATE('18/12/2019', 'DD/MM/YYYY'),'2201912181'  FROM dual UNION ALL 
  select 'PG926','P926','JE1',TO_DATE('18/12/2019', 'DD/MM/YYYY'),'1201912182'  FROM dual UNION ALL 
  select 'PG927','P927','JE4',TO_DATE('18/12/2019', 'DD/MM/YYYY'),'4201912183'  FROM dual UNION ALL 
  select 'PG928','P928','JE6',TO_DATE('18/12/2019', 'DD/MM/YYYY'),'6201912184'  FROM dual UNION ALL 
  select 'PG929','P929','JE5',TO_DATE('18/12/2019', 'DD/MM/YYYY'),'5201912185'  FROM dual UNION ALL 
  select 'PG930','P930','JE1',TO_DATE('18/12/2019', 'DD/MM/YYYY'),'1201912186'  FROM dual UNION ALL 
  select 'PG931','P931','JE7',TO_DATE('18/12/2019', 'DD/MM/YYYY'),'7201912187'  FROM dual UNION ALL 
  select 'PG932','P932','JE6',TO_DATE('19/12/2019', 'DD/MM/YYYY'),'6201912191'  FROM dual UNION ALL 
  select 'PG933','P933','JE7',TO_DATE('19/12/2019', 'DD/MM/YYYY'),'7201912192'  FROM dual UNION ALL 
  select 'PG934','P934','JE4',TO_DATE('19/12/2019', 'DD/MM/YYYY'),'4201912193'  FROM dual UNION ALL 
  select 'PG935','P935','JE3',TO_DATE('19/12/2019', 'DD/MM/YYYY'),'3201912194'  FROM dual UNION ALL 
  select 'PG936','P936','JE5',TO_DATE('19/12/2019', 'DD/MM/YYYY'),'5201912195'  FROM dual UNION ALL 
  select 'PG937','P937','JE1',TO_DATE('19/12/2019', 'DD/MM/YYYY'),'1201912196'  FROM dual UNION ALL 
  select 'PG938','P938','JE2',TO_DATE('19/12/2019', 'DD/MM/YYYY'),'2201912197'  FROM dual UNION ALL 
  select 'PG939','P939','JE1',TO_DATE('20/12/2019', 'DD/MM/YYYY'),'1201912201'  FROM dual UNION ALL 
  select 'PG940','P940','JE2',TO_DATE('20/12/2019', 'DD/MM/YYYY'),'2201912202'  FROM dual UNION ALL 
  select 'PG941','P941','JE1',TO_DATE('20/12/2019', 'DD/MM/YYYY'),'1201912203'  FROM dual UNION ALL 
  select 'PG942','P942','JE4',TO_DATE('20/12/2019', 'DD/MM/YYYY'),'4201912204'  FROM dual UNION ALL 
  select 'PG943','P943','JE3',TO_DATE('20/12/2019', 'DD/MM/YYYY'),'3201912205'  FROM dual UNION ALL 
  select 'PG944','P944','JE4',TO_DATE('20/12/2019', 'DD/MM/YYYY'),'4201912206'  FROM dual UNION ALL 
  select 'PG945','P945','JE4',TO_DATE('20/12/2019', 'DD/MM/YYYY'),'4201912207'  FROM dual UNION ALL 
  select 'PG946','P946','JE6',TO_DATE('21/12/2019', 'DD/MM/YYYY'),'6201912211'  FROM dual UNION ALL 
  select 'PG947','P947','JE7',TO_DATE('21/12/2019', 'DD/MM/YYYY'),'7201912212'  FROM dual UNION ALL 
  select 'PG948','P948','JE1',TO_DATE('21/12/2019', 'DD/MM/YYYY'),'1201912213'  FROM dual UNION ALL 
  select 'PG949','P949','JE5',TO_DATE('21/12/2019', 'DD/MM/YYYY'),'5201912214'  FROM dual UNION ALL 
  select 'PG950','P950','JE7',TO_DATE('21/12/2019', 'DD/MM/YYYY'),'7201912215'  FROM dual UNION ALL 
  select 'PG951','P951','JE4',TO_DATE('21/12/2019', 'DD/MM/YYYY'),'4201912216'  FROM dual UNION ALL 
  select 'PG952','P952','JE3',TO_DATE('21/12/2019', 'DD/MM/YYYY'),'3201912217'  FROM dual UNION ALL 
  select 'PG953','P953','JE2',TO_DATE('22/12/2019', 'DD/MM/YYYY'),'2201912221'  FROM dual UNION ALL 
  select 'PG954','P954','JE1',TO_DATE('22/12/2019', 'DD/MM/YYYY'),'1201912222'  FROM dual UNION ALL 
  select 'PG955','P955','JE7',TO_DATE('22/12/2019', 'DD/MM/YYYY'),'7201912223'  FROM dual UNION ALL 
  select 'PG956','P956','JE3',TO_DATE('22/12/2019', 'DD/MM/YYYY'),'3201912224'  FROM dual UNION ALL 
  select 'PG957','P957','JE1',TO_DATE('22/12/2019', 'DD/MM/YYYY'),'1201912225'  FROM dual UNION ALL 
  select 'PG958','P958','JE1',TO_DATE('22/12/2019', 'DD/MM/YYYY'),'1201912226'  FROM dual UNION ALL 
  select 'PG959','P959','JE1',TO_DATE('22/12/2019', 'DD/MM/YYYY'),'1201912227'  FROM dual UNION ALL 
  select 'PG960','P960','JE1',TO_DATE('23/12/2019', 'DD/MM/YYYY'),'1201912231'  FROM dual UNION ALL 
  select 'PG961','P961','JE5',TO_DATE('23/12/2019', 'DD/MM/YYYY'),'5201912232'  FROM dual UNION ALL 
  select 'PG962','P962','JE3',TO_DATE('23/12/2019', 'DD/MM/YYYY'),'3201912233'  FROM dual UNION ALL 
  select 'PG963','P963','JE6',TO_DATE('23/12/2019', 'DD/MM/YYYY'),'6201912234'  FROM dual UNION ALL 
  select 'PG964','P964','JE7',TO_DATE('23/12/2019', 'DD/MM/YYYY'),'7201912235'  FROM dual UNION ALL 
  select 'PG965','P965','JE3',TO_DATE('23/12/2019', 'DD/MM/YYYY'),'3201912236'  FROM dual UNION ALL 
  select 'PG966','P966','JE2',TO_DATE('23/12/2019', 'DD/MM/YYYY'),'2201912237'  FROM dual UNION ALL 
  select 'PG967','P967','JE2',TO_DATE('24/12/2019', 'DD/MM/YYYY'),'2201912241'  FROM dual UNION ALL 
  select 'PG968','P968','JE7',TO_DATE('24/12/2019', 'DD/MM/YYYY'),'7201912242'  FROM dual UNION ALL 
  select 'PG969','P969','JE3',TO_DATE('24/12/2019', 'DD/MM/YYYY'),'3201912243'  FROM dual UNION ALL 
  select 'PG970','P970','JE1',TO_DATE('24/12/2019', 'DD/MM/YYYY'),'1201912244'  FROM dual UNION ALL 
  select 'PG971','P971','JE4',TO_DATE('24/12/2019', 'DD/MM/YYYY'),'4201912245'  FROM dual UNION ALL 
  select 'PG972','P972','JE3',TO_DATE('24/12/2019', 'DD/MM/YYYY'),'3201912246'  FROM dual UNION ALL 
  select 'PG973','P973','JE2',TO_DATE('24/12/2019', 'DD/MM/YYYY'),'2201912247'  FROM dual UNION ALL 
  select 'PG974','P974','JE5',TO_DATE('25/12/2019', 'DD/MM/YYYY'),'5201912251'  FROM dual UNION ALL 
  select 'PG975','P975','JE7',TO_DATE('25/12/2019', 'DD/MM/YYYY'),'7201912252'  FROM dual UNION ALL 
  select 'PG976','P976','JE2',TO_DATE('25/12/2019', 'DD/MM/YYYY'),'2201912253'  FROM dual UNION ALL 
  select 'PG977','P977','JE2',TO_DATE('25/12/2019', 'DD/MM/YYYY'),'2201912254'  FROM dual UNION ALL 
  select 'PG978','P978','JE3',TO_DATE('25/12/2019', 'DD/MM/YYYY'),'3201912255'  FROM dual UNION ALL 
  select 'PG979','P979','JE2',TO_DATE('25/12/2019', 'DD/MM/YYYY'),'2201912256'  FROM dual UNION ALL 
  select 'PG980','P980','JE7',TO_DATE('25/12/2019', 'DD/MM/YYYY'),'7201912257'  FROM dual UNION ALL 
  select 'PG981','P981','JE4',TO_DATE('26/12/2019', 'DD/MM/YYYY'),'4201912261'  FROM dual UNION ALL 
  select 'PG982','P982','JE5',TO_DATE('26/12/2019', 'DD/MM/YYYY'),'5201912262'  FROM dual UNION ALL 
  select 'PG983','P983','JE1',TO_DATE('26/12/2019', 'DD/MM/YYYY'),'1201912263'  FROM dual;

INSERT INTO PENGIRIMAN (ID_PENGIRIMAN, ID_PESANAN, ID_EKSPEDISI, TANGGAL_MENGIRIM, KODE_RESI) 
select 'PG984','P984','JE1',TO_DATE('26/12/2019', 'DD/MM/YYYY'),'1201912264'  FROM dual UNION ALL 
  select 'PG985','P985','JE7',TO_DATE('26/12/2019', 'DD/MM/YYYY'),'7201912265'  FROM dual UNION ALL 
  select 'PG986','P986','JE5',TO_DATE('26/12/2019', 'DD/MM/YYYY'),'5201912266'  FROM dual UNION ALL 
  select 'PG987','P987','JE6',TO_DATE('26/12/2019', 'DD/MM/YYYY'),'6201912267'  FROM dual UNION ALL 
  select 'PG988','P988','JE6',TO_DATE('27/12/2019', 'DD/MM/YYYY'),'6201912271'  FROM dual UNION ALL 
  select 'PG989','P989','JE1',TO_DATE('27/12/2019', 'DD/MM/YYYY'),'1201912272'  FROM dual UNION ALL 
  select 'PG990','P990','JE5',TO_DATE('27/12/2019', 'DD/MM/YYYY'),'5201912273'  FROM dual UNION ALL 
  select 'PG991','P991','JE1',TO_DATE('27/12/2019', 'DD/MM/YYYY'),'1201912274'  FROM dual UNION ALL 
  select 'PG992','P992','JE4',TO_DATE('27/12/2019', 'DD/MM/YYYY'),'4201912275'  FROM dual UNION ALL 
  select 'PG993','P993','JE5',TO_DATE('27/12/2019', 'DD/MM/YYYY'),'5201912276'  FROM dual UNION ALL 
  select 'PG994','P994','JE5',TO_DATE('27/12/2019', 'DD/MM/YYYY'),'5201912277'  FROM dual UNION ALL 
  select 'PG995','P995','JE3',TO_DATE('28/12/2019', 'DD/MM/YYYY'),'3201912281'  FROM dual UNION ALL 
  select 'PG996','P996','JE2',TO_DATE('28/12/2019', 'DD/MM/YYYY'),'2201912282'  FROM dual UNION ALL 
  select 'PG997','P997','JE1',TO_DATE('28/12/2019', 'DD/MM/YYYY'),'1201912283'  FROM dual UNION ALL 
  select 'PG998','P998','JE1',TO_DATE('28/12/2019', 'DD/MM/YYYY'),'1201912284'  FROM dual UNION ALL 
  select 'PG999','P999','JE7',TO_DATE('28/12/2019', 'DD/MM/YYYY'),'7201912285'  FROM dual UNION ALL 
  select 'PG1000','P1000','JE3',TO_DATE('28/12/2019', 'DD/MM/YYYY'),'3201912286'  FROM dual UNION ALL 
  select 'PG1001','P1001','JE7',TO_DATE('28/12/2019', 'DD/MM/YYYY'),'7201912287'  FROM dual UNION ALL 
  select 'PG1002','P1002','JE6',TO_DATE('29/12/2019', 'DD/MM/YYYY'),'6201912291'  FROM dual UNION ALL 
  select 'PG1003','P1003','JE3',TO_DATE('29/12/2019', 'DD/MM/YYYY'),'3201912292'  FROM dual UNION ALL 
  select 'PG1004','P1004','JE6',TO_DATE('29/12/2019', 'DD/MM/YYYY'),'6201912293'  FROM dual UNION ALL 
  select 'PG1005','P1005','JE7',TO_DATE('29/12/2019', 'DD/MM/YYYY'),'7201912294'  FROM dual UNION ALL 
  select 'PG1006','P1006','JE4',TO_DATE('29/12/2019', 'DD/MM/YYYY'),'4201912295'  FROM dual UNION ALL 
  select 'PG1007','P1007','JE2',TO_DATE('29/12/2019', 'DD/MM/YYYY'),'2201912296'  FROM dual UNION ALL 
  select 'PG1008','P1008','JE1',TO_DATE('29/12/2019', 'DD/MM/YYYY'),'1201912297'  FROM dual UNION ALL 
  select 'PG1009','P1009','JE2',TO_DATE('30/12/2019', 'DD/MM/YYYY'),'2201912301'  FROM dual UNION ALL 
  select 'PG1010','P1010','JE3',TO_DATE('30/12/2019', 'DD/MM/YYYY'),'3201912302'  FROM dual UNION ALL 
  select 'PG1011','P1011','JE6',TO_DATE('30/12/2019', 'DD/MM/YYYY'),'6201912303'  FROM dual UNION ALL 
  select 'PG1012','P1012','JE6',TO_DATE('30/12/2019', 'DD/MM/YYYY'),'6201912304'  FROM dual UNION ALL 
  select 'PG1013','P1013','JE2',TO_DATE('30/12/2019', 'DD/MM/YYYY'),'2201912305'  FROM dual UNION ALL 
  select 'PG1014','P1014','JE5',TO_DATE('30/12/2019', 'DD/MM/YYYY'),'5201912306'  FROM dual UNION ALL 
  select 'PG1015','P1015','JE1',TO_DATE('30/12/2019', 'DD/MM/YYYY'),'1201912307'  FROM dual UNION ALL 
  select 'PG1016','P1016','JE4',TO_DATE('31/12/2019', 'DD/MM/YYYY'),'4201912311'  FROM dual UNION ALL 
  select 'PG1017','P1017','JE4',TO_DATE('31/12/2019', 'DD/MM/YYYY'),'4201912312'  FROM dual UNION ALL 
  select 'PG1018','P1018','JE1',TO_DATE('31/12/2019', 'DD/MM/YYYY'),'1201912313'  FROM dual UNION ALL 
  select 'PG1019','P1019','JE4',TO_DATE('31/12/2019', 'DD/MM/YYYY'),'4201912314'  FROM dual UNION ALL 
  select 'PG1020','P1020','JE5',TO_DATE('31/12/2019', 'DD/MM/YYYY'),'5201912315'  FROM dual UNION ALL 
  select 'PG1021','P1021','JE5',TO_DATE('31/12/2019', 'DD/MM/YYYY'),'5201912316'  FROM dual UNION ALL 
  select 'PG1022','P1022','JE3',TO_DATE('31/12/2019', 'DD/MM/YYYY'),'3201912317'  FROM dual UNION ALL 
  select 'PG1023','P1023','JE5',TO_DATE('01/01/2020', 'DD/MM/YYYY'),'5202001011'  FROM dual UNION ALL 
  select 'PG1024','P1024','JE5',TO_DATE('01/01/2020', 'DD/MM/YYYY'),'5202001012'  FROM dual UNION ALL 
  select 'PG1025','P1025','JE6',TO_DATE('01/01/2020', 'DD/MM/YYYY'),'6202001013'  FROM dual UNION ALL 
  select 'PG1026','P1026','JE7',TO_DATE('01/01/2020', 'DD/MM/YYYY'),'7202001014'  FROM dual UNION ALL 
  select 'PG1027','P1027','JE3',TO_DATE('01/01/2020', 'DD/MM/YYYY'),'3202001015'  FROM dual UNION ALL 
  select 'PG1028','P1028','JE3',TO_DATE('01/01/2020', 'DD/MM/YYYY'),'3202001016'  FROM dual UNION ALL 
  select 'PG1029','P1029','JE6',TO_DATE('01/01/2020', 'DD/MM/YYYY'),'6202001017'  FROM dual UNION ALL 
  select 'PG1030','P1030','JE3',TO_DATE('02/01/2020', 'DD/MM/YYYY'),'3202001021'  FROM dual UNION ALL 
  select 'PG1031','P1031','JE5',TO_DATE('02/01/2020', 'DD/MM/YYYY'),'5202001022'  FROM dual UNION ALL 
  select 'PG1032','P1032','JE5',TO_DATE('02/01/2020', 'DD/MM/YYYY'),'5202001023'  FROM dual UNION ALL 
  select 'PG1033','P1033','JE7',TO_DATE('02/01/2020', 'DD/MM/YYYY'),'7202001024'  FROM dual UNION ALL 
  select 'PG1034','P1034','JE2',TO_DATE('02/01/2020', 'DD/MM/YYYY'),'2202001025'  FROM dual UNION ALL 
  select 'PG1035','P1035','JE6',TO_DATE('02/01/2020', 'DD/MM/YYYY'),'6202001026'  FROM dual UNION ALL 
  select 'PG1036','P1036','JE3',TO_DATE('02/01/2020', 'DD/MM/YYYY'),'3202001027'  FROM dual UNION ALL 
  select 'PG1037','P1037','JE2',TO_DATE('03/01/2020', 'DD/MM/YYYY'),'2202001031'  FROM dual UNION ALL 
  select 'PG1038','P1038','JE7',TO_DATE('03/01/2020', 'DD/MM/YYYY'),'7202001032'  FROM dual UNION ALL 
  select 'PG1039','P1039','JE7',TO_DATE('03/01/2020', 'DD/MM/YYYY'),'7202001033'  FROM dual UNION ALL 
  select 'PG1040','P1040','JE6',TO_DATE('03/01/2020', 'DD/MM/YYYY'),'6202001034'  FROM dual UNION ALL 
  select 'PG1041','P1041','JE2',TO_DATE('03/01/2020', 'DD/MM/YYYY'),'2202001035'  FROM dual UNION ALL 
  select 'PG1042','P1042','JE6',TO_DATE('03/01/2020', 'DD/MM/YYYY'),'6202001036'  FROM dual UNION ALL 
  select 'PG1043','P1043','JE4',TO_DATE('03/01/2020', 'DD/MM/YYYY'),'4202001037'  FROM dual UNION ALL 
  select 'PG1044','P1044','JE2',TO_DATE('04/01/2020', 'DD/MM/YYYY'),'2202001041'  FROM dual UNION ALL 
  select 'PG1045','P1045','JE3',TO_DATE('04/01/2020', 'DD/MM/YYYY'),'3202001042'  FROM dual UNION ALL 
  select 'PG1046','P1046','JE2',TO_DATE('04/01/2020', 'DD/MM/YYYY'),'2202001043'  FROM dual UNION ALL 
  select 'PG1047','P1047','JE1',TO_DATE('04/01/2020', 'DD/MM/YYYY'),'1202001044'  FROM dual UNION ALL 
  select 'PG1048','P1048','JE6',TO_DATE('04/01/2020', 'DD/MM/YYYY'),'6202001045'  FROM dual UNION ALL 
  select 'PG1049','P1049','JE4',TO_DATE('04/01/2020', 'DD/MM/YYYY'),'4202001046'  FROM dual UNION ALL 
  select 'PG1050','P1050','JE2',TO_DATE('04/01/2020', 'DD/MM/YYYY'),'2202001047'  FROM dual UNION ALL 
  select 'PG1051','P1051','JE6',TO_DATE('05/01/2020', 'DD/MM/YYYY'),'6202001051'  FROM dual UNION ALL 
  select 'PG1052','P1052','JE2',TO_DATE('05/01/2020', 'DD/MM/YYYY'),'2202001052'  FROM dual UNION ALL 
  select 'PG1053','P1053','JE4',TO_DATE('05/01/2020', 'DD/MM/YYYY'),'4202001053'  FROM dual UNION ALL 
  select 'PG1054','P1054','JE4',TO_DATE('05/01/2020', 'DD/MM/YYYY'),'4202001054'  FROM dual UNION ALL 
  select 'PG1055','P1055','JE1',TO_DATE('05/01/2020', 'DD/MM/YYYY'),'1202001055'  FROM dual UNION ALL 
  select 'PG1056','P1056','JE4',TO_DATE('05/01/2020', 'DD/MM/YYYY'),'4202001056'  FROM dual UNION ALL 
  select 'PG1057','P1057','JE7',TO_DATE('05/01/2020', 'DD/MM/YYYY'),'7202001057'  FROM dual UNION ALL 
  select 'PG1058','P1058','JE1',TO_DATE('06/01/2020', 'DD/MM/YYYY'),'1202001061'  FROM dual UNION ALL 
  select 'PG1059','P1059','JE7',TO_DATE('06/01/2020', 'DD/MM/YYYY'),'7202001062'  FROM dual UNION ALL 
  select 'PG1060','P1060','JE6',TO_DATE('06/01/2020', 'DD/MM/YYYY'),'6202001063'  FROM dual UNION ALL 
  select 'PG1061','P1061','JE2',TO_DATE('06/01/2020', 'DD/MM/YYYY'),'2202001064'  FROM dual UNION ALL 
  select 'PG1062','P1062','JE6',TO_DATE('06/01/2020', 'DD/MM/YYYY'),'6202001065'  FROM dual UNION ALL 
  select 'PG1063','P1063','JE7',TO_DATE('06/01/2020', 'DD/MM/YYYY'),'7202001066'  FROM dual UNION ALL 
  select 'PG1064','P1064','JE4',TO_DATE('06/01/2020', 'DD/MM/YYYY'),'4202001067'  FROM dual UNION ALL 
  select 'PG1065','P1065','JE7',TO_DATE('07/01/2020', 'DD/MM/YYYY'),'7202001071'  FROM dual UNION ALL 
  select 'PG1066','P1066','JE4',TO_DATE('07/01/2020', 'DD/MM/YYYY'),'4202001072'  FROM dual UNION ALL 
  select 'PG1067','P1067','JE1',TO_DATE('07/01/2020', 'DD/MM/YYYY'),'1202001073'  FROM dual UNION ALL 
  select 'PG1068','P1068','JE5',TO_DATE('07/01/2020', 'DD/MM/YYYY'),'5202001074'  FROM dual UNION ALL 
  select 'PG1069','P1069','JE3',TO_DATE('07/01/2020', 'DD/MM/YYYY'),'3202001075'  FROM dual UNION ALL 
  select 'PG1070','P1070','JE5',TO_DATE('07/01/2020', 'DD/MM/YYYY'),'5202001076'  FROM dual UNION ALL 
  select 'PG1071','P1071','JE1',TO_DATE('07/01/2020', 'DD/MM/YYYY'),'1202001077'  FROM dual UNION ALL 
  select 'PG1072','P1072','JE3',TO_DATE('08/01/2020', 'DD/MM/YYYY'),'3202001081'  FROM dual UNION ALL 
  select 'PG1073','P1073','JE2',TO_DATE('08/01/2020', 'DD/MM/YYYY'),'2202001082'  FROM dual UNION ALL 
  select 'PG1074','P1074','JE2',TO_DATE('08/01/2020', 'DD/MM/YYYY'),'2202001083'  FROM dual UNION ALL 
  select 'PG1075','P1075','JE6',TO_DATE('08/01/2020', 'DD/MM/YYYY'),'6202001084'  FROM dual UNION ALL 
  select 'PG1076','P1076','JE5',TO_DATE('08/01/2020', 'DD/MM/YYYY'),'5202001085'  FROM dual UNION ALL 
  select 'PG1077','P1077','JE6',TO_DATE('08/01/2020', 'DD/MM/YYYY'),'6202001086'  FROM dual UNION ALL 
  select 'PG1078','P1078','JE1',TO_DATE('08/01/2020', 'DD/MM/YYYY'),'1202001087'  FROM dual UNION ALL 
  select 'PG1079','P1079','JE4',TO_DATE('09/01/2020', 'DD/MM/YYYY'),'4202001091'  FROM dual UNION ALL 
  select 'PG1080','P1080','JE1',TO_DATE('09/01/2020', 'DD/MM/YYYY'),'1202001092'  FROM dual UNION ALL 
  select 'PG1081','P1081','JE3',TO_DATE('09/01/2020', 'DD/MM/YYYY'),'3202001093'  FROM dual UNION ALL 
  select 'PG1082','P1082','JE4',TO_DATE('09/01/2020', 'DD/MM/YYYY'),'4202001094'  FROM dual UNION ALL 
  select 'PG1083','P1083','JE1',TO_DATE('09/01/2020', 'DD/MM/YYYY'),'1202001095'  FROM dual UNION ALL 
  select 'PG1084','P1084','JE3',TO_DATE('09/01/2020', 'DD/MM/YYYY'),'3202001096'  FROM dual UNION ALL 
  select 'PG1085','P1085','JE3',TO_DATE('09/01/2020', 'DD/MM/YYYY'),'3202001097'  FROM dual UNION ALL 
  select 'PG1086','P1086','JE3',TO_DATE('10/01/2020', 'DD/MM/YYYY'),'3202001101'  FROM dual UNION ALL 
  select 'PG1087','P1087','JE7',TO_DATE('10/01/2020', 'DD/MM/YYYY'),'7202001102'  FROM dual UNION ALL 
  select 'PG1088','P1088','JE6',TO_DATE('10/01/2020', 'DD/MM/YYYY'),'6202001103'  FROM dual UNION ALL 
  select 'PG1089','P1089','JE1',TO_DATE('10/01/2020', 'DD/MM/YYYY'),'1202001104'  FROM dual UNION ALL 
  select 'PG1090','P1090','JE1',TO_DATE('10/01/2020', 'DD/MM/YYYY'),'1202001105'  FROM dual UNION ALL 
  select 'PG1091','P1091','JE1',TO_DATE('10/01/2020', 'DD/MM/YYYY'),'1202001106'  FROM dual UNION ALL 
  select 'PG1092','P1092','JE5',TO_DATE('10/01/2020', 'DD/MM/YYYY'),'5202001107'  FROM dual UNION ALL 
  select 'PG1093','P1093','JE2',TO_DATE('11/01/2020', 'DD/MM/YYYY'),'2202001111'  FROM dual UNION ALL 
  select 'PG1094','P1094','JE2',TO_DATE('11/01/2020', 'DD/MM/YYYY'),'2202001112'  FROM dual UNION ALL 
  select 'PG1095','P1095','JE5',TO_DATE('11/01/2020', 'DD/MM/YYYY'),'5202001113'  FROM dual UNION ALL 
  select 'PG1096','P1096','JE5',TO_DATE('11/01/2020', 'DD/MM/YYYY'),'5202001114'  FROM dual UNION ALL 
  select 'PG1097','P1097','JE2',TO_DATE('11/01/2020', 'DD/MM/YYYY'),'2202001115'  FROM dual UNION ALL 
  select 'PG1098','P1098','JE6',TO_DATE('11/01/2020', 'DD/MM/YYYY'),'6202001116'  FROM dual UNION ALL 
  select 'PG1099','P1099','JE2',TO_DATE('11/01/2020', 'DD/MM/YYYY'),'2202001117'  FROM dual UNION ALL 
  select 'PG1100','P1100','JE1',TO_DATE('12/01/2020', 'DD/MM/YYYY'),'1202001121'  FROM dual UNION ALL 
  select 'PG1101','P1101','JE5',TO_DATE('12/01/2020', 'DD/MM/YYYY'),'5202001122'  FROM dual UNION ALL 
  select 'PG1102','P1102','JE3',TO_DATE('12/01/2020', 'DD/MM/YYYY'),'3202001123'  FROM dual UNION ALL 
  select 'PG1103','P1103','JE5',TO_DATE('12/01/2020', 'DD/MM/YYYY'),'5202001124'  FROM dual UNION ALL 
  select 'PG1104','P1104','JE4',TO_DATE('12/01/2020', 'DD/MM/YYYY'),'4202001125'  FROM dual UNION ALL 
  select 'PG1105','P1105','JE6',TO_DATE('12/01/2020', 'DD/MM/YYYY'),'6202001126'  FROM dual UNION ALL 
  select 'PG1106','P1106','JE3',TO_DATE('12/01/2020', 'DD/MM/YYYY'),'3202001127'  FROM dual UNION ALL 
  select 'PG1107','P1107','JE3',TO_DATE('13/01/2020', 'DD/MM/YYYY'),'3202001131'  FROM dual UNION ALL 
  select 'PG1108','P1108','JE7',TO_DATE('13/01/2020', 'DD/MM/YYYY'),'7202001132'  FROM dual UNION ALL 
  select 'PG1109','P1109','JE4',TO_DATE('13/01/2020', 'DD/MM/YYYY'),'4202001133'  FROM dual UNION ALL 
  select 'PG1110','P1110','JE7',TO_DATE('13/01/2020', 'DD/MM/YYYY'),'7202001134'  FROM dual UNION ALL 
  select 'PG1111','P1111','JE4',TO_DATE('13/01/2020', 'DD/MM/YYYY'),'4202001135'  FROM dual UNION ALL 
  select 'PG1112','P1112','JE3',TO_DATE('13/01/2020', 'DD/MM/YYYY'),'3202001136'  FROM dual UNION ALL 
  select 'PG1113','P1113','JE1',TO_DATE('13/01/2020', 'DD/MM/YYYY'),'1202001137'  FROM dual UNION ALL 
  select 'PG1114','P1114','JE4',TO_DATE('14/01/2020', 'DD/MM/YYYY'),'4202001141'  FROM dual UNION ALL 
  select 'PG1115','P1115','JE4',TO_DATE('14/01/2020', 'DD/MM/YYYY'),'4202001142'  FROM dual UNION ALL 
  select 'PG1116','P1116','JE4',TO_DATE('14/01/2020', 'DD/MM/YYYY'),'4202001143'  FROM dual UNION ALL 
  select 'PG1117','P1117','JE5',TO_DATE('14/01/2020', 'DD/MM/YYYY'),'5202001144'  FROM dual UNION ALL 
  select 'PG1118','P1118','JE7',TO_DATE('14/01/2020', 'DD/MM/YYYY'),'7202001145'  FROM dual UNION ALL 
  select 'PG1119','P1119','JE2',TO_DATE('14/01/2020', 'DD/MM/YYYY'),'2202001146'  FROM dual UNION ALL 
  select 'PG1120','P1120','JE7',TO_DATE('14/01/2020', 'DD/MM/YYYY'),'7202001147'  FROM dual UNION ALL 
  select 'PG1121','P1121','JE5',TO_DATE('15/01/2020', 'DD/MM/YYYY'),'5202001151'  FROM dual UNION ALL 
  select 'PG1122','P1122','JE2',TO_DATE('15/01/2020', 'DD/MM/YYYY'),'2202001152'  FROM dual UNION ALL 
  select 'PG1123','P1123','JE4',TO_DATE('15/01/2020', 'DD/MM/YYYY'),'4202001153'  FROM dual UNION ALL 
  select 'PG1124','P1124','JE7',TO_DATE('15/01/2020', 'DD/MM/YYYY'),'7202001154'  FROM dual UNION ALL 
  select 'PG1125','P1125','JE7',TO_DATE('15/01/2020', 'DD/MM/YYYY'),'7202001155'  FROM dual UNION ALL 
  select 'PG1126','P1126','JE5',TO_DATE('15/01/2020', 'DD/MM/YYYY'),'5202001156'  FROM dual UNION ALL 
  select 'PG1127','P1127','JE5',TO_DATE('15/01/2020', 'DD/MM/YYYY'),'5202001157'  FROM dual UNION ALL 
  select 'PG1128','P1128','JE3',TO_DATE('16/01/2020', 'DD/MM/YYYY'),'3202001161'  FROM dual UNION ALL 
  select 'PG1129','P1129','JE7',TO_DATE('16/01/2020', 'DD/MM/YYYY'),'7202001162'  FROM dual UNION ALL 
  select 'PG1130','P1130','JE3',TO_DATE('16/01/2020', 'DD/MM/YYYY'),'3202001163'  FROM dual UNION ALL 
  select 'PG1131','P1131','JE3',TO_DATE('16/01/2020', 'DD/MM/YYYY'),'3202001164'  FROM dual UNION ALL 
  select 'PG1132','P1132','JE1',TO_DATE('16/01/2020', 'DD/MM/YYYY'),'1202001165'  FROM dual UNION ALL 
  select 'PG1133','P1133','JE2',TO_DATE('16/01/2020', 'DD/MM/YYYY'),'2202001166'  FROM dual UNION ALL 
  select 'PG1134','P1134','JE5',TO_DATE('16/01/2020', 'DD/MM/YYYY'),'5202001167'  FROM dual UNION ALL 
  select 'PG1135','P1135','JE3',TO_DATE('17/01/2020', 'DD/MM/YYYY'),'3202001171'  FROM dual UNION ALL 
  select 'PG1136','P1136','JE5',TO_DATE('17/01/2020', 'DD/MM/YYYY'),'5202001172'  FROM dual UNION ALL 
  select 'PG1137','P1137','JE3',TO_DATE('17/01/2020', 'DD/MM/YYYY'),'3202001173'  FROM dual UNION ALL 
  select 'PG1138','P1138','JE1',TO_DATE('17/01/2020', 'DD/MM/YYYY'),'1202001174'  FROM dual UNION ALL 
  select 'PG1139','P1139','JE2',TO_DATE('17/01/2020', 'DD/MM/YYYY'),'2202001175'  FROM dual UNION ALL 
  select 'PG1140','P1140','JE1',TO_DATE('17/01/2020', 'DD/MM/YYYY'),'1202001176'  FROM dual UNION ALL 
  select 'PG1141','P1141','JE1',TO_DATE('17/01/2020', 'DD/MM/YYYY'),'1202001177'  FROM dual UNION ALL 
  select 'PG1142','P1142','JE4',TO_DATE('18/01/2020', 'DD/MM/YYYY'),'4202001181'  FROM dual UNION ALL 
  select 'PG1143','P1143','JE2',TO_DATE('18/01/2020', 'DD/MM/YYYY'),'2202001182'  FROM dual UNION ALL 
  select 'PG1144','P1144','JE6',TO_DATE('18/01/2020', 'DD/MM/YYYY'),'6202001183'  FROM dual UNION ALL 
  select 'PG1145','P1145','JE6',TO_DATE('18/01/2020', 'DD/MM/YYYY'),'6202001184'  FROM dual UNION ALL 
  select 'PG1146','P1146','JE3',TO_DATE('18/01/2020', 'DD/MM/YYYY'),'3202001185'  FROM dual UNION ALL 
  select 'PG1147','P1147','JE3',TO_DATE('18/01/2020', 'DD/MM/YYYY'),'3202001186'  FROM dual UNION ALL 
  select 'PG1148','P1148','JE5',TO_DATE('18/01/2020', 'DD/MM/YYYY'),'5202001187'  FROM dual UNION ALL 
  select 'PG1149','P1149','JE5',TO_DATE('19/01/2020', 'DD/MM/YYYY'),'5202001191'  FROM dual UNION ALL 
  select 'PG1150','P1150','JE4',TO_DATE('19/01/2020', 'DD/MM/YYYY'),'4202001192'  FROM dual UNION ALL 
  select 'PG1151','P1151','JE1',TO_DATE('19/01/2020', 'DD/MM/YYYY'),'1202001193'  FROM dual UNION ALL 
  select 'PG1152','P1152','JE7',TO_DATE('19/01/2020', 'DD/MM/YYYY'),'7202001194'  FROM dual UNION ALL 
  select 'PG1153','P1153','JE5',TO_DATE('19/01/2020', 'DD/MM/YYYY'),'5202001195'  FROM dual UNION ALL 
  select 'PG1154','P1154','JE7',TO_DATE('19/01/2020', 'DD/MM/YYYY'),'7202001196'  FROM dual UNION ALL 
  select 'PG1155','P1155','JE2',TO_DATE('19/01/2020', 'DD/MM/YYYY'),'2202001197'  FROM dual UNION ALL 
  select 'PG1156','P1156','JE7',TO_DATE('20/01/2020', 'DD/MM/YYYY'),'7202001201'  FROM dual UNION ALL 
  select 'PG1157','P1157','JE5',TO_DATE('20/01/2020', 'DD/MM/YYYY'),'5202001202'  FROM dual UNION ALL 
  select 'PG1158','P1158','JE3',TO_DATE('20/01/2020', 'DD/MM/YYYY'),'3202001203'  FROM dual UNION ALL 
  select 'PG1159','P1159','JE4',TO_DATE('20/01/2020', 'DD/MM/YYYY'),'4202001204'  FROM dual UNION ALL 
  select 'PG1160','P1160','JE5',TO_DATE('20/01/2020', 'DD/MM/YYYY'),'5202001205'  FROM dual UNION ALL 
  select 'PG1161','P1161','JE6',TO_DATE('20/01/2020', 'DD/MM/YYYY'),'6202001206'  FROM dual UNION ALL 
  select 'PG1162','P1162','JE2',TO_DATE('20/01/2020', 'DD/MM/YYYY'),'2202001207'  FROM dual UNION ALL 
  select 'PG1163','P1163','JE2',TO_DATE('21/01/2020', 'DD/MM/YYYY'),'2202001211'  FROM dual UNION ALL 
  select 'PG1164','P1164','JE5',TO_DATE('21/01/2020', 'DD/MM/YYYY'),'5202001212'  FROM dual UNION ALL 
  select 'PG1165','P1165','JE3',TO_DATE('21/01/2020', 'DD/MM/YYYY'),'3202001213'  FROM dual UNION ALL 
  select 'PG1166','P1166','JE1',TO_DATE('21/01/2020', 'DD/MM/YYYY'),'1202001214'  FROM dual UNION ALL 
  select 'PG1167','P1167','JE2',TO_DATE('21/01/2020', 'DD/MM/YYYY'),'2202001215'  FROM dual UNION ALL 
  select 'PG1168','P1168','JE7',TO_DATE('21/01/2020', 'DD/MM/YYYY'),'7202001216'  FROM dual UNION ALL 
  select 'PG1169','P1169','JE1',TO_DATE('21/01/2020', 'DD/MM/YYYY'),'1202001217'  FROM dual UNION ALL 
  select 'PG1170','P1170','JE4',TO_DATE('22/01/2020', 'DD/MM/YYYY'),'4202001221'  FROM dual UNION ALL 
  select 'PG1171','P1171','JE4',TO_DATE('22/01/2020', 'DD/MM/YYYY'),'4202001222'  FROM dual UNION ALL 
  select 'PG1172','P1172','JE5',TO_DATE('22/01/2020', 'DD/MM/YYYY'),'5202001223'  FROM dual UNION ALL 
  select 'PG1173','P1173','JE5',TO_DATE('22/01/2020', 'DD/MM/YYYY'),'5202001224'  FROM dual UNION ALL 
  select 'PG1174','P1174','JE4',TO_DATE('22/01/2020', 'DD/MM/YYYY'),'4202001225'  FROM dual UNION ALL 
  select 'PG1175','P1175','JE1',TO_DATE('22/01/2020', 'DD/MM/YYYY'),'1202001226'  FROM dual UNION ALL 
  select 'PG1176','P1176','JE2',TO_DATE('22/01/2020', 'DD/MM/YYYY'),'2202001227'  FROM dual UNION ALL 
  select 'PG1177','P1177','JE3',TO_DATE('23/01/2020', 'DD/MM/YYYY'),'3202001231'  FROM dual UNION ALL 
  select 'PG1178','P1178','JE3',TO_DATE('23/01/2020', 'DD/MM/YYYY'),'3202001232'  FROM dual UNION ALL 
  select 'PG1179','P1179','JE1',TO_DATE('23/01/2020', 'DD/MM/YYYY'),'1202001233'  FROM dual UNION ALL 
  select 'PG1180','P1180','JE1',TO_DATE('23/01/2020', 'DD/MM/YYYY'),'1202001234'  FROM dual UNION ALL 
  select 'PG1181','P1181','JE5',TO_DATE('23/01/2020', 'DD/MM/YYYY'),'5202001235'  FROM dual UNION ALL 
  select 'PG1182','P1182','JE6',TO_DATE('23/01/2020', 'DD/MM/YYYY'),'6202001236'  FROM dual UNION ALL 
  select 'PG1183','P1183','JE4',TO_DATE('23/01/2020', 'DD/MM/YYYY'),'4202001237'  FROM dual UNION ALL 
  select 'PG1184','P1184','JE5',TO_DATE('24/01/2020', 'DD/MM/YYYY'),'5202001241'  FROM dual UNION ALL 
  select 'PG1185','P1185','JE1',TO_DATE('24/01/2020', 'DD/MM/YYYY'),'1202001242'  FROM dual UNION ALL 
  select 'PG1186','P1186','JE2',TO_DATE('24/01/2020', 'DD/MM/YYYY'),'2202001243'  FROM dual UNION ALL 
  select 'PG1187','P1187','JE1',TO_DATE('24/01/2020', 'DD/MM/YYYY'),'1202001244'  FROM dual UNION ALL 
  select 'PG1188','P1188','JE7',TO_DATE('24/01/2020', 'DD/MM/YYYY'),'7202001245'  FROM dual UNION ALL 
  select 'PG1189','P1189','JE6',TO_DATE('24/01/2020', 'DD/MM/YYYY'),'6202001246'  FROM dual UNION ALL 
  select 'PG1190','P1190','JE7',TO_DATE('24/01/2020', 'DD/MM/YYYY'),'7202001247'  FROM dual UNION ALL 
  select 'PG1191','P1191','JE5',TO_DATE('25/01/2020', 'DD/MM/YYYY'),'5202001251'  FROM dual UNION ALL 
  select 'PG1192','P1192','JE1',TO_DATE('25/01/2020', 'DD/MM/YYYY'),'1202001252'  FROM dual UNION ALL 
  select 'PG1193','P1193','JE7',TO_DATE('25/01/2020', 'DD/MM/YYYY'),'7202001253'  FROM dual UNION ALL 
  select 'PG1194','P1194','JE2',TO_DATE('25/01/2020', 'DD/MM/YYYY'),'2202001254'  FROM dual UNION ALL 
  select 'PG1195','P1195','JE1',TO_DATE('25/01/2020', 'DD/MM/YYYY'),'1202001255'  FROM dual UNION ALL 
  select 'PG1196','P1196','JE3',TO_DATE('25/01/2020', 'DD/MM/YYYY'),'3202001256'  FROM dual UNION ALL 
  select 'PG1197','P1197','JE1',TO_DATE('25/01/2020', 'DD/MM/YYYY'),'1202001257'  FROM dual UNION ALL 
  select 'PG1198','P1198','JE6',TO_DATE('26/01/2020', 'DD/MM/YYYY'),'6202001261'  FROM dual UNION ALL 
  select 'PG1199','P1199','JE5',TO_DATE('26/01/2020', 'DD/MM/YYYY'),'5202001262'  FROM dual UNION ALL 
  select 'PG1200','P1200','JE3',TO_DATE('26/01/2020', 'DD/MM/YYYY'),'3202001263'  FROM dual;

